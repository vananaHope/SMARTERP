package com.web.erp.vo;

public class StoreStorage {
	private int product_num;
	private String brand;
	private String item_name;
	private String color;
	private int sizee;
	private int cost;
	private int storage_count;
	private int properties_num;
	private int item_num;
	private int product_nums[];
	private int counts[];
	private int store_num;

	public StoreStorage() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StoreStorage(int product_num, String brand, String item_name, String color, int sizee, int cost,
			int storage_count, int properties_num, int item_num, int[] product_nums, int[] counts, int store_num) {
		super();
		this.product_num = product_num;
		this.brand = brand;
		this.item_name = item_name;
		this.color = color;
		this.sizee = sizee;
		this.cost = cost;
		this.storage_count = storage_count;
		this.properties_num = properties_num;
		this.item_num = item_num;
		this.product_nums = product_nums;
		this.counts = counts;
		this.store_num = store_num;
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

	public int getSizee() {
		return sizee;
	}

	public void setSizee(int sizee) {
		this.sizee = sizee;
	}

	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	public int getStorage_count() {
		return storage_count;
	}

	public void setStorage_count(int storage_count) {
		this.storage_count = storage_count;
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

	public int[] getProduct_nums() {
		return product_nums;
	}

	public void setProduct_nums(int[] product_nums) {
		this.product_nums = product_nums;
	}

	public int[] getCounts() {
		return counts;
	}

	public void setCounts(int[] counts) {
		this.counts = counts;
	}

	public int getStore_num() {
		return store_num;
	}

	public void setStore_num(int store_num) {
		this.store_num = store_num;
	}

}
