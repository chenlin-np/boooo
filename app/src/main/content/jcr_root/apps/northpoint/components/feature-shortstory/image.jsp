<%@include file="/libs/foundation/global.jsp"%>
<%@include file="/apps/northpoint/components/global.jsp" %>
<!-- apps/northpoint/components/feature-shortstory/image.jsp -->
<%
	String fileReference = properties.get("./image/fileReference", "");
	
%>
  <% if(fileReference != null && fileReference.length() > 0) { %>
<%= displayRendition(resourceResolver, resource.getPath()+"/image", "cq5dam.web.400.400", null, 500) %>
  <% } %>
