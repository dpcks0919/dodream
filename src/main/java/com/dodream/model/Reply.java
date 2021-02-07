package com.dodream.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Reply {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "userId")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="requestId")
	private Request request;

	@ManyToOne
	@JoinColumn(name =" replyUserId")
	private User replyUser;
	
	@Column(nullable = false)
	private String replyOrg;
	
	@Column(nullable = false)
	private String replyPhone;
	
	@Column(nullable = false)
	private String replyContent;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private StatusType status;
	
	private String comment;

	@CreationTimestamp 
	private Timestamp regDate; // insert 시 시간 자동 저장 
	
	@UpdateTimestamp 
	private Timestamp updateDate; // update 시 시간 자동 저장
}
