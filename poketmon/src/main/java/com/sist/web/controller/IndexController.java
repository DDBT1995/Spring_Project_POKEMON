/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.controller
 * 파일명     : IndexController.java
 * 작성일     : 2021. 1. 21.
 * 작성자     : daekk
 * </pre>
 */
package com.sist.web.controller;

import java.util.List;

import java.util.stream.Collectors;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.StringUtil;
import com.sist.web.model.Poketmon;
import com.sist.web.model.Response;
import com.sist.web.service.BoardService;
import com.sist.web.service.PoketmonService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

/**
 * <pre>
 * 패키지명   : com.icia.web.controller
 * 파일명     : IndexController.java
 * 작성일     : 2021. 1. 21.
 * 작성자     : daekk
 * 설명       : 인덱스 컨트롤러
 * </pre>
 */
@Controller("indexController")
public class IndexController
{
	private static Logger logger = LoggerFactory.getLogger(IndexController.class);

	/**
	 * <pre>
	 * 메소드명   : index
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       : 인덱스 페이지 
	 * </pre>
	 * @param request  HttpServletRequest
	 * @param response HttpServletResponse
	 * @return String
	 */
	
	@Autowired
	private static final int LIST_COUNT = 15;
	
	@Autowired
	private PoketmonService poketmonService;
	
	
	
	@RequestMapping(value = "/index", method=RequestMethod.GET)
	public String index(ModelMap model,HttpServletRequest request, HttpServletResponse response)
	{	
		 Poketmon poketmon = new Poketmon();
		 List<Map<String, Object>> pokeTypeList = null;
		 
		 
		 pokeTypeList = poketmonService.pokeTypeList(poketmon);
		 
		 model.addAttribute("pokeTypeList", pokeTypeList);
		 
		 
		
		return "/index";
	}
	
	   @RequestMapping(value="/mainList")
	   @ResponseBody
	   public Response<Object> mainList(HttpServletRequest req, HttpServletResponse res) {
	      Response<Object> ajaxRes = new Response<Object>();
	      List<Poketmon> list = null;
	      List<Map<String, Object>> pokeTypeList = null;
	      
	      Poketmon poketmon = new Poketmon();
	      
	      int startDogam = HttpUtil.get(req, "startDogam", (int)0);
	      int endDogam = HttpUtil.get(req, "endDogam", (int)0);
	      float startWeight = HttpUtil.get(req, "startWeight", (float)0);
	      float endWeight = HttpUtil.get(req, "endWeight", (float)0);
	      float startHeight = HttpUtil.get(req, "startHeight", (float)0);
	      float endHeight = HttpUtil.get(req, "endHeight", (float)0);
	      String[] httpTypeList = req.getParameterValues("typeList[]");
	      
	    int indexPage = HttpUtil.get(req, "indexPage", 1);
	  	int pokeSortValue = HttpUtil.get(req, "pokeSortValue", 1);
	  	int minIndexNum = HttpUtil.get(req, "minIndexNum", 1);
	  	int maxIndexNum = HttpUtil.get(req, "maxIndexNum", 9999);
	  	int minHeightNum = HttpUtil.get(req, "minHeightNum", 0);
	  	int maxHeightNum = HttpUtil.get(req, "maxHeightNum", 9999);
	  	int minWeightNum = HttpUtil.get(req, "minWeightNum", 0);
	  	int maxWeightNum = HttpUtil.get(req, "maxWeightNum", 9999);
	  	
	  	String pokeSearch = HttpUtil.get(req, "pokeSearch", "");

	      
//	      System.out.println(httpTypeList);
//	      
//	      for(int i=0; i < httpTypeList.length; i++) {
//	         System.out.println(httpTypeList[i]);
//	      }
	      
	      Map<String, Object> resMap = new HashMap<>();
	      
	      pokeTypeList = poketmonService.pokeTypeList(poketmon);
	      
	      for(int i=0; i < pokeTypeList.size(); i++) {
	         System.out.println(pokeTypeList.get(i));
	      }
	      
	      
	      if (httpTypeList != null && httpTypeList.length > 0) {
	           // String[] -> List<Integer>로 변환
	           List<Integer> typeList = Arrays.stream(httpTypeList)
					                   .map(Integer::parseInt)
					                   .collect(Collectors.toList());
	           
	           poketmon.setTypeList(typeList);
	       }
	      
	       poketmon.setStartDogam(startDogam);
	       poketmon.setEndDogam(endDogam);
	       poketmon.setStartWeight(startWeight);
	       poketmon.setEndWeight(endWeight);
	       poketmon.setStartHeight(startHeight);
	       poketmon.setEndHeight(endHeight);
	       
	       poketmon.setMinIndexNum(minIndexNum);
	       poketmon.setMaxIndexNum(maxIndexNum);
	       poketmon.setMinWeightNum(minWeightNum);
	       poketmon.setMaxWeightNum(maxWeightNum);
	       poketmon.setMinHeightNum(minHeightNum);
	       poketmon.setMaxHeightNum(maxHeightNum);
	       poketmon.setPokeSortValue(pokeSortValue);
	       poketmon.setPokeSearch(pokeSearch);
	       	       	   
	      int page = HttpUtil.get(req, "page", (int)1);
	      
	      int startNum = page * LIST_COUNT - (LIST_COUNT - 1);
//	      System.out.println("start@@##@#@!#!@# : " + startNum);
	      int endNum = page * LIST_COUNT + 1;
//	      System.out.println("end@@@@@@@@@@@@@@@@ : " + endNum);
	      
	      poketmon.setStartNum(startNum);
	      poketmon.setEndNum(endNum);
	      
	      list = poketmonService.poketmonList(poketmon);
	      
	      resMap.put("list", list);
	      resMap.put("pokeTypeList", pokeTypeList);
	      
	      
	      System.out.println("list 사이즈~~~~~~ : " + list.size());
	      System.out.println("pokeTypeList 사이즈~~~~~~ : " + pokeTypeList.size());
	      if(list.size() >= 16) {
	         ajaxRes.setResponse(0, "list 출력 진행", resMap);
	         list.remove(list.size() -1);
	      } else {
	         ajaxRes.setResponse(1, "list 출력 끝", resMap);
	      }
	      
	      
	      
	      
	      return ajaxRes;
	   }
	   
	   
	@RequestMapping(value = "/indexView", method=RequestMethod.GET)
	public String indexView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{	
		
		// 포켓몬 ID 
		int pokeId = HttpUtil.get(request, "pokeId", 1);		
		// 포켓몬 진화
		int pokeEvo = HttpUtil.get(request, "pokeEvo", 1);
		
		logger.error("pokeId" + pokeId);
		logger.error("pokeEvo" + pokeEvo);
		
		
		Poketmon poketmon = null;
		Poketmon poketmonPrev = null;
		Poketmon poketmonNext = null;
		List<Poketmon> poketmonEvo = null;
		
		
		
		if(pokeId > 0)
		{
			poketmon = poketmonService.poketmonSelect(pokeId);						
												
			if(poketmon != null)
			{	
								
				poketmonEvo = poketmonService.poketmonEvo(poketmon);
				
				poketmon.setPokePrev(pokeId -1);
				poketmon.setPokeNext(pokeId +1);
				
				poketmonPrev = poketmonService.poketmonPrev(poketmon);
				poketmonNext = poketmonService.poketmonNext(poketmon);
			}
		}
		
		
		logger.error("poketmonPrev" + poketmonPrev);
		logger.error("poketmonNext" + poketmonNext);
		
		
		 model.addAttribute("poketmon",poketmon);
		 model.addAttribute("poketmonEvo",poketmonEvo);
		 model.addAttribute("poketmonPrev",poketmonPrev);
		 model.addAttribute("poketmonNext",poketmonNext);
		
		return "/indexView";
	}
	
}
