package com.javafast.modules.jgxy.service;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javafast.common.persistence.Page;
import com.javafast.common.service.CrudService;
import com.javafast.modules.jgxy.entity.JgxyImgSchool;
import com.javafast.modules.jgxy.dao.JgxyImgSchoolDao;

/**
 * jgxy_img_schoolService
 * @author zy
 * @version 2019-06-09
 */
@Service
@Transactional(readOnly = true)
public class JgxyImgSchoolService extends CrudService<JgxyImgSchoolDao, JgxyImgSchool> {

	public JgxyImgSchool get(String id) {
		return super.get(id);
	}
	
	public List<JgxyImgSchool> findList(JgxyImgSchool jgxyImgSchool) {
		return super.findList(jgxyImgSchool);
	}
	
	public Page<JgxyImgSchool> findPage(Page<JgxyImgSchool> page, JgxyImgSchool jgxyImgSchool) {
		return super.findPage(page, jgxyImgSchool);
	}
	
	@Transactional(readOnly = false)
	public void save(JgxyImgSchool jgxyImgSchool) {
		super.save(jgxyImgSchool);
	}
	
	@Transactional(readOnly = false)
	public void delete(JgxyImgSchool jgxyImgSchool) {
		super.delete(jgxyImgSchool);
	}
	
}