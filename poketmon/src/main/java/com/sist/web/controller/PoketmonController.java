package com.sist.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.web.model.Poketmon;
import com.sist.web.model.Response;
import com.sist.web.service.PoketmonService;
import com.sist.web.util.HttpUtil;

@Controller("poketmonController")
public class PoketmonController {

   @Autowired
   private PoketmonService poketmonService;
   
   private static final int LIST_COUNT = 15;
   
   @RequestMapping(value="/amainList")
   @ResponseBody
   public Response<Object> mainList(HttpServletRequest req, HttpServletResponse res) {
      Response<Object> ajaxRes = new Response<Object>();
      List<Poketmon> list = null;
      
      int page = HttpUtil.get(req, "page", (int)1);
      
      int startNum = page * LIST_COUNT - (LIST_COUNT - 1);
//      System.out.println("start@@##@#@!#!@# : " + startNum);
      int endNum = page * LIST_COUNT + 1;
//      System.out.println("end@@@@@@@@@@@@@@@@ : " + endNum);
      
      Poketmon poketmon = new Poketmon();
      
      poketmon.setStartNum(startNum);
      poketmon.setEndNum(endNum);
      
      list = poketmonService.poketmonList(poketmon);
      
      System.out.println("list 사이즈~~~~~~ : " + list.size());
      if(list.size() >= 16) {
         ajaxRes.setResponse(0, "list 출력 진행", list);
         list.remove(list.size() -1);
      } else {
         ajaxRes.setResponse(1, "list 출력 끝", list);
      }
      
      
      return ajaxRes;
   }
}


