package com.javafast.modules.jgxy.web;

import java.util.List;

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
import com.javafast.modules.jgxy.entity.JgxyImg;
import com.javafast.modules.jgxy.service.JgxyImgService;

/**
 * jgxy_imgController
 * @author javafast
 * @version 2019-06-23
 */
@Controller
@RequestMapping(value = "${adminPath}/jgxy/jgxyImg")
public class JgxyImgController extends BaseController {

	@Autowired
	private JgxyImgService jgxyImgService;
	
	@ModelAttribute
	public JgxyImg get(@RequestParam(required=false) String id) {
		JgxyImg entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jgxyImgService.get(id);
		}
		if (entity == null){
			entity = new JgxyImg();
		}
		return entity;
	}
	
	/**
	 * 轮播图列表页面
	 */
	@RequiresPermissions("jgxy:jgxyImg:list")
	@RequestMapping(value = {"list", ""})
	public String list(JgxyImg jgxyImg, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JgxyImg> page = jgxyImgService.findPage(new Page<JgxyImg>(request, response), jgxyImg); 
		model.addAttribute("page", page);
		return "modules/jgxy/jgxyImgList";
	}

	/**
	 * 编辑轮播图表单页面
	 */
	@RequiresPermissions(value={"jgxy:jgxyImg:view","jgxy:jgxyImg:add","jgxy:jgxyImg:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(JgxyImg jgxyImg, Model model) {
		model.addAttribute("jgxyImg", jgxyImg);
		return "modules/jgxy/jgxyImgForm";
	}
	
	/**
	 * 查看轮播图页面
	 */
	@RequiresPermissions(value="jgxy:jgxyImg:view")
	@RequestMapping(value = "view")
	public String view(JgxyImg jgxyImg, Model model) {
		model.addAttribute("jgxyImg", jgxyImg);
		return "modules/jgxy/jgxyImgView";
	}

	/**
	 * 保存轮播图
	 */
	@RequiresPermissions(value={"jgxy:jgxyImg:add","jgxy:jgxyImg:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(JgxyImg jgxyImg, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jgxyImg)){
			return form(jgxyImg, model);
		}
		
		try{
		
			if(!jgxyImg.getIsNewRecord()){//编辑表单保存				
				JgxyImg t = jgxyImgService.get(jgxyImg.getId());//从数据库取出记录的值
				MyBeanUtils.copyBeanNotNull2Bean(jgxyImg, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
				
				//超链接为空的时候 存储为  javascript:void(0)  省的每次点击刷新网页
				if(t.getImgHref() == null || "".equals(t.getImgHref()) || "null".equals(t.getImgHref())){
					t.setImgHref("javascript:void(0)");
				}
				jgxyImgService.save(t);//保存
			}else{//新增表单保存
				//超链接为空的时候 存储为  javascript:void(0)  省的每次点击刷新网页
				if(jgxyImg.getImgHref() == null || "".equals(jgxyImg.getImgHref()) || "null".equals(jgxyImg.getImgHref())){
					jgxyImg.setImgHref("javascript:void(0)");
				}
				jgxyImgService.save(jgxyImg);//保存
			}
			addMessage(redirectAttributes, "保存轮播图成功");
		}catch(Exception e){			
			e.printStackTrace();
			addMessage(redirectAttributes, "保存轮播图失败");
		}finally{
			return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyImg/?repage";
		}
	}
	
	/**
	 * 删除轮播图
	 */
	@RequiresPermissions("jgxy:jgxyImg:del")
	@RequestMapping(value = "delete")
	public String delete(JgxyImg jgxyImg, RedirectAttributes redirectAttributes) {
		jgxyImgService.delete(jgxyImg);
		addMessage(redirectAttributes, "删除轮播图成功");
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyImg/?repage";
	}
	
	/**
	 * 批量删除轮播图
	 */
	@RequiresPermissions("jgxy:jgxyImg:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			jgxyImgService.delete(jgxyImgService.get(id));
		}
		addMessage(redirectAttributes, "删除轮播图成功");
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyImg/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("jgxy:jgxyImg:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(JgxyImg jgxyImg, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "轮播图"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<JgxyImg> page = jgxyImgService.findPage(new Page<JgxyImg>(request, response, -1), jgxyImg);
    		new ExportExcel("轮播图", JgxyImg.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出轮播图记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyImg/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("jgxy:jgxyImg:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<JgxyImg> list = ei.getDataList(JgxyImg.class);
			for (JgxyImg jgxyImg : list){
				try{
					jgxyImgService.save(jgxyImg);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条轮播图记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条轮播图记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入轮播图失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyImg/?repage";
    }
	
	/**
	 * 下载导入轮播图数据模板
	 */
	@RequiresPermissions("jgxy:jgxyImg:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "轮播图数据导入模板.xlsx";
    		List<JgxyImg> list = Lists.newArrayList(); 
    		new ExportExcel("轮播图数据", JgxyImg.class, 2).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyImg/?repage";
    }
	
	/**
	 * 轮播图列表选择器
	 */
	@RequestMapping(value = "selectList")
	public String selectList(JgxyImg jgxyImg, HttpServletRequest request, HttpServletResponse response, Model model) {		
        list(jgxyImg, request, response, model);
        return "modules/jgxy/jgxyImgSelectList";
	}
	
}