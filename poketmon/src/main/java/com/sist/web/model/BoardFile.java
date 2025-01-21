package com.sist.web.model;

import java.io.Serializable;

public class BoardFile implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private short fileSeq;
	private long boardSeq;
	private String fileOrgName;
	private String fileName;
	private String fileExt;
	private long fileSize;
	private String fileRegDate;
	
	
	public BoardFile()
	{
		fileSeq = 0;
		boardSeq = 0;
		fileOrgName = "";
		fileName = "";
		fileExt = "";
		fileSize = 0;
		fileRegDate = "";
	}


	public short getFileSeq() {
		return fileSeq;
	}


	public void setFileSeq(short fileSeq) {
		this.fileSeq = fileSeq;
	}


	public long getBoardSeq() {
		return boardSeq;
	}


	public void setBoardSeq(long boardSeq) {
		this.boardSeq = boardSeq;
	}


	public String getFileOrgName() {
		return fileOrgName;
	}


	public void setFileOrgName(String fileOrgName) {
		this.fileOrgName = fileOrgName;
	}


	public String getFileName() {
		return fileName;
	}


	public void setFileName(String fileName) {
		this.fileName = fileName;
	}


	public String getFileExt() {
		return fileExt;
	}


	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}


	public long getFileSize() {
		return fileSize;
	}


	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}


	public String getFileRegDate() {
		return fileRegDate;
	}


	public void setFileRegDate(String fileRegDate) {
		this.fileRegDate = fileRegDate;
	}
	
	
}
