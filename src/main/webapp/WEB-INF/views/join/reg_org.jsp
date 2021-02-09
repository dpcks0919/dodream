<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../layout/header_join.jsp" %>    

        <style>
          body {
            background-color: #ed7e95;
          }
        </style>
    </head>

    <body id="page-top">
      <div id="menu-back" onclick="closeNav()"></div>
      <%@include file="../layout/sidebar_front.jsp" %> 


        <div id="Wrapper">
          <!-- Navigation-->
          <%@include file="../layout/navbar_join.jsp" %> 

          <section class="page-section text-white text-center" id="contact">
              <div class="container d-flex flex-column">
                  <div class="flex-center">
                      <div class="input-column">
                          <div class="input-info">
                              <h4>사회복지단체 가입</h4>
                              <p>회원가입 하시면, 보살피고 계신 이웃들의 필요를<br>요청하실 수 있습니다!</p>
                          </div>
                          <div class="input-card">
                              <div style="text-align:left;">
                                <form method="post" name="regForm" action="">
                                  	  <input type="hidden" id="type" value="INSTITUTION">	<!-- userType 히든으로 전달 -->
                                      <div class="input-content">
                                          <span class="input-title">아이디</span><span>&nbsp;<em>*</em></span><br>
                                          <div class="flex-center">
                                              <div style="width:calc(100% - 60px);">
                                                  <input class="text-input" type="text" name="userid" placeholder="아이디 입력" id="userid">
                                              </div>
                                              <div class="input-check" id="btn-id-check" >중복 확인</div>
                                          </div>
                                      </div>
                                      <div class="input-content">
                                          <span class="input-title">비밀번호</span><span>&nbsp;<em>*</em></span><br><input class="text-input" type="password" name="userpw" id="userpw" placeholder="비밀번호 입력">
                                      </div>
                                      <div class="input-content">
                                          <span class="input-title">비밀번호 확인</span><span>&nbsp;<em>*</em></span><br><input class="text-input" type="password" name="userpwchk" placeholder="비밀번호 입력">
                                      </div>
                                      <div class="divider-custom">
                                          <div class="divider-custom-line" style="background-color: rgb(175, 218, 231);border-color: rgb(175, 218, 231) !important;"></div>
                                          <div style="color:rgb(175, 218, 231)"><h4>기관정보</h4></div>
                                          <div class="divider-custom-line" style="background-color: rgb(175, 218, 231);border-color: rgb(175, 218, 231) !important;"></div>
                                      </div>
                                      <div class="input-content">
                                          <span class="input-title">기관명</span><span>&nbsp;<em>*</em></span><br><input class="text-input" type="text" name="username" placeholder="기관명 입력" id="username">
                                      </div>
                                      <div class="input-content">
                                          <span class="input-title">대표 이메일주소</span><span>&nbsp;<em>*</em></span><br><input class="text-input" type="text" name="useremail" placeholder="이메일주소 입력" id="useremail">
                                          <span class="extra-info">주변 이웃들의 필요를 메일로 받으실 수 있습니다.
                                          <br>메일 수신 동의&nbsp;&nbsp;
                                          <span>
                                              <label><input type="radio" name="mail_rcv" value="1" id=mail_rcv" checked> 예</label>&nbsp;&nbsp;
                                              <label><input type="radio" name="mail_rcv" value="0" id="mail_rcv"> 아니요</label>
                                          </span></span>
                                      </div>
                                      <div class="input-content">
                                        <span class="input-title">대표 전화번호</span><span>&nbsp;<em>*</em></span><br>
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
                                    	<span class="input-title">기관 도로명주소</span><span>&nbsp;<em>*</em></span><br>
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
                                  </form>
                                  <button id="btn-save" class="sign-submit">가입하기</button>
                              </div>
                          </div>
                      </div>
                  </div>
              </div>
          </section>

        </div>
        <%@include file="../layout/sidebar_back.jsp" %> 

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
