package com.javafast.modules.jgxy.dao;

import org.hibernate.validator.constraints.Length;

import java.util.List;
import com.javafast.common.persistence.CrudDao;
import com.javafast.common.persistence.annotation.MyBatisDao;
import com.javafast.modules.jgxy.entity.JgxyModalDiv;

/**
 * 模态窗口管理DAO接口
 * 
 * @author javafast
 * @version 2019-06-23
 */
@MyBatisDao
public interface JgxyModalDivDao extends CrudDao<JgxyModalDiv> {
	public void updateState(String id);

	public JgxyModalDiv getJgxyModalDiv();
}