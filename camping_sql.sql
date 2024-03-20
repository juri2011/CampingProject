-- --------------------------------------------------------
-- 호스트:                          3.39.15.64
-- 서버 버전:                        8.0.33-0ubuntu0.22.04.2 - (Ubuntu)
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */; 




/*
================================================================================
	캠핑가팀 여러분!!!!!
	아래 코드는 스크립트를 전체 실행(Alt + X) 하신 후 실행해주시길 바랍니다.
	(설명: spring 시간에 사용하던 dbuser에게 권한 설정을 해줬습니다^^ 모두 같은 환경에서 실행되게 하기 위함)
	
	grant all privileges on shop.* to 'dbuser'@'%';
	flush privileges;
	
---------------------------------------------------------------------------------	
	
	회원 비번에 암호화가 설정되어 있어서 기존에 insert된 데이터로는 테스트 할 수 없습니다.
	회원가입을 한 뒤에 테스트해주세요.
	
	관리자 메뉴를 보고 싶으신 분은 아래 코드를 추가로 실행해주세요.
	(회원가입을 하면 일반 사용자 등급을 받습니다.)
	
	select * from member;
	select * from authority;
	
	insert into authority (mem_id, auth) values('본인닉네임', 'ROLE_MANAGER');
	insert into authority (mem_id, auth) values('본인닉네임', 'ROLE_ADMIN'); 
================================================================================	 
*/

-- shop 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `shop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shop`;

-- 테이블 shop.answer_claim 구조 내보내기
CREATE TABLE IF NOT EXISTS `answer_claim` (
  `answer_no` int NOT NULL AUTO_INCREMENT,
  `gclaim_no` int NOT NULL COMMENT 'gclaim gclaim_no 컬럼 fk',
  `title` varchar(200) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `regidate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('1','2','3') NOT NULL DEFAULT '1' COMMENT '1:처리대기 2:처리중 3:처리완료',
  PRIMARY KEY (`answer_no`) USING BTREE,
  KEY `fk_answer_claim_gclaim` (`gclaim_no`),
  CONSTRAINT `fk_answer_claim_gclaim` FOREIGN KEY (`gclaim_no`) REFERENCES `gclaim` (`gclaim_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='관리자 클레임 답변';

-- 테이블 데이터 shop.answer_claim:~4 rows (대략적) 내보내기
DELETE FROM `answer_claim`;
/*!40000 ALTER TABLE `answer_claim` DISABLE KEYS */;
/*!40000 ALTER TABLE `answer_claim` ENABLE KEYS */;

-- 테이블 shop.authority 구조 내보내기
CREATE TABLE IF NOT EXISTS `authority` (
  `auth_id` int NOT NULL AUTO_INCREMENT,
  `mem_id` varchar(100) NOT NULL,
  `auth` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '이용자:ROLE_MEMBER / 매니저:ROLE_MANAGER / 관리자:ROLE_ADMIN',
  PRIMARY KEY (`auth_id`),
  KEY `fk_mem_id` (`mem_id`),
  CONSTRAINT `fk_mem_id` FOREIGN KEY (`mem_id`) REFERENCES `member` (`mem_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 shop.authority:~5 rows (대략적) 내보내기
DELETE FROM `authority`;
/*!40000 ALTER TABLE `authority` DISABLE KEYS */;
INSERT INTO `authority` (`auth_id`, `mem_id`, `auth`) VALUES
	(1, 'test00', 'ROLE_MEMBER'),
	(2, 'test123', 'ROLE_MEMBER'),
	(3, 'admin', 'ROLE_MEMBER'),
	(4, 'admin', 'ROLE_MANAGER'),
	(5, 'admin', 'ROLE_ADMIN'),
	(6, 'jh123', 'ROLE_MEMBER');
/*!40000 ALTER TABLE `authority` ENABLE KEYS */;

-- 테이블 shop.cart 구조 내보내기
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_no` int NOT NULL AUTO_INCREMENT,
  `mem_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'member 컬럼 fk',
  `goods_no` int DEFAULT NULL,
  `ordernum` int DEFAULT NULL,
  `regidate` datetime DEFAULT CURRENT_TIMESTAMP,
  `quantity` int DEFAULT NULL,
  `status` enum('1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1' COMMENT '1.결제전 2. 결제완료',
  `update_date` datetime DEFAULT NULL,
  `optionName` varchar(200) DEFAULT NULL,
  `totalPrice` int DEFAULT NULL,
  `pname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cart_no`) USING BTREE,
  KEY `FK_MEM_ID2` (`mem_id`),
  KEY `FK_ORDER_NO` (`ordernum`),
  KEY `FK_GOODS_NO` (`goods_no`),
  CONSTRAINT `FK_GOODS_NO` FOREIGN KEY (`goods_no`) REFERENCES `goods` (`goods_no`),
  CONSTRAINT `FK_MEM_ID2` FOREIGN KEY (`mem_id`) REFERENCES `member` (`mem_id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='장바구니\r\n';

-- 테이블 데이터 shop.cart:~36 rows (대략적) 내보내기
DELETE FROM `cart`;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` (`cart_no`, `mem_id`, `goods_no`, `ordernum`, `regidate`, `quantity`, `status`, `update_date`, `optionName`, `totalPrice`, `pname`) VALUES
	(1, 'admin', 58, 28, '2023-07-22 11:10:50', 16, '2', '2023-07-28 01:03:31', NULL, NULL, NULL),
	(58, 'test00', 73, NULL, '2023-07-28 00:38:14', 1, '1', NULL, '[50%] 토프그레이\n', 6000, NULL),
	(59, 'test00', 73, NULL, '2023-07-28 00:38:14', 1, '1', NULL, '[50%] 다크브라운\n', 6000, NULL),
	(60, 'test00', 76, NULL, '2023-07-28 00:41:54', 1, '1', NULL, '워터뱅크 블루 히알루로닉 건성피부 에센셜 2스텝\n', 50250, NULL),
	(61, 'test00', 76, NULL, '2023-07-28 00:43:21', 1, '1', NULL, '워터뱅크 블루 히알루로닉 건성피부 에센셜 2스텝\n', 50250, '워터뱅크 블루 히알루로닉 건성피부 에센셜 2스텝 세트 160ml+120ml'),
	(62, 'test00', 85, NULL, '2023-07-28 00:44:36', 1, '1', NULL, '쁘띠 블링블링\n', 40000, '모노 아이즈 1.5g'),
	(68, 'test00', 58, NULL, '2023-07-28 00:47:36', 1, '1', NULL, '심마이크로 에센스(500ml) + 샘플30일\n', 56000, NULL),
	(69, 'test00', 58, NULL, '2023-07-28 00:47:41', NULL, '1', NULL, NULL, NULL, NULL),
	(70, 'test00', 58, NULL, '2023-07-28 00:47:41', 1, '1', NULL, '심마이크로 에센스(350ml) + 샘플10일\n', 56000, NULL),
	(71, 'test00', 58, NULL, '2023-07-28 00:50:02', 1, '1', NULL, '심마이크로 에센스(500ml) + 샘플30일\n', 56000, NULL),
	(72, 'test00', 58, NULL, '2023-07-28 00:50:06', NULL, '1', NULL, NULL, NULL, NULL),
	(73, 'test00', 58, NULL, '2023-07-28 00:50:06', 1, '1', NULL, '심마이크로 에센스(350ml) + 샘플10일\n', 56000, NULL),
	(74, 'test00', 58, NULL, '2023-07-28 00:50:24', 1, '1', NULL, '심마이크로 에센스(500ml) + 샘플30일\n', 56000, NULL),
	(75, 'test00', 58, NULL, '2023-07-28 00:50:27', NULL, '1', NULL, NULL, NULL, NULL),
	(76, 'test00', 58, NULL, '2023-07-28 00:50:27', 1, '1', NULL, '심마이크로 에센스(350ml) + 샘플10일\n', 56000, NULL),
	(77, 'admin', 91, 28, '2023-07-28 00:54:02', 1, '2', '2023-07-28 01:03:31', '체리쥬빌레\n', 8800, NULL),
	(78, 'test00', 58, NULL, '2023-07-28 00:55:20', 1, '1', NULL, '심마이크로 에센스(500ml) + 샘플30일\n', 56000, NULL),
	(79, 'test00', 58, NULL, '2023-07-28 00:55:46', 1, '1', NULL, '심마이크로 에센스(500ml) + 샘플30일\n', 56000, NULL),
	(80, 'admin', 91, 28, '2023-07-28 00:56:33', 1, '2', '2023-07-28 01:03:31', '체리쥬빌레\n', 8800, NULL),
	(81, 'test00', 58, NULL, '2023-07-28 00:56:39', 1, '1', NULL, '심마이크로 에센스(500ml) + 샘플30일\n', 56000, NULL),
	(82, 'test00', 58, NULL, '2023-07-28 00:57:22', 1, '1', NULL, '심마이크로 에센스(500ml) + 샘플30일\n', 56000, NULL),
	(83, 'test00', 58, NULL, '2023-07-28 00:57:35', NULL, '1', NULL, NULL, NULL, NULL),
	(84, 'test00', 58, NULL, '2023-07-28 00:57:35', 1, '1', NULL, '심마이크로 에센스(350ml) + 샘플10일\n', 56000, NULL);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

-- 테이블 shop.gclaim 구조 내보내기
CREATE TABLE IF NOT EXISTS `gclaim` (
  `gclaim_no` int NOT NULL AUTO_INCREMENT,
  `goods_no` int NOT NULL,
  `mem_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `regidate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('1','2','3','4','5') NOT NULL COMMENT '1:단순변심 2:제품하자 3:사이즈문제 4:오배송 5:기타',
  PRIMARY KEY (`gclaim_no`) USING BTREE,
  KEY `FK_GOODS_NO3` (`goods_no`),
  KEY `FK_MEM_NO4` (`mem_id`),
  CONSTRAINT `FK_GOODS_NO3` FOREIGN KEY (`goods_no`) REFERENCES `goods` (`goods_no`),
  CONSTRAINT `FK_MEM_NO4` FOREIGN KEY (`mem_id`) REFERENCES `member` (`mem_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='클레임';

-- 테이블 데이터 shop.gclaim:~6 rows (대략적) 내보내기
DELETE FROM `gclaim`;
/*!40000 ALTER TABLE `gclaim` DISABLE KEYS */;
INSERT INTO `gclaim` (`gclaim_no`, `goods_no`, `mem_id`, `content`, `regidate`, `updatedate`, `status`) VALUES
	(10, 78, 'test00', 'test', '2023-07-28 01:09:39', '2023-07-28 01:09:39', '1'),
	(11, 88, 'test00', 'test00', '2023-07-28 01:28:16', '2023-07-28 01:28:16', '2');
/*!40000 ALTER TABLE `gclaim` ENABLE KEYS */;

-- 테이블 shop.goods 구조 내보내기
CREATE TABLE IF NOT EXISTS `goods` (
  `goods_no` int NOT NULL AUTO_INCREMENT,
  `category` varchar(100) NOT NULL,
  `pname` varchar(100) NOT NULL,
  `sellPrice` int NOT NULL,
  `skintype` varchar(100) NOT NULL,
  `regidate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `stock` int NOT NULL,
  `status` enum('1','2','3') NOT NULL COMMENT '1:판매중 2:재입고중 3:품절',
  `content` text,
  `discountPrice` int DEFAULT NULL,
  `originalPrice` int DEFAULT NULL,
  `UUID` varchar(100) DEFAULT NULL,
  `imagepath` varchar(200) DEFAULT NULL,
  `option_list` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`goods_no`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='상품\r\n';

select * from goods;

-- 테이블 데이터 shop.goods:~15 rows (대략적) 내보내기
DELETE FROM `goods`;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` (`goods_no`, `category`, `pname`, `sellPrice`, `skintype`, `regidate`, `updatedate`, `stock`, `status`, `content`, `discountPrice`, `originalPrice`, `UUID`, `imagepath`, `option_list`) VALUES
	(58, 'skincare', '[Sephora] 더 퍼스트 제너추어 심마이크로 에센스', 63000, 'middle', '2023-07-22 11:20:56', '2023-07-22 11:20:56', 300, '1', '<p><img alt="김태희 사진1" src="/upload/355015d4c84145748d3de3bc783957c6.png" style="height:718px; width:538px" /><img alt="김태희 사진2" src="/upload/7882370d5dc34044a9b8927613a67727.png" style="height:829px; width:700px" /><img alt="태희 사진3" src="/upload/64c1d21e822c451ab1a3095c7697e452.jpg" style="height:989px; width:700px" /></p>\r\n', 56000, 10000, 'f35628f5-821d-4716-8a7a-9f179f99c653', '58/f35628f5-821d-4716-8a7a-9f179f99c653_kth1.png', '심마이크로 에센스(500ml) + 샘플30일\r\n심마이크로 에센스(350ml) + 샘플10일\r\n'),
	(72, 'skincare', '★여름마켓★ 파인드 더 리얼 커버 쿠션', 24000, 'oily', '2023-07-27 21:01:03', '2023-07-27 21:01:03', 100, '1', '<p><img alt="상품 메인" src="/upload/4d22479766e9449d98f7deee24863a5a.png" style="height:635px; width:567px" /><img alt="" src="/upload/798a641640d841ad811b01eab8a26050.png" style="height:571px; width:527px" /><img alt="" src="/upload/afda5ae6411f43d4891d33911bf40bd4.png" style="height:498px; width:506px" /><img alt="" src="/upload/fa2663e15d924c4b8886eb3f4c6377a6.png" style="height:497px; width:506px" /></p>\r\n', 20000, 10000, '66d7b1b4-5439-4376-8bb4-72dc7e01a4dd_pro2.png', '72/66d7b1b4-5439-4376-8bb4-72dc7e01a4dd_pro2.png', '[본품+리필] 1호 퓨어베이지\r\n[본품+리필] 2호 라이트베이지\r\n[본품+리필] 3호 미디엄베이지\r\n'),
	(73, 'eye', '★여름마켓★ 올데이 이지 초슬림 브로우', 8500, 'dry,middle,oily', '2023-07-27 21:04:53', '2023-07-27 21:04:53', 1000, '1', '<p><img alt="" src="/upload/305aad023d94443ab235bce90445ab09.png" style="height:636px; width:567px" /></p>\r\n', 6000, 3000, '52a9718b-4a2e-4625-aca1-199edf5ea33c_pro3.png', '73/52a9718b-4a2e-4625-aca1-199edf5ea33c_pro3.png', '[50%] 토프그레이\r\n[50%] 다크브라운\r\n[50%] 라이트브라운\r\n'),
	(74, 'skincare', '슈퍼바이탈 에센셜 에멀젼 150ml', 45000, 'middle,oily', '2023-07-27 21:07:50', '2023-07-27 21:07:50', 333, '1', '<p><img alt="" src="/upload/adbad2d015664bea94731d4fd69259e3.png" style="height:462px; width:433px" /></p>\r\n', 30000, 22000, '4c530b74-4dc3-480f-9174-f5f0dab0f90a_pro04.png', '74/4c530b74-4dc3-480f-9174-f5f0dab0f90a_pro04.png', '아이오페 슈퍼 에멀전 본품 + 리필\r\n아이오페 슈퍼 에멀전 본품 + 리필 + 증정품 세트\r\n'),
	(75, 'skincare', '하이드로 리프트 소프너 150ML', 38000, 'dry,middle', '2023-07-27 21:09:13', '2023-07-27 21:09:13', 300, '1', '<p><img alt="" src="/upload/e417a38d31da4897ab83420ec4d5a4a4.png" style="height:567px; width:547px" /></p>\r\n', 34000, 12000, 'd9bd9c3b-e7ad-42e5-8499-420289c695d7_p5.png', '75/d9bd9c3b-e7ad-42e5-8499-420289c695d7_p5.png', ''),
	(76, 'skincare', '워터뱅크 블루 히알루로닉 건성피부 에센셜 2스텝 세트 160ml+120ml', 67000, 'dry', '2023-07-27 21:10:51', '2023-07-27 21:10:51', 1000, '1', '<p><img alt="" src="/upload/6557666fb4f14f14b43599b925abb1a7.png" style="height:451px; width:449px" /></p>\r\n', 50250, 34000, '04628c66-d5cd-4c49-bd63-0d9668d504de_p6.png', '76/04628c66-d5cd-4c49-bd63-0d9668d504de_p6.png', '워터뱅크 블루 히알루로닉 건성피부 에센셜 2스텝\r\n워터뱅크 블루 히알루로닉 건성피부 에센셜 3스텝\r\n'),
	(77, 'skincare', '래디언씨 크림 30ml', 40000, 'middle,oily', '2023-07-27 21:14:50', '2023-07-27 21:14:50', 200, '1', '<p><img alt="" src="/upload/884b6c2533eb4dff8e5ee7900097cb7f.png" style="height:428px; width:426px" /></p>\r\n', 32000, 20000, 'a5cf1dcd-72a0-445b-b2d0-f7a812cb596d_p7.png', '77/a5cf1dcd-72a0-445b-b2d0-f7a812cb596d_p7.png', '래디언씨 크림 + 래디언씨 토너 세트\r\n래디언씨 크림 + 래디언씨 에멀전(50ml) 세트\r\n'),
	(78, 'skincare', '로즈워터 토너 250ml', 45000, 'dry,middle,oily', '2023-07-27 21:16:52', '2023-07-27 21:16:52', 3000, '1', '<p><img alt="" src="/upload/0756702ec80b41ebb2ec28bfbf7c88a8.png" style="height:484px; width:493px" /></p>\r\n', 40000, 25000, '8d331455-6791-4c65-83ca-edf2f433e13d_p8.png', '78/8d331455-6791-4c65-83ca-edf2f433e13d_p8.png', '마몽드 로즈워터(300ml)\r\n마몽드 라벤더워터(300ml)'),
	(79, 'base', '[본품] NEW 네오 쿠션_매트 15g', 24000, 'middle', '2023-07-27 21:20:51', '2023-07-27 21:20:51', 200, '1', '<p><img alt="" src="/upload/dd3993eeabd843b2ad9cb06b184bf7aa.png" style="height:515px; width:524px" /></p>\r\n', 18000, 10000, 'cebbcecf-9179-4694-820e-144414dbc368_p9.png', '79/cebbcecf-9179-4694-820e-144414dbc368_p9.png', '[본품] NEW 네오 쿠션_매트 15g\r\n[본품] NEW 네오 쿠션_매트 15g * 2\r\n[본품] NEW 네오 쿠션_촉촉 15g\r\n'),
	(80, 'lip', '[롬앤X산리오캐릭터즈] 글래스팅 워터 글로스', 12000, 'dry,middle,oily', '2023-07-27 21:24:37', '2023-07-27 21:24:37', 1000, '1', '<p><img alt="" src="/upload/f2ee73cb29694a4e861a0fd46476d242.png" style="height:507px; width:509px" /></p>\r\n', 10000, 8900, '753d5ede-fd8b-42c1-b724-1f9782d1b90e_p10.png', '80/753d5ede-fd8b-42c1-b724-1f9782d1b90e_p10.png', '00 메테오트랙(산리호)\r\n01 산호크러쉬(산리오X)\r\n'),
	(81, 'skincare', '[NEW Color 추가] 웨이크메이크 듀이 젤 글레이즈 스틱 11COLOR', 16000, 'dry,middle,oily', '2023-07-27 21:26:43', '2023-07-27 21:26:43', 4, '1', '<p><img alt="" src="/upload/6b1d1b1911914fdb96050375f5306b78.png" style="height:510px; width:506px" /></p>\r\n', 11900, 7000, '93834303-d834-45ab-bc6e-ff151338e766_p11.png', '81/93834303-d834-45ab-bc6e-ff151338e766_p11.png', '01 뮤트퍼센트\r\n02 멜티드핑크\r\n03 쿨리쉬 베리 \r\n04워밍 코랄\r\n'),
	(82, 'skincare', '★여름마켓★ 올데이 롱앤컬 마스카라', 10000, 'dry,middle,oily', '2023-07-27 21:29:31', '2023-07-27 21:29:31', 1000, '1', '<p><img alt="" src="/upload/87018058af034386bd597b692a1d0197.png" style="height:599px; width:566px" /></p>\r\n', 75000, 3000, '6a8ff8f8-0b7d-48f7-b22f-bc4668d179ea_p12.png', '82/6a8ff8f8-0b7d-48f7-b22f-bc4668d179ea_p12.png', '[블랙]\r\n[브라운]\r\n[다크토프]\r\n'),
	(83, 'cheek', '러블리 쿠키 블러셔 4g', 30000, 'dry,middle,oily', '2023-07-27 21:32:21', '2023-07-27 21:32:21', 10, '1', '<p><img alt="" src="/upload/66bc1bda03fc4e53a9f635ffa0fd3d49.png" style="height:448px; width:447px" /></p>\r\n', 23000, 15000, '019aa4b3-4a2f-485f-8db9-4b3620e7a357_p13.png', '83/019aa4b3-4a2f-485f-8db9-4b3620e7a357_p13.png', 'RD301 레드자몽푸딩\r\nPP502 라벤더레본마카롱\r\n'),
	(84, 'lip', '꾸뛰르 립 틴트 샤인 8.5g', 25500, 'dry,middle,oily', '2023-07-27 21:34:17', '2023-07-27 21:34:17', 3, '1', '<p><img alt="" src="/upload/c9da5935071e4760a53848a7da6313e9.png" style="height:590px; width:595px" /></p>\r\n', 20000, 12000, '739301ad-2d82-4fa2-8932-18bc394d284e_14.png', '84/739301ad-2d82-4fa2-8932-18bc394d284e_14.png', '6호 너티\r\n7호 배드\r\n'),
	(85, 'eye', '모노 아이즈 1.5g', 41500, 'dry,middle,oily', '2023-07-27 21:36:42', '2023-07-27 21:36:42', 2400, '1', '<h1><img alt="" src="/upload/91e49cda648a4c2eb2ffd9705d73bb5c.png" style="height:502px; width:518px" /></h1>\r\n', 40000, 24000, '4e5ef4c8-bc97-438e-b86d-0a8b80228ee7_p123.png', '85/4e5ef4c8-bc97-438e-b86d-0a8b80228ee7_p123.png', '쁘띠 블링블링\r\n베리 큐트\r\n글램 샤인\r\n'),
	(86, 'eye', '프레쉬 모이스춰 립앤아이 리무버 300ml', 9600, 'dry,middle', '2023-07-27 21:39:28', '2023-07-27 21:39:28', 200, '1', '<p><img alt="" src="/upload/04bed08fbf4c4ea2a52df7ac9a248ef4.png" style="height:529px; width:513px" /></p>\r\n', 8800, 2400, '804e6525-18ac-4c38-81ca-a4a751767d58_p17.png', '86/804e6525-18ac-4c38-81ca-a4a751767d58_p17.png', '300ml 본품 + 50ml 여행용 파우치[증정]\r\n300ml 본품 + 신제품 아이크림[증정]\r\n'),
	(87, 'skincare', '★여름마켓★ 롱 래스팅 벨벳 광채 쿠션', 35000, 'middle,oily', '2023-07-27 21:45:12', '2023-07-27 21:45:12', 1000, '1', '<p><img alt="" src="/upload/de936d26c0664c44a5c6f51023d99cbe.png" style="height:589px; width:566px" /></p>\r\n', 17500, 10000, '9f6c48e1-3615-4ff8-8846-130e60603be3_ppdf.png', '87/9f6c48e1-3615-4ff8-8846-130e60603be3_ppdf.png', 'N01호 퓨어베이지\r\nN02호 라이트베이지\r\n'),
	(88, 'skincare', 'sum37 시크릿 에센스', 18000, 'dry', '2023-07-27 21:47:44', '2023-07-27 21:47:44', 100, '1', '<p><img alt="" src="/upload/274543527b304873baadd0dc27c6b509.png" style="height:597px; width:601px" /></p>\r\n', 16000, 12000, 'caeab3bd-555d-446c-b6ba-7234bfcd167b_ssdf.png', '88/caeab3bd-555d-446c-b6ba-7234bfcd167b_ssdf.png', '숨 시크릿 에센스 + 에멀전\r\n숨 시크릿 로션 + 토너\r\n'),
	(89, 'eye', '★여름마켓★페어리 쥬얼 아이 글리터', 12000, 'dry,middle,oily', '2023-07-27 21:51:45', '2023-07-27 21:51:45', 30, '1', '<p><img alt="" src="/upload/881ad3618ad846b38fc6802b2cd7b5c8.png" style="height:603px; width:571px" /></p>\r\n', 6000, 4000, '12c75981-e408-4a03-927e-e64e6e97d185_23.png', '89/12c75981-e408-4a03-927e-e64e6e97d185_23.png', '블링 주얼리\r\n멋쟁이 숙녀\r\n화사한 오펄\r\n'),
	(90, 'eye', '비 마이 퍼펙트 팔레트 미니', 25000, 'dry,middle,oily', '2023-07-27 21:54:52', '2023-07-27 21:54:52', 332, '1', '<p><img alt="" src="/upload/4a2c171d5b8240cbabf6e9c63817f065.png" style="height:567px; width:571px" /></p>\r\n', 12500, 6000, '0ccea58a-91f6-4db9-b910-c3cc0030da4d_p255.png', '90/0ccea58a-91f6-4db9-b910-c3cc0030da4d_p255.png', '01# 초코바닐라 스플릿\r\n02# 스트로베리 코튼 캔디\r\n03# 소프트 피치 소르베\r\n'),
	(91, 'lip', '헤라 루즈 홀릭 3g', 9500, 'dry,middle,oily', '2023-07-27 22:00:01', '2023-07-27 22:00:01', 25, '1', '<p><img alt="" src="/upload/ae9da49b729e4d4fa7e66badebcabbae.png" style="height:505px; width:490px" /></p>\r\n', 8800, 2400, '9d12dda5-a238-407e-a569-56546e0524c0_sd.png', '91/9d12dda5-a238-407e-a569-56546e0524c0_sd.png', '체리쥬빌레\r\n쁘띠프랑스\r\n큐트걸\r\n');
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;

-- 테이블 shop.goodsImage 구조 내보내기
CREATE TABLE IF NOT EXISTS `goodsImage` (
  `image_no` int NOT NULL AUTO_INCREMENT,
  `goods_no` int NOT NULL,
  `imagepath` varchar(150) NOT NULL,
  `uuid` varchar(100) NOT NULL,
  `ifmain` enum('1','2','3') DEFAULT NULL,
  PRIMARY KEY (`image_no`) USING BTREE,
  KEY `FK_GOODS_NO2` (`goods_no`),
  CONSTRAINT `FK_GOODS_NO2` FOREIGN KEY (`goods_no`) REFERENCES `goods` (`goods_no`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='상품 이미지';

-- 테이블 데이터 shop.goodsImage:~26 rows (대략적) 내보내기
DELETE FROM `goodsImage`;
/*!40000 ALTER TABLE `goodsImage` DISABLE KEYS */;
INSERT INTO `goodsImage` (`image_no`, `goods_no`, `imagepath`, `uuid`, `ifmain`) VALUES
	(60, 58, '58/36a5a453-ab47-49a2-967a-6fd8053b550c_product1.png', '36a5a453-ab47-49a2-967a-6fd8053b550c', NULL),
	(61, 58, '58/215661eb-b070-4be7-a688-d58c2d766a3c_product2.png', '215661eb-b070-4be7-a688-d58c2d766a3c', NULL),
	(62, 58, '58/545b6ed5-3fb6-4f3e-8e93-07a3dd17ca39_product3.png', '545b6ed5-3fb6-4f3e-8e93-07a3dd17ca39', NULL),
	(63, 58, '58/b108f5f0-fccc-4181-9c96-4a31cff1b646_product4.png', 'b108f5f0-fccc-4181-9c96-4a31cff1b646', NULL),
	(64, 58, '58/95f786db-c7c7-4793-a432-dfc68510035a_product5.png', '95f786db-c7c7-4793-a432-dfc68510035a', NULL),
	(65, 58, '58/8b0198ec-adc3-4041-abed-597d1ec4499c_product6.png', '8b0198ec-adc3-4041-abed-597d1ec4499c', NULL),
	(66, 58, '58/825d2270-5b89-4b9e-856e-0615a8cba49a_product7.png', '825d2270-5b89-4b9e-856e-0615a8cba49a', NULL),
	(74, 72, '72/a5b7bb30-62c3-4814-8fe4-0b8fae0e6bf3_pro2-4.png', 'a5b7bb30-62c3-4814-8fe4-0b8fae0e6bf3', NULL),
	(75, 73, '73/f1fcbd86-5707-404a-9ecb-5a1179aa1591_', 'f1fcbd86-5707-404a-9ecb-5a1179aa1591', NULL),
	(76, 74, '74/91159afb-439a-4e12-9299-6846a3715151_', '91159afb-439a-4e12-9299-6846a3715151', NULL),
	(77, 75, '75/ed386145-2af2-465f-8a5d-8032ef0c2aa3_', 'ed386145-2af2-465f-8a5d-8032ef0c2aa3', NULL),
	(78, 76, '76/e01e4b45-a0fd-4529-9e09-fb535f0cca59_', 'e01e4b45-a0fd-4529-9e09-fb535f0cca59', NULL),
	(79, 77, '77/f3f32b90-383b-44ad-aab4-22b64bdfe99c_', 'f3f32b90-383b-44ad-aab4-22b64bdfe99c', NULL),
	(80, 78, '78/9d3b816c-84b5-4b4f-af1d-16be665b3c02_', '9d3b816c-84b5-4b4f-af1d-16be665b3c02', NULL),
	(81, 79, '79/246922a6-016e-4f67-8472-649c5c4a741d_', '246922a6-016e-4f67-8472-649c5c4a741d', NULL),
	(82, 80, '80/70607166-011a-4d0e-ada2-7f937f683d3a_', '70607166-011a-4d0e-ada2-7f937f683d3a', NULL),
	(83, 81, '81/a8f38c99-786f-4f5c-90c9-f634e4dc2004_', 'a8f38c99-786f-4f5c-90c9-f634e4dc2004', NULL),
	(84, 82, '82/33b0c609-0fe2-43e3-801a-b7d94855ff26_', '33b0c609-0fe2-43e3-801a-b7d94855ff26', NULL),
	(85, 83, '83/10d75d6e-afaa-4f51-b662-57319f674128_', '10d75d6e-afaa-4f51-b662-57319f674128', NULL),
	(86, 84, '84/56d2c548-1ae8-473d-8284-5d4814746882_', '56d2c548-1ae8-473d-8284-5d4814746882', NULL),
	(87, 85, '85/67a63f0f-9960-4890-8642-cddabf2493b6_', '67a63f0f-9960-4890-8642-cddabf2493b6', NULL),
	(88, 86, '86/f57549cf-453b-4bc3-9f05-e9ade3e7b8b8_', 'f57549cf-453b-4bc3-9f05-e9ade3e7b8b8', NULL),
	(89, 87, '87/f0db93f7-0216-4746-b6d3-22ce08588c4f_', 'f0db93f7-0216-4746-b6d3-22ce08588c4f', NULL),
	(90, 88, '88/24d65dbb-478d-45f9-a878-329ee8339a0b_', '24d65dbb-478d-45f9-a878-329ee8339a0b', NULL),
	(91, 89, '89/331a915e-7754-4eca-a12d-78a829db9b9d_', '331a915e-7754-4eca-a12d-78a829db9b9d', NULL),
	(92, 90, '90/36f50e72-38ac-4a25-a33c-1fbc595461a0_', '36f50e72-38ac-4a25-a33c-1fbc595461a0', NULL),
	(93, 91, '91/f8b01eb5-76f7-42f1-ac81-8a96d91a15c2_', 'f8b01eb5-76f7-42f1-ac81-8a96d91a15c2', NULL);
/*!40000 ALTER TABLE `goodsImage` ENABLE KEYS */;

-- 테이블 shop.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `mem_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(100) NOT NULL,
  `pwd` varchar(300) NOT NULL,
  `pnum` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `userAddr` varchar(300) NOT NULL,
  `userDaddr` varchar(200) NOT NULL,
  `grade` int NOT NULL DEFAULT '2' COMMENT '1:관리자 2~4:일반회원 2:새싹회원, 3:실버회원, 4:골드회원',
  `regidate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('1','2','3','4') NOT NULL DEFAULT '1' COMMENT '1:정상 2:휴면 3:잠금 4:탈퇴',
  PRIMARY KEY (`mem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 shop.member:~3 rows (대략적) 내보내기
DELETE FROM `member`;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` (`mem_id`, `name`, `pwd`, `pnum`, `email`, `userAddr`, `userDaddr`, `grade`, `regidate`, `updatedate`, `status`) VALUES
	('admin', '관리자', '312433c28349f63c4f387953ff337046e794bea0f9b9ebfcb08e90046ded9c76', '01034563456', 'admin@admin.com', '서울 강동구 가래여울길 71 (고덕동)', '513-206', 2, '2023-07-24 00:03:12', '2023-07-24 00:03:12', '1'),
	('jh123', 'jh', '6a49581eb57172ed76b52bf2131ecb05fe31b393026cdf09fb5d92c5096d7cd5', '', '', '', '', 2, '2023-07-27 06:56:36', '2023-07-27 06:56:36', '1'),
	('test00', '자바무새', '312433c28349f63c4f387953ff337046e794bea0f9b9ebfcb08e90046ded9c76', '01011111111', 'parrot@naver.om', '경기 안산시 단원구 예술대학로 61 (고잔동, 주공5단지상가)', '513-206', 2, '2023-07-21 00:14:15', '2023-07-21 00:14:15', '1'),
	('test123', '홍길동', '99d4335759ab8f7e708ca3922e1171aeadc95b3367e1e3442104f6e2949379cd', '', '', '', '', 2, '2023-07-22 11:06:12', '2023-07-22 11:06:12', '1');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;

select * from member;

-- 테이블 shop.menu 구조 내보내기
CREATE TABLE IF NOT EXISTS `menu` (
  `menu_cd` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `menu_name` varchar(10) DEFAULT NULL,
  `menu_url` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`menu_cd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 shop.menu:~4 rows (대략적) 내보내기
DELETE FROM `menu`;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` (`menu_cd`, `menu_name`, `menu_url`) VALUES
	('01', 'Home', '/home'),
	('02', 'Shop', '/showlist'),
	('03', 'Features', '/cart/view'),
	('05', 'About', '/about');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;

-- 테이블 shop.orderlist 구조 내보내기
CREATE TABLE IF NOT EXISTS `orderlist` (
  `orderlist_no` int NOT NULL AUTO_INCREMENT,
  `mem_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `totprice` int NOT NULL,
  `regidate` datetime DEFAULT CURRENT_TIMESTAMP,
  `dstatus` enum('1','2','3','4') NOT NULL DEFAULT '1' COMMENT '1:배송준비중 2:출고완료 3:배송중 4:배송완료',
  `waybill_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '송장 번호',
  `parcel_cd` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '택배사 코드_ji add',
  PRIMARY KEY (`orderlist_no`) USING BTREE,
  KEY `FK_MEM_ID3` (`mem_id`),
  CONSTRAINT `FK_MEM_ID3` FOREIGN KEY (`mem_id`) REFERENCES `member` (`mem_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 shop.orderlist:~23 rows (대략적) 내보내기
DELETE FROM `orderlist`;
/*!40000 ALTER TABLE `orderlist` DISABLE KEYS */;
INSERT INTO `orderlist` (`orderlist_no`, `mem_id`, `totprice`, `regidate`, `dstatus`, `waybill_num`, `parcel_cd`) VALUES
	(4, 'test123', 5616, '2023-07-22 16:12:33', '1', NULL, NULL),
	(5, 'test123', 3500, '2023-07-22 16:12:54', '1', NULL, NULL),
	(6, 'test123', 5616, '2023-07-22 16:15:41', '1', NULL, NULL),
	(7, 'test123', 5616, '2023-07-22 16:17:55', '1', NULL, NULL),
	(8, 'test123', 5616, '2023-07-22 16:19:55', '1', NULL, NULL),
	(9, 'test123', 3500, '2023-07-22 16:21:14', '1', NULL, NULL),
	(10, 'test123', 5616, '2023-07-22 16:24:18', '1', NULL, NULL),
	(11, 'test123', 3500, '2023-07-24 04:12:40', '1', NULL, NULL),
	(12, 'admin', 3500, '2023-07-24 04:13:07', '4', '576110328685', '04'),
	(13, 'admin', 3500, '2023-07-24 09:38:40', '1', NULL, NULL),
	(14, 'admin', 3500, '2023-07-24 09:38:42', '1', NULL, NULL),
	(15, 'admin', 3500, '2023-07-24 09:38:45', '1', NULL, NULL),
	(16, 'admin', 3500, '2023-07-24 09:38:48', '1', NULL, NULL),
	(17, 'admin', 3500, '2023-07-24 09:38:48', '1', NULL, NULL),
	(18, 'test00', 318500, '2023-07-26 16:16:38', '1', NULL, NULL),
	(19, 'test00', 318500, '2023-07-26 16:16:48', '1', NULL, NULL),
	(20, 'test00', 822500, '2023-07-27 07:05:12', '1', NULL, NULL),
	(21, 'test00', 3500, '2023-07-27 09:26:24', '1', NULL, NULL),
	(22, 'test00', 66500, '2023-07-27 09:29:29', '1', NULL, NULL),
	(23, 'admin', 13000, '2023-07-28 00:54:21', '1', NULL, NULL),
	(24, 'admin', 13000, '2023-07-28 00:56:58', '1', NULL, NULL),
	(25, 'admin', 13000, '2023-07-28 00:59:21', '1', NULL, NULL),
	(26, 'admin', 13000, '2023-07-28 00:59:56', '1', NULL, NULL),
	(27, 'admin', 13000, '2023-07-28 01:02:58', '1', NULL, NULL),
	(28, 'admin', 13000, '2023-07-28 01:03:31', '1', NULL, NULL);
/*!40000 ALTER TABLE `orderlist` ENABLE KEYS */;

-- 테이블 shop.order_address 구조 내보내기
CREATE TABLE IF NOT EXISTS `order_address` (
  `address_no` int NOT NULL AUTO_INCREMENT,
  `order_no` int NOT NULL,
  `name` varchar(10) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `addr1` text NOT NULL,
  `addr2` text NOT NULL,
  `memo` text,
  `registered` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`address_no`),
  KEY `FK_ORDER_NO` (`order_no`),
  CONSTRAINT `FK_ORDER_NO` FOREIGN KEY (`order_no`) REFERENCES `orderlist` (`orderlist_no`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='배송주소';

-- 테이블 데이터 shop.order_address:~23 rows (대략적) 내보내기
DELETE FROM `order_address`;
/*!40000 ALTER TABLE `order_address` DISABLE KEYS */;
INSERT INTO `order_address` (`address_no`, `order_no`, `name`, `phone`, `addr1`, `addr2`, `memo`, `registered`) VALUES
	(4, 4, '홍길동', '01011112222', '경기 성남시 분당구 서판교로 32', 'ㄻㄻ', 'ㄻㄴㄻ', '2023-07-22 16:12:33'),
	(5, 5, '홍길동', '01011112222', '경기 성남시 분당구 서판교로 32', 'ㄻㄻ', 'ㄻㄴㄻ', '2023-07-22 16:12:54'),
	(6, 6, 'fasf', 'fasf', '경기 가평군 청평면 북한강로 2020', 'fsa', 'fsaf', '2023-07-22 16:15:41'),
	(7, 7, 'fafsaf', 'asfa', '서울 종로구 세검정로7가길 16', 'fasf', 'fasf', '2023-07-22 16:17:55'),
	(8, 8, '홍길동', '0101112222', '경기 성남시 분당구 대왕판교로 477', '테스트', 'ㅁㅁ', '2023-07-22 16:19:55'),
	(9, 9, '홍길동', '0101112222', '경기 성남시 분당구 대왕판교로 477', '테스트', 'ㅁㅁ', '2023-07-22 16:21:14'),
	(10, 10, '홍길동', '01011112222', '서울 강남구 압구정로79길 6', '테스트', '가나다', '2023-07-22 16:24:18'),
	(11, 11, '테스트 이름', '01011112222', '대전 동구 판교1길 3', '123', '123', '2023-07-24 04:12:40'),
	(12, 12, '테스트 이름', '01011112222', '경기 성남시 분당구 대왕판교로606번길 45', '123', '123', '2023-07-24 04:13:07'),
	(13, 13, 'test', '0152475922', '경기 안산시 단원구 시화벤처로 705', 'test', 'ㅅㄷ', '2023-07-24 09:38:40'),
	(14, 14, 'test', '0152475922', '경기 안산시 단원구 시화벤처로 705', 'test', 'ㅅㄷ', '2023-07-24 09:38:42'),
	(15, 15, 'test', '0152475922', '경기 안산시 단원구 시화벤처로 705', 'test', 'ㅅㄷ', '2023-07-24 09:38:45'),
	(16, 16, 'test', '0152475922', '경기 안산시 단원구 시화벤처로 705', 'test', 'ㅅㄷ', '2023-07-24 09:38:48'),
	(17, 17, 'test', '0152475922', '경기 안산시 단원구 시화벤처로 705', 'test', 'ㅅㄷ', '2023-07-24 09:38:48'),
	(18, 18, 'wjww', 'ww', '경기 안산시 단원구 갈마지길 5-2', 'ㅇㄹㄴㅇㄹ', 'ㄴㅇㄹㄴ', '2023-07-26 16:16:38'),
	(19, 19, 'wjww', 'ww', '경기 안산시 단원구 갈마지길 5-2', 'ㅇㄹㄴㅇㄹ', 'ㄴㅇㄹㄴ', '2023-07-26 16:16:48'),
	(20, 20, 'sss', '01076272879', '경기 성남시 분당구 판교역로 4', '거북섬', 'ㄴㅇㄹ', '2023-07-27 07:05:12'),
	(21, 21, '정재은', '01076272879', '경기 성남시 분당구 판교역로 166', '거북섬', 'sdf', '2023-07-27 09:26:24'),
	(22, 22, 'fdfg', 'sdfsdf', '경기 성남시 분당구 판교역로 166', '거북섬', 'sdf', '2023-07-27 09:29:29'),
	(23, 23, 'test', '123', '경기 성남시 분당구 판교역로 166', 'test', 'test', '2023-07-28 00:54:21'),
	(24, 24, 'test', '01011111111', '경기 성남시 분당구 판교역로 166', 'test', 'test', '2023-07-28 00:56:58'),
	(25, 25, 'test', '01011111111', '경기 성남시 분당구 판교역로 166', 'test', 'test', '2023-07-28 00:59:21'),
	(26, 26, 'test', '01011111111', '경기 성남시 분당구 판교역로 166', 'test', 'test', '2023-07-28 00:59:56'),
	(27, 27, 'test', '01011111111', '경기 성남시 분당구 판교역로 166', 'test', 'test', '2023-07-28 01:02:58'),
	(28, 28, 'test', '01011111111', '경기 성남시 분당구 판교역로 166', 'test', 'test', '2023-07-28 01:03:31');
/*!40000 ALTER TABLE `order_address` ENABLE KEYS */;

-- 테이블 shop.order_payment 구조 내보내기
CREATE TABLE IF NOT EXISTS `order_payment` (
  `payment_no` int NOT NULL AUTO_INCREMENT,
  `order_no` int NOT NULL,
  `pay_type` tinyint NOT NULL DEFAULT '1' COMMENT 'pay_type. 1: 주문결제, 2: 주문취소',
  `imp_uid` varchar(45) NOT NULL COMMENT 'imp_uid',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT 'status. 1: 확인 대기, 2: 검증 완료, 3: 위조 혹은 변조 발생하여 강제취소',
  `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'reg_date',
  PRIMARY KEY (`payment_no`),
  KEY `FK_ORDER_NO2` (`order_no`),
  CONSTRAINT `FK_ORDER_NO2` FOREIGN KEY (`order_no`) REFERENCES `orderlist` (`orderlist_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 shop.order_payment:~0 rows (대략적) 내보내기
DELETE FROM `order_payment`;
/*!40000 ALTER TABLE `order_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_payment` ENABLE KEYS */;

-- 테이블 shop.review 구조 내보내기
CREATE TABLE IF NOT EXISTS `review` (
  `review_no` int NOT NULL AUTO_INCREMENT,
  `mem_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'member id 컬럼 fk',
  `goods_no` int NOT NULL,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `content` varchar(4000) NOT NULL,
  `score` int NOT NULL,
  `regidate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_no`) USING BTREE,
  KEY `FK_MEM_ID5` (`mem_id`),
  KEY `FK_GOODS_NO4` (`goods_no`),
  CONSTRAINT `FK_GOODS_NO4` FOREIGN KEY (`goods_no`) REFERENCES `goods` (`goods_no`),
  CONSTRAINT `FK_MEM_ID5` FOREIGN KEY (`mem_id`) REFERENCES `member` (`mem_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 shop.review:~0 rows (대략적) 내보내기
DELETE FROM `review`;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;

-- 테이블 shop.wish 구조 내보내기
CREATE TABLE IF NOT EXISTS `wish` (
  `mem_id` varchar(100) NOT NULL,
  `goods_no` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 shop.wish:~0 rows (대략적) 내보내기
DELETE FROM `wish`;
/*!40000 ALTER TABLE `wish` DISABLE KEYS */;
INSERT INTO `wish` (`mem_id`, `goods_no`) VALUES
	('test00', 58),
	('anonymousUser', 58),
	('anonymousUser', 58),
	('anonymousUser', 58),
	('anonymousUser', 58),
	('anonymousUser', 58),
	('anonymousUser', 58),
	('anonymousUser', 58),
	('anonymousUser', 58),
	('admin', 58),
	('anonymousUser', 86),
	('test00', 85);
/*!40000 ALTER TABLE `wish` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
