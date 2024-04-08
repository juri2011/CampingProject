package com.campingga.domain;
import lombok.*;

//결제
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BillVO {
	//private String item_img; //상품 이미지 경로
	//private String iname; //상품 이름
	private Long bill_no;
	private int item_no; //상품 번호
	private String mem_id;
	private int amount; //구매 수량
	private int valid; //결제 정보(실제로 쓰일 지 잘 모르겠음)
	private Integer cart_no; //구매 완료시 삭제할 장바구니 번호(바로구매의 경우 안 쓰일 수 있음)
	private String item_name;
	private int price; //상품 가격
	//private Date regdate; //등록일
	private String status; //상태(1: 결제완료, 2: 배송준비, 3: 배송중, 4: 배송완료)
}
