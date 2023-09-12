package com.web.erp.vo;

public class SchPrd {
	private int product_num;
	private String brand;
	private String item_name;
	private String color;
	private String prd_size;
	private int cost;
	private String reg_date;
	private int product_count;
	private int properties_num;
	private int item_num;

	public SchPrd() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SchPrd(int product_num, String brand, String item_name, String color, String prd_size, int cost,
			String reg_date, int product_count, int properties_num, int item_num) {
		super();
		this.product_num = product_num;
		this.brand = brand;
		this.item_name = item_name;
		this.color = color;
		this.prd_size = prd_size;
		this.cost = cost;
		this.reg_date = reg_date;
		this.product_count = product_count;
		this.properties_num = properties_num;
		this.item_num = item_num;
	}

	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getPrd_size() {
		return prd_size;
	}

	public void setPrd_size(String prd_size) {
		this.prd_size = prd_size;
	}

	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public int getProduct_count() {
		return product_count;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	public int getProperties_num() {
		return properties_num;
	}

	public void setProperties_num(int properties_num) {
		this.properties_num = properties_num;
	}

	public int getItem_num() {
		return item_num;
	}

	public void setItem_num(int item_num) {
		this.item_num = item_num;
	}

}
