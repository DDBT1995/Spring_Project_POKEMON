package com.sist.web.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sist.common.util.FileUtil;
import com.sist.web.dao.BoardDao;
import com.sist.web.model.Board;
import com.sist.web.model.BoardFile;
import com.sist.web.model.Comm;
import com.sist.web.model.Comm2;






@Service("boardService")
public class BoardService
{
private static Logger logger = LoggerFactory.getLogger(BoardService.class);
	
	@Autowired
	private BoardDao boardDao;
	
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	// 게시물 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardInsert(Board board) throws Exception
	{	
		// Propagation.REQUIRED : 트랜젝션이 있으면 그 트랜잭션에서 실행이 되고
		// 없으면 현재상태에서 새로운 트랜젝샨 실행(기본설정)
		int count =  0;
		
		
		count = boardDao.boardInsert(board);
		
		if(count > 0 && board.getBoardFile() != null)
		{
			BoardFile boardFile = board.getBoardFile();
			
			boardFile.setBoardSeq(board.getBoardSeq()); // 선행처리에 의한 값 적용
			boardFile.setFileSeq((short)1);
			
			boardDao.boardFileInsert(boardFile);
		}
		return count;
	}
	
	//게시물 리스트
	public List<Board> boardList(Board board)
	{
		List<Board> list = null;
		
		try
		{
			list = boardDao.boardList(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardList Exception", e);
		}
		
		return list;
	}
		
	// 총 게시물 수
	public long boardListCount(Board board)
	{
		long count = 0;
		
		try
		{
			count  = boardDao.boardListCount(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardListCount Exception", e);
		}
		
		return count;
	}
	
	// regDate를 ~분전 ~시간전 ~년전으로 반환 메소드
	// regDate를 기준으로 얼마전에 쓴 건지 반환
    public static String timeAgo(String dateString){
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");

    try {
       // 문자열을 Date 객체로 변환
       Date postDate = dateFormat.parse(dateString);
       Date now = new Date(); // 현재 시간

       // 두 날짜 간의 차이를 밀리초 단위로 계산
       long diffInMillis = now.getTime() - postDate.getTime();
       long diffInMinutes = diffInMillis / (1000 * 60);

       if (diffInMinutes < 1) {
      return "방금 전";
       } else if (diffInMinutes < 60) {
      return diffInMinutes + "분 전";
       } else if (diffInMinutes < 1440) {
      long hours = diffInMinutes / 60;
      return hours + "시간 전";
       } else if (diffInMinutes < 43200) { // 1440분 * 30일 = 43200분 (약 한 달)
      long days = diffInMinutes / 1440;
      return days + "일 전";
       } else if (diffInMinutes < 525600) { // 43200분 * 12개월 = 525600분 (약 1년)
      long months = diffInMinutes / 43200;
      return months + "달 전";
       } else {
      long years = diffInMinutes / 525600;
      return years + "년 전";
       }
   } catch (ParseException e) {
       e.printStackTrace();
       return "잘못된 날짜 형식입니다";
   }
    }
		
 // 게시물 보기(첨부파일 포함, 조회수 증가 포함)
 	public Board boardView(long boardSeq)
 	{	
 		Board board = null;
 		
 		try
 		{
 			board = boardDao.boardSelect(boardSeq);
 			
 			if(board != null)
 			{
 				// 조회수 증가
 				boardDao.boardReadCntPlus(boardSeq);
 				
 				
 				BoardFile boardFile = boardDao.boardFileSelect(boardSeq);
 				
 				if(boardFile != null)
 				{
 					board.setBoardFile(boardFile);
 				}
 			}
 		}
 		catch(Exception e)
 		{
 			logger.error("[boardService] boardView Exception", e);
 		}
 		
 		return board;
 	}
 	
 	// 게시물 조회
 	public Board boardSelect(long boardSeq)
 	{
 		Board board = null;
 		
 		try
 		{
 			board = boardDao.boardSelect(boardSeq);
 		}
 		catch(Exception e)
 		{
 			logger.error("[BoardService] boardSelect Exception", e);
 		}
 		
 		return board;
 	}
 	
 	//첨부파일 조회용
	public BoardFile boardFileSelect(long boardsSeq)
	{
		BoardFile boardFile = null;
		
		try
		{
			boardFile = boardDao.boardFileSelect(boardsSeq);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardFileSelect Exception", e);
		}
		
		return boardFile;
	}
	
// 게시물 수정폼 조회(첨부파일 포함)
	public Board boardViewUpdate(long boardSeq)
	{
		Board board = null;
		
		try
		{
			board = boardDao.boardSelect(boardSeq);
			
			if(board != null)
			{
				BoardFile boardFile = boardDao.boardFileSelect(boardSeq);
				
				if(boardFile != null)
				{
					board.setBoardFile(boardFile);
				}
			}
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardViewUpdate Exception", e);
		}
		return board;
}
	
	
	
	// 게시물 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardUpdate(Board board) throws Exception
	{
		int count = 0;
		
		
		count = boardDao.boardUpdate(board);
	
		if(count > 0 && board.getBoardFile() != null)
		{
			BoardFile delBoardFile = boardDao.boardFileSelect(board.getBoardSeq());
			
			// 기존 파일이 있으면 삭제
			if(delBoardFile != null)
			{
				FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + 
														delBoardFile.getFileName());
				boardDao.boardFileDelete(board.getBoardSeq());
			}
			
			BoardFile boardFile = board.getBoardFile();
			boardFile.setBoardSeq(board.getBoardSeq());
			
			boardDao.boardFileInsert(boardFile);
			
		}
		
		return count;
	}
	
	// 게시물 삭제 ( 업데이트 방식 )
	public int boardDelete(Board board)
	{
		int count = 0;
		
		try
		{
			count = boardDao.boardDelete(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] boardDelete Exception", e);
		}
		
		return count;
	}
	
	// 댓글 등록 
	public int commInsert(Comm comm)
	{
		int count = 0;
		
		try
		{
			count = boardDao.commInsert(comm);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] commInsert Exception", e);
		}
		
		return count;
	}
	
	// 댓글 리스트
	public List<Comm> commList(Comm comm)
	{
		List<Comm> cmlist = null;
		
		try
		{
			cmlist = boardDao.commList(comm);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] commList Exception", e);
		}
		
		return cmlist;
	}
	
	
	// 총 게시물 댓글 수
	public long commListCount(Board board)
	{
		long count = 0;
		
		try
		{
			count  = boardDao.commListCount(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] commListCount Exception", e);
		}
		
		return count;
	}
	
	// 좋아요 중복 체크 인서트
	public int likeCheck(Board board) 
	{	
		
		int count =  0;
		
		try
		{
			count = boardDao.likeCheck(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] likeCheck Exception", e);
		}
		
		
		return count;
	}
	
	// 좋아요 중복 체크 유저
	public long likeCheckUser(Board board) 
	{	
		
		long count =  0;
		
		try
		{
			count = boardDao.likeCheckUser(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] likeCheckUser Exception", e);
		}
		
		
		return count;
	}
	
	// 좋아요 중복 체크 삭제
	public int likeCheckDel(Board board) 
	{	
		
		int count =  0;
		
		try
		{
			count = boardDao.likeCheckDel(board);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] likeCheckDel Exception", e);
		}
		
		
		return count;
	}
	
	// 댓글 상세 조회
 	public Comm commSelect(long commSeq)
 	{
 		Comm comm = null;
 		
 		try
 		{
 			comm = boardDao.commSelect(commSeq);
 		}
 		catch(Exception e)
 		{
 			logger.error("[BoardService] commSelect Exception", e);
 		}
 		
 		return comm;
 	}
	
	// 댓글 수정
	public int commUpdate(Comm comm) 
	{	
		
		int count =  0;
		
		try
		{
			count = boardDao.commUpdate(comm);
		}
		catch(Exception e)
		{
			logger.error("[BoardService] commUpdate Exception", e);
		}
		
		
		return count;
	}
	
	// 댓글 삭제
		public int commDel(Comm comm) 
		{	
			
			int count =  0;
			
			try
			{
				count = boardDao.commDel(comm);
			}
			catch(Exception e)
			{
				logger.error("[BoardService] commDel Exception", e);
			}
			
			
			return count;
		}
}
