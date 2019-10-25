package com.javafast.modules.xxgk.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.javafast.modules.xxgk.entity.XxgkSysMenu;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.javafast.common.persistence.DataEntity;
import com.javafast.common.utils.excel.annotation.ExcelField;

/**
 * 文章Entity
 * 
 * @author javafast
 * @version 2019-06-04
 */
public class XxgkNote extends DataEntity<XxgkNote> {

	private static final long serialVersionUID = 1L;
	private XxgkSysMenu xxgkSysMenu;
	private String title; // 标题
	private String contents; // 内容
	private Date releaseDate; // 可以调整的发布时间
	private String clickThroughput; // 点击量
	private String newState; //New 图标显示状态

	public XxgkNote() {
		super();
	}

	public XxgkNote(String id) {
		super(id);
	}

	@NotNull(message = "备注信息不能为空")
	@ExcelField(title = "备注信息", align = 2, sort = 6)
	public XxgkSysMenu getXxgkSysMenu() {
		return xxgkSysMenu;
	}

	public void setXxgkSysMenu(XxgkSysMenu xxgkSysMenu) {
		this.xxgkSysMenu = xxgkSysMenu;
	}

	@Length(min = 0, max = 50, message = "标题长度必须介于 0 和 50 之间")
	@ExcelField(title = "标题", align = 2, sort = 7)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@ExcelField(title = "内容", align = 2, sort = 8)
	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message = "发布日期不能为空")
	@ExcelField(title = "发布日期", align = 2, sort = 6)
	public Date getReleaseDate() {
		return releaseDate;
	}

	@ExcelField(title = "点击量", align = 2, sort = 3)
	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getClickThroughput() {
		return clickThroughput;
	}

	public void setClickThroughput(String clickThroughput) {
		this.clickThroughput = clickThroughput;
	}

	public String getNewState() {
		return newState;
	}

	public void setNewState(String newState) {
		this.newState = newState;
	}

	@Override
	public String toString() {
		return "XxgkNote [xxgkSysMenu=" + xxgkSysMenu + ", title=" + title + ", contents=" + contents + ", releaseDate=" + releaseDate
				+ ", clickThroughput=" + clickThroughput + ", newState=" + newState + "]";
	}

}