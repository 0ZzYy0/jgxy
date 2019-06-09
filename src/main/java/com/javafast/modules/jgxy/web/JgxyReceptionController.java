package com.javafast.modules.jgxy.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javafast.common.utils.StringUtils;
import com.javafast.modules.jgxy.service.JgxyNoteService;
import com.javafast.modules.jgxy.service.JgxySysMenuService;
import com.javafast.modules.jgxy.entity.JgxyNote;
import com.javafast.modules.jgxy.entity.JgxySysMenu;

/**
 * 警官学院前台控制类
 * 
 * @author javafast
 * @version 2019-06-04
 */
@Controller
@RequestMapping(value = "${adminPath}/jgxy/jgxyReception")
public class JgxyReceptionController {
	@Autowired
	private JgxyNoteService jgxyNoteService;
	@Autowired
	private JgxySysMenuService jgxySysMenuService;

	@ResponseBody
	@RequestMapping(value = "getNote", method = RequestMethod.POST)
	public List<JgxyNote> getNote() {
		List<JgxyNote> dataList = jgxyNoteService.findList(new JgxyNote());
		return dataList;
	}

	@RequestMapping(value = "list")
	public String list(JgxySysMenu jgxySysMenu, HttpServletRequest request, HttpServletResponse response, Model model) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
		// 获取菜单
		List<JgxySysMenu> jgxySysMenuList = jgxySysMenuService.findList(jgxySysMenu);
		JgxyNote jgxyNote = new JgxyNote();

		String jgxySysMenuId = (String) request.getParameter("jgxySysMenuId");
		
		
		String jgxyNoteTitle = null;
		if (request.getParameter("jgxyNoteTitle") != null) {
			jgxyNoteTitle = new String(request.getParameter("jgxyNoteTitle").getBytes("ISO8859-1"), "UTF-8");
		}

		if (jgxySysMenuId != null && !jgxySysMenuId.equals("")) {
			JgxySysMenu x = new JgxySysMenu();
			x.setId(jgxySysMenuId);
			jgxyNote.setJgxySysMenu(x);
		}

		// 根据标题名称搜索
		if (jgxyNoteTitle != null && !jgxyNoteTitle.equals("")) {
			jgxyNote.setTitle(jgxyNoteTitle);
		}

		// 获取新闻
		List<JgxyNote> jgxyNoteList = jgxyNoteService.findList(jgxyNote);

		request.setAttribute("jgxySysMenuList", jgxySysMenuList);
		request.setAttribute("jgxyNoteList", jgxyNoteList);
		return "modules/jgxy/reception/news_list";
	}

	@RequestMapping(value = "index")
	public String index(JgxySysMenu jgxySysMenu, HttpServletRequest request, HttpServletResponse response, Model model) {

		// 获取菜单
		List<JgxySysMenu> jgxySysMenuList = jgxySysMenuService.findList(jgxySysMenu);

		// 获取全部新闻
		List<JgxyNote> jgxyNoteList = jgxyNoteService.findList(new JgxyNote());

		request.setAttribute("jgxySysMenuList", jgxySysMenuList);
		request.setAttribute("jgxyNoteList", jgxyNoteList);
		return "modules/jgxy/reception/indexJgxy";
	}

	@ResponseBody
	@RequestMapping(value = "get", method = RequestMethod.POST)
	public JgxyNote get(@RequestParam(required = false) String id) {
		JgxyNote entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = jgxyNoteService.get(id);
		}
		if (entity == null) {
			entity = new JgxyNote();
		}
		return entity;
	}

}
