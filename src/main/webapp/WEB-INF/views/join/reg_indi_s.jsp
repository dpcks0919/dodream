<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header_join.jsp" %>    


<style>
body {
	background-color: rgb(175, 218, 231);
}
</style>
</head>

<body id="page-top">
	<!-- Navigation-->
	<div id="menu-back" onclick="closeNav()"></div>
	<%@include file="../layout/sidebar_front.jsp"%>

	<div id="Wrapper">
		<%@include file="../layout/navbar_join.jsp"%>

		<section class="page-section text-white text-center" id="contact">
			<div class="container d-flex flex-column">
				<div class="flex-center">
					<div class="input-column">
						<div class="input-info">
							<h4>개인회원가입</h4>
							<p>
								회원가입 하시면, 주변 이웃들의 필요가 나타날 때마다<br>알림을 받으실 수 있습니다!
							</p>
						</div>
						<div class="input-card">
							<div style="text-align: left;">
                                <form method="post" name="regForm" action="">
									<input type="hidden" id="type" value="INDIVIDUAL">
									<div class="divider-custom" style="margin-top: 0;">
										<div class="divider-custom-line"></div>
										<div style="color: #e95378;">
											<h4>추가정보</h4>
										</div>
										<div class="divider-custom-line"></div>
									</div>
									<div class="input-content">
                                        <span class="input-title">성별</span><span>&nbsp;<em>*</em></span><br>
                                        <div class="flex-center"style="margin-top:0.5rem;">
                                            <div class="select-sex selected" id="maleuser" onclick="selectSex(this)">남자</div>
                                            <div style="width:2%;"></div>
                                            <div class="select-sex" id="femaleuser" onclick="selectSex(this)">여자</div>
                                        </div>
                                        <input id="input_sex" type="text" name="input_sex" value="male" style="display:none;">
                                    </div>
                                    <div class="input-content">
                                        <span class="input-title">생년월일</span><span>&nbsp;<em>*</em></span><br>
                                        <div class="flex-center" style="margin-top:0.5rem;">
                                        	<select class="select-date" id="selectyear"><option>2021</option></select>
                                            <input class="input-date" type="hidden" name="birthyear" id="birthyear">
                                            <div style="width:0.5%;"></div>
                                            <select class="select-date" id="selectmonth"><option>02</option></select>
                                            <input class="input-date" type="hidden" name="birthmonth" id="birthmonth" placeholder="01">
                                            <div style="width:0.5%;"></div>
                                            <select class="select-date" id="selectdate"><option>09</option></select>
                                            <input class="input-date" type="hidden" name="birthdate" id="birthdate" placeholder="19">
                                        </div>
                                    </div>
									<div class="input-content">
										<span class="input-title">이메일주소</span><span>&nbsp;<em>*</em></span><br>
										<input class="text-input" type="text" name="usermail" placeholder="이메일주소 입력" id="useremail"> <span class="extra-info">주변 이웃들의 필요를 메일로 받으실 수 있습니다. 
										<br>메일 수신 동의&nbsp;&nbsp;
											<span> 
												<label><input type="radio" name="mail_rcv" value="1" id="mail_rcv" checked> 예</label>&nbsp;&nbsp; 
												<label><input type="radio" name="mail_rcv" value="0" id="mail_rcv"> 아니요</label>
											</span>
										</span>
									</div>
									<div class="input-content">
                                        <span class="input-title">전화번호</span><span>&nbsp;<em>*</em></span><br>
                                        <div class="flex-center">
                                            <div style="width:calc(100% - 50px);">
                                                <input class="text-input" type="text" name="userphone" id="userphone" placeholder="전화번호 입력">                               
                                            </div>
                                            <div class="input-check" id="btn-send-text" style="width:50px;">인증</div>                                          
                                        </div>
                                        <div style="height:5px;"></div>
                                        <div class="flex-center">
                                            <div style="width:calc(100% - 50px);">                                                
                                               	<input class="text-input" type="text" name="verify-input" id="verify-input" placeholder="코드입력(30초)">
                                            </div>
                                            <div class="input-check" id="btn-code-verify" style="width:50px;">확인</div>
                                        </div>
                                        <span class="extra-info">
                                       		 주변 이웃들의 필요를 문자로 받으실 수 있습니다.
                                        	<br>SMS 수신 동의&nbsp;&nbsp;
                                        <span>
                                            <label><input type="radio" name="sms_rcv" value="1" id="sms_rcv" checked> 예</label>&nbsp;&nbsp;
                                            <label><input type="radio" name="sms_rcv" value="0" id="sms_rcv" > 아니요</label>
                                        </span></span>
                                    </div>
									<div class="input-content">
                                    	<span class="input-title">도로명주소</span><span>&nbsp;<em>*</em></span><br>
	                                    <div class="flex-center">
	                                    	<div style="width:calc(100% - 50px);">
	                                        	<input class="text-input" type="text" name="roadAddrPart1" id="roadAddrPart1" placeholder="도로명 주소 입력" disabled>                           
	                                        </div>
	                                        <div class="input-check" onclick="goPopup();" id="btn-addr-search" style="width:50px;">검색</div>
	                                    </div>
	                                    <div style="height:5px;"></div>
	                                    <input class="text-input" type="text" name="addrDetail" id="addrDetail" placeholder="상세주소 입력">
                                        <span class="extra-info">반경 내의 소식들을 확인할 수 있습니다.</span>
                                    </div>
									<div class="input-content">
										<span class="input-title">소속되어 있는 단체</span><br>
										<input class="text-input" type="text" name="orgname" id="orgname" placeholder="정확한 명칭을 적어주세요.">
									</div>
									<div class="input-content">
										<span class="input-title">직위/역할</span><br>
										<input class="text-input" type="text" name="userpos" id="userpos" placeholder="소속이 있다면 직위나 역할을 작성해주세요.">
									</div>
									<div style="width: 100%;">
										<!--  <input class="sign-submit" type="submit" value="가입하기"> -->
									</div>
								</form>
								<button id="btn-save" class="sign-submit">가입하기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<%@include file="../layout/sidebar_back.jsp"%>


	<!-- Bootstrap core JS-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Third party plugin JS-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
	<!-- Contact form JS-->
	<script src="assets/mail/jqBootstrapValidation.js"></script>
	<script src="assets/mail/contact_me.js"></script>
	<!-- Core theme JS-->
	<script src="/js/scripts.js"></script>
	<script src="/js/modal.js"></script>
	<script type="text/javascript" src="/js/join.js"></script>
</body>
</html>
