package com.javafast.modules.iim.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javafast.common.config.Global;
import com.javafast.common.persistence.Page;
import com.javafast.common.utils.MyBeanUtils;
import com.javafast.common.utils.StringUtils;
import com.javafast.common.web.BaseController;
import com.javafast.modules.iim.entity.MyCalendar;
import com.javafast.modules.iim.service.MyCalendarService;
import com.javafast.modules.iim.utils.DateUtil;
import com.javafast.modules.oa.entity.OaTask;
import com.javafast.modules.sys.utils.UserUtils;

/**
 * 日历Controller
 */
@Controller
@RequestMapping(value = "${adminPath}/iim/myCalendar")
public class MyCalendarController extends BaseController {

	@Autowired
	private MyCalendarService myCalendarService;
	
	@ModelAttribute
	public MyCalendar get(@RequestParam(required = false) String id) {
		MyCalendar entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = myCalendarService.get(id);
		}
		if (entity == null) {
			entity = new MyCalendar();
		}
		return entity;
	}

	/**
	 * 日历页面
	 */
	@RequestMapping(value = { "index", "" })
	public String index(MyCalendar myCalendar, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		return "modules/iim/myCalendar";
	}

	/**
	 * 查看，增加，编辑日历信息表单页面
	 */
	@RequestMapping(value = "addform")
	public String addform(MyCalendar myCalendar, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String date = request.getParameter("date");
		String enddate = request.getParameter("end");
		if (date.equals(enddate)) {
			enddate = "";
		}
		String display = "";
		String chk = "";
		if ("".equals(enddate)) {
			display = "style=\"display:none\"";
			enddate = date;
		} else {
			chk = "checked";
		}
		model.addAttribute("date", date);
		model.addAttribute("display", display);
		model.addAttribute("chk", chk);
		model.addAttribute("enddate", enddate);
		model.addAttribute("myCalendar", myCalendar);
		return "modules/iim/myCalendarForm-add";
	}

	@RequestMapping(value = "editform")
	public String editform(MyCalendar myCalendar, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String title = myCalendar.getTitle();// 事件标题
		String start = myCalendar.getStart();// 事件开始时间
		String end = myCalendar.getEnd();// 结束时间
		String allDay = myCalendar.getAdllDay();// 是否为全天事件
		String color = myCalendar.getColor();// 事件的背景

		String start_d = "";
		String start_h = "";
		String start_m = "";

		String end_d = "";
		String end_h = "";
		String end_m = "";

		if ("1".equals(allDay) && !"".equals(end)) {
			start_d = start;
			end_d = end;
		} else if ("1".equals(allDay) && "".equals(end)) {
			start_d = start;
		} else if ("0".equals(allDay) && !"".equals(end)) {
			start_d = start.substring(0, 10);
			start_h = start.substring(11, 13);
			start_m = start.substring(14, 16);

			end_d = end.substring(0, 10);
			end_h = end.substring(11, 13);
			end_m = end.substring(14, 16);
		} else {
			start_d = start.substring(0, 10);
			start_h = start.substring(11, 13);
			start_m = start.substring(14, 16);
		}

		model.addAttribute("title", title);
		model.addAttribute("color", color);
		model.addAttribute("start_d", start_d);
		model.addAttribute("start_h", start_h);
		model.addAttribute("start_m", start_m);
		model.addAttribute("end", end_d);
		model.addAttribute("end_d", end_d);
		model.addAttribute("end_h", end_h);
		model.addAttribute("end_m", end_m);
		model.addAttribute("allDay", allDay);
		return "modules/iim/myCalendarForm-edit";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "findList")
	protected List<MyCalendar> doPost(MyCalendar myCalendar,
			HttpServletRequest request, HttpServletResponse response,
			Model model) throws ServletException, IOException {
		myCalendar.setUser(UserUtils.getUser());
		List<MyCalendar> list = myCalendarService.findList(myCalendar);

		return list;
	}

	/**
	 * 新建日历
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "add")
	public String add(MyCalendar myCalendar, HttpServletRequest request,
			HttpServletResponse response, Model model) {

		String events = request.getParameter("event");// 事件内容
		String isallday = request.getParameter("isallday");// 是否是全天事件
		String isend = request.getParameter("isend");// 是否有结束时间
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String s_time = request.getParameter("s_hour") + ":"
				+ request.getParameter("s_minute") + ":00";
		String e_time = request.getParameter("e_hour") + ":"
				+ request.getParameter("e_minute") + ":00";

		String start = "";
		String end = "";
		if ("1".equals(isallday) && "1".equals(isend)) {
			start = startdate;
			end = enddate;
		} else if ("1".equals(isallday) && isend == null) {
			start = startdate;
		} else if (isallday == null && "1".equals(isend)) {
			start = startdate + " " + s_time;
			end = enddate + " " + e_time;
			isallday = "0";
		} else {
			start = startdate + " " + s_time;
			isallday = "0";
		}

		String[] colors = { "#360", "#f30", "#06c" };
		int index = (int) (Math.random() * colors.length);
		myCalendar.setTitle(events);
		myCalendar.setStart(start);
		myCalendar.setEnd(end);
		myCalendar.setAdllDay(isallday);
		myCalendar.setColor(colors[index]);
		myCalendar.setUser(UserUtils.getUser());
		myCalendarService.save(myCalendar);

		return "1";
	}

	/**
	 * 编辑日历
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "edit")
	public String edit(MyCalendar myCalendar, HttpServletRequest request,
			HttpServletResponse response, Model model) {

		String events = request.getParameter("event");// 事件内容
		String isallday = request.getParameter("isallday");// 是否是全天事件
		String isend = request.getParameter("isend");// 是否有结束时间
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String s_time = request.getParameter("s_hour") + ":"
				+ request.getParameter("s_minute") + ":00";
		String e_time = request.getParameter("e_hour") + ":"
				+ request.getParameter("e_minute") + ":00";

		String start = "";
		String end = "";
		if ("1".equals(isallday) && "1".equals(isend)) {
			start = startdate;
			end = enddate;
		} else if ("1".equals(isallday) && isend == null) {
			start = startdate;
		} else if (isallday == null && "1".equals(isend)) {
			start = startdate + " " + s_time;
			end = enddate + " " + e_time;
			isallday = "0";
		} else {
			start = startdate + " " + s_time;
			isallday = "0";
		}

		String[] colors = { "#360", "#f30", "#06c" };
		int index = (int) (Math.random() * colors.length);
		myCalendar.setTitle(events);
		myCalendar.setStart(start);
		myCalendar.setEnd(end);
		myCalendar.setAdllDay(isallday);
		myCalendar.setColor(colors[index]);
		myCalendar.setUser(UserUtils.getUser());
		myCalendarService.save(myCalendar);

		model.addAttribute("myCalendar", myCalendar);

		return "1";
	}

	/**
	 * 删除日历
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "del")
	public String del(MyCalendar myCalendar,
			RedirectAttributes redirectAttributes) {

		myCalendarService.delete(myCalendar);
		return "1";

	}

	/**
	 * 縮放日歷
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "resize")
	public String resize(MyCalendar myCalendar, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Integer daydiff = Integer.parseInt(request.getParameter("daydiff")) * 24 * 60 * 60;
		Integer minudiff = Integer.parseInt(request.getParameter("minudiff")) * 60;
		String start = myCalendar.getStart();
		long lstart = DateUtil.string2long(start);
		String end = myCalendar.getEnd();
		Integer difftime = daydiff + minudiff;
		if ("".equals(end)) {
			myCalendar.setEnd(DateUtil.long2string(lstart + difftime));
			myCalendar.setUser(UserUtils.getUser());
			myCalendarService.save(myCalendar);
		} else {
			long lend = DateUtil.string2long(end);
			myCalendar.setEnd(DateUtil.long2string(lend + difftime));
			myCalendar.setUser(UserUtils.getUser());
			myCalendarService.save(myCalendar);
		}
		return "1";
	}

	/**
	 * 拖拽日历
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "drag")
	public String drag(MyCalendar myCalendar, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Integer daydiff = Integer.parseInt(request.getParameter("daydiff")) * 24 * 60 * 60;
		Integer minudiff = Integer.parseInt(request.getParameter("minudiff")) * 60;
		String allday = request.getParameter("allday");
		String start = myCalendar.getStart();
		long lstart = DateUtil.string2long(start);

		String end = myCalendar.getEnd();
		if ("true".equals(allday)) {
			if ("".equals(end)) {
				myCalendar.setStart(DateUtil.long2string(lstart + daydiff));
				myCalendar.setUser(UserUtils.getUser());
				myCalendarService.save(myCalendar);
			} else {
				long lend = DateUtil.string2long(end);
				myCalendar.setStart(DateUtil.long2string(lstart + daydiff));
				myCalendar.setEnd(DateUtil.long2string(lend + daydiff));
				myCalendar.setUser(UserUtils.getUser());
				myCalendarService.save(myCalendar);
			}
		} else {
			Integer difftime = daydiff + minudiff;
			if ("".equals(end)) {
				myCalendar.setStart(DateUtil.long2string(lstart + difftime));
				myCalendar.setUser(UserUtils.getUser());
				myCalendarService.save(myCalendar);
			} else {
				long lend = DateUtil.string2long(end);
				myCalendar.setStart(DateUtil.long2string(lstart + difftime));
				myCalendar.setEnd(DateUtil.long2string(lend + difftime));
				myCalendar.setUser(UserUtils.getUser());
				myCalendarService.save(myCalendar);
			}
		}
		return "1";
	}

	/**
	 * 日程列表
	 * @param myCalendar
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "myCalendarList")
	public String myCalendarList(MyCalendar myCalendar, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		myCalendar.setUser(UserUtils.getUser());
		Page<MyCalendar> page = myCalendarService.findPage(new Page<MyCalendar>(request, response), myCalendar); 
		model.addAttribute("page", page);
		
		return "modules/oa/myCalendarList";
	}
	
	/**
	 * 日程表单
	 * @param myCalendar
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "form")
	public String form(MyCalendar myCalendar, Model model) {
				
		if(myCalendar.getUser() == null){
			myCalendar.setUser(UserUtils.getUser());
		}
		
		model.addAttribute("myCalendar", myCalendar);
		return "modules/oa/myCalendarForm";
	}
	
	/**
	 * 保存日程
	 * @param myCalendar
	 * @param model
	 * @param redirectAttributes
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "save")
	public String save(MyCalendar myCalendar, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, myCalendar)){
			return form(myCalendar, model);
		}
		
		try{
		
			if(!myCalendar.getIsNewRecord()){//编辑表单保存				
				MyCalendar t = myCalendarService.get(myCalendar.getId());//从数据库取出记录的值
				MyBeanUtils.copyBeanNotNull2Bean(myCalendar, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
				myCalendarService.save(t);//保存
			}else{//新增表单保存
				myCalendar.setUser(UserUtils.getUser());
				myCalendarService.save(myCalendar);//保存
			}
			addMessage(redirectAttributes, "保存日程成功");
			//return "redirect:"+Global.getAdminPath()+"/iim/myCalendar/?repage";
			if(StringUtils.isNotBlank(myCalendar.getCustomerId())){
				return "redirect:"+Global.getAdminPath()+"/crm/crmCustomer/crmIndex?repage&id="+myCalendar.getCustomerId();
			}
			return "redirect:"+Global.getAdminPath()+"/home?repage";
		}catch(Exception e){
			e.printStackTrace();
			addMessage(redirectAttributes, "保存日程失败");
			if(StringUtils.isNotBlank(myCalendar.getCustomerId())){
				return "redirect:"+Global.getAdminPath()+"/crm/crmCustomer/crmIndex?repage&id="+myCalendar.getCustomerId();
			}
			return "redirect:"+Global.getAdminPath()+"/home?repage";
		}
	}
	
	/**
	 * 删除日程
	 * @param myCalendar
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "delete")
	public String delete(MyCalendar myCalendar, RedirectAttributes redirectAttributes) {
		myCalendarService.delete(myCalendar);
		addMessage(redirectAttributes, "删除日程成功");
		return "redirect:"+Global.getAdminPath()+"/iim/myCalendar/myCalendarList?repage&customerId="+myCalendar.getCustomerId();
	}
	
	/**
	 * 日历页面
	 */
	@RequestMapping(value = "myCalendarView")
	public String myCalendarView(MyCalendar myCalendar, HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/iim/myCalendarView";
	}
}