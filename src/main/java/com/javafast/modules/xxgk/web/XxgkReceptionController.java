package com.javafast.modules.xxgk.web;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javafast.common.persistence.Page;
import com.javafast.modules.xxgk.entity.XxgkNote;
import com.javafast.modules.xxgk.entity.XxgkSysMenu;
import com.javafast.modules.xxgk.service.XxgkNoteService;
import com.javafast.modules.xxgk.service.XxgkSysMenuService;

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
	private XxgkSysMenuService xxgkSysMenuService;
	@Autowired
	private XxgkNoteService xxgkNoteService;

	@RequestMapping(value = "index")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {

		// 左侧导航
		// 用最顶级的菜单名称来锁定 ,写死了
		XxgkSysMenu xxgkSysMenu = xxgkSysMenuService.getByName("左侧导航");
		List<XxgkSysMenu> liftXxgkSysMenuList = xxgkSysMenuService.findListByPid(xxgkSysMenu.getId());

		// 页面下方的按钮
		// 用最顶级的菜单名称来锁定 ,写死了
		XxgkSysMenu xxgksxSysMenu = xxgkSysMenuService.getByName("信息公开事项");
		List<XxgkSysMenu> xxgksxXxgkSysMenuList = xxgkSysMenuService.findListByPid(xxgksxSysMenu.getId());

		// 获取十条最新信息公开新闻
		Page<XxgkNote> page = xxgkNoteService.findPage(new Page<XxgkNote>(1, 12), new XxgkNote());

		request.setAttribute("xxgkNoteList", page.getList());
		request.setAttribute("liftXxgkSysMenuList", liftXxgkSysMenuList);
		request.setAttribute("xxgksxXxgkSysMenuList", xxgksxXxgkSysMenuList);

		return "modules/xxgk/reception/indexXxgk";
	}

	@RequestMapping(value = "buttonList")
	public String buttonList(HttpServletRequest request, HttpServletResponse response, Model model) {
		// 左侧导航
		// 用最顶级的菜单名称来锁定 ,写死了
		XxgkSysMenu xxgkSysMenu = xxgkSysMenuService.getByName("左侧导航");
		List<XxgkSysMenu> liftXxgkSysMenuList = xxgkSysMenuService.findListByPid(xxgkSysMenu.getId());
		request.setAttribute("liftXxgkSysMenuList", liftXxgkSysMenuList);

		// 接收 id
		String xxgkSysMenuId = request.getParameter("xxgkSysMenuId");

		// 查询该id 为多少菜单的pid ,来查看他是不是 叶子菜单
		List<XxgkSysMenu> xxgksysMenuList = xxgkSysMenuService.findListByPid(xxgkSysMenuId);
		for(XxgkSysMenu s : xxgksysMenuList){
			System.out.println(s);
		}

		// 查询菜单名称
		String xxgkSysMenuName = xxgkSysMenuService.get(xxgkSysMenuId).getName();

		// 查询菜单类型
		String xxgkSysMenuMenuType = xxgkSysMenuService.get(xxgkSysMenuId).getMenuType();
		request.setAttribute("xxgkSysMenuName", xxgkSysMenuName);

		if (xxgksysMenuList.size() == 0) {
			// 是叶子菜单

			// 菜单的类型是 详细 ,直接跳转到新闻详细
			if (xxgkSysMenuMenuType != null && "2".equals(xxgkSysMenuMenuType)) {
				// 取出菜单id
				XxgkNote xn = new XxgkNote();
				xn.setXxgkSysMenu(xxgkSysMenuService.get(xxgkSysMenuId));
				List<XxgkNote> xnList = xxgkNoteService.findList(xn);
				if (xnList != null && xnList.size() > 0) {
					xn = xnList.get(0);
					addClickThroughput(xn);
					request.setAttribute("xxgkNote", xn);
					return "modules/xxgk/reception/listXxgk";
				}
			}

			// 菜单的类型是 列表
			XxgkNote xxgkNote = new XxgkNote();
			XxgkSysMenu pXxgkSysMenu = new XxgkSysMenu();
			pXxgkSysMenu.setId(xxgkSysMenuId);
			xxgkNote.setXxgkSysMenu(pXxgkSysMenu);
			List<XxgkNote> xxgkNoteList = xxgkNoteService.findList(xxgkNote);
			request.setAttribute("xxgkNoteList", xxgkNoteList);
			return "modules/xxgk/reception/listXxgk";
		} else {
			// 还有 子菜单,继续显示子菜单
			request.setAttribute("xxgksysMenuList", xxgksysMenuList);
			return "modules/xxgk/reception/indexXxgk";
		}
	}

	// 新闻详情
	@RequestMapping(value = "get")
	public String get(HttpServletRequest request, HttpServletResponse response, Model model) {
		// 获取菜单
		// 左侧导航
		// 用最顶级的菜单名称来锁定 ,写死了
		XxgkSysMenu sysMenu = xxgkSysMenuService.getByName("左侧导航");
		List<XxgkSysMenu> liftXxgkSysMenuList = xxgkSysMenuService.findListByPid(sysMenu.getId());

		String id = (String) request.getParameter("id");
		XxgkNote xxgkNote = xxgkNoteService.get(id);
		addClickThroughput(xxgkNote);

		request.setAttribute("liftXxgkSysMenuList", liftXxgkSysMenuList);
		request.setAttribute("xxgkNote", xxgkNote);
		return "modules/xxgk/reception/listXxgk";
	}

	@RequestMapping(value = "list")
	public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
		// 左侧导航
		// 用最顶级的菜单名称来锁定 ,写死了
		XxgkSysMenu xxgkSysMenu = xxgkSysMenuService.getByName("左侧导航");
		List<XxgkSysMenu> liftXxgkSysMenuList = xxgkSysMenuService.findListByPid(xxgkSysMenu.getId());

		List<XxgkNote> xxgkNoteList = xxgkNoteService.findList(new XxgkNote());
		request.setAttribute("liftXxgkSysMenuList", liftXxgkSysMenuList);
		request.setAttribute("xxgkNoteList", xxgkNoteList);
		request.setAttribute("xxgkSysMenuName", "信息公开");
		return "modules/xxgk/reception/listXxgk";
	}

	// 更新点击量 点击量+1
	public void addClickThroughput(XxgkNote xxgkNote) {
		int clickThroughput;
		// 如果不是整整数 则默认为0
		if (isMatches(xxgkNote.getClickThroughput())) {
			clickThroughput = Integer.parseInt(xxgkNote.getClickThroughput());
		} else {
			clickThroughput = 0;
		}
		xxgkNote.setClickThroughput(String.valueOf(++clickThroughput));
		xxgkNoteService.save(xxgkNote);
	}

	// 判断一个字符串 是否为正整数
	public boolean isMatches(String bot) {
		if (bot != null && !bot.equals("")) {
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
