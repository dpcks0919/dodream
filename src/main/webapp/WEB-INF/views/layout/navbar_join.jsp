<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top shadow" id="mainNav">
	<div class="container">
		<img src="/image/Logo.png" class="logo" onclick="document.location.href='/'"> 
		<div class="collapse navbar-collapse" id="navbarResponsive">
		</div>
	</div>
	<div class="responsive-container">
		<img src="/image/hamburger.png" class="menu-bar" onclick="openMenu()" id="nav-burger"> 
		<img src="/image/Logo.png" class="responsive-logo " id="nav-logo" onclick="document.location.href='/'"> 
		<img src="/image/myinfo.png" class="profile " id="nav-profile" onclick="openProfile()" hidden>
	</div>
</nav>
