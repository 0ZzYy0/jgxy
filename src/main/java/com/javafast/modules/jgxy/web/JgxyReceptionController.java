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
		//解决 偶尔的乱码
		request.setCharacterEncoding("UTF-8");
		
		
		//根据菜单id 获取新闻列表(一般情况下是点击了首页的菜单和"更多"按钮)
		String jgxySysMenuId = (String) request.getParameter("jgxySysMenuId");
		if(jgxySysMenuId != null && !jgxySysMenuId.equals("")){
			
			JgxySysMenu jsm = jgxySysMenuService.get(jgxySysMenuId);
			String menuType = jsm.getMenuType();
			
			
			//获取菜单列表
			String jgxySysMenuPId = (String) request.getParameter("jgxySysMenuPId");
			if(jgxySysMenuId != null && !jgxySysMenuId.equals("")){
				if(jgxySysMenuPId != null && !jgxySysMenuPId.equals("")){
					jgxySysMenu.setId(jgxySysMenuPId);
				}else{
					jgxySysMenu.setId(jgxySysMenuId);
				}
			}
			List<JgxySysMenu> jgxySysMenuList = jgxySysMenuService.findList(jgxySysMenu);
			request.setAttribute("jgxySysMenuList", jgxySysMenuList);
			
			
			//菜单类型为新闻详细且有文章的时候
			if(menuType != null && menuType.equals("2")){
				//取出菜单id 
				JgxyNote jn = new JgxyNote();
				jn.setJgxySysMenu(jsm);
				
				List<JgxyNote> jgxyNoteList = jgxyNoteService.findList(jn);
				
				if(jgxyNoteList != null && jgxyNoteList.size() > 0){
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
		
		
		//根据搜索获得新闻列表
		if (request.getParameter("jgxyNoteTitle") != null) {
			String jgxyNoteTitle = java.net.URLDecoder.decode(request.getParameter("jgxyNoteTitle"));
			if(!jgxyNoteTitle.equals("")){
				JgxyNote jgxyNote = new JgxyNote();
				jgxyNote.setTitle(jgxyNoteTitle);
				
				// 获取新闻列表
				List<JgxyNote> jgxyNoteList = jgxyNoteService.findList(jgxyNote);

				request.setAttribute("jgxyNoteList", jgxyNoteList);
				
				return "modules/jgxy/reception/news_list";
			}
		}
		
		//如果 走到这里说明没有 
		//jgxyNoteTitle  和    jgxySysMenuId
		//那么肯定是点击 首页最大的 "更多"  进来的,所以 列出所有菜单和新闻
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
		List<JgxyNote> jgxyNoteXFJS = new ArrayList<>();

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
			} else if (jn.getJgxySysMenu().getId().equals("3946981313027664138")) {
				if (jgxyNoteXFJS.size() < 5) {
					jgxyNoteXFJS.add(jn);
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
		request.setAttribute("jgxyNoteXFJS", jgxyNoteXFJS);
		return "modules/jgxy/reception/indexJgxy";
	}

	// 新闻详情
	@RequestMapping(value = "get")
	public String get(JgxySysMenu jgxySysMenu, HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = (String) request.getParameter("id");
		JgxyNote jgxyNote = null;
		if (StringUtils.isNotBlank(id)) {
			jgxyNote = jgxyNoteService.get(id);
			jgxySysMenu.setId(jgxyNote.getJgxySysMenu().getParentId());
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
	
	
	// 更新点击量 点击量+1
	public void addClickThroughput(JgxyNote jgxyNote){
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
	
	
	
	//判断一个字符串 是否为正整数
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
