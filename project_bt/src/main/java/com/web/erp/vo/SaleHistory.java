package com.web.erp.vo;

public class SaleHistory {
	private int store_num;
	private String store_name;
	private String item_name;
	private String brand;
	private String color;
	private String size;
	private String store_product_id;
	private String cost;
	private int cnt;
	
	public SaleHistory() {
		// TODO Auto-generated constructor stub
	}

	public SaleHistory(int store_num, String store_name, String item_name, String brand, String color, String size,
			String store_product_id, String cost, int cnt) {
		this.store_num = store_num;
		this.store_name = store_name;
		this.item_name = item_name;
		this.brand = brand;
		this.color = color;
		this.size = size;
		this.store_product_id = store_product_id;
		this.cost = cost;
		this.cnt = cnt;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getBrand() {
		return brand;
	}


	public void setBrand(String brand) {
		this.brand = brand;
	}


	public String getColor() {
		return color;
	}


	public void setColor(String color) {
		this.color = color;
	}


	public String getSize() {
		return size;
	}


	public void setSize(String size) {
		this.size = size;
	}


	public String getStore_product_id() {
		return store_product_id;
	}


	public void setStore_product_id(String store_product_id) {
		this.store_product_id = store_product_id;
	}


	public String getCost() {
		return cost;
	}


	public void setCost(String cost) {
		this.cost = cost;
	}


	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public int getStore_num() {
		return store_num;
	}
	public void setStore_num(int store_num) {
		this.store_num = store_num;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	
	
	
	
}
