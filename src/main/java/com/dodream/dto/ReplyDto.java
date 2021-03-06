package com.dodream.dto;

import com.dodream.model.Reply;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReplyDto {
	Reply reply;
	ReplyItemDto[] replyItems;
}
