## DATABASE 생성 및 선택
CREATE DATABASE IF NOT EXISTS spring;
use spring;

#서브쿼리 그리고 이름검색
SELECT COUNT(no)
FROM (SELECT no,MARK_NAME as name,MARK_NICKNAME as nickname FROM Mark) AS A 
WHERE A.name like '%중%';

#수정문
UPDATE Mark
SET MARK_NICKNAME = "으즐~~~~"
WHERE no = 17;

#테이블 초기화(auto_increment 사용 때문에 테이블 삭제 할 필요 없음)
truncate `mark`; 

CREATE TABLE IF NOT EXISTS Mark(
	no int auto_increment PRIMARY KEY,
	MARK_NAME VARCHAR(50) NOT NULL,
	MARK_latitude VARCHAR(50) NOT NULL,
    MARK_longitude VARCHAR(50) NOT NULL, 
    MARK_latticeX VARCHAR(50) NOT NULL,
    MARK_latticeY VARCHAR(50) NOT NULL,
	MARK_NICKNAME VARCHAR(50)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
 

INSERT INTO mark(MARK_NAME,MARK_latitude,MARK_longitude,MARK_latticeX,MARK_latticeY,MARK_NICKNAME) VALUES("서울 중구 태평로1가 31","37.56681294278494","126.9786664108551","60","127","직장");
INSERT INTO mark(MARK_NAME,MARK_latitude,MARK_longitude,MARK_latticeX,MARK_latticeY,MARK_NICKNAME) VALUES("서울 중구 태평로1가 31","37.56681294278494","126.9786664108551","60","127","직장");
INSERT INTO mark(MARK_NAME,MARK_latitude,MARK_longitude,MARK_latticeX,MARK_latticeY,MARK_NICKNAME) VALUES("서울 중구 태평로1가 31","37.56681294278494","126.9786664108551","60","127","직장");
INSERT INTO mark(MARK_NAME,MARK_latitude,MARK_longitude,MARK_latticeX,MARK_latticeY,MARK_NICKNAME) VALUES("서울 중구 태평로1가 31","37.56681294278494","126.9786664108551","60","127","직장");
INSERT INTO mark(MARK_NAME,MARK_latitude,MARK_longitude,MARK_latticeX,MARK_latticeY,MARK_NICKNAME) VALUES("서울 중구 태평로1가 31","37.56681294278494","126.9786664108551","60","127","직장");
INSERT INTO mark(MARK_NAME,MARK_latitude,MARK_longitude,MARK_latticeX,MARK_latticeY,MARK_NICKNAME) VALUES("서울 중구 태평로1가 31","37.56681294278494","126.9786664108551","60","127","직장");
INSERT INTO mark(MARK_NAME,MARK_latitude,MARK_longitude,MARK_latticeX,MARK_latticeY,MARK_NICKNAME) VALUES("서울 중구 태평로1가 31","37.56681294278494","126.9786664108551","60","127","직장");
INSERT INTO mark(MARK_NAME,MARK_latitude,MARK_longitude,MARK_latticeX,MARK_latticeY,MARK_NICKNAME) VALUES("서울 중구 태평로1가 31","37.56681294278494","126.9786664108551","60","127","직장");
commit;
SELECT * FROM mark;

SELECT COUNT(no) 
FROM Mark;

# 테이블 삭제
DROP TABLE IF EXISTS Mark;

#컬럼명에 따라 삭제
DELETE FROM mark
WHERE NO=2


#auto_increment-> 시퀀스랑 같음, 초기화에서 문제가 많은듯
#사용법 : 테이블 생성시 미리 작성, insert문에는 따로 작성하지 않고(자동 입력됨), 테이블 적을 때 컬럼명을 같이 적어야 적용 가능

#컬럼 소개
#int no; //  북마크 넘버  , DB ->시퀀스처리함 
#String name; // 북마크한 장소 이름  ex) 서울특별시 강남구 역삼동
#String latitude; //위도
#String longitude; //경도
#String latticeX; //격자X
#String latticeY;//격자 Y
#String nickname; //사용자가 북마크한 장소의 별칭 , DB- NOTNULL 처리 안 했음

