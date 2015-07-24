<%@page session="false"%><%--
  Copyright 1997-2010 Day Management AG
  Barfuesserplatz 6, 4001 Basel, Switzerland
  All Rights Reserved.

  This software is the confidential and proprietary information of
  Day Management AG, ("Confidential Information"). You shall not
  disclose such Confidential Information and shall use it only in
  accordance with the terms of the license agreement you entered into
  with Day.

  ==============================================================================

  Default head script.

  Draws the HTML head with some default content:
  - includes the WCML init script
  - includes the head libs script
  - includes the favicons
  - sets the HTML title
  - sets some meta data

  ==============================================================================

--%><%@include file="/libs/foundation/global.jsp" %><%
%><%@ page import="com.day.cq.commons.Doctype" %><%
    String xs = Doctype.isXHTML(request) ? "/" : "";
    String favIcon = currentDesign.getPath() + "/favicon.ico";
    if (resourceResolver.getResource(favIcon) == null) {
        favIcon = null;
    }
%><head>
<%
	String pageCategory = "DEFAULT";
	Object pageCategoryObject = request.getAttribute("PAGE_CATEGORY");
	if (pageCategoryObject != null) {
		pageCategory = (String) pageCategoryObject;
	}
%>
	<!-- page category = <%= pageCategory%> -->
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"<%=xs%>>
	<meta name="keywords" content="<%= xssAPI.encodeForHTMLAttr(WCMUtils.getKeywords(currentPage, false)) %>"<%=xs%>>
	<meta name="description" content="<%= xssAPI.encodeForHTMLAttr(properties.get("jcr:description", "")) %>"<%=xs%>>
	<cq:include script="headlibs.jsp"/>
	<cq:include script="/libs/wcm/core/components/init/init.jsp"/>
	<cq:include script="stats.jsp"/>
<% 
	if (favIcon != null) {
%>
	<link rel="icon" type="image/vnd.microsoft.icon" href="<%= xssAPI.getValidHref(favIcon) %>"<%=xs%>>
	<link rel="shortcut icon" type="image/vnd.microsoft.icon" href="<%= xssAPI.getValidHref(favIcon) %>"<%=xs%>>
<%
	}
	String title = "";
	try {
        	title = currentPage.getContentResource().adaptTo(ValueMap.class).get("seoTitle", "");
    		if (title.isEmpty()) {
    			title = currentPage.getTitle() == null ? currentPage.getName() : currentPage.getTitle();
		}
        } catch (Exception e) {}
    	title = xssAPI.encodeForHTML(title);

%>
<!--//loading a font file for all the small icons on the site-->
  <link rel="stylesheet" href="/etc/designs/northpoint/fonts/style.css" type="text/css"/>
  <title><%= title %></title>
</head>
