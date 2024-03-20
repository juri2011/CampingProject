package com.campingga.dto.res;

import java.util.List;

import lombok.Data;

@Data
public class CartPutitem {

	List<Integer> list;
	
	int totalCount;
}
