package com.dodream.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
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
public class News{

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne  //Many = board, User = One
	@JoinColumn(name = "userId")
	private User user;
	
	@Column(nullable = false, length= 100)
	private String title;
	
	@Lob // 대용량 데이터.
	private String content;
	
	@Column(columnDefinition = "int default 0")
	private int count;
	
	@CreationTimestamp
	private Timestamp regDate;
	
	@UpdateTimestamp 
	private Timestamp updateDate; // update 시 시간 자동 저장
}