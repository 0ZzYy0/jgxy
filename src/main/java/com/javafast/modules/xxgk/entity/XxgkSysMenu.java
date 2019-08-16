package com.javafast.modules.xxgk.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.validator.constraints.Length;

import com.javafast.common.persistence.TreeEntity;

/**
 * 菜单(树结构)Entity
 * 
 * @author javafast
 * @version 2019-08-10
 */
public class XxgkSysMenu extends TreeEntity<XxgkSysMenu> {

	private static final long serialVersionUID = 1L;
	private XxgkSysMenu parent; // 上级分类
	private String parentIds; // 所有父级编号
	private String name; // 菜单名称
	private Integer sort; // 排序
	private String menuType; // 菜单类型

	public XxgkSysMenu() {
		super();
	}

	public XxgkSysMenu(String id) {
		super(id);
	}

	@JsonBackReference
	public XxgkSysMenu getParent() {
		return parent;
	}

	public void setParent(XxgkSysMenu parent) {
		this.parent = parent;
	}

	@Length(min = 0, max = 1000, message = "所有父级编号长度必须介于 0 和 1000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}

	@Length(min = 1, max = 200, message = "菜单名称长度必须介于 1 和 200 之间")
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

	@Length(min = 0, max = 30, message = "菜单类型长度必须介于 0 和 30 之间")
	public String getMenuType() {
		return menuType;
	}

	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}

	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}

	@Override
	public String toString() {
		return "XxgkSysMenu [parent=" + parent + ", parentIds=" + parentIds + ", name=" + name + ", sort=" + sort + ", menuType=" + menuType + "]";
	}

}