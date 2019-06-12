package com.javafast.modules.jgxy.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.validator.constraints.Length;

import com.javafast.common.persistence.TreeEntity;

/**
 * 菜单(树结构)Entity
 * @author javafast
 * @version 2019-06-06
 */
public class JgxySysMenu extends TreeEntity<JgxySysMenu> {
	
	private static final long serialVersionUID = 1L;
	private JgxySysMenu parent;		// 上级分类
	private String parentIds;		// 所有父级编号
	private String name;		// 菜单名称
	private Integer sort;		// 排序
	private String menuType;
	
	public JgxySysMenu() {
		super();
	}

	public JgxySysMenu(String id){
		super(id);
	}

	@JsonBackReference
	public JgxySysMenu getParent() {
		return parent;
	}

	public void setParent(JgxySysMenu parent) {
		this.parent = parent;
	}
	
	@Length(min=0, max=1000, message="所有父级编号长度必须介于 0 和 1000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@Length(min=1, max=50, message="菜单名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}

	public String getMenuType() {
		return menuType;
	}

	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}

	@Override
	public String toString() {
		return "JgxySysMenu [parent=" + parent + ", parentIds=" + parentIds + ", name=" + name + ", sort=" + sort + ", menuType=" + menuType + "]";
	}
	
}