package com.web.erp.vo;

public class OrderGantt {
	private String start;
	private String end;
	private String name;
	private String id;
	private String employee_name;
	private String brand;
	private String item_name;
	private String color;
	private String prd_size;
	private int order_count;
	private int order_status;
	private int product_num;

	public OrderGantt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public OrderGantt(String start, String end, String name, String id, String employee_name, String brand,
			String item_name, String color, String prd_size, int order_count, int order_status, int product_num) {
		super();
		this.start = start;
		this.end = end;
		this.name = name;
		this.id = id;
		this.employee_name = employee_name;
		this.brand = brand;
		this.item_name = item_name;
		this.color = color;
		this.prd_size = prd_size;
		this.order_count = order_count;
		this.order_status = order_status;
		this.product_num = product_num;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getEmployee_name() {
		return employee_name;
	}

	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
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

	public int getOrder_count() {
		return order_count;
	}

	public void setOrder_count(int order_count) {
		this.order_count = order_count;
	}

	public int getOrder_status() {
		return order_status;
	}

	public void setOrder_status(int order_status) {
		this.order_status = order_status;
	}

	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}


	
}
