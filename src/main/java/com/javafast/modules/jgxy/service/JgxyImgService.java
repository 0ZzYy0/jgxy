package com.javafast.modules.jgxy.service;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javafast.common.persistence.Page;
import com.javafast.common.service.CrudService;
import com.javafast.modules.jgxy.entity.JgxyImg;
import com.javafast.modules.jgxy.dao.JgxyImgDao;

/**
 * jgxy_imgService
 * @author javafast
 * @version 2019-06-23
 */
@Service
@Transactional(readOnly = true)
public class JgxyImgService extends CrudService<JgxyImgDao, JgxyImg> {

	public JgxyImg get(String id) {
		return super.get(id);
	}
	
	public List<JgxyImg> findList(JgxyImg jgxyImg) {
		return super.findList(jgxyImg);
	}
	
	public Page<JgxyImg> findPage(Page<JgxyImg> page, JgxyImg jgxyImg) {
		return super.findPage(page, jgxyImg);
	}
	
	@Transactional(readOnly = false)
	public void save(JgxyImg jgxyImg) {
		super.save(jgxyImg);
	}
	
	@Transactional(readOnly = false)
	public void delete(JgxyImg jgxyImg) {
		super.delete(jgxyImg);
	}
	
}