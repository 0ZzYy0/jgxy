package com.javafast.modules.jgxy.service;

import java.util.List;

import com.javafast.modules.jgxy.entity.JgxySysMenu;

import javax.validation.constraints.NotNull;

import org.apache.commons.lang3.StringEscapeUtils;
import org.hibernate.validator.constraints.Length;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javafast.common.persistence.Page;
import com.javafast.common.service.CrudService;
import com.javafast.modules.jgxy.entity.JgxyNote;
import com.javafast.modules.jgxy.dao.JgxyNoteDao;

/**
 * 文章Service
 * @author javafast
 * @version 2019-06-04
 */
@Service
@Transactional(readOnly = true)
public class JgxyNoteService extends CrudService<JgxyNoteDao, JgxyNote> {

	public JgxyNote get(String id) {
		return super.get(id);
	}
	
	public List<JgxyNote> findList(JgxyNote jgxyNote) {
		return super.findList(jgxyNote);
	}
	
	public Page<JgxyNote> findPage(Page<JgxyNote> page, JgxyNote jgxyNote) {
		return super.findPage(page, jgxyNote);
	}
	
	@Transactional(readOnly = false)
	public void save(JgxyNote jgxyNote) {
		//文本域转码
		if (jgxyNote.getContents()!=null){
			jgxyNote.setContents(StringEscapeUtils.unescapeHtml4(jgxyNote.getContents()));
			System.out.println(jgxyNote);
		}
		super.save(jgxyNote);
	}
	
	@Transactional(readOnly = false)
	public void delete(JgxyNote jgxyNote) {
		super.delete(jgxyNote);
	}
	
}