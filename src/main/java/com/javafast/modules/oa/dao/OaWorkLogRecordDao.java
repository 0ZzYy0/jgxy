package com.javafast.modules.oa.dao;

import org.hibernate.validator.constraints.Length;
import com.javafast.modules.sys.entity.User;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.List;
import com.javafast.common.persistence.CrudDao;
import com.javafast.common.persistence.annotation.MyBatisDao;
import com.javafast.modules.oa.entity.OaWorkLogRecord;

/**
 * 工作报告DAO接口
 * @author javafast
 * @version 2018-05-03
 */
@MyBatisDao
public interface OaWorkLogRecordDao extends CrudDao<OaWorkLogRecord> {
	
}