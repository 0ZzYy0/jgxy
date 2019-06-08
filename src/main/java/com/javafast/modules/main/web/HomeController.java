package com.javafast.modules.main.web;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javafast.common.persistence.Page;
import com.javafast.common.utils.DateUtils;
import com.javafast.common.web.BaseController;
import com.javafast.common.websocket.onchat.ChatServerPool;
import com.javafast.modules.gen.entity.GenReport;
import com.javafast.modules.gen.service.GenReportService;
import com.javafast.modules.iim.entity.MyCalendar;
import com.javafast.modules.iim.service.MyCalendarService;
import com.javafast.modules.oa.entity.OaCommonAudit;
import com.javafast.modules.oa.entity.OaNotify;
import com.javafast.modules.oa.entity.OaProject;
import com.javafast.modules.oa.entity.OaTask;
import com.javafast.modules.oa.service.OaCommonAuditService;
import com.javafast.modules.oa.service.OaNotifyService;
import com.javafast.modules.oa.service.OaProjectService;
import com.javafast.modules.oa.service.OaTaskService;
import com.javafast.modules.sys.entity.SysBrowseLog;
import com.javafast.modules.sys.entity.SysDynamic;
import com.javafast.modules.sys.entity.SysPanel;
import com.javafast.modules.sys.entity.User;
import com.javafast.modules.sys.service.SysBrowseLogService;
import com.javafast.modules.sys.service.SysDynamicService;
import com.javafast.modules.sys.service.SysPanelService;
import com.javafast.modules.sys.service.UserService;
import com.javafast.modules.sys.utils.Contants;
import com.javafast.modules.sys.utils.UserUtils;

/**
 * 主页 Controller
 */
@Controller
public class HomeController extends BaseController{
	
	@Autowired
	private OaNotifyService oaNotifyService;
	
	@Autowired
	private OaTaskService oaTaskService;
	
	@Autowired
	private SysBrowseLogService sysBrowseLogService;
	
	@Autowired
	private SysDynamicService sysDynamicService;
	
	@Autowired
	private GenReportService genReportService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private OaCommonAuditService oaCommonAuditService;
	
	@Autowired
	private OaProjectService oaProjectService;
	
	@Autowired
	private MyCalendarService myCalendarService;
	
	@Autowired
	private SysPanelService sysPanelService;
	
	/**
	 * 仪表盘
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "${adminPath}/home")
	public String dashboard(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		List<String> panelList = new ArrayList<String>();

		StringBuffer sb = new StringBuffer();
		List<SysPanel> sysPanelList = sysPanelService.findCurrentList(new SysPanel());
		for(int i=0; i<sysPanelList.size(); i++){
			SysPanel sysPanel = sysPanelList.get(i);
			sb.append("-");
			sb.append(sysPanel.getPanelId());
			sb.append("-");
			panelList.add(sysPanel.getPanelId());
		}		
		model.addAttribute("userPanels", sb.toString());
		System.out.println(sb.toString());
		
		//如果未设置，则显示默认的
		if(sysPanelList == null || sysPanelList.size() == 0){
			
			panelList.add(Contants.PANEL_TYPE_REMIND);//待办提醒
			panelList.add(Contants.PANEL_TYPE_NOTE);//我的便签
			panelList.add(Contants.PANEL_TYPE_AUDIT);//我的审批
			panelList.add(Contants.PANEL_TYPE_PROJECT);//项目
			panelList.add(Contants.PANEL_TYPE_TASK);//任务
			
			
			model.addAttribute("userPanels", "-1--2--5--11--12-");
		}
		
		Date endDate = DateUtils.getDayAfterN(30);//往后推30天
		
		//最新公告
		if(panelList.contains(Contants.PANEL_TYPE_NOTIFY)){
			OaNotify conOaNotify = new OaNotify();
			conOaNotify.setSelf(true);
			Page<OaNotify> newNotifyPage = oaNotifyService.findPage(new Page<OaNotify>(request, response), conOaNotify);
			model.addAttribute("newNotifyPage", newNotifyPage);
		}
		
		//待办提醒
		if(panelList.contains(Contants.PANEL_TYPE_REMIND)){
			//日程
			MyCalendar myCalendar = new MyCalendar();
			myCalendar.setBeginStart(DateUtils.getDate());
			myCalendar.setEndStart(DateUtils.formatDateTime(endDate));
			Page<MyCalendar> calenderPage = myCalendarService.findPage(new Page<MyCalendar>(request, response), myCalendar);
			model.addAttribute("calenderPage", calenderPage);
		}
		
		//我的便签
		if(panelList.contains(Contants.PANEL_TYPE_NOTE)){
			
		}
		
		//待办审批
		if(panelList.contains(Contants.PANEL_TYPE_AUDIT)){
			//流程审批
			OaCommonAudit oaCommonAudit =  new OaCommonAudit();
			oaCommonAudit.setCurrentBy(UserUtils.getUser());
			oaCommonAudit.setStatus("1");
			Page<OaCommonAudit> oaCommonAuditPage = oaCommonAuditService.findPage(new Page<OaCommonAudit>(request, response), oaCommonAudit);
			model.addAttribute("oaCommonAuditPage", oaCommonAuditPage);
		}
		
		//待办项目
		if(panelList.contains(Contants.PANEL_TYPE_PROJECT)){
			//项目
			OaProject oaProject = new OaProject();
			oaProject.setSelf(true);
			oaProject.setIsUnComplete(true);
			Page<OaProject> projectPage = oaProjectService.findPage(new Page<OaProject>(request, response), oaProject); 
			model.addAttribute("projectPage", projectPage);
		}
		
		//待办任务
		if(panelList.contains(Contants.PANEL_TYPE_TASK)){
			//任务
			OaTask oaTask = new OaTask();
			oaTask.setSelf(true);
			oaTask.setIsUnComplete(true);
			Page<OaTask> taskPage = oaTaskService.findPage(new Page<OaTask>(request, response), oaTask); 
			model.addAttribute("taskPage", taskPage);
		}

	    
		return "modules/main/sysDashboard";
	}
	
	/**
	 * 动态
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "${adminPath}/sysDynamic")
	public String home(SysDynamic sysDynamic, HttpServletRequest request, HttpServletResponse response, Model model) {
	    
	    //查询动态
		Page<SysDynamic> sysDynamicPage = sysDynamicService.findPage(new Page<SysDynamic>(request, response), new SysDynamic());
	  	model.addAttribute("sysDynamicPage", sysDynamicPage);
	    
		
		return "modules/main/sysDynamic";		
	}
	
	
	/**
	 * 办公主页
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "${adminPath}/oaHome")
	public String oaHome(HttpServletRequest request, HttpServletResponse response, Model model) {
			
		//公告
		OaNotify conOaNotify = new OaNotify();
		conOaNotify.setSelf(true);
		Page<OaNotify> newNotifyPage = oaNotifyService.findPage(new Page<OaNotify>(request, response), conOaNotify);
		model.addAttribute("newNotifyPage", newNotifyPage);
		
		//流程审批
		OaCommonAudit oaCommonAudit =  new OaCommonAudit();
		oaCommonAudit.setStatus("1");
		oaCommonAudit.setCurrentBy(UserUtils.getUser());
		Page<OaCommonAudit> oaCommonAuditPage = oaCommonAuditService.findPage(new Page<OaCommonAudit>(request, response), oaCommonAudit);
		model.addAttribute("oaCommonAuditPage", oaCommonAuditPage);
				
		//任务
		OaTask oaTask = new OaTask();
		oaTask.setSelf(true);
		oaTask.setIsUnComplete(true);
		Page<OaTask> taskPage = oaTaskService.findPage(new Page<OaTask>(request, response), oaTask); 
		model.addAttribute("taskPage", taskPage);
		
		//任务总数量
		Long taskCount = taskPage.getCount();
		model.addAttribute("taskCount", taskCount);
		
		//我负责的
		oaTask.setOwnBy(UserUtils.getUser());
		Long ownTaskCount = oaTaskService.findCount(oaTask);
		model.addAttribute("ownTaskCount", ownTaskCount);
		
		//我参与的
		model.addAttribute("joinTaskCount", taskCount - ownTaskCount);
		
		//项目
		OaProject oaProject = new OaProject();
		oaProject.setSelf(true);
		oaProject.setIsUnComplete(true);
		Page<OaProject> projectPage = oaProjectService.findPage(new Page<OaProject>(request, response), oaProject); 
		model.addAttribute("projectPage", projectPage);
		
		//项目总数量
		Long projectCount = projectPage.getCount();
		model.addAttribute("projectCount", projectCount);
		
		//我负责的
		oaProject.setOwnBy(UserUtils.getUser());
		Long ownProjectCount = oaProjectService.findCount(oaProject);
		model.addAttribute("ownProjectCount", ownProjectCount);
	    		
		return "modules/main/oaHome";		
	}
	
	
	/**
	 * 报表主页
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "${adminPath}/reportHome")
	public String reportHome(GenReport genReport, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		genReport.setStatus("1");
		Page<GenReport> page = genReportService.findPage(new Page<GenReport>(request, response), genReport); 
		model.addAttribute("page", page);
		
		return "modules/main/reportHome";	
	}
	
	/**
	 * 引导页
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "${adminPath}/sysGuide")
	public String guide(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/main/sysGuide";		
	}
	
	/**
	 * 帮助页
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "${adminPath}/sysHelp")
	public String sysHelp(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		return "modules/main/sysHelp";		
	}
	
	/**
	 * 获取在线用户
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "${adminPath}/getOnlineUser")
	public String getOnlineUser(HttpServletRequest request, HttpServletResponse response, Model model) {
	
		//查询在线用户
		Collection<String> onlineUsers = ChatServerPool.getOnlineUser();
		for(String userId : onlineUsers){
			System.out.println(userId);
		}
		
		//查询所有用户
		List<User> onlineUserList = new ArrayList<User>();
		List<User> userList = userService.findUser(new User());
		for(User user : userList){
			
			//只添加在线的用户到LIST
			if(onlineUsers.contains(user.getLoginName())){
				onlineUserList.add(user);
			}
		}		
		
		model.addAttribute("onlineUserList", onlineUserList);
		return "modules/main/onlineUser";		
	}
}
