package com.campingga.mapper;

import java.util.List;

import com.campingga.domain.Criteria;
import com.campingga.domain.ItemVO;

public interface ItemMapper {

	public List<ItemVO> selectList();

	public List<ItemVO> selectListWithPaging(Criteria cri);

	public int selectTotalCount(Criteria cri);

	public ItemVO selectOneItem(int item_no);

}
