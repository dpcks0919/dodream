		  function openMenu() {
              document.getElementById("Wrapper").style.marginLeft = "70%";
              document.getElementById("mySidebar").style.width = "70%";
              document.getElementById("mainNav").style.left = "70%";
              document.getElementById("page-top").style.overflow = "hidden";
              document.getElementById("nav-profile").style.color="white";
              document.getElementById("nav-logo").style.display="none";
              document.getElementById("menu-back").style.display="block";
            }

            function openProfile() {
              document.getElementById("Wrapper").style.marginLeft = "-70%";
              document.getElementById("mySidebar2").style.width = "70%";
              document.getElementById("mainNav").style.right = "70%";
              document.getElementById("page-top").style.overflow = "hidden";
              document.getElementById("nav-burger").style.color="white";
              document.getElementById("nav-logo").style.display="none";
              document.getElementById("menu-back").style.display="block";
            }

            function closeNav() {
              document.getElementById("mySidebar").style.width = "0";
              document.getElementById("mySidebar2").style.width = "0";
              document.getElementById("Wrapper").style.marginLeft= "0";
              document.getElementById("Wrapper").style.marginRight= "0";
              document.getElementById("mainNav").style.left = "0";
              document.getElementById("mainNav").style.right = "0";
              document.getElementById("page-top").style.overflow = "visible";
              document.getElementById("nav-profile").style.color="#e95378";
              document.getElementById("nav-burger").style.color="#e95378";
              document.getElementById("nav-logo").style.display="initial";
              document.getElementById("menu-back").style.display="none";
            }

            function goDetail() {
              document.getElementById("modal-bg").style.display="block";
              document.getElementById("view-detail").style.display="block";
              document.getElementById("page-top").style.overflow="hidden";
              document.getElementById("menu-back").style.filter = "blur(5px)"
              document.getElementById("Wrapper").style.filter = "blur(5px)"
            }
            function closeModal() {
              document.getElementById("modal-bg").style.display="none";
              document.getElementById("view-detail").style.display="none";
              document.getElementById("view-responseForm").style.display="none";
              document.getElementById("page-top").style.overflow="visible";
              document.getElementById("menu-back").style.filter = "none"
              document.getElementById("Wrapper").style.filter = "none"
            }
            function goResponse() {
              document.getElementById("view-responseForm").style.display="block";
              document.getElementById("view-detail").style.display="none";
              document.getElementById("page-top").style.overflow="hidden";
            }
            function goBack() {
              document.getElementById("view-detail").style.display="block";
              document.getElementById("view-responseForm").style.display="none";
            }
            
            
// 성민 request.jsp

