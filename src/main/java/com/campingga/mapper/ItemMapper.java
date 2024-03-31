package com.campingga.mapper;

import java.util.List;

import com.campingga.domain.Criteria;
import com.campingga.domain.ItemVO;

public interface ItemMapper {

	List<ItemVO> selectList();

	List<ItemVO> selectListWithPaging(Criteria cri);

	int selectTotalCount();

}
