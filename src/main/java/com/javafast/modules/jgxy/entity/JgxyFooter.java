package com.javafast.modules.jgxy.entity;

import org.hibernate.validator.constraints.Length;

import com.javafast.common.persistence.DataEntity;
import com.javafast.common.utils.excel.annotation.ExcelField;

/**
 * 前台页脚Entity
 * @author javafast
 * @version 2019-06-22
 */
public class JgxyFooter extends DataEntity<JgxyFooter> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 配置名称
	private String state;		// 状态
	private String contents;		// 文本内容
	
	public JgxyFooter() {
		super();
	}

	public JgxyFooter(String id){
		super(id);
	}

	@Length(min=0, max=255, message="配置名称长度必须介于 0 和 255 之间")
	@ExcelField(title="配置名称", align=2, sort=1)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=50, message="状态长度必须介于 0 和 50 之间")
	@ExcelField(title="状态", dictType="jgxyState", align=2, sort=2)
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	@ExcelField(title="文本内容", align=2, sort=3)
	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}
	
}