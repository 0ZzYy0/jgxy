package com.javafast.modules.jgxy.entity;

import com.javafast.modules.jgxy.entity.JgxySysMenu;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.javafast.common.persistence.DataEntity;
import com.javafast.common.utils.excel.annotation.ExcelField;

/**
 * 文章Entity
 * @author javafast
 * @version 2019-06-04
 */
public class JgxyNote extends DataEntity<JgxyNote> {
	
	private static final long serialVersionUID = 1L;
	private JgxySysMenu jgxySysMenu;		// 备注信息
	private String title;		// 标题
	private String contents;		// 内容
	
	public JgxyNote() {
		super();
	}

	public JgxyNote(String id){
		super(id);
	}

	@NotNull(message="备注信息不能为空")
	@ExcelField(title="备注信息", align=2, sort=5)
	public JgxySysMenu getJgxySysMenu() {
		return jgxySysMenu;
	}

	public void setJgxySysMenu(JgxySysMenu jgxySysMenu) {
		this.jgxySysMenu = jgxySysMenu;
	}
	
	@Length(min=0, max=50, message="标题长度必须介于 0 和 50 之间")
	@ExcelField(title="标题", align=2, sort=7)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@ExcelField(title="内容", align=2, sort=8)
	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	@Override
	public String toString() {
		return "JgxyNote [jgxySysMenu=" + jgxySysMenu + ", title=" + title + ", contents=" + contents + "]";
	}
	
}