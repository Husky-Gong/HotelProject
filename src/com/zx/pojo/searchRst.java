package com.zx.pojo;

public class searchRst {
	private int roomId;
	private int id;
	private String name;
	private int type;
	private double price;
	private String address;
	private String mobile;
	public int getId() {
		return id;
	}
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public void setId(int id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "searchRst [roomId=" + roomId + ", id=" + id + ", name=" + name + ", type=" + type + ", price=" + price
				+ ", address=" + address + ", mobile=" + mobile + "]";
	}
	public searchRst(int roomId, int id, String name, int type, double price, String address, String mobile) {
		super();
		this.roomId = roomId;
		this.id = id;
		this.name = name;
		this.type = type;
		this.price = price;
		this.address = address;
		this.mobile = mobile;
	}
	public searchRst() {
		super();
	}
	
	
	
}

