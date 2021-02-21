
CREATE DATABASE IF NOT EXISTS maps;
use maps;
CREATE TABLE map (
   no INTEGER AUTO_INCREMENT PRIMARY KEY,
   map_s VARCHAR(40) not NULL,
   map_e VARCHAR(40) not NULL
   
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
drop Table map;

 
INSERT INTO map( map_s , map_e ) VALUES(  '경기도 오산시', '경기도 수원시');
INSERT INTO map( map_s , map_e ) VALUES(  '서울시 마포구 와우산로29가길 69', '서울특별시 서대문구 충정로3가 35-1 KT');

commit;

SELECT
    no , map_s 출발지 , map_e 도착지
FROM map;

SELECT
     map_s 출발지 
FROM map
    where no =2;

SELECT
     map_e 도착지 
FROM map
    where no =2;