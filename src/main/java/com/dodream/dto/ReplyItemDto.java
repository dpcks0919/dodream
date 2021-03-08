package com.dodream.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReplyItemDto {
	int id;
	String itemName;
	String itemNum;
	String receivedNum;
	String requestType;
	String replyNum;
}
