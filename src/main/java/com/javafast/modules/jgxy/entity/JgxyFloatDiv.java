package com.javafast.modules.jgxy.entity;

import org.hibernate.validator.constraints.Length;

import com.javafast.common.persistence.DataEntity;
import com.javafast.common.utils.excel.annotation.ExcelField;

/**
 * 悬浮窗口Entity
 * @author javafast
 * @version 2019-06-23
 */
public class JgxyFloatDiv extends DataEntity<JgxyFloatDiv> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 配置名称
	private String state;		// 状态
	private String imgPath;		// 图片
	private String href;		// 超链接
	
	public JgxyFloatDiv() {
		super();
	}

	public JgxyFloatDiv(String id){
		super(id);
	}

	@Length(min=1, max=255, message="配置名称长度必须介于 1 和 255 之间")
	@ExcelField(title="配置名称", align=2, sort=1)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=255, message="状态长度必须介于 1 和 255 之间")
	@ExcelField(title="状态", dictType="jgxyState", align=2, sort=2)
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	@Length(min=1, max=255, message="图片长度必须介于 1 和 255 之间")
	@ExcelField(title="图片", align=2, sort=3)
	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	
	@Length(min=0, max=255, message="超链接长度必须介于 0 和 255 之间")
	@ExcelField(title="超链接", align=2, sort=4)
	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}
	
}