package com.pet.app.entity;

import java.util.List;

/**
 * 分页数据封装类
 */
public class PageBean<T> {
    private int page;       // 当前页码
    private int size;       // 每页条数
    private int total;      // 总记录数
    private int totalPages; // 总页数
    private List<T> list;   // 当前页数据

    public PageBean(int page, int size, int total, List<T> list) {
        this.page = page;
        this.size = size;
        this.total = total;
        this.totalPages = (int) Math.ceil((double) total / size);
        this.list = list;
    }

    public int getPage() { return page; }
    public int getSize() { return size; }
    public int getTotal() { return total; }
    public int getTotalPages() { return totalPages; }
    public List<T> getList() { return list; }
}
