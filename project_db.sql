-- 도커 컨테이너 mysql 클라이언트에 인코딩 알림(안하면 한글 깨짐)
SET NAMES utf8mb4;

CREATE DATABASE project_db DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;
USE project_db;

CREATE TABLE project (
	project_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL, -- 프로젝트명
    proficiency ENUM('초급', '중급', '고급', '무관') NOT NULL, -- 숙련도
    project_duration VARCHAR(50) NOT NULL, -- 프로젝트 참여 기간
    location ENUM('서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '강원', '경기', '경남', '경북', '전남', '전북', '충남', '충북', '제주' ) NOT NULL, -- 희망 근무 지역
    recruitment_status ENUM('모집 중', '모집 완료') NOT NULL, -- 모집 상태
    deadline VARCHAR(50) NOT NULL, -- 마감 기한
    likes INT DEFAULT 0, -- 좋아요 수
    monthly_price VARCHAR(50) NOT NULL, -- 월 단가
    current_members INT DEFAULT 0, -- 참여 중인 인원
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP, -- 등록 날짜
	technology_id INT NOT NULL, -- 외래키
    category_id INT NOT NULL -- 카테고리 외래키
);

CREATE TABLE technologies (
	technology_id INT PRIMARY KEY AUTO_INCREMENT,
    technology_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE technology_details (
	detail_id INT PRIMARY KEY AUTO_INCREMENT,
    technology_id INT NOT NULL, -- 외래키
    detail_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE category (
	category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO category (category_name) VALUES
('개발'), ('기획'), ('퍼블리싱'), ('디자인'), ('기타');

SELECT * FROM technology_details;
INSERT INTO technologies (technology_name) VALUES
('JAVA'), ('APP'), ('PHP/ASP'), ('C/C++'), ('DB');
INSERT INTO technologies (technology_name) VALUES ('기획도구');

INSERT INTO technology_details (technology_id, detail_name) VALUES
(1, 'JAVA'), (1, 'Node.js'), (1, 'React.js'), (1, 'Vue.js'), (1, 'TypeScript'), (1, 'Nexacro'), (1, 'MiPlatform'), (1, 'Angular'),
(2, 'Android'), (2, 'IOS(Object-C)'), (2, 'Kotlin'), (2, 'Flutter'), (2, 'React Native'),
(3, 'PHP'), (3,'Laravel'), (3, 'ASP'),
(4, 'C'), (4, 'C#'), (4, 'C++'), (4, 'MFC'), (4, '.NET'), (4, 'Python'), (4, 'Delphi'),
(5, 'Oracle'), (5, 'MSSQL'), (5, 'MySQL'), (5, 'MariaDB'),
(6, 'PowerPoint'),(6, 'Figma');


-- 기획도구에 category_id = 2 (기획) 연결
UPDATE technologies SET category_id = 2 WHERE technology_name = '기획도구';
CREATE DATABASE project_db DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;
USE project_db;



INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/C#,JAVASCRIPT/12개월/잠실역] 롯데시네마 온라인 시스템 운영', 4, '고급', '11개월', '서울', '모집 중', '마감 6일 전', '600만원 ~ 600만원', 2, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/Java(React)/약8.5개월/을지로] 하나은행 퇴직연금시스템 구축', 1, '중급', '8개월', '서울', '모집 중', '마감 2일 전', '금액 제안 가능', 1, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/JAVA/SQL 튜닝/3개월 이후 연장/종각] 하나투어 유지보수', 1, '고급', '3개월', '서울', '모집 중', '마감 2일 전', '650만원 ~ 650만원', 4, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/C#/약15개월/종각역] SK온 25년 ERP GSI 구축 사업의 Legacy System 개선 (중급 가능)', 4, '고급', '17개월', '서울', '모집 중', '마감 2일 전', '금액 제안 가능', 3, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[초급 개발자/C#/4개월/강동구] 차세대 POS 및 키오스크 구축건 테스터 업무', 4, '초급', '4개월', '서울', '모집 중', '마감 2일 전', '금액 제안 가능', 0, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/React/약12개월/여의도] 생보사 영업지원시스템(SFA) 운영 (프론트)', 1, '중급', '12개월', '서울', '모집 중', '마감 9일 전', '금액 제안 가능', 1, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/React/약12개월/여의도] 생보사 영업지원시스템(SFA) 운영 (프론트)', 1, '고급', '12개월', '서울', '모집 중', '마감 9일 전', '금액 제안 가능', 0, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/Java/약12개월/여의도] 생보사 영업지원시스템(SFA) 운영 (백엔드)', 1, '고급', '12개월', '서울', '모집 중', '마감 9일 전', '금액 제안 가능', 4, 1, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/Java/약12개월/여의도] 생보사 영업지원시스템(SFA) 운영 (백엔드)', 1, '고급', '12개월', '서울', '모집 중', '마감 9일 전', '금액 제안 가능', 1, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/C#.NET/6개월/여의도] 카드사 개발(8/1~)', 4, '고급', '5개월', '서울', '모집 중', '마감 2일 전', '금액 협의 가능', 3, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/Java/5개월/인천] 산업안전보건 포털 시스템 고도화 (고급 가능)', 5, '중급', '5개월', '인천', '모집 중', '마감 2일 전', '금액 제안 가능', 2, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/Websquare/약3개월/여의도] 삼성증권 Websquare 전환 개발', 1, '중급', '3개월', '서울', '모집 중', '마감 2일 전', '600만원 ~ 600만원', 6, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/JAVA/5개월/인덕원] 금융권 프론트 개발(8/1~)', 1, '중급', '5개월', '서울', '모집 중', '마감 9일 전', '450만원 ~ 450만원', 1, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/AA/9개월/보라매] 공제회 프로젝트 AA', 1, '고급', '9개월', '서울', '모집 중', '마감 2일 전', '금액 제안 가능', 2, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/SE/약5.5개월(연단위 연장)/기흥] HL홀딩스 데이터센터 서버 운영', 1, '중급', '5개월', '경기', '모집 중', '마감 9일 전', '금액 협의 가능', 0, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/Next.js/약12개월/서울역] 퍼시스 ERP 시스템 구축', 1, '고급', '11개월', '서울', '모집 중', '마감 9일 전', '금액 제안 가능', 1, 1, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/Java/3개월(이후 연장)/성수] 토마토 솔루션 개선 및 유지보수', 1, '고급', '3개월', '서울', '모집 중', '마감 2일 전', '금액 제안 가능', 9, 0, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/Java/약3개월(이후 년 단위계약)/용산] AXA 손해보험 ITO 운영', 1, '중급', '2개월', '서울', '모집 중', '마감 9일 전', '금액 제안 가능', 3, 2, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[초급 개발자/Websquare/7개월/서초구(양재시민의숲)] 물류시스템 관련 프론트웹개발(9/1~)', 1, '초급', '7개월', '서울', '모집 중', '마감 9일 전', '금액 협의 가능', 0, 5, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/Websquare/8개월/서초구(양재시민의숲)] 물류시스템 관련 프론트웹개발(8/1~)', 1, '중급', '8개월', '서울', '모집 중', '마감 9일 전', '금액 협의 가능', 2, 2, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/Java/3개월(이후 연장)/성수] 토마토 솔루션 개선 및 유지보수', 1, '중급', '3개월', '서울', '모집 중', '마감 2일 전', '금액 제안 가능', 7, 7, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/React/약5개월/이천] SK하이닉스 신규업무시스템 개발', 1, '고급', '5개월', '경기', '모집 중', '마감 2일 전', '금액 제안 가능', 0, 3, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급이상 개발자/JAVA/약3개월(3개월 단위 연장)/판교] 정보시스템 유지보수 및 운영', 5, '중급', '2개월', '경기', '모집 중', '마감 2일 전', '금액 제안 가능', 5, 3, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/Java/3개월/을지로3가역] 신한손해보험 전자계약 솔루션 구축', 1, '고급', '2개월', '서울', '모집 중', '마감 2일 전', '금액 제안 가능', 11, 2, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/Java/약5.5개월/광화문역] 버거킹 OMS 서버단 유지보수', 5, '중급', '5개월', '서울', '모집 중', '마감 9일 전', '금액 제안 가능', 5, 8, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/JAVA/약5.5개월/원주] 공공(건보) 프로젝트 (초급가능)', 1, '중급', '6개월', '경기', '모집 중', '마감 2일 전', '금액 제안 가능', 4, 6, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/WebSquare/약4.5개월/시청역] 메리츠화재 장기가입설계 시스템구축', 1, '고급', '4개월', '서울', '모집 중', '마감 2일 전', '700만원 ~ 700만원', 5, 3, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/Websquare/약4개월/서현역] 저축은행 UI 공통 개발', 1, '고급', '4개월', '경기', '모집 중', '마감 2일 전', '금액 제안 가능', 3, 2, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/React/3개월/강서구(마곡나루)] OO전자 CS_One 운영 고도화', 1, '고급', '2개월', '서울', '모집 중', '마감 2일 전', '금액 제안 가능', 3, 2, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급/AA/5개월/원주] 공공기관 SI 프로젝트 AA', 1, '고급', '5개월', '서울', '모집 중', '마감 2일 전', '850만원 ~ 850만원', 2, 4, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[초상 개발자/JAVA/12개월/여의도] 외환전산망 유지보수', 1, '초급', '12개월', '서울', '모집 중', '마감 2일 전', '400만원 ~ 400만원', 6, 8, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/NET/12개월/강서구] LX그룹 웹메일시스템 운영(고급 가능)(7/28~)', 4, '중급', '12개월', '서울', '모집 중', '마감 2일 전', '금액 제안 가능', 7, 5, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[고급 개발자/React, Typescript/5.5개월/양재] 현대자동차 사이트 프론트 개발', 1, '고급', '5개월', '서울', '모집 중', '마감 2일 전', '650만원 ~ 650만원', 2, 5, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/React, Typescript/5.5개월/양재] 현대자동차 사이트 프론트 개발', 1, '중급', '5개월', '서울', '모집 중', '마감 2일 전', '550만원 ~ 550만원', 1, 6, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/IOS/3개월/안양시 동안구] iOS 개발(8/1~)', 1, '중급', '3개월', '경기', '모집 중', '마감 10일 전', '500만원 ~ 650만원', 3, 2, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급/React/4개월/보라매병원역] OO쇼핑 시스템 개발', 1, '중급', '4개월', '서울', '모집 중', '마감 2일 전', '금액 제안 가능', 1, 6, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[초급 개발자/Java/약6개월(이후 년 단위계약)/용산] JB우리캐피탈 ITO 개발 및 운영', 1, '초급', '6개월', '서울', '모집 중', '마감 2일 전', '금액 제안 가능', 5, 7, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[중급 개발자/Java/약5.5개월/선릉] 현대/기아자동차 CRM-영업지원시스템 (초상가능)', 1, '중급', '5개월', '서울', '모집 중', '마감 2일 전', '500만원 ~ 500만원', 8, 8, 1);
INSERT INTO project (title, technology_id, proficiency, project_duration, location, recruitment_status, deadline, monthly_price, current_members, likes, category_id) VALUES
('[등급무관 개발자/KOTLIN/2개월/강남구] 플랫폼내 쇼핑몰 개발 (Android) (07월)', 2, '무관', '2개월', '서울', '모집 중', '마감 2일 전', '금액 제안 가능', 7, 7, 1);

SELECT * FROM project;
SHOW CREATE TABLE project;
DELETE FROM project WHERE project_id = 3;
ALTER TABLE project AUTO_INCREMENT = 2;

DESC project;