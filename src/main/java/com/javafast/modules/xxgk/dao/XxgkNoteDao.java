package com.javafast.modules.xxgk.dao;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.javafast.modules.xxgk.entity.XxgkSysMenu;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import java.util.List;
import com.javafast.common.persistence.CrudDao;
import com.javafast.common.persistence.annotation.MyBatisDao;
import com.javafast.modules.xxgk.entity.XxgkNote;

/**
 * 富文本编辑器DAO接口
 * @author javafast
 * @version 2019-08-10
 */
@MyBatisDao
public interface XxgkNoteDao extends CrudDao<XxgkNote> {
	
}