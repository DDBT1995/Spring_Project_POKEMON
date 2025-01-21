package com.sist.web.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.sist.web.model.User;


@Repository("userDao")
public interface UserDao 
{	// @Repository : 해당 클래스에서 발생하는 DB 관련 예외를 spring DAOException 으로 전환.
	
	// 사용자 정보조회 // 
	public User userSelect (String userEmail);
	
	// 사용자 등록 
	public int userInsert(User user);
	
	// 사용자 이메일 찾기
	public User userMailFind(@Param("userName")String userName,@Param("userTel")String userTel);
	
	// 사용자 비밀번호 찾기
	public User userPwFind (String userEmail);
	
	// 사용자 비밀번호 수정
    public int userPwUpdate(User user);
	
	// 사용자 정보 수정
	public int userUpdate(User user);
	
	// 사용자 회원 탈퇴 (STATUS 변경)
	public int userWithdraw(User user);
}
