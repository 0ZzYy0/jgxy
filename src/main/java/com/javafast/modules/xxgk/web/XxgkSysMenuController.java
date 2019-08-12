package com.javafast.modules.xxgk.web;

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
import com.javafast.modules.xxgk.entity.XxgkSysMenu;
import com.javafast.modules.xxgk.service.XxgkSysMenuService;

/**
 * 菜单(树结构)Controller
 * @author javafast
 * @version 2019-08-10
 */
@Controller
@RequestMapping(value = "${adminPath}/xxgk/xxgkSysMenu")
public class XxgkSysMenuController extends BaseController {

	@Autowired
	private XxgkSysMenuService xxgkSysMenuService;
	
	@ModelAttribute
	public XxgkSysMenu get(@RequestParam(required=false) String id) {
		XxgkSysMenu entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xxgkSysMenuService.get(id);
		}
		if (entity == null){
			entity = new XxgkSysMenu();
		}
		return entity;
	}
	
	/**
	 * 菜单(树结构)列表页面
	 */
	@RequiresPermissions("xxgk:xxgkSysMenu:list")
	@RequestMapping(value = {"list", ""})
	public String list(XxgkSysMenu xxgkSysMenu, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<XxgkSysMenu> list = xxgkSysMenuService.findList(xxgkSysMenu); 
		model.addAttribute("list", list);
		return "modules/xxgk/xxgkSysMenuList";
	}

	/**
	 * 查看，增加，编辑菜单(树结构)表单页面
	 */
	@RequiresPermissions(value={"xxgk:xxgkSysMenu:view","xxgk:xxgkSysMenu:add","xxgk:xxgkSysMenu:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XxgkSysMenu xxgkSysMenu, Model model) {
		if (xxgkSysMenu.getParent()!=null && StringUtils.isNotBlank(xxgkSysMenu.getParent().getId())){
			xxgkSysMenu.setParent(xxgkSysMenuService.get(xxgkSysMenu.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(xxgkSysMenu.getId())){
				XxgkSysMenu xxgkSysMenuChild = new XxgkSysMenu();
				xxgkSysMenuChild.setParent(new XxgkSysMenu(xxgkSysMenu.getParent().getId()));
				List<XxgkSysMenu> list = xxgkSysMenuService.findList(xxgkSysMenu); 
				if (list.size() > 0){
					xxgkSysMenu.setSort(list.get(list.size()-1).getSort());
					if (xxgkSysMenu.getSort() != null){
						xxgkSysMenu.setSort(xxgkSysMenu.getSort() + 30);
					}
				}
			}
		}
		if (xxgkSysMenu.getSort() == null){
			xxgkSysMenu.setSort(30);
		}
		model.addAttribute("xxgkSysMenu", xxgkSysMenu);
		return "modules/xxgk/xxgkSysMenuForm";
	}

	/**
	 * 保存菜单(树结构)
	 */
	@RequiresPermissions(value={"xxgk:xxgkSysMenu:add","xxgk:xxgkSysMenu:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XxgkSysMenu xxgkSysMenu, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, xxgkSysMenu)){
			return form(xxgkSysMenu, model);
		}
		
		try{
		
			if(!xxgkSysMenu.getIsNewRecord()){//编辑表单保存
				XxgkSysMenu t = xxgkSysMenuService.get(xxgkSysMenu.getId());//从数据库取出记录的值
				MyBeanUtils.copyBeanNotNull2Bean(xxgkSysMenu, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
				xxgkSysMenuService.save(t);//保存
			}else{//新增表单保存
				xxgkSysMenuService.save(xxgkSysMenu);//保存
			}
			addMessage(redirectAttributes, "保存菜单(树结构)成功");
		}catch(Exception e){			
			e.printStackTrace();
			addMessage(redirectAttributes, "保存菜单(树结构)失败");
		}finally{
			return "redirect:"+Global.getAdminPath()+"/xxgk/xxgkSysMenu/?repage";
		}
	}
	
	/**
	 * 删除菜单(树结构)
	 */
	@RequiresPermissions("xxgk:xxgkSysMenu:del")
	@RequestMapping(value = "delete")
	public String delete(XxgkSysMenu xxgkSysMenu, RedirectAttributes redirectAttributes) {
		xxgkSysMenuService.delete(xxgkSysMenu);
		addMessage(redirectAttributes, "删除菜单(树结构)成功");
		return "redirect:"+Global.getAdminPath()+"/xxgk/xxgkSysMenu/?repage";
	}

	/**
	 * 菜单(树结构)树形选择器
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<XxgkSysMenu> list = xxgkSysMenuService.findList(new XxgkSysMenu());
		for (int i=0; i<list.size(); i++){
			XxgkSysMenu e = list.get(i);
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