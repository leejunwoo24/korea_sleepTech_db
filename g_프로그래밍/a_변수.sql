USE market_db;

select * from `member`;
select * from `buy`;

###  변수 선언 규칙
# : 우항의 데이터를 좌항의 변수에 저장
# set @변수명 = 변수의 값;

# 2) 변수 값 출력 (사용)
# select @변수명;

# cf) SQL 변수의 특징
# : MySQL 워크벤치 시작 시 유지, 종료할 경우 사라짐(임시 저장 공간)

set @myVar1 = 5;
set @myVar2 = 3.14;

# 변수 출력
select @myVar1;
select @myVar2;



# 파일 전체 실행: ctrl + shifht + enter
# 부분 실행: ctrl + enter 

# 테이블 조회 시 변수 사용
select * from `member`;

# 166 이상인 가수 이름 출력
set @txt = '가수이름'; -- 문자열
set @height = 166; -- 숫자

select @txt, mem_name
from `member`
where height > @height;

# cf) limit 키워드에 변수 사용 x
# 		>> 반환하는 행을 제한alter

set @count = 3;
# select * from `member` limit @count;

-- prepare, excute  키워드를 사용한 변수 사용

# prepare: sql문을 실행하지 않고 준비
# -? 키워드를 사용하여 코드 작성 시에는 값이 채워지지 않지만, 실행시 채워지는 코드 작성 가능

# execute: 해당 키워드를 만나야 prepare 코드가 실행

# prepare 실행시킬문장명 (코드블럭명)
# from '실제 SQL믄'
prepare mySQL
	from 'select * from `member` order by height limit ? ';
    # 키가 작은 순서(오름차순)에서 상위 3개의 레코드 출력
    
# execute 실행시킬문장명 using 변수명;
execute mySQL using @count;

# Prepare: 쿼리를 미리 준비 (실행 X)
# Execute: 준비된 쿼리를 실행
# ?: 실행 시 채워질 자리 (플레이스 홀더)
# Using: 플레이스 홀더에 넣을 값 지정