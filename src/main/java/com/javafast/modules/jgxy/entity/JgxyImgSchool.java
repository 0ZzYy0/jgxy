package com.javafast.modules.jgxy.entity;

import org.hibernate.validator.constraints.Length;

import com.javafast.common.persistence.DataEntity;
import com.javafast.common.utils.excel.annotation.ExcelField;

/**
 * jgxy_img_schoolEntity
 * @author zy
 * @version 2019-06-09
 */
public class JgxyImgSchool extends DataEntity<JgxyImgSchool> {
	
	private static final long serialVersionUID = 1L;
	private String isRelease;		// 是否发布
	private String imgPath;		// 图片
	private String imgTitle;		// 图片标题
	private String imgType;		// 图片类型
	private String sort;		// 排序
	private String remark;		// 备注
	
	public JgxyImgSchool() {
		super();
	}

	public JgxyImgSchool(String id){
		super(id);
	}

	@Length(min=0, max=10, message="是否发布长度必须介于 0 和 10 之间")
	@ExcelField(title="是否发布", dictType="is_release", align=2, sort=1)
	public String getIsRelease() {
		return isRelease;
	}

	public void setIsRelease(String isRelease) {
		this.isRelease = isRelease;
	}
	
	@Length(min=0, max=1000, message="图片长度必须介于 0 和 1000 之间")
	@ExcelField(title="图片", align=2, sort=2)
	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	
	@Length(min=0, max=500, message="图片标题长度必须介于 0 和 500 之间")
	@ExcelField(title="图片标题", align=2, sort=3)
	public String getImgTitle() {
		return imgTitle;
	}

	public void setImgTitle(String imgTitle) {
		this.imgTitle = imgTitle;
	}
	

	@ExcelField(title="图片类型", align=2, sort=4)
	public String getImgType() {
		return imgType;
	}

	public void setImgType(String imgType) {
		this.imgType = imgType;
	}
	
	@Length(min=0, max=10, message="排序长度必须介于 0 和 10 之间")
	@ExcelField(title="排序", align=2, sort=5)
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
	@Length(min=0, max=500, message="备注长度必须介于 0 和 500 之间")
	@ExcelField(title="备注", align=2, sort=6)
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}