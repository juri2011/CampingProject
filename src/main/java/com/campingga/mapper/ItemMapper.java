package com.campingga.mapper;

import java.util.List;

import com.campingga.domain.Criteria;
import com.campingga.domain.ItemVO;
import com.campingga.domain.PagingVO;

public interface ItemMapper {

    public List<ItemVO> selectList();

    public List<ItemVO> selectListWithPaging(Criteria cri);

    public int selectTotalCount(Criteria cri);

    public ItemVO selectOneItem(int item_no);

    public List<ItemVO> selectNewItems();

    public List<ItemVO> selectItem(PagingVO vo);

    public int countItem();

    public int itemUpdate(ItemVO vo);

    public int deleteItem(int item_no);


}
