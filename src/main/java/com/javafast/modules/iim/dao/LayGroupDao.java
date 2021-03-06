package com.javafast.modules.iim.dao;

import com.javafast.common.persistence.CrudDao;
import com.javafast.common.persistence.annotation.MyBatisDao;
import com.javafast.modules.iim.entity.LayGroup;

/**
 * 群组DAO接口
 */
@MyBatisDao
public interface LayGroupDao extends CrudDao<LayGroup> {

	
}