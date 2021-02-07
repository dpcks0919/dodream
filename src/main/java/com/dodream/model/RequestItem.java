package com.dodream.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class RequestItem {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name ="requestId")
	private Request request;
	
	@Column(nullable = false)
	private String itemName;
	
	@Column(nullable = false)
	private int itemNum;
	
	@Column(nullable = false)
	private int receivedNum;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private RequestType requestType;
}
