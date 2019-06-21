package com.javafast.modules.jgxy.web;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javafast.modules.jgxy.entity.JgxySysMenu;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.google.common.collect.Lists;
import com.javafast.common.utils.DateUtils;
import com.javafast.common.utils.MyBeanUtils;
import com.javafast.common.config.Global;
import com.javafast.common.persistence.Page;
import com.javafast.common.web.BaseController;
import com.javafast.common.utils.StringUtils;
import com.javafast.common.utils.excel.ExportExcel;
import com.javafast.common.utils.excel.ImportExcel;
import com.javafast.modules.jgxy.entity.JgxyNote;
import com.javafast.modules.jgxy.service.JgxyNoteService;

/**
 * 文章Controller
 * @author javafast
 * @version 2019-06-04
 */
@Controller
@RequestMapping(value = "${adminPath}/jgxy/jgxyNote")
public class JgxyNoteController extends BaseController {

	@Autowired
	private JgxyNoteService jgxyNoteService;
	
	@ModelAttribute
	public JgxyNote get(@RequestParam(required=false) String id) {
		JgxyNote entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jgxyNoteService.get(id);
		}
		if (entity == null){
			entity = new JgxyNote();
		}
		return entity;
	}
	
	/**
	 * 文章列表页面（左树右表）
	 */
	@RequiresPermissions("jgxy:jgxyNote:list")
	@RequestMapping(value = "index")
	public String index(JgxyNote jgxyNote, HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/jgxy/jgxyNoteIndex";
	}
	
	/**
	 * 文章列表页面
	 */
	@RequiresPermissions("jgxy:jgxyNote:list")
	@RequestMapping(value = {"list", ""})
	public String list(JgxyNote jgxyNote, HttpServletRequest request, HttpServletResponse response, Model model) {

		
		String menuType = (String)request.getParameter("jgxySysMenu.menuType");
		if (menuType == null || menuType.equals("1") || "null".equals(menuType)) {
			//menuType == 1  为新闻列表
			Page<JgxyNote> page = jgxyNoteService.findPage(new Page<JgxyNote>(request, response), jgxyNote);
			model.addAttribute("page", page);
			return "modules/jgxy/jgxyNoteList";
		} else {
			//menuType == 2 为新闻详细
			//取出菜单id 
			String jgxySysMenuId = (String)request.getParameter("jgxySysMenu.id");

			JgxyNote jn = new JgxyNote();
			JgxySysMenu jsm = new JgxySysMenu();
			jsm.setId(jgxySysMenuId);
			jn.setJgxySysMenu(jsm);
			
			List<JgxyNote> jgxyNoteList = jgxyNoteService.findList(jn);
			
			if(jgxyNoteList == null || jgxyNoteList.size() == 0){
				return "modules/jgxy/jgxyNoteForm";
			}else{
				jn = jgxyNoteList.get(0);
				model.addAttribute("jgxyNote", jn);
				return "modules/jgxy/jgxyNoteView";
			}
		}
		
		
	}

	/**
	 * 编辑文章表单页面
	 */
	@RequiresPermissions(value={"jgxy:jgxyNote:view","jgxy:jgxyNote:add","jgxy:jgxyNote:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(JgxyNote jgxyNote, Model model) {
		model.addAttribute("jgxyNote", jgxyNote);
		return "modules/jgxy/jgxyNoteForm";
	}
	
	/**
	 * 编辑文章表单页面
	 */
	@RequiresPermissions(value={"jgxy:jgxyNote:view","jgxy:jgxyNote:add","jgxy:jgxyNote:edit"},logical=Logical.OR)
	@RequestMapping(value = "aaaaaa")
	public String aaaaaa(JgxyNote jgxyNote, Model model) {
		return "modules/jgxy/jgxyNoteForm";
	}
	
	/**
	 * 查看文章页面
	 */
	@RequiresPermissions(value="jgxy:jgxyNote:view")
	@RequestMapping(value = "view")
	public String view(JgxyNote jgxyNote, Model model) {
		model.addAttribute("jgxyNote", jgxyNote);
		return "modules/jgxy/jgxyNoteView";
	}
	
	/**
	 * 保存文章
	 */
	@RequestMapping(value = "save")
	public String save(JgxyNote jgxyNote, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jgxyNote)){
			return form(jgxyNote, model);
		}
		
		try{
		
			if(!jgxyNote.getIsNewRecord()){//编辑表单保存				
				JgxyNote t = jgxyNoteService.get(jgxyNote.getId());//从数据库取出记录的值
				MyBeanUtils.copyBeanNotNull2Bean(jgxyNote, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
					
					
					int clickThroughput ;
					//如果不是整整数 则默认为0
					if(isMatches(t.getClickThroughput())){
						clickThroughput = Integer.parseInt(t.getClickThroughput());
					}else{
						clickThroughput = 0;
					}
					t.setClickThroughput(String.valueOf(clickThroughput));
					
					jgxyNoteService.save(t);//保存
			}else{//新增表单保存
				jgxyNoteService.save(jgxyNote);//保存
			}
			addMessage(redirectAttributes, "保存文章成功");
		}catch(Exception e){			
			e.printStackTrace();
			addMessage(redirectAttributes, "保存文章失败");
		}finally{
			return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyNote/?repage";
		}
	}
	
	/**
	 * 删除文章
	 */
	@RequiresPermissions("jgxy:jgxyNote:del")
	@RequestMapping(value = "delete")
	public String delete(JgxyNote jgxyNote, RedirectAttributes redirectAttributes) {
		jgxyNoteService.delete(jgxyNote);
		addMessage(redirectAttributes, "删除文章成功");
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyNote/?repage";
	}
	
	/**
	 * 批量删除文章
	 */
	@RequiresPermissions("jgxy:jgxyNote:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			jgxyNoteService.delete(jgxyNoteService.get(id));
		}
		addMessage(redirectAttributes, "删除文章成功");
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyNote/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("jgxy:jgxyNote:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(JgxyNote jgxyNote, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "文章"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<JgxyNote> page = jgxyNoteService.findPage(new Page<JgxyNote>(request, response, -1), jgxyNote);
    		new ExportExcel("文章", JgxyNote.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出文章记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyNote/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("jgxy:jgxyNote:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<JgxyNote> list = ei.getDataList(JgxyNote.class);
			for (JgxyNote jgxyNote : list){
				try{
					jgxyNoteService.save(jgxyNote);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条文章记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条文章记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入文章失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyNote/?repage";
    }
	
	/**
	 * 下载导入文章数据模板
	 */
	@RequiresPermissions("jgxy:jgxyNote:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "文章数据导入模板.xlsx";
    		List<JgxyNote> list = Lists.newArrayList(); 
    		new ExportExcel("文章数据", JgxyNote.class, 2).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyNote/?repage";
    }
	
	/**
	 * 文章列表选择器
	 */
	@RequestMapping(value = "selectList")
	public String selectList(JgxyNote jgxyNote, HttpServletRequest request, HttpServletResponse response, Model model) {		
        list(jgxyNote, request, response, model);
        return "modules/jgxy/jgxyNoteSelectList";
	}
	
	//判断一个字符串 是否为正整数
	public boolean isMatches(String bot) {
		if (bot != null && !bot.equals("")) {
			boolean flag = false;
			String regex = "^[1-9]+[0-9]*$";
			// ^[1-9]+\\d*$
			Pattern p = Pattern.compile(regex);
			Matcher m = p.matcher(bot);
			if (m.find()) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
}