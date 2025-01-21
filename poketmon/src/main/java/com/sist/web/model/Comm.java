package com.sist.web.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Comm implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long commSeq;
	private String userEmail;
	private String userName;
	private String userNickname;
	private long boardSeq;
	private String commContent;
	private String commRegDate;
	private String commModiDate;
	private String commDelDate;
	private long commGroup;
	private int commOrder;
	private int commIndent;
	private long commParent;
	
	private long startRow;		//시작페이지 rownum
	private long endRow;		//끝페이지 rownum
	
	private String commMe;		// 그냥 이거 쓰자
	
	private List<Comm> replies;  
	
	public Comm()
	{
		commSeq = 0;
		userEmail = "";
		userName = "";
		userNickname = "";
		boardSeq = 0;
		commContent = "";
		commRegDate = "";
		commModiDate = "";
		commDelDate = "";
		commGroup = 0;
		commOrder = 0;
		commIndent = 0;
		commParent = 0;
		
		startRow = 0;		//시작페이지 rownum
		endRow = 0;		//끝페이지 rownum
		
		commMe = "N";
		
		this.replies = new ArrayList<>();
	}
	
	
	
	public String getCommMe() {
		return commMe;
	}



	public void setCommMe(String commMe) {
		this.commMe = commMe;
	}



	public List<Comm> getReplies() {
		return replies;
	}



	public void setReplies(List<Comm> replies) {
		this.replies = replies;
	}



	public long getCommSeq() {
		return commSeq;
	}

	public void setCommSeq(long commSeq) {
		this.commSeq = commSeq;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
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

	public long getBoardSeq() {
		return boardSeq;
	}

	public void setBoardSeq(long boardSeq) {
		this.boardSeq = boardSeq;
	}

	public String getCommContent() {
		return commContent;
	}

	public void setCommContent(String commContent) {
		this.commContent = commContent;
	}

	public String getCommRegDate() {
		return commRegDate;
	}

	public void setCommRegDate(String commRegDate) {
		this.commRegDate = commRegDate;
	}

	public String getCommModiDate() {
		return commModiDate;
	}

	public void setCommModiDate(String commModiDate) {
		this.commModiDate = commModiDate;
	}

	public String getCommDelDate() {
		return commDelDate;
	}

	public void setCommDelDate(String commDelDate) {
		this.commDelDate = commDelDate;
	}

	public long getCommGroup() {
		return commGroup;
	}

	public void setCommGroup(long commGroup) {
		this.commGroup = commGroup;
	}

	public int getCommOrder() {
		return commOrder;
	}

	public void setCommOrder(int commOrder) {
		this.commOrder = commOrder;
	}

	public int getCommIndent() {
		return commIndent;
	}

	public void setCommIndent(int commIndent) {
		this.commIndent = commIndent;
	}

	public long getCommParent() {
		return commParent;
	}

	public void setCommParent(long commParent) {
		this.commParent = commParent;
	}

	public long getStartRow() {
		return startRow;
	}

	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}

	public long getEndRow() {
		return endRow;
	}

	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}
	
	
	
	
}
