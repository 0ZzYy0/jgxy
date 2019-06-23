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
import com.javafast.modules.jgxy.entity.JgxyFooter;
import com.javafast.modules.jgxy.service.JgxyFooterService;

/**
 * 前台页脚Controller
 * 
 * @author javafast
 * @version 2019-06-22
 */
@Controller
@RequestMapping(value = "${adminPath}/jgxy/jgxyFooter")
public class JgxyFooterController extends BaseController {

	@Autowired
	private JgxyFooterService jgxyFooterService;

	@ModelAttribute
	public JgxyFooter get(@RequestParam(required = false) String id) {
		JgxyFooter entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = jgxyFooterService.get(id);
		}
		if (entity == null) {
			entity = new JgxyFooter();
		}
		return entity;
	}

	/**
	 * 前台页脚列表页面
	 */
	@RequiresPermissions("jgxy:jgxyFooter:list")
	@RequestMapping(value = { "list", "" })
	public String list(JgxyFooter jgxyFooter, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JgxyFooter> page = jgxyFooterService.findPage(new Page<JgxyFooter>(request, response), jgxyFooter);
		model.addAttribute("page", page);
		return "modules/jgxy/jgxyFooterList";
	}

	/**
	 * 编辑前台页脚表单页面
	 */
	@RequiresPermissions(value = { "jgxy:jgxyFooter:view", "jgxy:jgxyFooter:add", "jgxy:jgxyFooter:edit" }, logical = Logical.OR)
	@RequestMapping(value = "form")
	public String form(JgxyFooter jgxyFooter, Model model) {
		model.addAttribute("jgxyFooter", jgxyFooter);
		return "modules/jgxy/jgxyFooterForm";
	}

	/**
	 * 查看前台页脚页面
	 */
	@RequiresPermissions(value = "jgxy:jgxyFooter:view")
	@RequestMapping(value = "view")
	public String view(JgxyFooter jgxyFooter, Model model) {
		model.addAttribute("jgxyFooter", jgxyFooter);
		return "modules/jgxy/jgxyFooterView";
	}

	/**
	 * 保存前台页脚
	 */
	@RequiresPermissions(value = { "jgxy:jgxyFooter:add", "jgxy:jgxyFooter:edit" }, logical = Logical.OR)
	@RequestMapping(value = "save")
	public String save(JgxyFooter jgxyFooter, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jgxyFooter)) {
			return form(jgxyFooter, model);
		}

		try {

			if (!jgxyFooter.getIsNewRecord()) {// 编辑表单保存
				JgxyFooter t = jgxyFooterService.get(jgxyFooter.getId());// 从数据库取出记录的值
				MyBeanUtils.copyBeanNotNull2Bean(jgxyFooter, t);// 将编辑表单中的非NULL值覆盖数据库记录中的值

				// 如果state为1的话 ,则让其他数据为0,因为能同时存在一个 在用
				if (t.getState().equals("1")) {
					jgxyFooterService.updateState(t.getId());
				}

				jgxyFooterService.save(t);// 保存
			} else {// 新增表单保存

				// 如果state为1的话 ,则让其他数据为0,因为能同时存在一个 在用
				if (jgxyFooter.getState().equals("1")) {
					jgxyFooterService.updateState(jgxyFooter.getId());
				}
				jgxyFooterService.save(jgxyFooter);// 保存
			}
			addMessage(redirectAttributes, "保存前台页脚成功");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "保存前台页脚失败");
		} finally {
			return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyFooter/?repage";
		}
	}

	/**
	 * 删除前台页脚
	 */
	@RequiresPermissions("jgxy:jgxyFooter:del")
	@RequestMapping(value = "delete")
	public String delete(JgxyFooter jgxyFooter, RedirectAttributes redirectAttributes) {
		jgxyFooterService.delete(jgxyFooter);
		addMessage(redirectAttributes, "删除前台页脚成功");
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyFooter/?repage";
	}

	/**
	 * 批量删除前台页脚
	 */
	@RequiresPermissions("jgxy:jgxyFooter:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] = ids.split(",");
		for (String id : idArray) {
			jgxyFooterService.delete(jgxyFooterService.get(id));
		}
		addMessage(redirectAttributes, "删除前台页脚成功");
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyFooter/?repage";
	}

	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("jgxy:jgxyFooter:export")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(JgxyFooter jgxyFooter, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "前台页脚" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<JgxyFooter> page = jgxyFooterService.findPage(new Page<JgxyFooter>(request, response, -1), jgxyFooter);
			new ExportExcel("前台页脚", JgxyFooter.class).setDataList(page.getList()).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出前台页脚记录失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyFooter/?repage";
	}

	/**
	 * 导入Excel数据
	 */
	@RequiresPermissions("jgxy:jgxyFooter:import")
	@RequestMapping(value = "import", method = RequestMethod.POST)
	public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<JgxyFooter> list = ei.getDataList(JgxyFooter.class);
			for (JgxyFooter jgxyFooter : list) {
				try {
					jgxyFooterService.save(jgxyFooter);
					successNum++;
				} catch (ConstraintViolationException ex) {
					failureNum++;
				} catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum > 0) {
				failureMsg.insert(0, "，失败 " + failureNum + " 条前台页脚记录。");
			}
			addMessage(redirectAttributes, "已成功导入 " + successNum + " 条前台页脚记录" + failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入前台页脚失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyFooter/?repage";
	}

	/**
	 * 下载导入前台页脚数据模板
	 */
	@RequiresPermissions("jgxy:jgxyFooter:import")
	@RequestMapping(value = "import/template")
	public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "前台页脚数据导入模板.xlsx";
			List<JgxyFooter> list = Lists.newArrayList();
			new ExportExcel("前台页脚数据", JgxyFooter.class, 2).setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/jgxy/jgxyFooter/?repage";
	}

	/**
	 * 前台页脚列表选择器
	 */
	@RequestMapping(value = "selectList")
	public String selectList(JgxyFooter jgxyFooter, HttpServletRequest request, HttpServletResponse response, Model model) {
		list(jgxyFooter, request, response, model);
		return "modules/jgxy/jgxyFooterSelectList";
	}

}