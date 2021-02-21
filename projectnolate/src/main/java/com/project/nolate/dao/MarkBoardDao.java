package com.project.nolate.dao;

import java.util.List;

import com.project.nolate.domain.MarkBoard;

public interface MarkBoardDao {
	
	// - 한 페이지에 보여질 북마크 리스트를 가져오는 메서드
	// - 현재 페이지에 해당하는 게시글 리스트를 db에 읽어와 반환
	// - 페이징 처리 , 검색 추가
	List<MarkBoard> markList(int startRow, int num,String type,String keyword);
	// - 페이징 처리에 사용함, 검색 추가 
	// - DB에 저장된 전체 게시글 수 계산(카운트) 반환 메서드
	int getMarkBoardCount(String type,String keyword);
	
	// - 북마크 글쓰기(북마크한 장소 별칭) 요청시 호출되는 메서드
	// - 글쓰기 요청시 글 내용을 board 객체로 받아 db에 추가하는 메서드
	void insertMark(MarkBoard markBoard);
	// - 수정요청시 수정된 내용을 board객체로 받아 db에 수정하는 메서드
	//void updateMark(MarkBoard markBoard);
	void updateMark(String no, String nickname);
	// - 삭제요청시 no에 해당하는 북마크를 db에서 삭제하는 메서드
	void deleteMark(String no);
	
	//--->인설트,업데이트 , 삭제 는
	// 댓글쓰기쪽처럼 비동기식으로 갱신으로 압력,수정 가능하면 그렇게 변경

	

	
	
}
