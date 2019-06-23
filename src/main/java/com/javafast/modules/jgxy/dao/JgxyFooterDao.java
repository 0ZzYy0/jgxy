package com.javafast.modules.jgxy.dao;

import org.hibernate.validator.constraints.Length;

import java.util.List;
import com.javafast.common.persistence.CrudDao;
import com.javafast.common.persistence.annotation.MyBatisDao;
import com.javafast.modules.jgxy.entity.JgxyFooter;

/**
 * 前台页脚DAO接口
 * 
 * @author javafast
 * @version 2019-06-22
 */
@MyBatisDao
public interface JgxyFooterDao extends CrudDao<JgxyFooter> {
	
	//把其他数据的状态设置为0
	public void updateState(String id);

	// 查询当前唯一启用的 数据
	public JgxyFooter getJgxyFooter();

}