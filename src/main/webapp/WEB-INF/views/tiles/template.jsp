<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title><tiles:getAsString name="title" /></title>
</head>
<body>
	<script src="../resources/vendor/jquery/jquery-3.2.1.min.js"></script>
	<tiles:insertAttribute name="header" ></tiles:insertAttribute>
	<tiles:insertAttribute name="body"></tiles:insertAttribute>
	<tiles:insertAttribute name="footer" ></tiles:insertAttribute>