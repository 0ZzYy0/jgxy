package com.javafast.modules.test.entity.note;

import org.hibernate.validator.constraints.Length;

import com.javafast.common.persistence.DataEntity;
import com.javafast.common.utils.excel.annotation.ExcelField;

/**
 * 富文本测试Entity
 * @author javafast
 * @version 2018-07-18
 */
public class TestNote extends DataEntity<TestNote> {
	
	private static final long serialVersionUID = 1L;
	private String title;		// 标题
	private String contents;		// 内容
	
	public TestNote() {
		super();
	}

	public TestNote(String id){
		super(id);
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
	
}