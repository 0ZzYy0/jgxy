package com.javafast.modules.jgxy.dao;

import org.hibernate.validator.constraints.Length;

import java.util.List;
import com.javafast.common.persistence.CrudDao;
import com.javafast.common.persistence.annotation.MyBatisDao;
import com.javafast.modules.jgxy.entity.JgxyImg;

/**
 * jgxy_imgDAO接口
 * @author javafast
 * @version 2019-06-09
 */
@MyBatisDao
public interface JgxyImgDao extends CrudDao<JgxyImg> {
	
}