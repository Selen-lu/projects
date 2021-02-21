package com.mycompany.myapp.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mycompany.myapp.domain.MarkBoard;

@Repository
public class MarkBoardImpl implements MarkBoardDao {

	
	private final String NAME_SPACE ="com.mycompany.myapp.mapper.MarkBoardMapper";
	
	// What is SqlSessionTemplate?  
	// -> mybatis의 sqlSession(커밋 롤백 수동처리 해야됬지만 템플릿은 자동) 기능 : 트랜젝션 처리가 다르다라고 함 
	// ->DB지원기능 연동
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//세터주입 : 
	// 원래는이 클래스의 인스턴스 생성후 
	//  세터주입을 해야되서 기본생성자가 필요하지만
	//   이 클래스에서 다른 기본생성자를 만들지 않아 (이 클래스의 기본생성자를 작성하지 않았음)
	//    컴파일러에 의해 기본생성자가 자동생성되므로 
	//바로 세터에 오토와이어드달음
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	// - 페이징 처리, 검색 
	// - 한 페이지에 보여질 북마크리스트 요청시 호출
	// - 해당 mapper 구문 호출
	@Override
	public List<MarkBoard> markList(int startRow, int num,String type,String keyword) {
		// - sql파라미터가 여러개일 경우 Map사용
		// - 페이징 처리만 할때는 String,Integer였으나 
		// - 검색기능까지 추가되  String,Object로 변경
		Map<String,Object> markParams= new HashMap<String, Object>();
		markParams.put("startRow", startRow);
		markParams.put("num",num);
		markParams.put("type",type);
		markParams.put("keyword",keyword);
		return sqlSession.selectList(NAME_SPACE+".markList",markParams);
	
	}

	// - 페이징 처리시 DB에 있는 전체 게시글 수 카운트
	// - 해당 mapper 구문 호출
	// - 페이징 처리에 사용,검색까지
	@Override
	public int getMarkBoardCount(String type,String keyword) {
		
		// - SQL 파라미터가 여러개라면 Map사용
		// - 검색시 키워드와 타입에 해당되는 게시글 갯수 반환
		Map<String,String> mCountParams = new HashMap<String, String>();
		mCountParams.put("type", type);
		mCountParams.put("keyword",keyword);
		return sqlSession.selectOne(NAME_SPACE+".getMarkBoardCount",mCountParams);
	
	}
	
	
	//장소 DB에 저장하는 메서드
	//해당 mapper 구문 호출
	@Override
	public void insertMark(MarkBoard markBoard) {
		sqlSession.insert(NAME_SPACE+".insertMark", markBoard);
	}

	//수정 요청시 호출 메서드, 수정내용을 board객체로 받아 db로 보냄
	//해당 mapper 구문 호출
	@Override
	//public void updateMark(MarkBoard markBoard) {
	public void updateMark(String no, String nickname) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("no", no);
		params.put("nickname", nickname);
		//sqlSession.update(NAME_SPACE+".updateMark", markBoard);
		sqlSession.update(NAME_SPACE+".updateMark", params);
	}

	//삭제 메서드
	//해당 mapper 구문 호출
	@Override
	public void deleteMark(String no) {
		sqlSession.delete(NAME_SPACE+".deleteMark",no);
	}



}
