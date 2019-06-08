package com.javafast.modules.jgxy.dao;

import com.javafast.common.persistence.TreeDao;
import com.javafast.common.persistence.annotation.MyBatisDao;
import com.javafast.modules.jgxy.entity.JgxySysMenu;

/**
 * 菜单(树结构)DAO接口
 * @author javafast
 * @version 2019-06-06
 */
@MyBatisDao
public interface JgxySysMenuDao extends TreeDao<JgxySysMenu> {
	
}