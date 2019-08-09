package com.javafast.modules.xxgk.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javafast.common.persistence.Page;
import com.javafast.modules.jgxy.entity.JgxyImg;
import com.javafast.modules.jgxy.entity.JgxyImgSchool;
import com.javafast.modules.jgxy.entity.JgxyNote;
import com.javafast.modules.jgxy.entity.JgxySysMenu;
import com.javafast.modules.jgxy.service.JgxyFloatDivService;
import com.javafast.modules.jgxy.service.JgxyFooterService;
import com.javafast.modules.jgxy.service.JgxyImgSchoolService;
import com.javafast.modules.jgxy.service.JgxyImgService;
import com.javafast.modules.jgxy.service.JgxyModalDivService;
import com.javafast.modules.jgxy.service.JgxyNoteService;
import com.javafast.modules.jgxy.service.JgxySysMenuService;

/**
 * 信息公开前台控制类
 * 
 * @author javafast
 * @version 2019-08-08
 */

@Controller
@RequestMapping(value = "${adminPath}/xxgk/xxgkReception")
public class XxgkReceptionController {
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
		// request.setAttribute("jgxyNoteDJGZ", jgxyNoteDJGZ);
		// return "modules/jgxy/reception/NewFile1";
		return "modules/xxgk/reception/indexXxgk";
	}

	@RequestMapping(value = "list")
	public String list(JgxySysMenu jgxySysMenu, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		//String xxgkSXId = (String) request.getParameter("jgxySysMenuId");
		
		System.out.println("list方法近来了!");
		System.out.println("list方法近来了!");
		System.out.println("list方法近来了!");
		System.out.println("list方法近来了!");
		System.out.println("list方法近来了!");
		return "modules/xxgk/reception/list_Xxgk";
	}
}
