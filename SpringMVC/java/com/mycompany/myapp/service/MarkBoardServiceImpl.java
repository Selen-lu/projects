package com.mycompany.myapp.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.myapp.dao.MarkBoardDao;
import com.mycompany.myapp.domain.MarkBoard;

@Service
public class MarkBoardServiceImpl implements MarkBoardService {

	//dao 세터 주입
	@Autowired
	private MarkBoardDao markBoardDao;
	public void setMarkBoard(MarkBoardDao markBoardDao) {
		this.markBoardDao = markBoardDao;
	}

	
	//페이징처리에 필요한 상수 선언
	private static final int PAGE_SIZE =5; //한 페이지에 보여질 글 개수
	private static final int PAGE_GROUP=5;  //[이전] [1] [2] [3] [다음]<-이렇게 링크로 묶은 갯수 (이전,다음 빼고)

	//MarkBoardDao 이용해서 게시판 테이블에
	//현재 페이지에 해당하는 게시글 리스트 읽어와 반환
	@Override
	public Map<String, Object> markList(int pageNum,String type,String keyword) {
		
		// - 현재 머무르고 있는 페이지 = pageNum
		int nowPage =pageNum;
		// - 보고싶은 페이지에 해당하는 첫번째 글(행 단위) 계산
		// -  1페이지 -> 1~5번째 글  ,  2페이지 ->5~10번째 글
		// - 그 중 첫번째 글이 요청한 페이지 첫번째행에 오게(1페이지 : 1번째글,2페이지 : 6번째 글)
		// - 첫번째 글(=첫번째 행) 계산은 아래처럼 한다
		int listCount =0;
		
		// - 요청 파라미터가 null이면? = 일반 게시글 리스트요청 = false 값 줌
		boolean searchOption =(type.equals("null") || keyword.equals("null")) ? false :  true;
		
		int startRow = (nowPage - 1 ) * PAGE_SIZE;//첫행
		listCount = markBoardDao.getMarkBoardCount(type,keyword);//dao이용, 전체 게시글 수 가져옴
		
		//리스트 몇개인지 , 검색 내용은 뭔지 콘솔로 찍음
		System.out.println("listCount : " + listCount + ", type : " + type + ", keyword : " + keyword);
	
		
		// - LIMIT -> mysql에서 사용(맵퍼에서 사용한것처럼)
		// - 검색된 데이터에서 특정행 번호부터 지정한 개수만큼 행을 읽어옴
		// - 오라클은 RowNum사용
		// - Mapper에서 지정한 듯이 
		// - LIMIT의 첫번째 매개변수에 가져올 데이터의 시작행을 지정,
		// - 두번째 매개변수에 가져올 데이터의 개수를 지정
		List<MarkBoard> markBoardList = markBoardDao.markList(startRow, PAGE_SIZE,type,keyword);
		
		
		// - 페이지 그룹 이동 처리 계산
		// -  전체페이지 계산 
		// - 계산법 :  전체페이지 = 전체게시글 카운트 수  / 한 페이지에 표시되는 글 수(PAGE_SIZE)
		// - 계산 후 나머지가 존재하면 전체 페이지수는 +1씩 늘어나서 표기됨
		// -  11 / 5 했을 때 나머지 생김 ->  [1] [2] [3] 페이지 생기고 3페이지에 남은 글 수 가 담긴다는 뜻
		// - 	위 계산이 만약 10 / 5 라서 나머지가 생기지 않는다면(=0) True, 나머지가 생기면(=1) false 
		int pageCount = listCount / PAGE_SIZE + (listCount % PAGE_SIZE == 0 ? 0 : 1);
		
		
		// - 페이지 그룹 처리를 위해 페이지 그룹별 시작 페이지와 마지막 페이지 계산
		// - 다음 페이지로 넘어갈 때마다 보여지는 그룹링크 계산하는것
		// - 그리고 현재 내가 3페이지에 있다면 1~5페이지를 보여줘야함
		// - [1][2][3][4][5] [다음] ->(다음클릭후)-> [6][7][8][9][10][다음]
		// - 정수형 연산의 특징을 이용하여 startPage 구함
		// - 현재 내가 머무는 페이지  = 3페이지
		// - (3/5) * 5 +1 - (현재머무는 페이지 와 페이지 그룹이 나머지 없으면 ? 페이지 그룹을 빼주고 아니면 0을 빼줌)
		int startPage = (nowPage /  PAGE_GROUP) * PAGE_GROUP +1 
				-(nowPage % PAGE_GROUP == 0 ? PAGE_GROUP : 0 );
				// - 3/5 -> 정수형계산이면 0임
				// - 3페이지 기준으로 계산하면 보여지는 그룹링크의 시작은 1페이지
				// -  >[1]< ... [5][다음]
		int endPage = startPage + PAGE_GROUP-1;
				// -> 1 + 5 -1  = 5
				// -  [1] ... >[5]<[다음]
				
		// - 존재하는 글 개수만큼 페이지 나오게하기
		// - 위만 처리하면 페이지가 7페이지여도 
		// - 항상 5단위로 링크그룹이 나온다(10페이지가 그룹링크로 표시됨)
		// - 마지막 페이지가 전체페이지 개수보다 크다면
		// -  endPage가 되도록 지정
		// - 처리할 페이지수 = pageCount = 7 
		// - 끝 페이지 그룹링크 = endPage = 10이면
		// - endPage =pageCount 가 되게 해서
		// - 글이 없어 비어있는 그룹링크가 없게 함
		if(endPage > pageCount) {
			endPage = pageCount;	
		}
		
		// - View 페이지에서 필요한 데이터를 Map에 저장해서 컨트롤러로 전달
		// - 	Dao 이용해서 게시판 테이블에 현재 페이지에 해당하는 게시글 리스트 읽어와 반환하는 메서드 (markBoardList)
		// - 	현재페이지(nowPage) 
		// - 	전체 페이지 개수(pageCount),
		// - 	페이지 그룹의 시작페이지(startPage) 
		// - 	페이지 그룹의 끝 페이지(endPage)
		// - 	게시글 리스트의 수(listCount)
		// - 	접속해 있는 페이지 밑에 보여줄 그룹링크 개수(PAGE_GROUP) 
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("markBoardList",markBoardList); // - (보드dao에서)페이징처리까지 끝낸 DB에 저장된 전체글 보여주는 메서드
		modelMap.put("nowPage",nowPage);// - 현재 페이지
		modelMap.put("pageCount",pageCount); // - 전체 페이지 개수
		modelMap.put("startPage",startPage); // - 시작페이지
		modelMap.put("endPage",endPage);// - 끝페이지
		modelMap.put("listCount",listCount);// - 게시글 리스트의 수
		modelMap.put("pageGroup",PAGE_GROUP);// - 접속해 있는 페이지 밑에 보여줄 그룹링크 개수
		modelMap.put("searchOption", searchOption); // 일반 게시글 리스트 요청인가 검색 게시글 리스트 요청인지 판단 
		
		// - 검색 요청(searchOption = true)이면?
		// - type과 keyword도 모델에 저장해서 전달함
		if(searchOption) {
			
			try {
				// - IE에서 사용시 검색 인코딩 깨질 수도 있음. 이 때 들어오는 트라이문
				// - 딱히 필요없으면 스루됨
				// - 해결법 : java.net패키지의 urlEncoder사용하면된다.
				modelMap.put("keyword", URLEncoder.encode(keyword, "utf-8"));
			
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			modelMap.put("keyword", keyword);
			modelMap.put("type",type);
		}
		
		return modelMap;
	}

	
	//글 DB저장 메서드 
	@Override
	public void insertMark(MarkBoard markBoard) {
		markBoardDao.insertMark(markBoard);

	}

	//boarddao를 이용해 게시글 수정
	@Override
	//public void updateMark(MarkBoard markBoard) {
	public void updateMark(String no, String nickname) {	
		markBoardDao.updateMark(no, nickname);
	}
	


	//boarddao를 이용해 게시글 삭제
	@Override
	public void deleteMark(String no) {
		markBoardDao.deleteMark(no);
	}

}
