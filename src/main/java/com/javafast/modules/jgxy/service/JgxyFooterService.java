package com.javafast.modules.jgxy.service;

import java.util.List;

import org.apache.commons.lang3.StringEscapeUtils;
import org.hibernate.validator.constraints.Length;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javafast.common.persistence.Page;
import com.javafast.common.service.CrudService;
import com.javafast.modules.jgxy.entity.JgxyFooter;
import com.javafast.modules.jgxy.dao.JgxyFooterDao;

/**
 * 前台页脚Service
 * 
 * @author javafast
 * @version 2019-06-22
 */
@Service
@Transactional(readOnly = true)
public class JgxyFooterService extends CrudService<JgxyFooterDao, JgxyFooter> {

	@Autowired
	private JgxyFooterDao jgxyFooterDao;

	public JgxyFooter get(String id) {
		return super.get(id);
	}

	public List<JgxyFooter> findList(JgxyFooter jgxyFooter) {
		return super.findList(jgxyFooter);
	}

	public Page<JgxyFooter> findPage(Page<JgxyFooter> page, JgxyFooter jgxyFooter) {
		return super.findPage(page, jgxyFooter);
	}

	@Transactional(readOnly = false)
	public void save(JgxyFooter jgxyFooter) {
		//文本域转码
		if (jgxyFooter.getContents()!=null){
			jgxyFooter.setContents(StringEscapeUtils.unescapeHtml4(jgxyFooter.getContents()));
			System.out.println(jgxyFooter);
		}
		super.save(jgxyFooter);
	}

	@Transactional(readOnly = false)
	public void delete(JgxyFooter jgxyFooter) {
		super.delete(jgxyFooter);
	}
	
	//把除了自己的全部数据 state 变成 0
	@Transactional(readOnly = false)
	public void updateState(String id) {
		jgxyFooterDao.updateState(id);
	}
	
	//查询当前启用的唯一数据
	public JgxyFooter getJgxyFooter(){
		return jgxyFooterDao.getJgxyFooter();
	}

}