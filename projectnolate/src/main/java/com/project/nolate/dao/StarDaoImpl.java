package com.project.nolate.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;

import java.util.Set;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.TextNode;
import org.jsoup.select.Elements;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Repository;

import com.project.nolate.domain.Star;


@Repository
public class StarDaoImpl implements StarDao {

	private static final String NAME_SPACE ="com.project.nolate.mapper.StarMapper"; 
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<Star> starList() {
		
		return sqlSession.selectList(NAME_SPACE+".starLists");
	}

	@Override
	public Star getStarLuck(String title) {
		
		return sqlSession.selectOne(NAME_SPACE+".getstar",title);
	}

	@Override
	@Scheduled(cron="* * * * * *",zone="Asia/Seoul")
	public void updateStar() {
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyyMMdd");
		Date time = new Date();
		String daily = format1.format(time);
		//파싱
		String url = "https://www.ytn.co.kr/_ln/0121_"+daily+"0000000002";
		try {
		Document doc =Jsoup.connect(url).get();
		
		Elements ele =doc.select("div.article_paragraph span");
		List<TextNode>starlist =ele.textNodes();
		ArrayList<String> luck = new ArrayList<String>();
		
		  for(int i=0;i<starlist.size();i++) {
			String starluck =starlist.get(i).toString();
			luck.add(starluck);
			
		}
		  Set<String> luckey = new LinkedHashSet<String>();
		  for(int i=0;i<luck.size();i++) {
			  luckey.remove(" ");
			  luckey.add(luck.get(i));
		  }
		  luckey.remove(" 제공=드림웍");
		  Iterator<String>it=luckey.iterator();
		  		Star Star=null;
		  while(it.hasNext()) {
			  Star=new Star();
			  Star.setTitle(it.next().trim());
			  Star.setContent(it.next().trim());
			  Star.setItem(it.next().trim());
			  
			  sqlSession.update(NAME_SPACE+".updatestar",Star);
		  }
		  
		}catch (Exception e) {
		e.printStackTrace();
		}
		
	}
	

}