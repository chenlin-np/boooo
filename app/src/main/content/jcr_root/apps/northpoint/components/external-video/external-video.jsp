<%@ page import="com.day.cq.wcm.api.WCMMode" %>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<%  
	String html = properties.get("html", "");
	if (html.isEmpty() && WCMMode.fromRequest(request) == WCMMode.EDIT) {
	%>##### Embed Code of External Video#####<%
	} else {
	    %><div class="video-container"><%= html %></div><%
	}
%>
