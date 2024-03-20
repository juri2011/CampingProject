package com.campingga.dto.res;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Getter
@Builder
@ToString 
public class PaymentItem {
	int totalPrice;
	int orderNo;
}
