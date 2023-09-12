package com.web.erp.vo;

public class SalesDetail {
	private String store_name;
	private int title;
	private String start;
	
	private int cur_year;
	private int cur_month;
	
	private int total_price;
	private int count;
	public SalesDetail() {
		// TODO Auto-generated constructor stub
	}
	// 점포별 일별 총매출 캘린더에 뿌리기
	public SalesDetail(String store_name, int title, String start) {
		this.store_name = store_name;
		this.title = title;
		this.start = start;
	}
	// 점포 월별 총매출 parameterType 생성자 
	public SalesDetail(String store_name, int cur_year, int cur_month) {
		this.store_name = store_name;
		this.cur_year = cur_year;
		this.cur_month = cur_month;
	}
	// 점포 월별 총매출 resultType 생성자
	public SalesDetail(int total_price, int count) {
		this.total_price = total_price;
		this.count = count;
	}
	
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getCur_year() {
		return cur_year;
	}
	public void setCur_year(int cur_year) {
		this.cur_year = cur_year;
	}
	public int getCur_month() {
		return cur_month;
	}
	public void setCur_month(int cur_month) {
		this.cur_month = cur_month;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public int getTitle() {
		return title;
	}
	public void setTitle(int title) {
		this.title = title;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	
}
