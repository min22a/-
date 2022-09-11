package com.min.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageVO {

	private List<ReplyVO> list;
	private int replyCnt;
}
