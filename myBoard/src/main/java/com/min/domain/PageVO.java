package com.min.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@ToString
public class PageVO {

	private int total;
	
	private int start;
	private int last;
	
	private boolean prev;
	private boolean next;
	
	private Search search;
	
	public PageVO(Search search, int total) {
		this.search = search;
		this.total = total;
		
		this.last = (int)(Math.ceil(search.getPageNum() / 5.0)) *5;
		
		this.start = this.last - 4;
		
		int realLast = (int)(Math.ceil(total*1.0)/ search.getAmount());
		
		if(realLast < this.last) {
			this.last = realLast;
		}
		
		this.prev = this.start > 1;
		this.next = this.last < realLast;
	}
}

