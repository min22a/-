package com.min.domain;



import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@ToString
@Getter
public class Search {

	private int pageNum = 1;
	private int amount = 10;
	
	private int skip;
	
	private String sort;
	
	public Search(int pageNum, int amount) {
		this.pageNum=pageNum;
		
		this.amount=amount;
	
	}
	public Search() {
		this(1,10);
		
	}
	//검색 조건
	private String type;
	private String keyword;
	
	public int getskip() {
		return (pageNum - 1) * 10;
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
}
