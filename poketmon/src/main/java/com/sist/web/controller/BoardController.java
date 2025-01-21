package com.sist.web.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sist.common.model.FileData;
import com.sist.common.util.FileUtil;
import com.sist.common.util.StringUtil;
import com.sist.web.model.Board;
import com.sist.web.model.BoardFile;
import com.sist.web.model.Comm;
import com.sist.web.model.Comm2;
import com.sist.web.model.Paging;
import com.sist.web.model.Response;
import com.sist.web.model.User;
import com.sist.web.service.BoardService;
import com.sist.web.service.UserService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("boardController")
public class BoardController 
{	
	private static Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private BoardService boardService;
	
	private static final int LIST_COUNT = 5; 	// 한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5;
	
	
	// 보드 리스트
	@RequestMapping(value="/board/boardList")
	public String boardList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{	
		// 조회항목(1:작성자, 2:제목, 3:내용)
		String searchType = HttpUtil.get(request, "searchType", "");
		// 조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		// 현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		
		// 총 게시물 수
		long totalCount = 0;
		// 게시물 리스트
		List<Board> list = null;
		
		// 조회 객체
		Board search = new Board();
		// 페이징 객체
		Paging paging = null;
		
		
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		
		totalCount = boardService.boardListCount(search);
		
		logger.debug("=============================");
		logger.debug("totalCount : " + totalCount);
		logger.debug("==============================");
		
		if(totalCount > 0)
		{
			paging = new Paging("/board/boardList", totalCount, LIST_COUNT, PAGE_COUNT,
					curPage,"curPage");
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = boardService.boardList(search);
			
			// 각 게시글의 작성 시간을 변환
			for (Board board : list) {
			    String timeRegAgo = boardService.timeAgo(board.getBoardRegDate()); // regDate를 기반으로 시간 변환
			    board.setBoardRegDate(timeRegAgo); // 변환된 시간을 게시글 객체에 설정
			    if(board.getBoardModiDate() != "")
			    {
				    String timeMdAog = boardService.timeAgo(board.getBoardModiDate());
				    board.setBoardModiDate(timeMdAog);
			    }
			}
		}
		
		logger.debug("=============================");
		logger.debug("list : " + list);
		logger.debug("==============================");
		
		model.addAttribute("list", list);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);	
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		
		return "/board/boardList";
	}
	
	// 게시물 쓰기 화면
	@RequestMapping(value="/board/writeForm")
	public String writeForm(ModelMap model,HttpServletRequest request, HttpServletResponse response)
	{	
		//쿠키값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		//조회항목
		String searchType = HttpUtil.get(request, "searchType");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue");
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			//사용자 정보조회
			 User user = userService.userSelect(cookieUserId);
			 
			 model.addAttribute("user",user);
			 model.addAttribute("searchType", searchType);
			 model.addAttribute("searchValue", searchValue);
			 model.addAttribute("curPage", curPage);
			
			return "/board/writeForm";
		}
		else
		{
			return "/user/loginForm";
		}
	}
	
	// 게시물 쓰기 에이젝스 통신
	// MultipartHttpServletRequest 로 데이터를 받겠다는뜻
	@RequestMapping(value="/board/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String boardTitle = HttpUtil.get(request, "boardTitle", "");
		String boardContent = HttpUtil.get(request, "boardContent", "");
		FileData fileData = HttpUtil.getFile(request, "boardFile", UPLOAD_SAVE_DIR);
		
		if(!StringUtil.isEmpty(boardTitle) && !StringUtil.isEmpty(boardContent))
		{
			Board board = new Board();
			
			board.setUserEmail(cookieUserId);
			board.setBoardTitle(boardTitle);
			board.setBoardContent(boardContent);
			board.setBoardStatus("Y");
			
			if(fileData != null && fileData.getFileSize() > 0)
			{
				BoardFile boardFile = new BoardFile();
				
				boardFile.setFileName(fileData.getFileName());
				boardFile.setFileOrgName(fileData.getFileOrgName());
				boardFile.setFileExt(fileData.getFileExt());
				boardFile.setFileSize(fileData.getFileSize());
				
				board.setBoardFile(boardFile);
			}
			
			try
			{
				if(boardService.boardInsert(board) > 0)
				{
					ajaxResponse.setResponse(0, "success");
				}
				else
				{
					ajaxResponse.setResponse(500, "internal server error");
				}
			}
			catch(Exception e)
			{
				logger.error("[HiBoardController] writeProc Exception", e);
				ajaxResponse.setResponse(500, "internal server error2");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
		
		
		return ajaxResponse;
	}
	
	// 게시물 조회
	@RequestMapping(value="/board/boardView")
	public String boardView(ModelMap model,HttpServletRequest request, HttpServletResponse response)
	{	
		//쿠키값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		// 게시물 번호
		long boardSeq = HttpUtil.get(request, "boardSeq", (long)0);
		
		//조회항목
		String searchType = HttpUtil.get(request, "searchType");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue");
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		// 댓글 페이지
		long cmCurPage = HttpUtil.get(request, "cmCurPage", (long)1);
		// 본인글 여부
		String boardMe = "N";
		// 본인댓글 여부
		// commMe 값을 담을 리스트 생성
	    List<String> commMeList = new ArrayList<>();
		
		Board board = null;
		
		
		
		// 댓글 리스트
		List<Comm> cmList = null;
		List<Comm> replies = null;
		// 해당 게시물 총 댓글 수
		long cmTotalCount = 0;
		// 조회 객체
		Comm cmSearch = new Comm();
		Comm rpSearch = new Comm();
		// 페이징 객체
		Paging paging = null;
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			if(boardSeq > 0)
			{	
				// board 조회
				board = boardService.boardView(boardSeq);
				
				String timeAgo = boardService.timeAgo(board.getBoardRegDate()); // regDate를 기반으로 시간 변환
				board.setBoardRegDate(timeAgo); // 변환된 시간을 게시글 객체에 설정
				
				if(board.getBoardModiDate() != "")
				{
				    String timeMdAog = boardService.timeAgo(board.getBoardModiDate());
				    board.setBoardModiDate(timeMdAog);
			    }
				
				
				if(board != null && StringUtil.equals(board.getUserEmail(), cookieUserId))
				{
					boardMe = "Y";
				}
				
				
				

				
				logger.error("cmTotalCount@@@@@@@@@@@@@@@@@@@@@" + cmTotalCount);
				
				cmTotalCount = boardService.commListCount(board);
				
				logger.error("cmTotalCount@@@@@@@@@@@@@@@@@@@@@" + cmTotalCount);
				
				if(cmTotalCount > 0)
				{
					paging = new Paging("/board/boardView", cmTotalCount, LIST_COUNT, PAGE_COUNT,
							cmCurPage,"cmCurPage");
					
					logger.error("boardSeq@@@@@@@@@@@@@@@@@@@@@" + boardSeq);
					
					cmSearch.setBoardSeq(boardSeq);
					cmSearch.setCommParent(boardSeq);
					cmSearch.setStartRow(paging.getStartRow());
					cmSearch.setEndRow(paging.getEndRow());
					
					rpSearch.setBoardSeq(boardSeq);
					
					logger.error("boardSeq@@@@@@@@@@@@@@@@@@@@@" + boardSeq);
					
					cmList = boardService.commList(cmSearch); 
					
					replies = boardService.commList(rpSearch); 
					
					for(Comm cm : cmList)
					{	
						if(StringUtil.equals(cm.getUserEmail(), cookieUserId))
						{
							cm.setCommMe("Y");
						}
						else
						{
							cm.setCommMe("N");
						}
					}											
				}
				
				logger.debug("=============================");
				logger.debug("cmTotalCount : " + cmTotalCount);
				logger.debug("==============================");
				
				
				 model.addAttribute("replies",replies);
				 model.addAttribute("cmList",cmList);
				 model.addAttribute("boardMe",boardMe);
				 model.addAttribute("boardSeq", boardSeq);
				 model.addAttribute("board", board);
				 model.addAttribute("searchType", searchType);
				 model.addAttribute("searchValue", searchValue);
				 model.addAttribute("paging", paging);
				 model.addAttribute("curPage", curPage);
				 model.addAttribute("cmCurPage", cmCurPage);
				 
				 return "/board/boardView";
			}
			else
			{
				return "/user/boardList";
			}
		}
		else
		{
			return "/user/loginForm";
		}
	}
	
	// 게시물 수정화면
	@RequestMapping(value="/board/updateForm")
	public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{	
		// 쿠키값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		// 게시물 번호
		long boardSeq = HttpUtil.get(request, "boardSeq", (long)0);
		// 조회항목
		String searchType = HttpUtil.get(request, "searchType", "");
		// 조회 값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		// 현재 페이지
		long curPage = HttpUtil.get(request, "curPage", 1);
		
		Board board = null;
		
		if(boardSeq > 0)
		{
			board = boardService.boardViewUpdate(boardSeq);
			
			if(board != null)
			{
				if(!StringUtil.equals(board.getUserEmail(), cookieUserId))
				{
					// 내글이 아닌 경우 수정 불가능 하도록 처리
					board = null;
				}
			}
		}
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("board", board);
		
		
		return "/board/updateForm";
	}

	
	// 게시물 수정 proc
	@RequestMapping(value="/board/updateProc",  method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> updatePorc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long boardSeq = HttpUtil.get(request, "boardSeq", (long)0);
		String boardTitle = HttpUtil.get(request, "boardTitle", "");
		String boardContent = HttpUtil.get(request, "boardContent", "");
		FileData fileData = HttpUtil.getFile(request, "boardFile", UPLOAD_SAVE_DIR);
		
		if(boardSeq > 0 && !StringUtil.isEmpty(boardTitle) &&
								!StringUtil.isEmpty(boardContent))
		{
			Board board = boardService.boardSelect(boardSeq);
			
			if(board != null)
			{
				if(StringUtil.equals(board.getUserEmail(), cookieUserId))
				{
					board.setBoardTitle(boardTitle);
					board.setBoardContent(boardContent);
					
					if(fileData != null && fileData.getFileSize() > 0)
					{
						BoardFile boardFile = new BoardFile();
						
						boardFile.setFileName(fileData.getFileName());
						boardFile.setFileOrgName(fileData.getFileOrgName());
						boardFile.setFileExt(fileData.getFileExt());
						boardFile.setFileSize(fileData.getFileSize());
						
						board.setBoardFile(boardFile);
					}
					
					try
					{
						if(boardService.boardUpdate(board) > 0)
						{
							ajaxResponse.setResponse(0, "success");
						}
						else
						{
							ajaxResponse.setResponse(500, "internal server error2");
						}
					}
					catch(Exception e)
					{
						logger.error("[BoardController] updatePorc Exception", e);
						ajaxResponse.setResponse(500, "internal server error");
					}
				}
				else
				{
					ajaxResponse.setResponse(403, "server error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
	
		
		return ajaxResponse;
	}
	
	//게시물 삭제
	@RequestMapping(value="/board/delete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> delete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long boardSeq = HttpUtil.get(request, "boardSeq", (long)0);
		
		if(boardSeq > 0)
		{
			Board board = boardService.boardSelect(boardSeq);
			
			if(board != null)
			{	
				if(StringUtil.equals(cookieUserId, board.getUserEmail()))
				{
					try
					{	
						board.setBoardStatus("N");
						
						logger.debug("getBoardStatus111111111111" + board.getBoardStatus());
						
						logger.debug("boardSeq" + board.getBoardSeq());
	
						if(boardService.boardDelete(board) > 0)
						{
							ajaxResponse.setResponse(0, "success");
						}
						else
						{
							ajaxResponse.setResponse(500, "server error2");
						}
					}
					catch(Exception e)
					{
						logger.error("[BoardController] delete Exception", e);
						ajaxResponse.setResponse(500, "server error1");
					}
				}
				else 
				{
					// 내 글이 아닐때
					ajaxResponse.setResponse(403, "server error");
				}
			}
				
			else
			{
				ajaxResponse.setResponse(404, "not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
		
		
		
		return ajaxResponse;
	}
	
	// 파일 다운
	@RequestMapping(value="/board/download")
	public ModelAndView download(HttpServletRequest request, HttpServletResponse response)
	{
		ModelAndView modelAndView = null;
		
		long boardSeq = HttpUtil.get(request, "boardSeq", (long)0);
		
		if(boardSeq > 0)
		{
			BoardFile boardFile = boardService.boardFileSelect(boardSeq);
			
			if(boardFile != null)
			{
				File file = new File(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() +
															boardFile.getFileName());
				
				logger.debug("=================================");
	            logger.debug("UPLOAD_SAVE_DIR : " + UPLOAD_SAVE_DIR);
	            logger.debug("FileUtil.getFileSeparator() : " + FileUtil.getFileSeparator());
	            logger.debug("hiBoardFile.getFileName() : " + boardFile.getFileName());
	            logger.debug("hiBoardFile.getFileOrgName() : " + boardFile.getFileOrgName());
	            logger.debug("=================================");
	            
	            if(FileUtil.isFile(file))
	            {
	               modelAndView = new ModelAndView();
	               
	               //응답할 view설정(servlet-context.xml에 정의한 FileDownloadView id)
	               modelAndView.setViewName("fileDownloadView");
	               modelAndView.addObject("file", file);
	               modelAndView.addObject("fileName", boardFile.getFileOrgName());
	               
	               return modelAndView;	          
	            }
			}
		}
		
		return modelAndView;
	}
	
	
	//댓글 등록
	@RequestMapping(value="/board/commProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> commProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long boardSeq = HttpUtil.get(request, "boardSeq", (long)0);
		String commContent = HttpUtil.get(request, "commContent", "");
		
		
		if(boardSeq > 0 && !StringUtil.isEmpty(commContent))	
		{	
			
			Board board =  boardService.boardSelect(boardSeq);
			
			if(board != null)
			{
				Comm comm = new Comm();
				
				User user = userService.userSelect(cookieUserId);
				
				comm.setUserEmail(user.getUserEmail());
				comm.setBoardSeq(boardSeq);
				comm.setCommContent(commContent);
				comm.setCommGroup(boardSeq);
				comm.setCommOrder(comm.getCommOrder());
				comm.setCommIndent(comm.getCommIndent());
				comm.setCommParent(boardSeq);
				
				try
				{
					if(boardService.commInsert(comm) > 0)
					{
						ajaxResponse.setResponse(0, "success", comm);
					}
					else
					{
						ajaxResponse.setResponse(500, "intetnal server error2");
					}
				}
				catch(Exception e)
				{
					logger.error("[BoardController] commInsert Exception", e);
					ajaxResponse.setResponse(500, "intetnal server error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400,"bad request");
		}
		return ajaxResponse;
	}
	
	
	// 대댓글 등록
	@RequestMapping(value="/board/twoCommProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> twoCommProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long boardSeq = HttpUtil.get(request, "boardSeq", (long)0);
		long commSeq = HttpUtil.get(request, "commSeq", (long)0);
		String twoCommContent = HttpUtil.get(request, "twoCommContent", "");
		
		
		if(boardSeq > 0 && !StringUtil.isEmpty(twoCommContent))	
		{	
			
			Board board =  boardService.boardSelect(boardSeq);
			
			if(board != null)
			{
				Comm comm = new Comm();
				
				User user = userService.userSelect(cookieUserId);
				
				comm.setUserEmail(user.getUserEmail());
				comm.setBoardSeq(boardSeq);
				comm.setCommContent(twoCommContent);
				comm.setCommGroup(boardSeq);
				comm.setCommOrder(comm.getCommOrder() + 1); 	// 사용안함..
				comm.setCommIndent(comm.getCommIndent() + 1);	// 사용안함..
				comm.setCommParent(commSeq);
				
				try
				{
					if(boardService.commInsert(comm) > 0)
					{
						ajaxResponse.setResponse(0, "success");
					}
					else
					{
						ajaxResponse.setResponse(500, "intetnal server error2");
					}
				}
				catch(Exception e)
				{
					logger.error("[BoardController] commInsert Exception", e);
					ajaxResponse.setResponse(500, "intetnal server error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400,"bad request");
		}
		return ajaxResponse;
	}
	
	
	// 좋아요 중복 체크
	@RequestMapping(value="board/likeCheckProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> likeCheckProc(HttpServletRequest request, HttpServletResponse response)
	{ 
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long boardSeq = HttpUtil.get(request, "boardSeq", (long)0);
		
		
		if(boardSeq > 0)
		{	
			
			User user = userService.userSelect(cookieUserId);
			
			
			
			
			if(user != null)
			{
				Board board = new Board();
				
				board.setUserEmail(user.getUserEmail());
				board.setBoardSeq(boardSeq);
				
				try
				{		
					if(boardService.likeCheckUser(board) <= 0)
					{	
						if(boardService.likeCheck(board) > 0)
						{	
							board = boardService.boardSelect(boardSeq);
							
							ajaxResponse.setResponse(0, "success", board.getLikeCount());												
						}
						else
						{
							ajaxResponse.setResponse(500, "success error");
						}					
					}
					else
					{	
						if(boardService.likeCheckDel(board) > 0)
						{	
							board = boardService.boardSelect(boardSeq);
							ajaxResponse.setResponse(1, "del success", board.getLikeCount());
						}
						else
						{
							ajaxResponse.setResponse(2, "del error");
						}
						
					}
				}
				catch(Exception e)
				{
					logger.error("[BoardController] likeCheckProc Exception", e);
					ajaxResponse.setResponse(500, "intetnal server error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400,"bad request");
		}
		
		
		
		return ajaxResponse;
	}
	
	// 좋아요 중복 체크 하트 색상 변경
		@RequestMapping(value="board/likeCheckHeart", method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> likeCheckHeart(HttpServletRequest request, HttpServletResponse response)
		{ 
			Response<Object> ajaxResponse = new Response<Object>();
			
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			long boardSeq = HttpUtil.get(request, "boardSeq", (long)0);
			
			
			if(boardSeq > 0)
			{					
				User user = userService.userSelect(cookieUserId);
				
				if(user != null)
				{
					Board board = new Board();
					
					board.setUserEmail(user.getUserEmail());
					board.setBoardSeq(boardSeq);
					
					try
					{		
						if(boardService.likeCheckUser(board) > 0)
						{	
							ajaxResponse.setResponse(0, "red");												
						}
						else
						{								
							ajaxResponse.setResponse(1, "gray");															
						}
					}
					catch(Exception e)
					{
						logger.error("[BoardController] likeCheckProc Exception", e);
						ajaxResponse.setResponse(500, "intetnal server error");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "not found");
				}
			}
			else
			{
				ajaxResponse.setResponse(400,"bad request");
			}									
			return ajaxResponse;
		}
	
		
		// 댓글 수정
		@RequestMapping(value="/board/commUpdateProc", method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> commUpdateProc(HttpServletRequest request, HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			long boardSeq = HttpUtil.get(request, "boardSeq", (long)0);
			long commSeq = HttpUtil.get(request, "commSeq", (long)0);
			String upCommContent = HttpUtil.get(request, "upCommContent", "");
			
			
			if(boardSeq > 0 && commSeq > 0 && !StringUtil.isEmpty(upCommContent))
			{
				Board board = boardService.boardSelect(boardSeq);
				
				if(board != null)
				{	
					Comm comm = boardService.commSelect(commSeq);
					
					if(StringUtil.equals(comm.getUserEmail(), cookieUserId))
					{	
						comm.setCommContent(upCommContent);
						
						if(boardService.commUpdate(comm) > 0) 
						{
							ajaxResponse.setResponse(0, "success");
						}
						else
						{
							ajaxResponse.setResponse(500, "success error");
						}
					}
					else 
					{
						// 내 글이 아닐때
						ajaxResponse.setResponse(403, "server error");
					}
				}
					
				else
				{
					ajaxResponse.setResponse(404, "not found");
				}
			}
			else
			{
				ajaxResponse.setResponse(400, "bad request");
			}
			
			
			
			return ajaxResponse;
		}
		
		// 댓글 삭제
				@RequestMapping(value="/board/commDelProc", method=RequestMethod.POST)
				@ResponseBody
				public Response<Object> commDelProc(HttpServletRequest request, HttpServletResponse response)
				{
					Response<Object> ajaxResponse = new Response<Object>();
					
					String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
					long boardSeq = HttpUtil.get(request, "boardSeq", (long)0);
					long commSeq = HttpUtil.get(request, "commSeq", (long)0);
														
					if(boardSeq > 0 && commSeq > 0)
					{
						Board board = boardService.boardSelect(boardSeq);
						
						if(board != null)
						{	
							Comm comm = boardService.commSelect(commSeq);
							
							if(StringUtil.equals(comm.getUserEmail(), cookieUserId))
							{	
								comm.setCommParent(commSeq);
								
								if(boardService.commDel(comm) > 0) 
								{
									ajaxResponse.setResponse(0, "success");
								}
								else
								{
									ajaxResponse.setResponse(500, "success error");
								}
							}
							else 
							{
								// 내 글이 아닐때
								ajaxResponse.setResponse(403, "server error");
							}
						}
							
						else
						{
							ajaxResponse.setResponse(404, "not found");
						}
					}
					else
					{
						ajaxResponse.setResponse(400, "bad request");
					}
					
					
					
					return ajaxResponse;
				}
			
	
}
