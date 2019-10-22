package com.javafast.modules.xxgk.web;

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

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.javafast.modules.xxgk.entity.XxgkSysMenu;
import com.google.common.collect.Lists;
import com.javafast.common.utils.DateUtils;
import com.javafast.common.utils.MyBeanUtils;
import com.javafast.common.config.Global;
import com.javafast.common.persistence.Page;
import com.javafast.common.web.BaseController;
import com.javafast.common.utils.StringUtils;
import com.javafast.common.utils.excel.ExportExcel;
import com.javafast.common.utils.excel.ImportExcel;
import com.javafast.modules.xxgk.entity.XxgkNote;
import com.javafast.modules.xxgk.service.XxgkNoteService;

/**
 * 富文本编辑器Controller
 * 
 * @author javafast
 * @version 2019-08-10
 */
@Controller
@RequestMapping(value = "${adminPath}/xxgk/xxgkNote")
public class XxgkNoteController extends BaseController {

	@Autowired
	private XxgkNoteService xxgkNoteService;

	@ModelAttribute
	public XxgkNote get(@RequestParam(required = false) String id) {
		XxgkNote entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = xxgkNoteService.get(id);
		}
		if (entity == null) {
			entity = new XxgkNote();
		}
		return entity;
	}

	/**
	 * 富文本编辑器列表页面（左树右表）
	 */
	@RequiresPermissions("xxgk:xxgkNote:list")
	@RequestMapping(value = "index")
	public String index(XxgkNote xxgkNote, HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/xxgk/xxgkNoteIndex";
	}

	/**
	 * 富文本编辑器列表页面
	 */
	@RequiresPermissions("xxgk:xxgkNote:list")
	@RequestMapping(value = { "list", "" })
	public String list(XxgkNote xxgkNote, HttpServletRequest request, HttpServletResponse response, Model model) {

		String menuType = (String) request.getParameter("xxgkSysMenu.menuType");
		if (menuType == null || menuType.equals("1") || "null".equals(menuType)) {
			// menuType == 1 为新闻列表
			String xxgkSysMenuId = "";
			if (xxgkNote.getXxgkSysMenu() != null) {
				if (xxgkNote.getXxgkSysMenu().getId() != null && !("").equals(xxgkNote.getXxgkSysMenu().getId())) {
					xxgkSysMenuId = xxgkNote.getXxgkSysMenu().getId();
				} else {
					xxgkSysMenuId = request.getParameter("xxgkSysMenuId");
				}
			} else {
				xxgkSysMenuId = request.getParameter("xxgkSysMenuId");
			}
			System.out.println(xxgkSysMenuId);
			System.out.println(xxgkSysMenuId);
			System.out.println(xxgkSysMenuId);
			System.out.println(xxgkSysMenuId);
			xxgkNote.setXxgkSysMenu(new XxgkSysMenu());
			xxgkNote.getXxgkSysMenu().setId(xxgkSysMenuId);
			
			Page<XxgkNote> page = xxgkNoteService.findPage(new Page<XxgkNote>(request, response), xxgkNote);
			request.setAttribute("xxgkSysMenuId",xxgkNote.getXxgkSysMenu().getId());
			model.addAttribute("page", page);
			return "modules/xxgk/xxgkNoteList";
		} else {
			// menuType == 2 为新闻详细
			// 取出菜单id
			String xxgkSysMenuId = (String) request.getParameter("xxgkSysMenu.id");

			XxgkNote jn = new XxgkNote();
			XxgkSysMenu jsm = new XxgkSysMenu();
			jsm.setId(xxgkSysMenuId);
			jn.setXxgkSysMenu(jsm);

			List<XxgkNote> xxgkNoteList = xxgkNoteService.findList(jn);

			if (xxgkNoteList == null || xxgkNoteList.size() == 0) {
				return "modules/xxgk/xxgkNoteForm";
			} else {
				jn = xxgkNoteList.get(0);
				model.addAttribute("xxgkNote", jn);
				return "modules/xxgk/xxgkNoteView";
			}
		}
	}

	/**
	 * 编辑富文本编辑器表单页面
	 */
	@RequiresPermissions(value = { "xxgk:xxgkNote:view", "xxgk:xxgkNote:add", "xxgk:xxgkNote:edit" }, logical = Logical.OR)
	@RequestMapping(value = "form")
	public String form(XxgkNote xxgkNote, Model model) {
		model.addAttribute("xxgkNote", xxgkNote);
		return "modules/xxgk/xxgkNoteForm";
	}

	/**
	 * 查看富文本编辑器页面
	 */
	@RequiresPermissions(value = "xxgk:xxgkNote:view")
	@RequestMapping(value = "view")
	public String view(XxgkNote xxgkNote, Model model) {
		model.addAttribute("xxgkNote", xxgkNote);
		return "modules/xxgk/xxgkNoteView";
	}

	/**
	 * 保存富文本编辑器
	 */
	@RequestMapping(value = "save")
	public String save(XxgkNote xxgkNote, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, xxgkNote)) {
			return form(xxgkNote, model);
		}

		try {

			if (!xxgkNote.getIsNewRecord()) {// 编辑表单保存
				XxgkNote t = xxgkNoteService.get(xxgkNote.getId());// 从数据库取出记录的值
				MyBeanUtils.copyBeanNotNull2Bean(xxgkNote, t);// 将编辑表单中的非NULL值覆盖数据库记录中的值

				int clickThroughput;
				// 如果不是整整数 则默认为0
				if (isMatches(t.getClickThroughput())) {
					clickThroughput = Integer.parseInt(t.getClickThroughput());
				} else {
					clickThroughput = 0;
				}
				t.setClickThroughput(String.valueOf(clickThroughput));

				xxgkNoteService.save(t);// 保存
			} else {// 新增表单保存
				xxgkNoteService.save(xxgkNote);// 保存
			}
			addMessage(redirectAttributes, "保存富文本编辑器成功");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "保存富文本编辑器失败");
		} finally {
			return "redirect:" + Global.getAdminPath() + "/xxgk/xxgkNote/?repage";
		}
	}

	/**
	 * 删除富文本编辑器
	 */
	@RequiresPermissions("xxgk:xxgkNote:del")
	@RequestMapping(value = "delete")
	public String delete(XxgkNote xxgkNote, RedirectAttributes redirectAttributes) {
		xxgkNoteService.delete(xxgkNote);
		addMessage(redirectAttributes, "删除富文本编辑器成功");
		return "redirect:" + Global.getAdminPath() + "/xxgk/xxgkNote/?repage";
	}

	/**
	 * 批量删除富文本编辑器
	 */
	@RequiresPermissions("xxgk:xxgkNote:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] = ids.split(",");
		for (String id : idArray) {
			xxgkNoteService.delete(xxgkNoteService.get(id));
		}
		addMessage(redirectAttributes, "删除富文本编辑器成功");
		return "redirect:" + Global.getAdminPath() + "/xxgk/xxgkNote/?repage";
	}

	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xxgk:xxgkNote:export")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(XxgkNote xxgkNote, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "富文本编辑器" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<XxgkNote> page = xxgkNoteService.findPage(new Page<XxgkNote>(request, response, -1), xxgkNote);
			new ExportExcel("富文本编辑器", XxgkNote.class).setDataList(page.getList()).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出富文本编辑器记录失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/xxgk/xxgkNote/?repage";
	}

	/**
	 * 导入Excel数据
	 */
	@RequiresPermissions("xxgk:xxgkNote:import")
	@RequestMapping(value = "import", method = RequestMethod.POST)
	public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XxgkNote> list = ei.getDataList(XxgkNote.class);
			for (XxgkNote xxgkNote : list) {
				try {
					xxgkNoteService.save(xxgkNote);
					successNum++;
				} catch (ConstraintViolationException ex) {
					failureNum++;
				} catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum > 0) {
				failureMsg.insert(0, "，失败 " + failureNum + " 条富文本编辑器记录。");
			}
			addMessage(redirectAttributes, "已成功导入 " + successNum + " 条富文本编辑器记录" + failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入富文本编辑器失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/xxgk/xxgkNote/?repage";
	}

	/**
	 * 下载导入富文本编辑器数据模板
	 */
	@RequiresPermissions("xxgk:xxgkNote:import")
	@RequestMapping(value = "import/template")
	public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "富文本编辑器数据导入模板.xlsx";
			List<XxgkNote> list = Lists.newArrayList();
			new ExportExcel("富文本编辑器数据", XxgkNote.class, 2).setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/xxgk/xxgkNote/?repage";
	}

	/**
	 * 富文本编辑器列表选择器
	 */
	@RequestMapping(value = "selectList")
	public String selectList(XxgkNote xxgkNote, HttpServletRequest request, HttpServletResponse response, Model model) {
		list(xxgkNote, request, response, model);
		return "modules/xxgk/xxgkNoteSelectList";
	}

	// 判断一个字符串 是否为正整数
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