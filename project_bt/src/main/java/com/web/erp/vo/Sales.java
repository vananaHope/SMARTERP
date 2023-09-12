package com.web.erp.vo;

public class Sales {
	private int store_num;
	private String store_name;
	private String employee_name;
	private int total_price;
	private String contact;
	private String city;
	private String region;
	private String detail_address;
	private String item_name;
	private int brand_num;
	private int current_month;
	private int current_year;
	
	public Sales() {
		// TODO Auto-generated constructor stub
	}
	// 점포별 매출
	public Sales(int store_num, String store_name, String employee_name, int total_price, String contact, String city,
			String region, String detail_address) {
		this.store_num = store_num;
		this.store_name = store_name;
		this.employee_name = employee_name;
		this.total_price = total_price;
		this.contact = contact;
		this.city = city;
		this.region = region;
		this.detail_address = detail_address;
	}
	
	// 브랜드별 매출
	public Sales(String item_name, int brand_num, int current_month, int current_year) {
		this.item_name = item_name;
		this.brand_num = brand_num;
		this.current_month = current_month;
		this.current_year = current_year;
	}
	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public int getBrand_num() {
		return brand_num;
	}

	public void setBrand_num(int brand_num) {
		this.brand_num = brand_num;
	}

	public int getCurrent_month() {
		return current_month;
	}

	public void setCurrent_month(int current_month) {
		this.current_month = current_month;
	}

	public int getCurrent_year() {
		return current_year;
	}

	public void setCurrent_year(int current_year) {
		this.current_year = current_year;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getDetail_address() {
		return detail_address;
	}

	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
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
	public String getEmployee_name() {
		return employee_name;
	}
	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	
	
	
}
