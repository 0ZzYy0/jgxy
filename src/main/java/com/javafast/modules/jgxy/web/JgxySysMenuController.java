package com.javafast.modules.jgxy.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.javafast.common.utils.MyBeanUtils;
import com.javafast.common.config.Global;
import com.javafast.common.web.BaseController;
import com.javafast.common.utils.StringUtils;
import com.javafast.modules.jgxy.entity.JgxySysMenu;
import com.javafast.modules.jgxy.service.JgxySysMenuService;

/**
 * 菜单(树结构)Controller
 * @author javafast
 * @version 2019-06-06
 */
@Controller
@RequestMapping(value = "${adminPath}/jgxy/jgxySysMenu")
public class JgxySysMenuController extends BaseController {

	@Autowired
	private JgxySysMenuService jgxySysMenuService;
	
	@ModelAttribute
	public JgxySysMenu get(@RequestParam(required=false) String id) {
		JgxySysMenu entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jgxySysMenuService.get(id);
		}
		if (entity == null){
			entity = new JgxySysMenu();
		}
		return entity;
	}
	
	/**
	 * 菜单(树结构)列表页面
	 */
	@RequiresPermissions("jgxy:jgxySysMenu:list")
	@RequestMapping(value = {"list", ""})
	public String list(JgxySysMenu jgxySysMenu, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<JgxySysMenu> list = jgxySysMenuService.findList(jgxySysMenu); 
		model.addAttribute("list", list);
		return "modules/jgxy/jgxySysMenuList";
	}

	/**
	 * 查看，增加，编辑菜单(树结构)表单页面
	 */
	@RequiresPermissions(value={"jgxy:jgxySysMenu:view","jgxy:jgxySysMenu:add","jgxy:jgxySysMenu:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(JgxySysMenu jgxySysMenu, Model model) {
		if (jgxySysMenu.getParent()!=null && StringUtils.isNotBlank(jgxySysMenu.getParent().getId())){
			jgxySysMenu.setParent(jgxySysMenuService.get(jgxySysMenu.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(jgxySysMenu.getId())){
				JgxySysMenu jgxySysMenuChild = new JgxySysMenu();
				jgxySysMenuChild.setParent(new JgxySysMenu(jgxySysMenu.getParent().getId()));
				List<JgxySysMenu> list = jgxySysMenuService.findList(jgxySysMenu); 
				if (list.size() > 0){
					jgxySysMenu.setSort(list.get(list.size()-1).getSort());
					if (jgxySysMenu.getSort() != null){
						jgxySysMenu.setSort(jgxySysMenu.getSort() + 30);
					}
				}
			}
		}
		if (jgxySysMenu.getSort() == null){
			jgxySysMenu.setSort(30);
		}
		model.addAttribute("jgxySysMenu", jgxySysMenu);
		return "modules/jgxy/jgxySysMenuForm";
	}

	/**
	 * 保存菜单(树结构)
	 */
	@RequiresPermissions(value={"jgxy:jgxySysMenu:add","jgxy:jgxySysMenu:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(JgxySysMenu jgxySysMenu, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jgxySysMenu)){
			return form(jgxySysMenu, model);
		}
		
		try{
		
			if(!jgxySysMenu.getIsNewRecord()){//编辑表单保存
				JgxySysMenu t = jgxySysMenuService.get(jgxySysMenu.getId());//从数据库取出记录的值
				MyBeanUtils.copyBeanNotNull2Bean(jgxySysMenu, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
				jgxySysMenuService.save(t);//保存
			}else{//新增表单保存
				jgxySysMenuService.save(jgxySysMenu);//保存
			}
			addMessage(redirectAttributes, "保存菜单(树结构)成功");
		}catch(Exception e){			
			e.printStackTrace();
			addMessage(redirectAttributes, "保存菜单(树结构)失败");
		}finally{
			return "redirect:"+Global.getAdminPath()+"/jgxy/jgxySysMenu/?repage";
		}
	}
	
	/**
	 * 删除菜单(树结构)
	 */
	@RequiresPermissions("jgxy:jgxySysMenu:del")
	@RequestMapping(value = "delete")
	public String delete(JgxySysMenu jgxySysMenu, RedirectAttributes redirectAttributes) {
		jgxySysMenuService.delete(jgxySysMenu);
		addMessage(redirectAttributes, "删除菜单(树结构)成功");
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxySysMenu/?repage";
	}

	/**
	 * 菜单(树结构)树形选择器
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<JgxySysMenu> list = jgxySysMenuService.findList(new JgxySysMenu());
		for (int i=0; i<list.size(); i++){
			JgxySysMenu e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				map.put("menuType", e.getMenuType());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
}