package com.web.erp.vo;

public class ProductProperties {
	private int properties_num;
	private String color;
	private int ref_num;

	public ProductProperties() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProductProperties(int properties_num, String color, int ref_num) {
		super();
		this.properties_num = properties_num;
		this.color = color;
		this.ref_num = ref_num;
	}

	public int getProperties_num() {
		return properties_num;
	}

	public void setProperties_num(int properties_num) {
		this.properties_num = properties_num;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public int getRef_num() {
		return ref_num;
	}

	public void setRef_num(int ref_num) {
		this.ref_num = ref_num;
	}

}
