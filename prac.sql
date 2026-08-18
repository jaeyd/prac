-- 1. "각 지역별로 가장 큰 키"를 뽑는 쿼리(usertbl), 그 사람들의 키의 평균을 표시
select addr, max(height) from usertbl group by addr;
select addr, avg(height) from usertbl group by addr;
select addr, round(avg(height),0) from usertbl group by addr;
select addr, max(height) as '총합' 
	from usertbl group by addr order by 총합 desc;
with abc(addr, max) as
	(select addr, max(height) from usertbl group by addr)
select avg(max) from abc;

select userid, sum(price*amount)
	from buytbl group by userid;
with total(userid, sum) as	-- cte
	(select userid, sum(price*amount) 
		from buytbl group by userid)
select * from total order by sum desc;
with total as	-- cte
	(select userid, sum(price*amount) as 'plus' 
		from buytbl group by userid)
select userid, plus from total order by plus desc;

select * from usertbl where name like '김%';
select addr, count(*) from usertbl group by addr;
select addr, count(userid) as total
	from usertbl group by addr order by total desc, addr desc;
select addr, count(userid) as 'count'
	from usertbl group by addr order by count(userid) desc;
select * from usertbl where mdate >= '2010-01-01';
select * from usertbl where height >= 180;

CREATE TABLE pension_payment 
	( payment_id INT PRIMARY KEY, member_id INT NOT NULL, 
    payment_date DATE NOT NULL, amount DECIMAL(12, 0) NOT NULL, 
    pension_type VARCHAR(20) NOT NULL, 
    payment_status VARCHAR(20) DEFAULT '지급완료', 
    FOREIGN KEY (member_id) references mem(member_id) );
CREATE TABLE mem ( member_id INT PRIMARY KEY, 
	member_name VARCHAR(50) NOT NULL, gender CHAR(1), 
    region VARCHAR(20), birth_date DATE, join_date DATE NOT NULL, 
    phone VARCHAR(20), status VARCHAR(20) DEFAULT '정상' );
CREATE TABLE consultation ( consultation_id INT PRIMARY KEY, 
	member_id INT NOT NULL, consultation_date DATETIME NOT NULL, 
    category VARCHAR(30), counselor_name VARCHAR(50), status VARCHAR(20), 
    FOREIGN KEY (member_id) REFERENCES mem(member_id) );

-- 중 1.회원명과 해당 회원의 지급일, 연금 종류, 지급액을 조회
select m.member_name, p.payment_date, p.pension_type, p.amount
	from mem as m
    join pension_payment as p
    on m.member_id = p.member_id
    order by p.payment_date desc;

-- 중 2.지급상태가 지급완료인 전체 연금 지급액을 구함
select sum(amount)
	from pension_payment
    where payment_status = '지급완료';

-- 중 3.연급 종류별 지급 건수와 총 지급액을 구함
select pension_type, count(*), sum(amount)
	from pension_payment
    group by pension_type
    order by sum(amount) desc;

-- 중 4.회원별 평균 지급액을 조회
select m.member_id, m.member_name, avg(p.amount)
	from mem as m
    join pension_payment as p
    on m.member_id = p.member_id
    group by m.member_id
    order by avg(p.amount) desc;

-- 중 5.2024년 총 지급액이 1,000만 원 이상인 회원을 조회
select m.member_id, m.member_name, sum(p.amount)
	from mem as m
    join pension_payment as p
    on m.member_id = p.member_id
    where p.payment_date >= '2024-01-01' and p.payment_date < '2025-01-01'
    group by m.member_id
    having sum(p.amount) >= 10000000
    order by sum(p.amount) desc;

-- 하 1.회원 테이블의 모든 자료를 조회
-- 하 2.회원번호, 회원명, 지역을 조회
-- 하 3.지역이 제주인 회원의 회원번호, 회원명, 가입일을 조회
-- 하 4.회원 상태가 정상인 회원을 회원명 오름차순으로 조회
-- 하 5.2024년에 가입한 회원을 조회
-- 하 6.회원명이 김으로 시작하는 회원을 조회
-- 하 7.지역이 제주, 서울 또는 부산인 회원을 조회
-- 하 8.전화번호가 등록되지 않은 회원을 조회
-- 하 9.가장 최근에 가입한 회원 5명을 조회
-- 하 10.연금 지급 내역에 존재하는 연금 종류를 중복 없이 조회

CREATE TABLE branch ( 
	branch_id INT PRIMARY KEY, branch_name VARCHAR(30) NOT NULL, 
    region VARCHAR(20) NOT NULL );
CREATE TABLE mem ( 
	member_id INT PRIMARY KEY, member_name VARCHAR(30) NOT NULL, 
    birth_date DATE, join_date DATE, grade VARCHAR(20), 
    branch_id INT, status VARCHAR(10), 
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id) );
CREATE TABLE pension_payment ( 
	payment_id INT PRIMARY KEY, member_id INT NOT NULL, 
	payment_date DATE NOT NULL, payment_amount DECIMAL(12, 0) NOT NULL, 
    payment_type VARCHAR(20), 
    FOREIGN KEY (member_id) REFERENCES mem(member_id) );
CREATE TABLE contribution ( 
	contribution_id INT PRIMARY KEY, member_id INT NOT NULL, 
    payment_month CHAR(7), expected_amount DECIMAL(12, 0), 
    paid_amount DECIMAL(12, 0), paid_date DATE, 
    FOREIGN KEY (member_id) REFERENCES mem(member_id) );
CREATE TABLE pension_loan ( 
	loan_id INT PRIMARY KEY, member_id INT NOT NULL, 
    loan_date DATE, loan_amount DECIMAL(12, 0), 
    remaining_amount DECIMAL(12, 0), overdue_days INT DEFAULT 0, 
    FOREIGN KEY (member_id) REFERENCES mem(member_id) );
CREATE TABLE consultation ( 
	consultation_id INT PRIMARY KEY, member_id INT NOT NULL, 
    consultation_type VARCHAR(30), request_date DATE, 
    complete_date DATE, status VARCHAR(20), 
    FOREIGN KEY (member_id) REFERENCES mem(member_id) );

-- 1. member와 branch 테이블을 이용하여 제주 지역 지부에 소속된
--    가입자의 이름, 직급, 지부명을 출력하세요. 가입자 이름의 오름차순으로 정렬합니다.
select m.member_name, m.grade, b.branch_name
	from mem as m
    join branch as b
    on m.branch_id = b.branch_id
    where b.region = '제주'
    order by m.member_name;

-- 2. pension_payment 테이블에서 지급액이 2,000,000원 이상인 내역의 지급번호,
--    가입자번호, 지급일, 지급액을 조회하세요. 지급액이 큰 순서로 정렬합니다.
select payment_id, member_id, payment_date, payment_amount
	from pension_payment
    where payment_amount >= 2000000
    order by payment_amount desc;

-- 3. 지부별 가입자 수를 출력하세요. 결과에는 지부명과 가입자 수를 표시합니다.
select b.branch_name, count(m.member_id)
	from mem as m
    join branch as b
    on m.branch_id = b.branch_id
    group by b.branch_id
    order by b.branch_name;

-- 4. 기여금 납부내역에서 납부액이 예정액 이상이면 정상, 예정액보다 적으면 미납으로 표시하세요.
select contribution_id, member_id, expected_amount, paid_amount,
		case
			when paid_amount >= expected_amount then '정상'
            else '미납'
		end as 'status'
	from contribution;

-- 5. 2025년에 지급된 연금의 총 지급 건수, 총 지급액, 평균 지급액을 출력하세요.
select count(payment_id), sum(payment_amount), avg(payment_amount)
	from pension_payment
    where payment_date >= '2025-01-01' and payment_date < '2026-01-01';

CREATE TABLE branch (
    branch_id   INT PRIMARY KEY,
    branch_name VARCHAR(30) NOT NULL,
    region      VARCHAR(20) NOT NULL
);
CREATE TABLE mem (
    member_id   INT PRIMARY KEY,
    member_name VARCHAR(30) NOT NULL,
    birth_date  DATE,
    join_date   DATE NOT NULL,
    grade       VARCHAR(20),
    branch_id   INT,
    status      VARCHAR(15) NOT NULL,
    FOREIGN KEY (branch_id)
        REFERENCES branch(branch_id)
);
CREATE TABLE pension_payment (
    payment_id     INT PRIMARY KEY,
    member_id      INT NOT NULL,
    payment_date   DATE NOT NULL,
    payment_amount DECIMAL(12, 0) NOT NULL,
    payment_type   VARCHAR(20),
    FOREIGN KEY (member_id)
        REFERENCES mem(member_id)
);
CREATE TABLE contribution (
    contribution_id INT PRIMARY KEY,
    member_id        INT NOT NULL,
    payment_month    CHAR(7) NOT NULL,
    expected_amount  DECIMAL(12, 0) NOT NULL,
    paid_amount      DECIMAL(12, 0),
    paid_date        DATE,
    FOREIGN KEY (member_id)
        REFERENCES mem(member_id)
);

/*
1. 지부별 가입자 수
branch와 member 테이블을 이용하여 지부별 가입자 수를 구하세요.
다음 항목을 출력하고, 가입자 수가 많은 순서로 정렬하세요.
branch_name
가입자 수: member_count */
select b.branch_name, count(m.member_id) as 'member_count'
	from branch as b
    left join mem as m
    on b.branch_id = m.branch_id
    group by b.branch_id
    order by count(m.member_id) desc;

/*
2. member와 pension_payment 테이블을 이용하여 가입자별 연금 지급 현황을 구하세요.
다음 항목을 출력하고, 총 지급액이 큰 순서로 정렬하세요.
member_id
member_name
지급 건수: payment_count
총 지급액: total_amount */
select m.member_id, m.member_name, 
		count(p.payment_id) as 'payment_count', 
        sum(p.payment_amount) as 'total_amount'
	from mem as m
    join pension_payment as p
    on m.member_id = p.member_id
    group by m.member_id
    order by sum(p.payment_amount) desc;

/*
3. 가입자별 총 연금 지급액을 구하고, 총 지급액이 5,000,000원 이상인 가입자만 출력하세요.
다음 항목을 출력하세요.
member_id
member_name
총 지급액: total_amount */
select m.member_id, m.member_name, sum(p.payment_amount) as 'total_amount'
	from mem as m
    join pension_payment as p
    on m.member_id = p.member_id
    group by m.member_id	-- group by 를 먼저 사용해야 하면 having 으로 조건검색
    having sum(p.payment_amount) >= 5000000
    order by sum(p.payment_amount) desc;

/*
4. member와 contribution 테이블을 이용하여 2025년에 기여금을 미납한 가입자를 조회하세요.
paid_amount가 expected_amount보다 작은 경우를 미납으로 판단합니다. paid_amount가 
NULL이면 0으로 처리하세요. 다음 항목을 출력하세요.
member_name
payment_month
expected_amount
실제 납부금액: paid_amount
미납금액: unpaid_amount */
select m.member_name, c.payment_month, c.expected_amount, 
		ifnull(c.paid_amount,0) as 'paid_amount', 
        c.expected_amount - ifnull(c.paid_amount,0) as 'unpaid_amount'
	from mem as m
    join contribution as c
    on m.member_id = c.member_id
    where c.payment_month between '2025-01' and '2025-12'
		and ifnull(c.paid_amount,0) < c.expected_amount
    order by m.member_name desc;

/*
5. member와 pension_payment 테이블을 이용하여 가입자별 가장 최근 연금 지급일을 구하세요.
다음 항목을 출력하세요.
member_id
member_name
최근 지급일: latest_payment_date */
select m.member_id, m.member_name, 
		max(p.payment_date) as 'latest_payment_date'
	from mem as m
    join pension_payment as p
    on m.member_id = p.member_id
    group by m.member_id	-- sum, count, avg, max 등을 사용할 때 group by
    order by max(p.payment_date) desc;

/*
상 1. 전체 연금 지급액의 평균보다 payment_amount가 큰 지급내역을 조회하세요.
다음 항목을 출력하세요. 지급액이 큰 순서로 정렬하세요.
p.payment_id
m.member_name
p.payment_date
p.payment_amount */
select p.payment_id, m.member_name, p.payment_date, p.payment_amount
	from mem as m
    join pension_payment as p
    on m.member_id = p.member_id
    where p.payment_amount > (	-- 서브쿼리
		select avg(payment_amount) from pension_payment )
	order by p.payment_amount desc;

/*
상 2. member 테이블에서 2025년에 연금을 한 번도 지급받지 않은 가입자를 조회하세요.
다음 항목을 출력하세요. NOT EXISTS를 사용하세요.
member_id
member_name
branch_name
status
member / branch / pension_payment */
select m.member_id, m.member_name, b.branch_name, m.status
	from mem as m
    join branch as b
    on m.branch_id = b.branch_id
    where not exists (
		select 1 
			from pension_payment as p
            where m.member_id = p.member_id
				and payment_date >= '2025-01-01' 
                and payment_date < '2026-01-01'
	);

/*
상3. 2025년 지부별 총 연금 지급액을 계산하고, 총 지급액이 많은 지부부터 순위를 부여하세요.
지급액이 같은 지부는 같은 순위를 부여합니다. 다음 항목을 출력하세요.
branch_name
총 지급액: total_amount
지급 순위: payment_rank */
with branch_sum as
	(select b.branch_name, sum(p.payment_amount) as 'total_amount'
		from branch as b
        join mem as m
        on b.branch_id = m.branch_id
        join pension_payment as p
        on m.member_id = p.member_id
        where p.payment_date >= '2025-01-01' and p.payment_date < '2026-01-01'
        group by b.branch_name)
select branch_name, total_amount, dense_rank() over (
		order by total_amount desc) as 'payment_rank'
	from branch_sum;

/*
상 4. 각 가입자의 가장 최근 연금 지급내역을 한 건씩 조회하세요.
같은 날짜에 여러 지급내역이 있으면 payment_id가 가장 큰 내역을 선택하세요.다음 항목을 출력하세요.
member_id
member_name
payment_id
payment_date
payment_amount
payment_type */
with rank_payment as
	(select member_id, payment_id, payment_date, payment_amount, 
			payment_type, row_number() over (
				partition by member_id 
				order by payment_date desc, payment_id desc) as 'row_num'
		from pension_payment)
select m.member_id, m.member_name, r.payment_id, r.payment_date, 
		r.payment_amount, r.payment_type
	from rank_payment as r
    join mem as m
    on r.member_id = m.member_id
    where r.row_num = 1
    order by m.member_id;

/*
상 5. 2025년 가입자별 총 연금 지급액을 계산한 후, 각 지부에서 지급액이 많은 상위 2명을 조회하세요.
다음 항목을 출력하세요.
branch_name
member_name
가입자 총 지급액: total_amount
지부 내 순위: branch_rank */
with member_sum as
	(select m.member_id, m.member_name, m.branch_id, 
			sum(p.payment_amount) as 'total_amount'
		from mem as m
        join pension_payment as p
        on m.member_id = p.member_id
        where payment_date >= '2025-01-01' and payment_date < '2026-01-01'
        group by m.member_id),
rank_member as 
	(select member_id, member_name, branch_id, total_amount,
			row_number() over (
				partition by branch_id 
                order by total_amount desc) as 'branch_rank'
		from member_sum)
select b.branch_name, r.member_name, r.total_amount, r.branch_rank
	from rank_member as r
    join branch as b
    on r.branch_id = b.branch_id
    where branch_rank <= 2
    order by b.branch_name;

CREATE TABLE branch (
    branch_id   INT PRIMARY KEY,
    branch_name VARCHAR(30) NOT NULL,
    region      VARCHAR(20) NOT NULL
);
CREATE TABLE mem (
    member_id   INT PRIMARY KEY,
    member_name VARCHAR(30) NOT NULL,
    birth_date  DATE,
    join_date   DATE NOT NULL,
    grade       VARCHAR(20),
    branch_id   INT,
    status      VARCHAR(15) NOT NULL,
    FOREIGN KEY (branch_id)
        REFERENCES branch(branch_id)
);
CREATE TABLE pension_payment (
    payment_id     INT PRIMARY KEY,
    member_id      INT NOT NULL,
    payment_date   DATE NOT NULL,
    payment_amount DECIMAL(12, 0) NOT NULL,
    payment_type   VARCHAR(20),
    FOREIGN KEY (member_id)
        REFERENCES mem(member_id)
);
CREATE TABLE contribution (
    contribution_id INT PRIMARY KEY,
    member_id        INT NOT NULL,
    payment_month    CHAR(7) NOT NULL,
    expected_amount  DECIMAL(12, 0) NOT NULL,
    paid_amount      DECIMAL(12, 0),
    paid_date        DATE,
    FOREIGN KEY (member_id)
        REFERENCES mem(member_id)
);
CREATE TABLE consultation (
    consultation_id   INT PRIMARY KEY,
    member_id          INT NOT NULL,
    consultation_type  VARCHAR(30),
    request_date       DATE NOT NULL,
    complete_date      DATE,
    status             VARCHAR(20),
    FOREIGN KEY (member_id)
        REFERENCES mem(member_id)
);

/*
1. member와 contribution 테이블을 이용하여 2025년 기여금 미납내역을 조회하세요.
다음 조건을 미납으로 판단합니다.
paid_amount < expected_amount
paid_amount가 NULL이면 0으로 처리하세요.
다음 항목을 출력하세요.
member_name
payment_month
expected_amount
paid_amount
미납금액: unpaid_amount
미납금액이 큰 순서로 정렬하세요. */
select m.member_name, c.payment_month, c.expected_amount, 
		ifnull(c.paid_amount,0) as 'paid_amount', 
		c.expected_amount - ifnull(c.paid_amount,0) as 'unpaid_amount'
	from mem as m
    join contribution as c
    on m.member_id = c.member_id
    where c.payment_month between '2025-01' and '2025-12'
		and ifnull(c.paid_amount,0) < c.expected_amount
	order by unpaid_amount desc;

/*
2. branch, member, pension_payment 테이블을 이용하여 2025년 지부별 연금 지급 현황을 구하세요.
다음 항목을 출력하세요.
branch_name
지급 건수: payment_count
총 지급액: total_amount
평균 지급액: average_amount
총 지급액이 큰 순서로 정렬하세요. */
select b.branch_name, count(p.payment_id) as 'payment_count',
		sum(p.payment_amount) as 'total_amount',
        round(avg(p.payment_amount),0) as 'average_amount'
	from branch as b
    join mem as m
    on b.branch_id = m.branch_id
    join pension_payment as p
    on m.member_id = p.member_id
    where p.payment_date >= '2025-01-01' and p.payment_date < '2026-01-01'
    group by b.branch_id
    order by total_amount desc;

/*
3. 각 가입자의 가장 최근 연금 지급내역을 한 건씩 조회하세요.
같은 날짜에 지급내역이 여러 건이면 payment_id가 가장 큰 내역을 선택합니다.
다음 항목을 출력하세요.
member_id
member_name
payment_id
payment_date
payment_amount
payment_type
ROW_NUMBER()와 PARTITION BY member_id를 사용하세요. */
with ranked_payment as
	(select member_id, payment_id, payment_date,
			payment_amount, payment_type, 
            row_number() over (
				partition by member_id
                order by payment_date desc, payment_id desc) as 'row_num'
		from pension_payment)
select m.member_id, m.member_name, r.payment_id, r.payment_date, 
		r.payment_amount, r.payment_type
	from ranked_payment as r
    join mem as m
    on r.member_id = m.member_id
    where r.row_num = 1
    order by m.member_id;

CREATE TABLE branch (
    branch_id   INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(30) NOT NULL,
    region      VARCHAR(20) NOT NULL
) ENGINE = InnoDB;
CREATE TABLE pension_member (
    member_id     INT AUTO_INCREMENT PRIMARY KEY,
    member_name   VARCHAR(30) NOT NULL,
    birth_date    DATE,
    join_date     DATE NOT NULL,
    grade         VARCHAR(20),
    member_status VARCHAR(15) NOT NULL,
    branch_id     INT NOT NULL,
    CONSTRAINT fk_pension_member_branch
        FOREIGN KEY (branch_id)
        REFERENCES branch(branch_id)
) ENGINE = InnoDB;
CREATE TABLE pension_payment (
    payment_id     INT AUTO_INCREMENT PRIMARY KEY,
    member_id      INT NOT NULL,
    payment_date   DATE NOT NULL,
    payment_amount DECIMAL(12, 0) NOT NULL,
    payment_type   VARCHAR(20) NOT NULL,
    CONSTRAINT fk_payment_pension_member
        FOREIGN KEY (member_id)
        REFERENCES pension_member(member_id)
) ENGINE = InnoDB;

/*
﻿하 난이도  1. 활동 가입자 조회
pension_member 테이블에서 현재 활동 중인 가입자를 조회하세요.
조건: member_status가 'ACTIVE'인 행만 조회합니다.
출력 항목: member_id, member_name, grade, join_date
정렬: member_name의 오름차순으로 정렬합니다. */
select member_id, member_name, grade, join_date
	from pension_member
    where member_status = 'ACTIVE'
    order by member_name;

/*
﻿하 난이도  2. 제주 지역 가입자 조회
pension_member와 branch 테이블을 연결하여 제주 지역에 소속된 가입자를 조회하세요.
조건: branch.region이 'Jeju'인 행만 조회합니다.
출력 항목: member_id, member_name, grade, branch_name, region
정렬: member_name의 오름차순으로 정렬합니다. */
select m.member_id, m.member_name, m.grade, 
		b.branch_name, b.region
	from pension_member as m
    join branch as b
    on m.branch_id = b.branch_id
    where b.region = 'Jeju'
    order by m.member_name;

/*
﻿중 난이도  3. 지부별 연금 지급 현황
branch, pension_member, pension_payment 테이블을 이용하여 2025년 지부별 연금 지급 현황을 구하세요.
조건: payment_date가 2025년에 속하는 지급내역만 사용하며, average_amount는 소수점 없이 표시합니다.
출력 항목: branch_name, payment_count, total_amount, average_amount
정렬: total_amount가 큰 순서로 정렬합니다. */
select b.branch_name, count(p.payment_id) as 'payment_count',
		sum(p.payment_amount) as 'total_amount',
        round(avg(p.payment_amount),0) as 'average_amount'
	from branch as b
    join pension_member as m
    on b.branch_id = m.branch_id
    join pension_payment as p
    on m.member_id = p.member_id
    where p.payment_date >= '2025-01-01' and p.payment_date < '2026-01-01'
    group by b.branch_id
    order by total_amount desc;

/*
﻿중 난이도  4. 총 지급액이 500만 원 이상인 가입자
pension_member와 pension_payment 테이블을 이용하여 2025년 가입자별 지급 건수와 총 연금 지급액을 계산하세요.
조건: 가입자별 total_amount가 5,000,000원 이상인 가입자만 출력합니다.
출력 항목: member_id, member_name, payment_count, total_amount
정렬: total_amount가 큰 순서로 정렬합니다. */
select m.member_id, m.member_name,
		count(p.payment_id) as 'payment_count',
        sum(p.payment_amount) as 'total_amount'
	from pension_member as m
    join pension_payment as p
    on m.member_id = p.member_id
    where p.payment_date >= '2025-01-01' and p.payment_date < '2026-01-01'
    group by m.member_id
    having sum(p.payment_amount) >= 5000000
    order by total_amount desc;

/*
﻿상 난이도  5. 지부별 총 연금 지급액 순위
branch, pension_member, pension_payment 테이블을 이용하여 2025년 지부별 총 연금 지급액과 순위를 구하세요.
조건: 총 지급액이 같은 지부에는 같은 순위를 부여하며, 동점 다음 순위는 건너뛰지 않습니다.
출력 항목: branch_name, total_amount, payment_rank
정렬: payment_rank의 오름차순으로 정렬하고, 순위가 같으면 branch_name의 오름차순으로 정렬합니다.
필수 사용 구문: CTE(WITH)와 DENSE_RANK()를 사용합니다. */
with branch_sum as
	(select b.branch_name, sum(p.payment_amount) as 'total_amount'
		from branch as b
        join pension_member as m
        on b.branch_id = m.branch_id
        join pension_payment as p
        on m.member_id = p.member_id
        where p.payment_date >= '2025-01-01' and p.payment_date < '2026-01-01'
        group by b.branch_name)
select branch_name, total_amount, dense_rank() over (
		order by total_amount desc) as 'payment_rank'
	from branch_sum
    order by payment_rank, branch_name;
