package com.javafast.modules.jgxy.service;

import java.util.List;

import org.hibernate.validator.constraints.Length;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javafast.common.persistence.Page;
import com.javafast.common.service.CrudService;
import com.javafast.modules.jgxy.entity.JgxyModalDiv;
import com.javafast.modules.jgxy.dao.JgxyModalDivDao;

/**
 * 模态窗口管理Service
 * 
 * @author javafast
 * @version 2019-06-23
 */
@Service
@Transactional(readOnly = true)
public class JgxyModalDivService extends CrudService<JgxyModalDivDao, JgxyModalDiv> {
	@Autowired
	private JgxyModalDivDao jgxyModalDivDao;

	public JgxyModalDiv get(String id) {
		return super.get(id);
	}

	public List<JgxyModalDiv> findList(JgxyModalDiv jgxyModalDiv) {
		return super.findList(jgxyModalDiv);
	}

	public Page<JgxyModalDiv> findPage(Page<JgxyModalDiv> page, JgxyModalDiv jgxyModalDiv) {
		return super.findPage(page, jgxyModalDiv);
	}

	@Transactional(readOnly = false)
	public void save(JgxyModalDiv jgxyModalDiv) {
		super.save(jgxyModalDiv);
	}

	@Transactional(readOnly = false)
	public void delete(JgxyModalDiv jgxyModalDiv) {
		super.delete(jgxyModalDiv);
	}

	@Transactional(readOnly = false)
	public void updateState(String id) {
		jgxyModalDivDao.updateState(id);
	}

	public JgxyModalDiv getJgxyModalDiv() {
		return jgxyModalDivDao.getJgxyModalDiv();
	}

}