package com.sist.web.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.StringUtil;
import com.sist.web.model.Response;
import com.sist.web.model.User;
import com.sist.web.service.UserService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;
import com.sist.web.util.JsonUtil;

@Controller("userController")
public class UserController
{
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	JavaMailSenderImpl mailSender;
	
	
	// 로그인 화면
	@RequestMapping(value="/user/loginForm", method=RequestMethod.GET)
	public String loginForm(HttpServletRequest request, HttpServletResponse response)
	{
			
		return "/user/loginForm";
	}
	// 로그인 Proc
	//로그인 (/user/login)
		@RequestMapping(value="/user/loginProc", method=RequestMethod.POST)
		@ResponseBody 
		public Response<Object> loginProc(HttpServletRequest request, HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			
			String userEmail = HttpUtil.get(request, "userEmail");
			String userPwd = HttpUtil.get(request, "userPwd");
			
			if(!StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userPwd))
			{
				User user = userService.userSelect(userEmail);
				
				if(user != null)
				{
					if(StringUtil.equals(user.getUserPwd(), userPwd))
					{
						if(StringUtil.equals(user.getUserStatus(), "Y"))
						{
							CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME,CookieUtil.stringToHex(userEmail));
							ajaxResponse.setResponse(0, "success");
						}
						else
						{
							ajaxResponse.setResponse(-99, "status error");
						}
					}
					else
					{	// 비밀번호 불일치
						ajaxResponse.setResponse(-1, "password mismatch");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "not found");
				}
			}
			else
			{
				ajaxResponse.setResponse(400, "Bad Request");
			}
			
			if(logger.isDebugEnabled())
			{
				logger.debug("[UserController] /user/login response \n" + 
								JsonUtil.toJsonPretty(ajaxResponse)); 
			}
			
			return ajaxResponse;
		}
		
	// 로그아웃
	@RequestMapping(value="/user/loginOut", method=RequestMethod.GET)
	public String loginOut(HttpServletRequest request, HttpServletResponse response)
	{	
		logger.debug("로그아웃요청 확인 강사님꺼@@@@@@@@@@@@@@@@@@@@");
		if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null)
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		}
		return "redirect:/";  //재접속하라는 명령 (url을 다시 가리킴)
	}
	
	// 회원가입 화면
	@RequestMapping(value="/user/regForm", method=RequestMethod.GET)
	public String regForm(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			return "redirect:/"; // 재접속하라는 명령
		}
		else
		{
			return "/user/regForm";
		}
		
	}
	
		//아이디 중복 체크
		@RequestMapping(value="/user/idCheck", method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> idCheck(HttpServletRequest request, HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			
			String userEmail = HttpUtil.get(request, "userEmail");
			
			if(!StringUtil.isEmpty(userEmail))
			{
				if(userService.userSelect(userEmail) == null)
				{
					ajaxResponse.setResponse(0, "success");
				}
				else
				{
					ajaxResponse.setResponse(100, "deplicate id");
				}
			}
			else
			{
				ajaxResponse.setResponse(400, "bad request");
			}
			
			if(logger.isDebugEnabled())
			{
				logger.debug("[UserController] /user/idCheck response \n" + 
								JsonUtil.toJsonPretty(ajaxResponse)); 
			}
			
			return ajaxResponse;
		}
		

		// 회원 등록
		@RequestMapping(value="/user/regProc", method=RequestMethod.POST)
		@ResponseBody
		public  Response<Object> regProc(HttpServletRequest request, HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			
			String userEmail = HttpUtil.get(request, "userEmail");
			String userPwd = HttpUtil.get(request, "userPwd");
			String userName = HttpUtil.get(request, "userName");
			String userNickname = HttpUtil.get(request, "userNickname");
			String userTel = HttpUtil.get(request, "userTel");
			String userBirth = HttpUtil.get(request, "userBirth");
			String userAddr = HttpUtil.get(request, "userAddr");
			
			String userPostcode = HttpUtil.get(request, "userPostcode");
			String userDetailaddr = HttpUtil.get(request, "userDetailaddr");
			
			
			if(!StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userPwd) &&
					!StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail))
			{
				if(userService.userSelect(userEmail) == null)
				{
					// 중복아아디가 없을 경우 정상 등록
					User user = new User();
					
					user.setUserEmail(userEmail);
					user.setUserPwd(userPwd);
					user.setUserName(userName);
					user.setUserNickname(userNickname);
					user.setUserTel(userTel);
					user.setUserBirth(userBirth);
					user.setUserAddr(userAddr);
					
					user.setUserPostcode(userPostcode);
					user.setUserDetailaddr(userDetailaddr);
					
					user.setUserStatus("Y");
		
					
					if(userService.userInsert(user) > 0)
					{
						ajaxResponse.setResponse(0, "success");
					}
					else
					{
						ajaxResponse.setResponse(500, "internal server error");
					}
				}
				else
				{
					ajaxResponse.setResponse(100, "doplicate Email");
				}
			}
			else
			{
				ajaxResponse.setResponse(400,"bad request");
			}
			
			if(logger.isDebugEnabled())
			{
				logger.debug("[UserController] /user/regProc response \n" + 
								JsonUtil.toJsonPretty(ajaxResponse)); 
			}
			
			
			return ajaxResponse;
		}
		
		// 아아디 찾기
		@RequestMapping(value="/user/mailFindForm", method=RequestMethod.GET)
		public String mailFindForm(HttpServletRequest request, HttpServletResponse response)
		{
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			
			if(!StringUtil.isEmpty(cookieUserId))
			{
				CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
				return "redirect:/"; // 재접속하라는 명령
			}
			else
			{
				return "/user/mailFindForm";
			}
			
		}
		
		// 이메일 찾기 에이젝스 통신
		//이메일 찾기 ajax통신
		@RequestMapping(value="/user/mailFindProc", method=RequestMethod.POST)
		@ResponseBody 
		public Response<Object> mailFindProc(HttpServletRequest request, HttpServletResponse response)
		{	
			logger.error("0000000000000000000000000000000000000");
			Response<Object> ajaxResponse = new Response<Object>();
		
			
			String userName = HttpUtil.get(request, "userName");
			String userTel = HttpUtil.get(request, "userTel");
			logger.error("11111111111111111111111111111111111111");
			
			if(!StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userTel))
			{	
				logger.error("222222222222222222222222222222222222222");
				User user = userService.userMailFind(userName, userTel);
				
				logger.error("user" + user);
				logger.error("3333333333333333333333333333333333333");
				
				if(user != null)
				{
					logger.error("4444444444444444444444444444444444444444");
					if(StringUtil.equals(user.getUserStatus(), "Y"))
					{
						
						ajaxResponse.setResponse(0, "success", user.getUserEmail());
					}
					else
					{
						ajaxResponse.setResponse(-99, "status error");
					}
				}
				else
				{
					ajaxResponse.setResponse(400, "user error");
				}
					
			}
			else
			{
				ajaxResponse.setResponse(404, "not found");
			}
			if(logger.isDebugEnabled())
			{
				logger.debug("[UserController] /user/mailFindProc response \n" + 
								JsonUtil.toJsonPretty(ajaxResponse)); 
			}
			
			return ajaxResponse;
		}
	
	
	// 비밀번호 찾기
	
	@RequestMapping(value="/user/pwFindForm", method=RequestMethod.GET)
	public String pwFindForm(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
			return "redirect:/"; // 재접속하라는 명령
		}
		else
		{
			return "/user/pwFindForm";
		}
	}
	
	// 비밀번호 찾기 에이젝스 통신
		//이메일 찾기 ajax통신
		@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
		@RequestMapping(value="/user/pwFindProc", method=RequestMethod.POST)
		@ResponseBody 
		public Response<Object> pwFindProc(HttpServletRequest request, HttpServletResponse response)
		{	
			
			Response<Object> ajaxResponse = new Response<Object>();
			
			String randumPw = "";
			
			
			String userEmail = HttpUtil.get(request, "userEmail");
			
			if(!StringUtil.isEmpty(userEmail))
			{	
				
				User user = userService.userSelect(userEmail);
				
				logger.error("user1111111111111111111    " + user);
				
				if(user != null)
				{
					
					if(StringUtil.equals(user.getUserStatus(), "Y"))
					{
						
						randumPw = userService.generateRandomString(12);
						
						if(!StringUtil.isEmpty(randumPw))
						{
							user.setUserEmail(userEmail);
							user.setUserPwd(randumPw);
							
							if(userService.userPwUpdate(user) > 0)
							{
								String setFrom = "kkh19950810@gmail.com"; //2단계 인증 x, 메일 설정에서 POP/IMAP 사용 설정에서 POP/SMTP 사용함으로 설정o
								String toMail = userEmail;
								String title = "회원가입 인증 이메일 입니다.";
								String content = "비밀번호는 " + randumPw + " 입니다." +
												 "<br>" +
												 "해당 비밀번호는 임시비밀번호 입니다." +
												 "<br>" + 
												 "마이 페이지에서 변경해주세요.";
								
								try {
									MimeMessage message = mailSender.createMimeMessage(); //Spring에서 제공하는 mail API
						            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
						            helper.setFrom(setFrom);
						            helper.setTo(toMail);
						            helper.setSubject(title);
						            helper.setText(content, true);
						            mailSender.send(message);
						            ajaxResponse.setResponse(0, "success");
								} catch (Exception e) {
									e.printStackTrace();
								}	
							}
							else
							{
								ajaxResponse.setResponse(2, "userPwUpdate error");
							}
						}
						else
						{
							ajaxResponse.setResponse(1, "randumPw error");
						}
						
						
					}
					else
					{
						ajaxResponse.setResponse(-99, "status error");
					}
				}
				else
				{
					ajaxResponse.setResponse(400, "user error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "not found");
			}
			if(logger.isDebugEnabled())
			{
				logger.debug("[UserController] /user/pwFindProc response \n" + 
								JsonUtil.toJsonPretty(ajaxResponse)); 
			}
			
			return ajaxResponse;
		}
	
		// 회원수정 (마이페이지)
		@RequestMapping(value="/user/myPageForm", method=RequestMethod.GET)
		public String myPageForm(ModelMap model,HttpServletRequest request, HttpServletResponse response)
		{
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			User user = null;
			
			user = userService.userSelect(cookieUserId);
			
			
			if(!StringUtil.isEmpty(cookieUserId))
			{	
				
				if(!StringUtil.isEmpty(user))
				{	
					model.addAttribute("user", user);
					return "/user/myPageForm";
				}
				else
				{	
					logger.error("user: " + user);
					return "redirect:/"; // 재접속하라는 명령
				}
				
			}
			else
			{	
				logger.error("cookieUserId: " + cookieUserId);
				return "redirect:/"; // 재접속하라는 명령
			}
			
		}
		// 회원 정보 수정 에이젝스 통신
		@RequestMapping(value="/user/myPageProc", method=RequestMethod.POST)
		@ResponseBody 
		public Response<Object> myPageProc(HttpServletRequest request, HttpServletResponse response)
		{
			
			Response<Object> ajaxResponse = new Response<Object>();

			
			String userEmail = HttpUtil.get(request, "userEmail");
			String userPwd = HttpUtil.get(request, "userPwd");
			String userNickname = HttpUtil.get(request, "userNickname");
			String userTel = HttpUtil.get(request, "userTel");
			String userPostcode = HttpUtil.get(request, "userPostcode");
			String userAddr = HttpUtil.get(request, "userAddr");
			String userDetailaddr = HttpUtil.get(request, "userDetailaddr");
			
			
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			
			if(!StringUtil.isEmpty(cookieUserId))
			{
				if(StringUtil.equals(userEmail, cookieUserId))
				{
					User user = userService.userSelect(cookieUserId);
					
					if(user != null)
					{
						if(!StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userPwd) && 
						   !StringUtil.isEmpty(userNickname) && !StringUtil.isEmpty(userTel) &&
						   !StringUtil.isEmpty(userPostcode) && !StringUtil.isEmpty(userAddr) &&
						   !StringUtil.isEmpty(userDetailaddr))
						{	
							user.setUserEmail(userEmail);
							user.setUserPwd(userPwd);
							user.setUserNickname(userNickname);
							user.setUserTel(userTel);
							user.setUserPostcode(userPostcode);
							user.setUserAddr(userAddr);
							user.setUserDetailaddr(userDetailaddr);
							
							
							if(userService.userUpdate(user) > 0)
							{
								ajaxResponse.setResponse(0, "success");
							}
							else
							{
								ajaxResponse.setResponse(500,"internal server error");
							}
						}
						else
						{
							// 파라미터 값이 올바르지 않을 경우
							ajaxResponse.setResponse(404, "bad request");
						}
					}
					else
					{
						// 사용자 정보가 없을 경우
						CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
						ajaxResponse.setResponse(404, "not found");
					}
				}
				else
				{
					//쿠키정보와 넘어온 userId가 다른경우
					CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
					ajaxResponse.setResponse(430, "id information is different");
					
				}
			}
			else
			{
				ajaxResponse.setResponse(410, "loing failed");
			}
			
			if(logger.isDebugEnabled())
			{
				logger.debug("[UserController] /user/myPageProc response \n" + 
								JsonUtil.toJsonPretty(ajaxResponse)); 
			}
			
			return ajaxResponse;
		}
		
	// 회원탈퇴
		
	@RequestMapping(value="/user/withdrawForm", method=RequestMethod.GET)
	public String withdrawForm(ModelMap model,HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = null;
		
		user = userService.userSelect(cookieUserId);
		
		
		if(!StringUtil.isEmpty(cookieUserId))
		{	
			
			if(!StringUtil.isEmpty(user))
			{	
				model.addAttribute("user", user);
				return "/user/withdrawForm";
			}
			else
			{	
				logger.error("user: " + user);
				return "redirect:/"; // 재접속하라는 명령
			}
			
		}
		else
		{	
			logger.error("cookieUserId: " + cookieUserId);
			return "redirect:/"; // 재접속하라는 명령
		}
		
	}
	
		// 회원탈퇴 Proc
		
		@RequestMapping(value="/user/withdrawProc", method=RequestMethod.POST)
		@ResponseBody 
		public Response<Object> withdrawProc(HttpServletRequest request, HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			
			String userEmail = HttpUtil.get(request, "userEmail");
			String userPwd = HttpUtil.get(request, "userPwd");
			
			if(!StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userPwd))
			{
				User user = userService.userSelect(userEmail);
				
				if(user != null)
				{
					if(StringUtil.equals(user.getUserPwd(), userPwd))
					{
						if(StringUtil.equals(user.getUserStatus(), "Y"))
						{
							user.setUserStatus("N");
							
							if(userService.userWithdraw(user) > 0)
							{
								ajaxResponse.setResponse(0, "success");
							}
							else
							{
								ajaxResponse.setResponse(1, "userWithdraw error");
							}
						}
						else
						{
							ajaxResponse.setResponse(-99, "status error");
						}
					}
					else
					{	// 비밀번호 불일치
						ajaxResponse.setResponse(-1, "password mismatch");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "not found");
				}
			}
			else
			{
				ajaxResponse.setResponse(400, "Bad Request");
			}
			
			if(logger.isDebugEnabled())
			{
				logger.debug("[UserController] /user/withdrawProc response \n" + 
								JsonUtil.toJsonPretty(ajaxResponse)); 
			}
			
			return ajaxResponse;
		}


		
		
}
