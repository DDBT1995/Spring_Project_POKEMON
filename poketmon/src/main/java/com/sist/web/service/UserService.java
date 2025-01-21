package com.sist.web.service;

import java.security.SecureRandom;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.UserDao;
import com.sist.web.model.User;


@Service("UserService")
public class UserService
{
	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Autowired
	private UserDao  userDao;
	
	// 사용자조회
	
	public User userSelect(String userEmail)
	{
		User user = null;
		
		try
		{
			user = userDao.userSelect(userEmail);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userSelect Exception", e);
		}
		return user;
	}
	
	// 사용자 등록
	public int userInsert(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.userInsert(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userInsert Exception", e);
		}
		
		return count;
	}
		
	// 사용자 이메일 찾기
	public User userMailFind(String userName,String userTel)
	{
		User user = null;
		
		try
		{
			user = userDao.userMailFind(userName, userTel);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userMailFind Exception", e);
		}
		return user;
	}
		
	// 사용자 비밀번호 찾기
		
	public User userPwFind(String userEmail)
	{
		User user = null;
		
		try
		{
			user = userDao.userSelect(userEmail);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userPwFind Exception", e);
		}
		return user;
	}
	
	// 사용자 비밀번호 수정
	
	public int userPwUpdate(User user)
	{

		int count = 0;
		
		try
		{
			count = userDao.userPwUpdate(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userPwUpdate Exception", e);
		}
		return count;
	}
	
	// 난수 12자리 설정 (임시 비밀번호)
    public String generateRandomString(int length)
    {
        StringBuilder sb = new StringBuilder(length);
        
        final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	    final SecureRandom RANDOM = new SecureRandom();

        for (int i = 0; i < length; i++) 
        {
            int randomIndex = RANDOM.nextInt(CHARACTERS.length());
            sb.append(CHARACTERS.charAt(randomIndex));
        }

        return sb.toString();
    }
	
	
	
	// 사용자 정보수정
	public int userUpdate(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.userUpdate(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userUpdate Exception", e);
		}
		
		return count;
	}
	// 사용자 회원탈퇴
	public int userWithdraw(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.userWithdraw(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userWithdraw Exception", e);
		}
		
		return count;
	}
		
}
