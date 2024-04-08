package com.campingga.domain;

import lombok.Data;

@Data
public class PagingVO {

    private int nowPage;
    private int startPage;
    private int endPage;
    private int total;
    private int cntPerPage;
    private int lastPage;
    private int start;
    private int end;
    private int cntPage = 5;

    public PagingVO() {
    }

    public PagingVO(int total, int nowPage, int cntPerPage) {
        setNowPage(nowPage);
        setCntPerPage(cntPerPage);
        setTotal(total);
        calcLastPage(getTotal(), getCntPerPage());
        calcStartEndPage(getNowPage(), cntPage);
        calcStartEnd(getNowPage(), getCntPerPage());
    }

    public void calcLastPage(int total, int cntPerPage) {
        setLastPage((int) Math.ceil((double) total / (double) cntPerPage));
    }

    public void calcStartEndPage(int nowPage, int cntPage) {
        setEndPage(((int) Math.ceil((double) nowPage / (double) cntPage)) * cntPage);
        if (getLastPage() < getEndPage()) {
            setEndPage(getLastPage());
        }
        setStartPage(getEndPage() - cntPage + 1);
        if (getStartPage() < 1) {
            setStartPage(1);
        }
    }

    public void calcStartEnd(int nowPage, int cntPerPage) {
        setStart((nowPage - 1) * cntPerPage);
        setEnd(getStart() + cntPerPage - 1);
    }
}