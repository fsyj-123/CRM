package com.fsyj.crm.vo;

import java.util.List;

public class PageNavigate<T> {
    Integer total;
    List<T> pageList;

    public PageNavigate() {
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<T> getPageList() {
        return pageList;
    }

    public void setPageList(List<T> pageList) {
        this.pageList = pageList;
    }
}
