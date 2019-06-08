package com.javafast.modules.sys.utils;

import com.javafast.common.utils.SpringContextHolder;
import com.javafast.modules.sys.entity.SysDynamic;
import com.javafast.modules.sys.service.SysDynamicService;


/**
 * 动态记录工具类
 * @author 1002377
 *
 */
public class DynamicUtils {

	private static SysDynamicService sysDynamicService = SpringContextHolder.getBean(SysDynamicService.class);
	
	/**
	 * 添加动态
	 * @param objectType 对象类型  0：登陆，2：签到，,3：签退，10：项目，11：任务，12:日报，13：通知，15：审批，20：客户，21：联系人，22：机会，23：报价，24：订单，30：产品：31：采购，32：入库，33：出库，50：收款，51：付款
	 * @param actionType 动作类型
	 * @param targetId 目标对象ID
	 * @param targetName 目标对象名称
	 * @param customerId 关联客户
	 */
	public static void addDynamic(String objectType, String actionType, String targetId, String targetName, String customerId){
		
		SysDynamic sysDynamic = new SysDynamic();
		sysDynamic.setObjectType(objectType);
		sysDynamic.setActionType(actionType);
		sysDynamic.setTargetId(targetId);
		sysDynamic.setTargetName(targetName);
		sysDynamic.setCustomerId(customerId);
		sysDynamicService.save(sysDynamic);
	}
}
