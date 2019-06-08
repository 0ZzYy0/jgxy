package com.javafast.modules.sys.service;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javafast.common.persistence.Page;
import com.javafast.common.service.CrudService;
import com.javafast.modules.sys.entity.SysSms;
import com.javafast.modules.sys.utils.UserUtils;
import com.javafast.modules.sys.dao.SysSmsDao;

/**
 * 系统短信Service
 */
@Service
@Transactional(readOnly = true)
public class SysSmsService extends CrudService<SysSmsDao, SysSms> {

	public SysSms get(String id) {
		return super.get(id);
	}
	
	public List<SysSms> findList(SysSms sysSms) {
		if(!UserUtils.getUser().isAdmin()){
			return null;
		}
		return super.findList(sysSms);
	}
	
	public Page<SysSms> findPage(Page<SysSms> page, SysSms sysSms) {
		if(!UserUtils.getUser().isAdmin()){
			return null;
		}
		return super.findPage(page, sysSms);
	}
	
	@Transactional(readOnly = false)
	public void save(SysSms sysSms) {
		super.save(sysSms);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysSms sysSms) {
		super.delete(sysSms);
	}
	
	public List<SysSms> findAllList(SysSms sysSms) {
		return super.findList(sysSms);
	}
}