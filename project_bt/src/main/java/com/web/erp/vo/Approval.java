package com.web.erp.vo;

public class Approval {
	private String approval_id;
	private String order_id;
	private String approval_date;
	private String approval_type;
	private String drafter;
	private String approver;
	private String subject;
	private String contents;
	private int approval_status;
	private String employee_name;
	private int employee_num;
	private String brand;
	private String item_name;
	private String color;
	private String prd_size;
	private String store;
	
	public Approval() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Approval(String approval_id, String order_id, String approval_date, String approval_type, String drafter,
			String approver, String subject, String contents, int approval_status, String employee_name,
			int employee_num, String brand, String item_name, String color, String prd_size, String store) {
		super();
		this.approval_id = approval_id;
		this.order_id = order_id;
		this.approval_date = approval_date;
		this.approval_type = approval_type;
		this.drafter = drafter;
		this.approver = approver;
		this.subject = subject;
		this.contents = contents;
		this.approval_status = approval_status;
		this.employee_name = employee_name;
		this.employee_num = employee_num;
		this.brand = brand;
		this.item_name = item_name;
		this.color = color;
		this.prd_size = prd_size;
		this.store = store;
	}

	public String getStore() {
		return store;
	}

	public void setStore(String store) {
		this.store = store;
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

	public String getEmployee_name() {
		return employee_name;
	}

	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}

	public int getEmployee_num() {
		return employee_num;
	}

	public void setEmployee_num(int employee_num) {
		this.employee_num = employee_num;
	}

	public String getApproval_id() {
		return approval_id;
	}
	public void setApproval_id(String approval_id) {
		this.approval_id = approval_id;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(String approval_date) {
		this.approval_date = approval_date;
	}
	public String getApproval_type() {
		return approval_type;
	}
	public void setApproval_type(String approval_type) {
		this.approval_type = approval_type;
	}
	public String getDrafter() {
		return drafter;
	}
	public void setDrafter(String drafter) {
		this.drafter = drafter;
	}
	public String getApprover() {
		return approver;
	}
	public void setApprover(String approver) {
		this.approver = approver;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getApproval_status() {
		return approval_status;
	}
	public void setApproval_status(int approval_status) {
		this.approval_status = approval_status;
	}

}
