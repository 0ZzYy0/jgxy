package com.javafast.modules.xxgk.dao;

import java.util.List;

import com.javafast.common.persistence.TreeDao;
import com.javafast.common.persistence.annotation.MyBatisDao;
import com.javafast.modules.xxgk.entity.XxgkSysMenu;

/**
 * 菜单(树结构)DAO接口
 * 
 * @author javafast
 * @version 2019-08-10
 */
@MyBatisDao
public interface XxgkSysMenuDao extends TreeDao<XxgkSysMenu> {
	public XxgkSysMenu getByName(String name);
	public List<XxgkSysMenu> findListByPid(String pid);
}