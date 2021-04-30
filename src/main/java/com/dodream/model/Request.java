package com.dodream.model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.dodream.listener.RequestItemListener;
import com.dodream.listener.RequestListener;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@EntityListeners(RequestListener.class)	// Reqeust 리스너
public class Request {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name = "userId")
	private User user;
	
	@Column(nullable = false)
	private String title;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private ClientType clientType;
	
	@Column(nullable = false)
	private String requestAddress;
	
	@Column(nullable = false)
	private double latitude;
	
	@Column(nullable = false)
	private double longitude;
	
	@Column(nullable = false)
	private int urgentLevel;
	
	@Lob
	@Column(nullable = false)
	private String description;
	
	@Column(nullable = false)
	private int showFlag;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private StatusType status;
	
	private String comment;

	//@JsonIgnoreProperties({"request"})
	@OneToMany(mappedBy = "request")
	@JsonManagedReference //본질적인 루프참조 해결방법 
	private List<RequestItem> requestItem;
	
	@CreationTimestamp 
	private Timestamp regDate;
	
	@UpdateTimestamp
	private Timestamp updateDate;
	
	private Date dueDate;
	
	@Column(columnDefinition = "int default 0")
	private int deleteFlag;
}
