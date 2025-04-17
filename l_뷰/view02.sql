### 뷰의 실제 생성, 수정, 삭제

use market_db;

create view v_view_test01
as 
	select B.mem_id 'Member Id', M.mem_name as 'Member Name'
		, B.prod_name 'Product Name'
        , concat(M.phone1, M.phone2) as 'Office Phone'
	from 
		buy B
			inner join member M
            on B.mem_id = M.mem_id;
            
# cf) 조회 시 컬럼(열) 이름에 공백이 있을 경우
#			, 백틱(`)으로 지정
select distinct `Member Id`, `Member Name` from v_view_test01;

### 뷰의 수정(구조) ###
alter view v_view_test01
as
	select B.mem_id '회원 아이디', M.mem_name as '회원 이름'
		, B.prod_name '제품 이름', concat(M.phone1, M.phone2) as '연락처'
	from 
		buy B
			join member M
            on B.mem_id = M.mem_id;
            
select * from v_view_test01;

### 뷰 삭제 (구조) ###
drop view v_view_test01;

# select * from v_view_test01;

# cf) 테이블 생성 시 `존재하는 테이블일 경우 생성하지 않는` 옵션
# create table 'if not exists' 테이블명 ();

# >> 뷰 존재 여부에 관계없이 생성
# 	: create(생성하다) or replace(채체하다)
#   - 실습 및 반복작업 시 유용

create or replace view v_view_test02
as 
	select mem_id, mem_name from member;
    
select * from v_view_test02;

### 뷰 정보 확인 ###
# describe (desc): 열(칼럼)의 정보 확인
describe v_view_test02;

# show create view 뷰이름; : 생성된 뷰의 sql 코드를 확인
show create view v_view_test02;

### 뷰를 통한 데이터 수정/삭제 ###
# : 뷰를 통해서 원본 테이블의 데이터를 수정
# >> 단! 뷰에 포함되지 않은 컬럼에 의한 제약조건에 따라 제한될 수 있음

select * from v_member;

update v_member
set 
	addr = '부산'
where mem_id = 'BLK';

select * from v_member;

select * from member;  # 뷰의 데이터 조작이 실제 테이블에도 적용

-- insert into v_member (mem_id, mem_name, addr)
-- values
-- 	('IVE', '아이브', '경기');
# >> v_member가 참조하는 원본 테이블의 NOT NULL 컬럼이 뷰에 포함되어 있지 않으면 삽입 불가!

create view v_height167
as 
	select * from member
    where
		height >= 167;
	
select * from v_height167;


#SET SQL_SAFE_UPDATES = 1;

# 뷰를 사용한 데이터 삭제 # 
delete from v_height167
	where height = 168;
    
	# >> 원본 테이블의 기준(참조 테이블 연결)과 충돌되어 삭제 X
    
check table  v_height167;
# 뷰의 상태 확인 가능