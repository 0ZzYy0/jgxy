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
import com.javafast.modules.jgxy.entity.JgxyFloatDiv;
import com.javafast.modules.jgxy.service.JgxyFloatDivService;

/**
 * 悬浮窗口Controller
 * 
 * @author javafast
 * @version 2019-06-23
 */
@Controller
@RequestMapping(value = "${adminPath}/jgxy/jgxyFloatDiv")
public class JgxyFloatDivController extends BaseController {

	@Autowired
	private JgxyFloatDivService jgxyFloatDivService;

	@ModelAttribute
	public JgxyFloatDiv get(@RequestParam(required = false) String id) {
		JgxyFloatDiv entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = jgxyFloatDivService.get(id);
		}
		if (entity == null) {
			entity = new JgxyFloatDiv();
		}
		return entity;
	}

	/**
	 * 悬浮窗口列表页面
	 */
	@RequiresPermissions("jgxy:jgxyFloatDiv:list")
	@RequestMapping(value = { "list", "" })
	public String list(JgxyFloatDiv jgxyFloatDiv, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JgxyFloatDiv> page = jgxyFloatDivService.findPage(new Page<JgxyFloatDiv>(request, response), jgxyFloatDiv);
		model.addAttribute("page", page);
		return "modules/jgxy/jgxyFloatDivList";
	}

	/**
	 * 编辑悬浮窗口表单页面
	 */
	@RequiresPermissions(value = { "jgxy:jgxyFloatDiv:view", "jgxy:jgxyFloatDiv:add", "jgxy:jgxyFloatDiv:edit" }, logical = Logical.OR)
	@RequestMapping(value = "form")
	public String form(JgxyFloatDiv jgxyFloatDiv, Model model) {
		model.addAttribute("jgxyFloatDiv", jgxyFloatDiv);
		return "modules/jgxy/jgxyFloatDivForm";
	}

	/**
	 * 查看悬浮窗口页面
	 */
	@RequiresPermissions(value = "jgxy:jgxyFloatDiv:view")
	@RequestMapping(value = "view")
	public String view(JgxyFloatDiv jgxyFloatDiv, Model model) {
		model.addAttribute("jgxyFloatDiv", jgxyFloatDiv);
		return "modules/jgxy/jgxyFloatDivView";
	}

	/**
	 * 保存悬浮窗口
	 */
	@RequiresPermissions(value = { "jgxy:jgxyFloatDiv:add", "jgxy:jgxyFloatDiv:edit" }, logical = Logical.OR)
	@RequestMapping(value = "save")
	public String save(JgxyFloatDiv jgxyFloatDiv, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jgxyFloatDiv)) {
			return form(jgxyFloatDiv, model);
		}

		try {

			if (!jgxyFloatDiv.getIsNewRecord()) {// 编辑表单保存
				JgxyFloatDiv t = jgxyFloatDivService.get(jgxyFloatDiv.getId());// 从数据库取出记录的值
				MyBeanUtils.copyBeanNotNull2Bean(jgxyFloatDiv, t);// 将编辑表单中的非NULL值覆盖数据库记录中的值

				// 把其他数据 状态设置成 0
				if (t.getState().equals("1")) {
					jgxyFloatDivService.updateState(t.getId());
				}
				jgxyFloatDivService.save(t);// 保存
			} else {// 新增表单保存
					// 把其他数据 状态设置成 0
				if (jgxyFloatDiv.getState().equals("1")) {
					jgxyFloatDivService.updateState(jgxyFloatDiv.getId());
				}
				jgxyFloatDivService.save(jgxyFloatDiv);// 保存
			}
			addMessage(redirectAttributes, "保存悬浮窗口成功");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "保存悬浮窗口失败");
		} finally {
			return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyFloatDiv/?repage";
		}
	}

	/**
	 * 删除悬浮窗口
	 */
	@RequiresPermissions("jgxy:jgxyFloatDiv:del")
	@RequestMapping(value = "delete")
	public String delete(JgxyFloatDiv jgxyFloatDiv, RedirectAttributes redirectAttributes) {
		jgxyFloatDivService.delete(jgxyFloatDiv);
		addMessage(redirectAttributes, "删除悬浮窗口成功");
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyFloatDiv/?repage";
	}

	/**
	 * 批量删除悬浮窗口
	 */
	@RequiresPermissions("jgxy:jgxyFloatDiv:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] = ids.split(",");
		for (String id : idArray) {
			jgxyFloatDivService.delete(jgxyFloatDivService.get(id));
		}
		addMessage(redirectAttributes, "删除悬浮窗口成功");
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyFloatDiv/?repage";
	}

	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("jgxy:jgxyFloatDiv:export")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(JgxyFloatDiv jgxyFloatDiv, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "悬浮窗口" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<JgxyFloatDiv> page = jgxyFloatDivService.findPage(new Page<JgxyFloatDiv>(request, response, -1), jgxyFloatDiv);
			new ExportExcel("悬浮窗口", JgxyFloatDiv.class).setDataList(page.getList()).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出悬浮窗口记录失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyFloatDiv/?repage";
	}

	/**
	 * 导入Excel数据
	 */
	@RequiresPermissions("jgxy:jgxyFloatDiv:import")
	@RequestMapping(value = "import", method = RequestMethod.POST)
	public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<JgxyFloatDiv> list = ei.getDataList(JgxyFloatDiv.class);
			for (JgxyFloatDiv jgxyFloatDiv : list) {
				try {
					jgxyFloatDivService.save(jgxyFloatDiv);
					successNum++;
				} catch (ConstraintViolationException ex) {
					failureNum++;
				} catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum > 0) {
				failureMsg.insert(0, "，失败 " + failureNum + " 条悬浮窗口记录。");
			}
			addMessage(redirectAttributes, "已成功导入 " + successNum + " 条悬浮窗口记录" + failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入悬浮窗口失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyFloatDiv/?repage";
	}

	/**
	 * 下载导入悬浮窗口数据模板
	 */
	@RequiresPermissions("jgxy:jgxyFloatDiv:import")
	@RequestMapping(value = "import/template")
	public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "悬浮窗口数据导入模板.xlsx";
			List<JgxyFloatDiv> list = Lists.newArrayList();
			new ExportExcel("悬浮窗口数据", JgxyFloatDiv.class, 2).setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyFloatDiv/?repage";
	}

	/**
	 * 悬浮窗口列表选择器
	 */
	@RequestMapping(value = "selectList")
	public String selectList(JgxyFloatDiv jgxyFloatDiv, HttpServletRequest request, HttpServletResponse response, Model model) {
		list(jgxyFloatDiv, request, response, model);
		return "modules/jgxy/jgxyFloatDivSelectList";
	}

}