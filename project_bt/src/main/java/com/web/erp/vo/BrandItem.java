package com.web.erp.vo;

public class BrandItem {
	private int item_num;
	private String item_name;
	private int ref_num;

	public BrandItem() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BrandItem(int item_num, String item_name, int ref_num) {
		super();
		this.item_num = item_num;
		this.item_name = item_name;
		this.ref_num = ref_num;
	}

	public int getItem_num() {
		return item_num;
	}

	public void setItem_num(int item_num) {
		this.item_num = item_num;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public int getRef_num() {
		return ref_num;
	}

	public void setRef_num(int ref_num) {
		this.ref_num = ref_num;
	}

}