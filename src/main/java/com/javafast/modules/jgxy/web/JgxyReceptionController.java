package com.javafast.modules.jgxy.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
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
import com.javafast.modules.jgxy.service.JgxyImgSchoolService;
import com.javafast.modules.jgxy.service.JgxyImgService;
import com.javafast.modules.jgxy.service.JgxyNoteService;
import com.javafast.modules.jgxy.service.JgxySysMenuService;
import com.javafast.modules.jgxy.entity.JgxyImg;
import com.javafast.modules.jgxy.entity.JgxyImgSchool;
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
	@Autowired
	private JgxyImgService jgxyImgService;
	@Autowired
	private JgxyImgSchoolService jgxyImgSchoolService;

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
			// jgxyNoteTitle = new
			// String(request.getParameter("jgxyNoteTitle").getBytes("ISO8859-1"),
			// "UTF-8");
			jgxyNoteTitle = java.net.URLDecoder.decode(request.getParameter("jgxyNoteTitle"));
		}

		if (jgxySysMenuId != null && !jgxySysMenuId.equals("")) {
			JgxySysMenu x = new JgxySysMenu();
			x.setId(jgxySysMenuId);
			jgxyNote.setJgxySysMenu(x);

			// 用来取出菜单名
			JgxySysMenu jsm = jgxySysMenuService.get(jgxySysMenuId);
			request.setAttribute("jgxySysMenuName", jsm.getName());
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

		JgxyImg ji = new JgxyImg();
		ji.setIsRelease("1");
		List<JgxyImg> jiList = jgxyImgService.findList(ji);

		JgxyImgSchool jis = new JgxyImgSchool();
		jis.setIsRelease("1");
		List<JgxyImgSchool> jiList1 = jgxyImgSchoolService.findList(jis);

		// 给新闻分类
		// 每个类别最多5条,学院新闻12条

		List<JgxyNote> jgxyNoteJXDT = new ArrayList<>();
		List<JgxyNote> jgxyNoteKYZX = new ArrayList<>();
		List<JgxyNote> jgxyNoteGZXY = new ArrayList<>();
		List<JgxyNote> jgxyNoteXXGK = new ArrayList<>();
		List<JgxyNote> jgxyNoteGSGG = new ArrayList<>();

		// 新闻种类暂时按照 id 来对比
		for (JgxyNote jn : jgxyNoteList) {
			if (jn.getJgxySysMenu().getId().equals("71864634419527302")) {
				if (jgxyNoteJXDT.size() < 5) {
					jgxyNoteJXDT.add(jn);
				}
			} else if (jn.getJgxySysMenu().getId().equals("1517093218844555186")) {
				if (jgxyNoteKYZX.size() < 5) {
					jgxyNoteKYZX.add(jn);
				}
			} else if (jn.getJgxySysMenu().getId().equals("2664446703223844603")) {
				if (jgxyNoteGZXY.size() < 5) {
					jgxyNoteGZXY.add(jn);
				}
			} else if (jn.getJgxySysMenu().getId().equals("7868304688644257636")) {
				if (jgxyNoteXXGK.size() < 5) {
					jgxyNoteXXGK.add(jn);
				}
			} else if (jn.getJgxySysMenu().getId().equals("1406319674601422774")) {
				if (jgxyNoteGSGG.size() < 5) {
					jgxyNoteGSGG.add(jn);
				}
			}
		}
		request.setAttribute("jiList", jiList);
		request.setAttribute("jiList1", jiList1);
		request.setAttribute("jgxySysMenuList", jgxySysMenuList);
		request.setAttribute("jgxyNoteList", jgxyNoteList.subList(0, 12));
		request.setAttribute("jgxyNoteJXDT", jgxyNoteJXDT);
		request.setAttribute("jgxyNoteKYZX", jgxyNoteKYZX);
		request.setAttribute("jgxyNoteGZXY", jgxyNoteGZXY);
		request.setAttribute("jgxyNoteXXGK", jgxyNoteXXGK);
		request.setAttribute("jgxyNoteGSGG", jgxyNoteGSGG);
		return "modules/jgxy/reception/indexJgxy";
	}

	// 新闻详情
	@RequestMapping(value = "get")
	public String get(JgxySysMenu jgxySysMenu, HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = (String) request.getParameter("id");
		JgxyNote jgxyNote = null;
		if (StringUtils.isNotBlank(id)) {
			jgxyNote = jgxyNoteService.get(id);
		}
		if (jgxyNote == null) {
			jgxyNote = new JgxyNote();
		}

		// 获取菜单
		List<JgxySysMenu> jgxySysMenuList = jgxySysMenuService.findList(jgxySysMenu);

		request.setAttribute("jgxySysMenuList", jgxySysMenuList);
		request.setAttribute("jgxyNote", jgxyNote);
		return "modules/jgxy/reception/news_list";
	}

}
