package com.javafast.modules.jgxy.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

import com.alibaba.fastjson.JSONObject;
import com.javafast.common.persistence.Page;
import com.javafast.common.utils.StringUtils;
import com.javafast.modules.jgxy.service.JgxyFloatDivService;
import com.javafast.modules.jgxy.service.JgxyFooterService;
import com.javafast.modules.jgxy.service.JgxyImgSchoolService;
import com.javafast.modules.jgxy.service.JgxyImgService;
import com.javafast.modules.jgxy.service.JgxyModalDivService;
import com.javafast.modules.jgxy.service.JgxyNoteService;
import com.javafast.modules.jgxy.service.JgxySysMenuService;
import com.javafast.modules.jgxy.entity.JgxyFloatDiv;
import com.javafast.modules.jgxy.entity.JgxyFooter;
import com.javafast.modules.jgxy.entity.JgxyImg;
import com.javafast.modules.jgxy.entity.JgxyImgSchool;
import com.javafast.modules.jgxy.entity.JgxyModalDiv;
import com.javafast.modules.jgxy.entity.JgxyNote;
import com.javafast.modules.jgxy.entity.JgxySysMenu;
import com.javafast.modules.oa.entity.OaNote;
import com.javafast.modules.sys.entity.User;
import com.javafast.modules.sys.utils.UserUtils;

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
	@Autowired
	private JgxyFooterService jgxyFooterService;
	@Autowired
	private JgxyFloatDivService jgxyFloatDivService;
	@Autowired
	private JgxyModalDivService jgxyModalDivService;

	@ResponseBody
	@RequestMapping(value = "getNote", method = RequestMethod.POST)
	public List<JgxyNote> getNote() {
		List<JgxyNote> dataList = jgxyNoteService.findList(new JgxyNote());
		return dataList;
	}

	@RequestMapping(value = "list")
	public String list(JgxySysMenu jgxySysMenu, HttpServletRequest request, HttpServletResponse response, Model model) throws UnsupportedEncodingException {
		// 解决 偶尔的乱码
		request.setCharacterEncoding("UTF-8");

		// 根据菜单id 获取新闻列表(一般情况下是点击了首页的菜单和"更多"按钮)
		String jgxySysMenuId = (String) request.getParameter("jgxySysMenuId");
		if (jgxySysMenuId != null && !jgxySysMenuId.equals("")) {

			JgxySysMenu jsm = jgxySysMenuService.get(jgxySysMenuId);
			String menuType = jsm.getMenuType();

			// 获取菜单列表
			String jgxySysMenuPId = (String) request.getParameter("jgxySysMenuPId");
			if (jgxySysMenuId != null && !jgxySysMenuId.equals("")) {
				if (jgxySysMenuPId != null && !jgxySysMenuPId.equals("")) {
					jgxySysMenu.setId(jgxySysMenuPId);
				} else {
					jgxySysMenu.setId(jgxySysMenuId);
				}
			}
			List<JgxySysMenu> jgxySysMenuList = jgxySysMenuService.findList(jgxySysMenu);
			request.setAttribute("jgxySysMenuList", jgxySysMenuList);

			// 菜单类型为新闻详细且有文章的时候
			if (menuType != null && menuType.equals("2")) {
				// 取出菜单id
				JgxyNote jn = new JgxyNote();
				jn.setJgxySysMenu(jsm);

				List<JgxyNote> jgxyNoteList = jgxyNoteService.findList(jn);

				if (jgxyNoteList != null && jgxyNoteList.size() > 0) {
					jn = jgxyNoteList.get(0);
					addClickThroughput(jn);
					request.setAttribute("jgxyNote", jn);
					return "modules/jgxy/reception/news_list";
				}
			}

			JgxySysMenu x = new JgxySysMenu();
			x.setId(jgxySysMenuId);

			JgxyNote jgxyNote = new JgxyNote();
			jgxyNote.setJgxySysMenu(x);

			// 取出菜单名称
			request.setAttribute("jgxySysMenuName", jsm.getName());

			// 获取新闻
			List<JgxyNote> jgxyNoteList = jgxyNoteService.findList(jgxyNote);
			request.setAttribute("jgxyNoteList", jgxyNoteList);

			return "modules/jgxy/reception/news_list";
		}

		// 根据搜索获得新闻列表
		if (request.getParameter("jgxyNoteTitle") != null) {
			String jgxyNoteTitle = java.net.URLDecoder.decode(request.getParameter("jgxyNoteTitle"));
			if (!jgxyNoteTitle.equals("")) {
				JgxyNote jgxyNote = new JgxyNote();
				jgxyNote.setTitle(jgxyNoteTitle);

				// 获取新闻列表
				List<JgxyNote> jgxyNoteList = jgxyNoteService.findList(jgxyNote);
				request.setAttribute("jgxyNoteList", jgxyNoteList);

				// 获取菜单列表
				List<JgxySysMenu> jgxySysMenuList = jgxySysMenuService.findList(new JgxySysMenu());
				request.setAttribute("jgxySysMenuList", jgxySysMenuList);

				return "modules/jgxy/reception/news_list";
			}
		}

		// 如果 走到这里说明没有
		// jgxyNoteTitle 和 jgxySysMenuId
		// 那么肯定是点击 首页最大的 "更多" 进来的,所以 列出所有菜单和新闻
		List<JgxySysMenu> jgxySysMenuList = jgxySysMenuService.findList(new JgxySysMenu());
		request.setAttribute("jgxySysMenuList", jgxySysMenuList);
		// 获取新闻
		request.setAttribute("jgxySysMenuName", "学院新闻");
		request.setAttribute("jgxyNoteList", jgxyNoteService.findList(new JgxyNote()));
		return "modules/jgxy/reception/news_list";
	}

	@RequestMapping(value = "index")
	public String index(JgxySysMenu jgxySysMenu, HttpServletRequest request, HttpServletResponse response, Model model) {

		// 获取菜单
		List<JgxySysMenu> jgxySysMenuList = jgxySysMenuService.findList(jgxySysMenu);

		// 获取全部新闻
		// 每个类别最多5条,学院新闻12条
		Page<JgxyNote> page = jgxyNoteService.findPage(new Page<JgxyNote>(1, 12), new JgxyNote());

		JgxyImg ji = new JgxyImg();
		ji.setIsRelease("1");
		List<JgxyImg> jiList = jgxyImgService.findList(ji);

		JgxyImgSchool jis = new JgxyImgSchool();
		jis.setIsRelease("1");
		List<JgxyImgSchool> jiList1 = jgxyImgSchoolService.findList(jis);

		// 用来做条件
		JgxySysMenu jsm = new JgxySysMenu();
		JgxyNote jn = new JgxyNote();

		// 新闻种类暂时按照 id 来对比
		jsm.setId("71864634419527302");
		jn.setJgxySysMenu(jsm);
		List<JgxyNote> jgxyNoteJXDT = jgxyNoteService.findPage(new Page<JgxyNote>(1, 5), jn).getList();

		jsm.setId("1517093218844555186");
		jn.setJgxySysMenu(jsm);
		List<JgxyNote> jgxyNoteKYZX = jgxyNoteService.findPage(new Page<JgxyNote>(1, 5), jn).getList();

		jsm.setId("2664446703223844603");
		jn.setJgxySysMenu(jsm);
		List<JgxyNote> jgxyNoteGZXY = jgxyNoteService.findPage(new Page<JgxyNote>(1, 5), jn).getList();

		jsm.setId("7868304688644257636");
		jn.setJgxySysMenu(jsm);
		List<JgxyNote> jgxyNoteXXGK = jgxyNoteService.findPage(new Page<JgxyNote>(1, 5), jn).getList();

		jsm.setId("1406319674601422774");
		jn.setJgxySysMenu(jsm);
		List<JgxyNote> jgxyNoteGSGG = jgxyNoteService.findPage(new Page<JgxyNote>(1, 5), jn).getList();

		jsm.setId("3946981313027664138");
		jn.setJgxySysMenu(jsm);
		List<JgxyNote> jgxyNoteXFJS = jgxyNoteService.findPage(new Page<JgxyNote>(1, 5), jn).getList();

		jsm.setId("4672773914173395715");
		jn.setJgxySysMenu(jsm);
		List<JgxyNote> jgxyNoteDJGZ = jgxyNoteService.findPage(new Page<JgxyNote>(1, 5), jn).getList();

		request.setAttribute("jiList", jiList);
		request.setAttribute("jiList1", jiList1);
		request.setAttribute("jgxySysMenuList", jgxySysMenuList);
		request.setAttribute("jgxyNoteList", page.getList());
		request.setAttribute("jgxyNoteJXDT", jgxyNoteJXDT);
		request.setAttribute("jgxyNoteKYZX", jgxyNoteKYZX);
		request.setAttribute("jgxyNoteGZXY", jgxyNoteGZXY);
		request.setAttribute("jgxyNoteXXGK", jgxyNoteXXGK);
		request.setAttribute("jgxyNoteGSGG", jgxyNoteGSGG);
		request.setAttribute("jgxyNoteXFJS", jgxyNoteXFJS);
		request.setAttribute("jgxyNoteDJGZ", jgxyNoteDJGZ);
		//return "modules/jgxy/reception/NewFile1";
		return "modules/jgxy/reception/indexJgxy";
	}

	// 新闻详情
	@RequestMapping(value = "get")
	public String get(JgxySysMenu jgxySysMenu, HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = (String) request.getParameter("id");
		JgxyNote jgxyNote = null;
		if (StringUtils.isNotBlank(id)) {
			jgxyNote = jgxyNoteService.get(id);
			if (jgxyNote.getJgxySysMenu().getParentId() == null || "0".equals(jgxyNote.getJgxySysMenu().getParentId())) {
				jgxySysMenu.setId(jgxyNote.getJgxySysMenu().getId());
			} else {
				jgxySysMenu.setId(jgxyNote.getJgxySysMenu().getParentId());
			}

			addClickThroughput(jgxyNote);
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

	// 获取页脚数据
	@ResponseBody
	@RequestMapping(value = "getFooterJgxy", method = RequestMethod.POST)
	public JgxyFooter getFooterJgxy() {
		JgxyFooter jgxyFooter = new JgxyFooter();
		jgxyFooter = jgxyFooterService.getJgxyFooter();
		return jgxyFooter;
	}

	// 获取飘动窗口数据
	@ResponseBody
	@RequestMapping(value = "getFloatDivJgxy", method = RequestMethod.POST)
	public JgxyFloatDiv getFloatDivJgxy() {
		JgxyFloatDiv jgxyFooter = jgxyFloatDivService.getJgxyFloatDiv();
		if (jgxyFooter == null) {
			jgxyFooter = new JgxyFloatDiv();
		}
		return jgxyFooter;
	}

	// 获取模态窗口数据
	@ResponseBody
	@RequestMapping(value = "getModalDivJgxy", method = RequestMethod.POST)
	public JgxyModalDiv getModalDivJgxy() {
		JgxyModalDiv jgxyModalDiv = jgxyModalDivService.getJgxyModalDiv();
		if (jgxyModalDiv == null) {
			jgxyModalDiv = new JgxyModalDiv();
		}
		return jgxyModalDiv;
	}

	// 更新点击量 点击量+1
	public void addClickThroughput(JgxyNote jgxyNote) {
		int clickThroughput;
		// 如果不是整整数 则默认为0
		if (isMatches(jgxyNote.getClickThroughput())) {
			clickThroughput = Integer.parseInt(jgxyNote.getClickThroughput());
		} else {
			clickThroughput = 0;
		}
		jgxyNote.setClickThroughput(String.valueOf(++clickThroughput));
		jgxyNoteService.save(jgxyNote);
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
