package com.sist.web.dao;

import java.util.List;
import java.util.Map;

import com.sist.web.model.Poketmon;

public interface PoketmonDao 
{
	//포켓몬 리스트
	
	public List<Poketmon> poketmonList(Poketmon poketmon);
	
	public Poketmon poketmonSelect(int pokeId);
	
	public List<Poketmon> poketmonEvo(Poketmon poketmon);
	
	public Poketmon poketmonPrev(Poketmon poketmon);
	
	public Poketmon poketmonNext(Poketmon poketmon);
	
	public List<Map<String, Object>> pokeTypeList(Poketmon poketmon);
	
	
		
}
