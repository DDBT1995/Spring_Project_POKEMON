package com.sist.web.model;

import java.io.Serializable;

public class User implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String userEmail;
	private String userPwd;
	private String userName;
	private String userNickname;
	private String userTel;
	private String userBirth;
	private String userAddr;
	
	private String userPostcode;
	private String userDetailaddr;
	
	private String userStatus;
	private String userRegDate;
	private String userModiDate;
	private String userDelDate;
	
	
	public User()
	{
		userEmail = "";
		userPwd = "";
		userName = "";
		userNickname = "";
		userTel = "";
		userBirth = "";
		userAddr = "";
		
		userPostcode = "";
		userDetailaddr = "";
		
		userStatus = "";
		userRegDate = "";
		userModiDate = "";
		userDelDate = "";
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public String getUserTel() {
		return userTel;
	}

	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}

	public String getUserBirth() {
		return userBirth;
	}

	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}

	public String getUserAddr() {
		return userAddr;
	}

	public void setUserAddr(String userAddr) {
		this.userAddr = userAddr;
	}
	
	
	
	
	
	public String getUserPostcode() {
		return userPostcode;
	}

	public void setUserPostcode(String userPostcode) {
		this.userPostcode = userPostcode;
	}

	public String getUserDetailaddr() {
		return userDetailaddr;
	}

	public void setUserDetailaddr(String userDetailaddr) {
		this.userDetailaddr = userDetailaddr;
	}
	
	
	

	public String getUserStatus() {
		return userStatus;
	}

	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}

	public String getUserRegDate() {
		return userRegDate;
	}

	public void setUserRegDate(String userRegDate) {
		this.userRegDate = userRegDate;
	}

	public String getUserModiDate() {
		return userModiDate;
	}

	public void setUserModiDate(String userModiDate) {
		this.userModiDate = userModiDate;
	}

	public String getUserDelDate() {
		return userDelDate;
	}

	public void setUserDelDate(String userDelDate) {
		this.userDelDate = userDelDate;
	}
	
	
}
