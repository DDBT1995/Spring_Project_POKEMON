package com.sist.web.model;

import java.io.Serializable;

public class Board implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	 private long boardSeq;
	 private String userEmail;
	 private String userName;
	 private String userNickname;
	 private String boardTitle;
	 private String boardContent;
	 private String boardCategory;
	 private int boardReadCnt;
	 private int likeCount;
	 private String boardStatus;
	 private String boardRegDate;
	 private String boardModiDate;
	 private String boardDelDate;
	 
	 private String searchType;	//검색타입 (1:이름, 2:제목, 3:내용)
	 private String searchValue;	// 검색 값
	
	 private long startRow;		//시작페이지 rownum
	 private long endRow;		//끝페이지 rownum
	 
	 private BoardFile boardFile;
	
	public Board()
	{
		 boardSeq = 0;
		 userEmail = "";
		 userName = "";
		 userNickname = "";
		 boardTitle = "";
		 boardContent = "";
		 boardCategory = "";
		 boardReadCnt = 0;
		 likeCount = 0;
		 boardStatus = "";
		 boardRegDate = "";
		 boardModiDate = "";
		 boardDelDate = "";
		 
		 searchType = "";	
		 searchValue = "";	
		
		 startRow = 0;		
		 endRow = 0;	
		 
		 boardFile = null;
	}
	
	

	public int getLikeCount() {
		return likeCount;
	}



	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}



	public String getSearchType() {
		return searchType;
	}



	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}



	public String getSearchValue() {
		return searchValue;
	}



	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
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



	public BoardFile getBoardFile() {
		return boardFile;
	}



	public void setBoardFile(BoardFile boardFile) {
		this.boardFile = boardFile;
	}



	public long getBoardSeq() {
		return boardSeq;
	}

	public void setBoardSeq(long boardSeq) {
		this.boardSeq = boardSeq;
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

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public String getBoardCategory() {
		return boardCategory;
	}

	public void setBoardCategory(String boardCategory) {
		this.boardCategory = boardCategory;
	}

	public int getBoardReadCnt() {
		return boardReadCnt;
	}

	public void setBoardReadCnt(int boardReadCnt) {
		this.boardReadCnt = boardReadCnt;
	}

	public String getBoardStatus() {
		return boardStatus;
	}

	public void setBoardStatus(String boardStatus) {
		this.boardStatus = boardStatus;
	}

	public String getBoardRegDate() {
		return boardRegDate;
	}

	public void setBoardRegDate(String boardRegDate) {
		this.boardRegDate = boardRegDate;
	}

	public String getBoardModiDate() {
		return boardModiDate;
	}

	public void setBoardModiDate(String boardModiDate) {
		this.boardModiDate = boardModiDate;
	}

	public String getBoardDelDate() {
		return boardDelDate;
	}

	public void setBoardDelDate(String boardDelDate) {
		this.boardDelDate = boardDelDate;
	}

}
