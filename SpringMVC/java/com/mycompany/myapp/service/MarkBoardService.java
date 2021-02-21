package com.mycompany.myapp.service;

import java.util.List;
import java.util.Map;

import com.mycompany.myapp.domain.MarkBoard;

public interface MarkBoardService {
	//dao이용
	//북마크 테이블에서 현재페이지에 해당하는 글 리스트 
	//읽어와 반환
	
	/*	한 페이지에 보여질 북마크 리스트를 가져오는 메서드
	 * 현재 페이지에 해당하는 게시글 리스트를 db에 읽어와 반환
	 * 검색기능 x : 
	 * List<MarkBoard> markList(int startRow,int num);*/	
	
	//한 페이지에 보여질 북마크 리스트를 가져오는 메서드((+페이징)
	//페이징 처리에 필요한 데이터 Map으로 반환(dao가 Map)
	//카운트는 dao에서만!!
	Map<String,Object> markList(int pageNum,String type,String keyword); 
	 
	//북마크 글쓰기(북마크한 장소 별칭) 요청시 호출되는 메서드
	//글쓰기 요청시 글 내용을 board 객체로 받아 db에 추가하는 메서드
	void insertMark(MarkBoard markBoard);
	//수정요청시 수정된 내용을 board객체로 받아 db에 수정하는 메서드
	//void updateMark(MarkBoard markBoard);
	void updateMark(String no, String nickname);
	
	//삭제요청시 no에 해당하는 북마크를 db에서 삭제하는 메서드
	void deleteMark(String no);
	

}
