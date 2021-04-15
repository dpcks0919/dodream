package com.dodream.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.dodream.listener.RequestItemListener;
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
@EntityListeners(RequestItemListener.class)	// ReqeustItem 리스너
public class RequestItem {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name ="requestId")
	@JsonBackReference	//본질적인 루프참조 해결방법 
	private Request request;
	
	@Column(nullable = false)
	private String itemName;
	
	@Column(nullable = false)
	private int itemNum;
	
	@Column(columnDefinition = "int default 0")
	private int receivedNum;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private RequestType requestType;
}
