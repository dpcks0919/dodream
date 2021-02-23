package com.dodream.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonBackReference;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class ReplyItem {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name = "replyId")
	@JsonBackReference
	private Reply reply;
	
	@OneToOne
	@JoinColumn(name = "requestItemId")
	private RequestItem requestItem;
	
	@Column(nullable = false)
	private int replyNum;
}
