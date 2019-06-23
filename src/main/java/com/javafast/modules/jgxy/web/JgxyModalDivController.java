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
import com.javafast.modules.jgxy.entity.JgxyModalDiv;
import com.javafast.modules.jgxy.service.JgxyModalDivService;

/**
 * 模态窗口管理Controller
 * 
 * @author javafast
 * @version 2019-06-23
 */
@Controller
@RequestMapping(value = "${adminPath}/jgxy/jgxyModalDiv")
public class JgxyModalDivController extends BaseController {

	@Autowired
	private JgxyModalDivService jgxyModalDivService;

	@ModelAttribute
	public JgxyModalDiv get(@RequestParam(required = false) String id) {
		JgxyModalDiv entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = jgxyModalDivService.get(id);
		}
		if (entity == null) {
			entity = new JgxyModalDiv();
		}
		return entity;
	}

	/**
	 * 模态窗口管理列表页面
	 */
	@RequiresPermissions("jgxy:jgxyModalDiv:list")
	@RequestMapping(value = { "list", "" })
	public String list(JgxyModalDiv jgxyModalDiv, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JgxyModalDiv> page = jgxyModalDivService.findPage(new Page<JgxyModalDiv>(request, response), jgxyModalDiv);
		model.addAttribute("page", page);
		return "modules/jgxy/jgxyModalDivList";
	}

	/**
	 * 编辑模态窗口管理表单页面
	 */
	@RequiresPermissions(value = { "jgxy:jgxyModalDiv:view", "jgxy:jgxyModalDiv:add", "jgxy:jgxyModalDiv:edit" }, logical = Logical.OR)
	@RequestMapping(value = "form")
	public String form(JgxyModalDiv jgxyModalDiv, Model model) {
		model.addAttribute("jgxyModalDiv", jgxyModalDiv);
		return "modules/jgxy/jgxyModalDivForm";
	}

	/**
	 * 查看模态窗口管理页面
	 */
	@RequiresPermissions(value = "jgxy:jgxyModalDiv:view")
	@RequestMapping(value = "view")
	public String view(JgxyModalDiv jgxyModalDiv, Model model) {
		model.addAttribute("jgxyModalDiv", jgxyModalDiv);
		return "modules/jgxy/jgxyModalDivView";
	}

	/**
	 * 保存模态窗口管理
	 */
	@RequiresPermissions(value = { "jgxy:jgxyModalDiv:add", "jgxy:jgxyModalDiv:edit" }, logical = Logical.OR)
	@RequestMapping(value = "save")
	public String save(JgxyModalDiv jgxyModalDiv, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jgxyModalDiv)) {
			return form(jgxyModalDiv, model);
		}

		try {

			if (!jgxyModalDiv.getIsNewRecord()) {// 编辑表单保存
				JgxyModalDiv t = jgxyModalDivService.get(jgxyModalDiv.getId());// 从数据库取出记录的值
				MyBeanUtils.copyBeanNotNull2Bean(jgxyModalDiv, t);// 将编辑表单中的非NULL值覆盖数据库记录中的值

				// 把其他数据的状态置为 0
				if (t.getState().equals("1")) {
					jgxyModalDivService.updateState(t.getId());
				}
				jgxyModalDivService.save(t);// 保存
			} else {// 新增表单保存

				// 把其他数据的状态置为 0
				if (jgxyModalDiv.getState().equals("1")) {
					jgxyModalDivService.updateState(jgxyModalDiv.getId());
				}
				jgxyModalDivService.save(jgxyModalDiv);// 保存
			}
			addMessage(redirectAttributes, "保存模态窗口管理成功");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "保存模态窗口管理失败");
		} finally {
			return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyModalDiv/?repage";
		}
	}

	/**
	 * 删除模态窗口管理
	 */
	@RequiresPermissions("jgxy:jgxyModalDiv:del")
	@RequestMapping(value = "delete")
	public String delete(JgxyModalDiv jgxyModalDiv, RedirectAttributes redirectAttributes) {
		jgxyModalDivService.delete(jgxyModalDiv);
		addMessage(redirectAttributes, "删除模态窗口管理成功");
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyModalDiv/?repage";
	}

	/**
	 * 批量删除模态窗口管理
	 */
	@RequiresPermissions("jgxy:jgxyModalDiv:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] = ids.split(",");
		for (String id : idArray) {
			jgxyModalDivService.delete(jgxyModalDivService.get(id));
		}
		addMessage(redirectAttributes, "删除模态窗口管理成功");
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyModalDiv/?repage";
	}

	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("jgxy:jgxyModalDiv:export")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(JgxyModalDiv jgxyModalDiv, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "模态窗口管理" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<JgxyModalDiv> page = jgxyModalDivService.findPage(new Page<JgxyModalDiv>(request, response, -1), jgxyModalDiv);
			new ExportExcel("模态窗口管理", JgxyModalDiv.class).setDataList(page.getList()).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出模态窗口管理记录失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyModalDiv/?repage";
	}

	/**
	 * 导入Excel数据
	 */
	@RequiresPermissions("jgxy:jgxyModalDiv:import")
	@RequestMapping(value = "import", method = RequestMethod.POST)
	public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<JgxyModalDiv> list = ei.getDataList(JgxyModalDiv.class);
			for (JgxyModalDiv jgxyModalDiv : list) {
				try {
					jgxyModalDivService.save(jgxyModalDiv);
					successNum++;
				} catch (ConstraintViolationException ex) {
					failureNum++;
				} catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum > 0) {
				failureMsg.insert(0, "，失败 " + failureNum + " 条模态窗口管理记录。");
			}
			addMessage(redirectAttributes, "已成功导入 " + successNum + " 条模态窗口管理记录" + failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模态窗口管理失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyModalDiv/?repage";
	}

	/**
	 * 下载导入模态窗口管理数据模板
	 */
	@RequiresPermissions("jgxy:jgxyModalDiv:import")
	@RequestMapping(value = "import/template")
	public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "模态窗口管理数据导入模板.xlsx";
			List<JgxyModalDiv> list = Lists.newArrayList();
			new ExportExcel("模态窗口管理数据", JgxyModalDiv.class, 2).setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyModalDiv/?repage";
	}

	/**
	 * 模态窗口管理列表选择器
	 */
	@RequestMapping(value = "selectList")
	public String selectList(JgxyModalDiv jgxyModalDiv, HttpServletRequest request, HttpServletResponse response, Model model) {
		list(jgxyModalDiv, request, response, model);
		return "modules/jgxy/jgxyModalDivSelectList";
	}

}