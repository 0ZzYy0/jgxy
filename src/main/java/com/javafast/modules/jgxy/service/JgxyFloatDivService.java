package com.javafast.modules.jgxy.service;

import java.util.List;

import org.hibernate.validator.constraints.Length;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javafast.common.persistence.Page;
import com.javafast.common.service.CrudService;
import com.javafast.modules.jgxy.entity.JgxyFloatDiv;
import com.javafast.modules.jgxy.dao.JgxyFloatDivDao;

/**
 * 悬浮窗口Service
 * 
 * @author javafast
 * @version 2019-06-23
 */
@Service
@Transactional(readOnly = true)
public class JgxyFloatDivService extends CrudService<JgxyFloatDivDao, JgxyFloatDiv> {

	@Autowired
	private JgxyFloatDivDao jgxyFloatDivDao;

	public JgxyFloatDiv get(String id) {
		return super.get(id);
	}

	public List<JgxyFloatDiv> findList(JgxyFloatDiv jgxyFloatDiv) {
		return super.findList(jgxyFloatDiv);
	}

	public Page<JgxyFloatDiv> findPage(Page<JgxyFloatDiv> page, JgxyFloatDiv jgxyFloatDiv) {
		return super.findPage(page, jgxyFloatDiv);
	}

	@Transactional(readOnly = false)
	public void save(JgxyFloatDiv jgxyFloatDiv) {
		super.save(jgxyFloatDiv);
	}

	@Transactional(readOnly = false)
	public void delete(JgxyFloatDiv jgxyFloatDiv) {
		super.delete(jgxyFloatDiv);
	}

	public JgxyFloatDiv getJgxyFloatDiv() {
		return jgxyFloatDivDao.getJgxyFloatDiv();
	}

	@Transactional(readOnly = false)
	public void updateState(String id) {
		jgxyFloatDivDao.updateState(id);
	}

}