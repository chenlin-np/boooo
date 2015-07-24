<!-- apps/northpoint/components/logo/header.jsp -->

<%@include file="/libs/foundation/global.jsp" %>
<%
	String regularWidth = properties.get("regular/width", "188");
	String regularHeight = properties.get("regular/height", "73");
String regularImage = properties.get("regular/fileReference", "/content/dam/northpoint/placeholder/logo.png");
	String alt = properties.get("alt", "");
	if (!alt.isEmpty()) alt = " alt=\"" + alt + "\"";
	String linkURL = properties.get("linkURL", "");
	if (!linkURL.isEmpty()) linkURL += ".html";

	String smallWidth = properties.get("small/width", "38");
	String smallHeight = properties.get("small/height", "38");
	String smallImage = properties.get("small/fileReference", "/content/dam/northpoint/placeholder/logo-small.jpeg");
	Boolean noLink = (Boolean) request.getAttribute("noLink");
%>

<% if(noLink != null && noLink == true){
// this shows for footer for mobile view only
%>
<nav class="small-centered columns small-5">
	<img src="<%= smallImage %>"<%= alt %> width="<%= smallWidth %>" height="<%= smallHeight %>" />
</nav>
<% } else {
// this shows for header large only
%>
<nav class="column large-24 medium-24">
<% if (!linkURL.isEmpty()) { %> <a href="<%= linkURL %>"> <% } %>
	<img src="<%= regularImage %>"<%= alt %> id="logoImg" width="<%= regularWidth %>" height="<%= regularHeight%>" />
<% if (!linkURL.isEmpty()) { %> </a> <% } %>
</nav>
<% } %>
<!--<![endif]-->
