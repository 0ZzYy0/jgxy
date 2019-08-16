package com.javafast.modules.xxgk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javafast.common.service.TreeService;
import com.javafast.common.utils.StringUtils;
import com.javafast.modules.xxgk.entity.XxgkSysMenu;
import com.javafast.modules.xxgk.dao.XxgkSysMenuDao;

/**
 * 菜单(树结构)Service
 * 
 * @author javafast
 * @version 2019-08-10
 */
@Service
@Transactional(readOnly = true)
public class XxgkSysMenuService extends TreeService<XxgkSysMenuDao, XxgkSysMenu> {

	@Autowired
	private XxgkSysMenuDao xxgkSysMenuDao;

	public XxgkSysMenu get(String id) {
		return super.get(id);
	}

	public XxgkSysMenu getByName(String name) {
		return xxgkSysMenuDao.getByName(name);
	}

	public List<XxgkSysMenu> findListByPid(String pid) {
		return xxgkSysMenuDao.findListByPid(pid);
	}

	public List<XxgkSysMenu> findList(XxgkSysMenu xxgkSysMenu) {
		if (StringUtils.isNotBlank(xxgkSysMenu.getParentIds())) {
			xxgkSysMenu.setParentIds("," + xxgkSysMenu.getParentIds() + ",");
		}
		return super.findList(xxgkSysMenu);
	}

	@Transactional(readOnly = false)
	public void save(XxgkSysMenu xxgkSysMenu) {
		super.save(xxgkSysMenu);
	}

	@Transactional(readOnly = false)
	public void delete(XxgkSysMenu xxgkSysMenu) {
		super.delete(xxgkSysMenu);
	}

}