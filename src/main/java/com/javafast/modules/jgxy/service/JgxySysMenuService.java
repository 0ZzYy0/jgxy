package com.javafast.modules.jgxy.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javafast.common.service.TreeService;
import com.javafast.common.utils.StringUtils;
import com.javafast.modules.jgxy.entity.JgxySysMenu;
import com.javafast.modules.jgxy.dao.JgxySysMenuDao;

/**
 * 菜单(树结构)Service
 * @author javafast
 * @version 2019-06-06
 */
@Service
@Transactional(readOnly = true)
public class JgxySysMenuService extends TreeService<JgxySysMenuDao, JgxySysMenu> {

	public JgxySysMenu get(String id) {
		return super.get(id);
	}
	
	public List<JgxySysMenu> findList(JgxySysMenu jgxySysMenu) {
		if (StringUtils.isNotBlank(jgxySysMenu.getParentIds())){
			jgxySysMenu.setParentIds(","+jgxySysMenu.getParentIds()+",");
		}
		return super.findList(jgxySysMenu);
	}
	
	@Transactional(readOnly = false)
	public void save(JgxySysMenu jgxySysMenu) {
		super.save(jgxySysMenu);
	}
	
	@Transactional(readOnly = false)
	public void delete(JgxySysMenu jgxySysMenu) {
		super.delete(jgxySysMenu);
	}
	
}