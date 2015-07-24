<%@include file="/libs/foundation/global.jsp"%>
<%@include file="/apps/northpoint/components/global.jsp"%>

<!-- apps/northpoint/components/feature-shortstory/text.jsp -->
<%
	String shortDesc = properties.get("shortdesc","");
	String link = genLink(resourceResolver,properties.get("pathfield",""));

%>
<%= shortDesc %>
<a href="<%= link %>">Continue &gt;</a>
