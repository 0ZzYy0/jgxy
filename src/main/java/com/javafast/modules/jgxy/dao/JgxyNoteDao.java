package com.javafast.modules.jgxy.dao;

import com.javafast.modules.jgxy.entity.JgxySysMenu;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import java.util.List;
import com.javafast.common.persistence.CrudDao;
import com.javafast.common.persistence.annotation.MyBatisDao;
import com.javafast.modules.jgxy.entity.JgxyNote;

/**
 * 文章DAO接口
 * @author javafast
 * @version 2019-06-04
 */
@MyBatisDao
public interface JgxyNoteDao extends CrudDao<JgxyNote> {
	
}