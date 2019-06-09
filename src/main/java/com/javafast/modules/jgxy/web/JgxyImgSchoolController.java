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
import com.javafast.modules.jgxy.entity.JgxyImgSchool;
import com.javafast.modules.jgxy.service.JgxyImgSchoolService;

/**
 * jgxy_img_schoolController
 * @author zy
 * @version 2019-06-09
 */
@Controller
@RequestMapping(value = "${adminPath}/jgxy/jgxyImgSchool")
public class JgxyImgSchoolController extends BaseController {

	@Autowired
	private JgxyImgSchoolService jgxyImgSchoolService;
	
	@ModelAttribute
	public JgxyImgSchool get(@RequestParam(required=false) String id) {
		JgxyImgSchool entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jgxyImgSchoolService.get(id);
		}
		if (entity == null){
			entity = new JgxyImgSchool();
		}
		return entity;
	}
	
	/**
	 * 校园风采列表页面
	 */
	@RequiresPermissions("jgxy:jgxyImgSchool:list")
	@RequestMapping(value = {"list", ""})
	public String list(JgxyImgSchool jgxyImgSchool, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JgxyImgSchool> page = jgxyImgSchoolService.findPage(new Page<JgxyImgSchool>(request, response), jgxyImgSchool); 
		model.addAttribute("page", page);
		return "modules/jgxy/jgxyImgSchoolList";
	}

	/**
	 * 编辑校园风采表单页面
	 */
	@RequiresPermissions(value={"jgxy:jgxyImgSchool:view","jgxy:jgxyImgSchool:add","jgxy:jgxyImgSchool:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(JgxyImgSchool jgxyImgSchool, Model model) {
		model.addAttribute("jgxyImgSchool", jgxyImgSchool);
		return "modules/jgxy/jgxyImgSchoolForm";
	}
	
	/**
	 * 查看校园风采页面
	 */
	@RequiresPermissions(value="jgxy:jgxyImgSchool:view")
	@RequestMapping(value = "view")
	public String view(JgxyImgSchool jgxyImgSchool, Model model) {
		model.addAttribute("jgxyImgSchool", jgxyImgSchool);
		return "modules/jgxy/jgxyImgSchoolView";
	}

	/**
	 * 保存校园风采
	 */
	@RequiresPermissions(value={"jgxy:jgxyImgSchool:add","jgxy:jgxyImgSchool:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(JgxyImgSchool jgxyImgSchool, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jgxyImgSchool)){
			return form(jgxyImgSchool, model);
		}
		
		try{
		
			if(!jgxyImgSchool.getIsNewRecord()){//编辑表单保存				
				JgxyImgSchool t = jgxyImgSchoolService.get(jgxyImgSchool.getId());//从数据库取出记录的值
				MyBeanUtils.copyBeanNotNull2Bean(jgxyImgSchool, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
				jgxyImgSchoolService.save(t);//保存
			}else{//新增表单保存
				jgxyImgSchoolService.save(jgxyImgSchool);//保存
			}
			addMessage(redirectAttributes, "保存校园风采成功");
		}catch(Exception e){			
			e.printStackTrace();
			addMessage(redirectAttributes, "保存校园风采失败");
		}finally{
			return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyImgSchool/?repage";
		}
	}
	
	/**
	 * 删除校园风采
	 */
	@RequiresPermissions("jgxy:jgxyImgSchool:del")
	@RequestMapping(value = "delete")
	public String delete(JgxyImgSchool jgxyImgSchool, RedirectAttributes redirectAttributes) {
		jgxyImgSchoolService.delete(jgxyImgSchool);
		addMessage(redirectAttributes, "删除校园风采成功");
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyImgSchool/?repage";
	}
	
	/**
	 * 批量删除校园风采
	 */
	@RequiresPermissions("jgxy:jgxyImgSchool:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			jgxyImgSchoolService.delete(jgxyImgSchoolService.get(id));
		}
		addMessage(redirectAttributes, "删除校园风采成功");
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyImgSchool/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("jgxy:jgxyImgSchool:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(JgxyImgSchool jgxyImgSchool, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "校园风采"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<JgxyImgSchool> page = jgxyImgSchoolService.findPage(new Page<JgxyImgSchool>(request, response, -1), jgxyImgSchool);
    		new ExportExcel("校园风采", JgxyImgSchool.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出校园风采记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyImgSchool/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("jgxy:jgxyImgSchool:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<JgxyImgSchool> list = ei.getDataList(JgxyImgSchool.class);
			for (JgxyImgSchool jgxyImgSchool : list){
				try{
					jgxyImgSchoolService.save(jgxyImgSchool);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条校园风采记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条校园风采记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入校园风采失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyImgSchool/?repage";
    }
	
	/**
	 * 下载导入校园风采数据模板
	 */
	@RequiresPermissions("jgxy:jgxyImgSchool:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "校园风采数据导入模板.xlsx";
    		List<JgxyImgSchool> list = Lists.newArrayList(); 
    		new ExportExcel("校园风采数据", JgxyImgSchool.class, 2).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/jgxy/jgxyImgSchool/?repage";
    }
	
	/**
	 * 校园风采列表选择器
	 */
	@RequestMapping(value = "selectList")
	public String selectList(JgxyImgSchool jgxyImgSchool, HttpServletRequest request, HttpServletResponse response, Model model) {		
        list(jgxyImgSchool, request, response, model);
        return "modules/jgxy/jgxyImgSchoolSelectList";
	}
	
}