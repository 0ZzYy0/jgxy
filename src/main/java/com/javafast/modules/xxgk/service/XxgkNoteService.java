package com.javafast.modules.xxgk.service;

import java.util.List;

import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javafast.common.persistence.Page;
import com.javafast.common.service.CrudService;
import com.javafast.modules.xxgk.entity.XxgkNote;
import com.javafast.modules.xxgk.dao.XxgkNoteDao;

/**
 * 文章Service
 * @author javafast
 * @version 2019-08-10
 */
@Service
@Transactional(readOnly = true)
public class XxgkNoteService extends CrudService<XxgkNoteDao, XxgkNote> {

	public XxgkNote get(String id) {
		return super.get(id);
	}

	public List<XxgkNote> findList(XxgkNote xxgkNote) {
		return super.findList(xxgkNote);
	}

	public Page<XxgkNote> findPage(Page<XxgkNote> page, XxgkNote xxgkNote) {
		return super.findPage(page, xxgkNote);
	}

	@Transactional(readOnly = false)
	public void save(XxgkNote xxgkNote) {
		// 文本域转码
		if (xxgkNote.getContents() != null) {
			xxgkNote.setContents(StringEscapeUtils.unescapeHtml4(xxgkNote.getContents()));
			System.out.println(xxgkNote);
		}
		super.save(xxgkNote);
	}

	@Transactional(readOnly = false)
	public void delete(XxgkNote xxgkNote) {
		super.delete(xxgkNote);
	}

}