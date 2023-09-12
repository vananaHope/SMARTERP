package com.web.erp.entity;

import java.util.Date;

import org.hibernate.annotations.ColumnDefault;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;

@SequenceGenerator(
		name="STORE_SEQ_GENERATOR",
		sequenceName="STORE_SEQ",
		initialValue=1,
		allocationSize=1)

@Entity
@Table(name = "STORE")
public class Store {
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,
				generator="STORE_SEQ_GENERATOR")
	@Column(name="STORE_NUM")
	private Long store_num;
	@Column(name="STORE_NAME", nullable = false)
	private String store_name;
	@Column(name="CITY", nullable = false)
	private String city;
	@Column(name="REGION", nullable = false)
	private String region;
	@Column(name="DETAIL_ADDRESS", nullable = false)
	private String detail_address;
	@Column(name="CONTACT", nullable = false)
	private String contact;
	@Column(name="STORE_AREA", nullable = false)
	private String store_area;
	@Column(name="LATITUDE", nullable = false)
	private String latitude;
	@Column(name="LONGITUDE", nullable = false)
	private String longitude;
	@Column(name="REG_DATE", nullable = false, columnDefinition = "date default sysdate")
	private Date reg_date = new Date();
	
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Long getStore_num() {
		return store_num;
	}
	public void setStore_num(Long store_num) {
		this.store_num = store_num;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getStore_area() {
		return store_area;
	}
	public void setStore_area(String store_area) {
		this.store_area = store_area;
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
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	
}
