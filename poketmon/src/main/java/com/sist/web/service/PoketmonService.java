package com.sist.web.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.PoketmonDao;
import com.sist.web.model.Board;
import com.sist.web.model.Poketmon;



@Service("poketmonService")
public class PoketmonService 
{
	private static Logger logger = LoggerFactory.getLogger(PoketmonService.class);
	
	@Autowired
	private PoketmonDao poketmonDao;
	
	//포켓몬 리스트
		public List<Poketmon> poketmonList(Poketmon poketmon)
		{
			List<Poketmon> pkList = null;
			
			try
			{
				pkList = poketmonDao.poketmonList(poketmon);
			}
			catch(Exception e)
			{
				logger.error("[poketmonService] poketmonList Exception", e);
			}
			
			return pkList;
		}
		
		
		// 포켓몬 조회
	 	public Poketmon poketmonSelect(int pokeId)
	 	{
	 		Poketmon pkSelect = null;
	 		
	 		try
	 		{
	 			pkSelect = poketmonDao.poketmonSelect(pokeId);
	 		}
	 		catch(Exception e)
	 		{
	 			logger.error("[PoketmonService] poketmonSelect Exception", e);
	 		}
	 		
	 		return pkSelect;
	 	}
	 	
		//포켓몬 진화 리스트
		public List<Poketmon> poketmonEvo(Poketmon poketmon)
		{
			List<Poketmon> pkEvo = null;
			
			try
			{
				pkEvo = poketmonDao.poketmonEvo(poketmon);
			}
			catch(Exception e)
			{
				logger.error("[poketmonService] poketmonEvo Exception", e);
			}
			
			return pkEvo;
		}
		
		//포켓몬 전 페이지
		public Poketmon poketmonPrev(Poketmon poketmon)
		{
			Poketmon pkPage = null;
			
			try
			{
				pkPage = poketmonDao.poketmonPrev(poketmon);
			}
			catch(Exception e)
			{
				logger.error("[poketmonService] poketmonPage Exception", e);
			}
			
			return pkPage;
		}
		
		//포켓몬 다음 페이지
		public Poketmon poketmonNext(Poketmon poketmon)
		{
			Poketmon pkPage = null;
			
			try
			{
				pkPage = poketmonDao.poketmonNext(poketmon);
			}
			catch(Exception e)
			{
				logger.error("[poketmonService] poketmonNext Exception", e);
			}
			
			return pkPage;
		}
		
		//포켓몬 타입 리스트
		public List<Map<String, Object>> pokeTypeList(Poketmon poketmon)
		{
			List<Map<String, Object>> pkTypeList = null;
			
			try
			{
				pkTypeList = poketmonDao.pokeTypeList(poketmon);
			}
			catch(Exception e)
			{
				logger.error("[poketmonService] pkTypeList Exception", e);
			}
			
			return pkTypeList;
		}
}
