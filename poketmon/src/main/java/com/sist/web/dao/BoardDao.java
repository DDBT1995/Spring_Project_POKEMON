package com.sist.web.dao;

import java.util.List;

import com.sist.web.model.Board;
import com.sist.web.model.BoardFile;
import com.sist.web.model.Comm;
import com.sist.web.model.Comm2;




public interface BoardDao 
{

	//게시물 등록
	public int boardInsert(Board board);
	
	//게시물 첨부파일 등록
	public int boardFileInsert(BoardFile boardFile);
	
	//게시물 리스트
	public List<Board> boardList(Board board);
		
	// 총 게시물 수
	public long boardListCount(Board board);
	
	// 게시물 조회
	public Board boardSelect(long boardSeq);
		
	// 첨부파일 조회
	public BoardFile boardFileSelect(long boardSeq);
	
	// 게시물 조회 수 증가
	public int boardReadCntPlus(long boardSeq);
	
	// 게시물 수정
	public int boardUpdate(Board board);
	
	// 게시물 첨부파일 삭제
	public int boardFileDelete(long boardSeq);
	
	// 게시물 삭제
	public int boardDelete(Board board);
	
	// 댓글 등록
	public int commInsert(Comm comm);
	
	// 댓글 리스트
	public List<Comm> commList(Comm comm);
	
	// 해당 게시판 총 댓글 수
	public long commListCount(Board board);
	
	// 좋아요 중복체크 인서트
	public int likeCheck(Board board);
	
	// 좋아요 중복체크 유저
	public long likeCheckUser(Board board);
	
	// 좋아요 중복체크 삭제
	public int likeCheckDel(Board board);
	
	// 게시물 조회
	public Comm commSelect(long commSeq);
	
	// 댓글 수정
	public int commUpdate(Comm comm);
	
	// 댓글 수정
	public int commDel(Comm comm);
	
	
}
