package com.dodream.model;

import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@DynamicInsert
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class User {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(nullable = false, unique = true)
	private String loginId;
	
	@Column(nullable = false)
	private String loginPassword;
	
	@Column(nullable = false)
	private String userName;
	
	private int userSex;
	
	private Date userDob;
	
	@Column(nullable = false)
	private String userPhone;
	
	@Column(nullable = false)
	private String userEmail;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private RoleType userType;
	
	private String orgName;
	
	private String orgPhone;
	
	private String orgUserRole;
	
	@Column(nullable = false)
	private String address;
	
	@Column(nullable = false)
	private double latitude;
	
	@Column(nullable = false)
	private double longitude;
	
	@Column(columnDefinition = "int default 0")
	private int showFlag;
	
	@Column(nullable = false)
	private int msgFlag;
	
	@Column(nullable = false)
	private int emailFlag;
		
	@Column(columnDefinition = "int default 0")
	private int loginCount;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private StatusType stateFlag;
	
//	private Timestamp lastLogin;
	
	@CreationTimestamp 
	private Timestamp regDate; // insert 시 시간 자동 저장 
	
	@UpdateTimestamp 
	private Timestamp updateDate; // update 시 시간 자동 저장
}
