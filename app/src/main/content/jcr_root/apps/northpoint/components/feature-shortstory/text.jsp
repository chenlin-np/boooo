<%@include file="/libs/foundation/global.jsp"%>
<!-- apps/northpoint/components/feature-shortstory/text.jsp -->
<%
	String shortDesc = properties.get("shortdesc","");
	String linkTitle = properties.get("pathfield","");
	if (!linkTitle.isEmpty()){
		//get the uri of the page
        Resource res = resourceResolver.getResource(linkTitle);
        if(res!=null && res.adaptTo(Page.class)!=null){
			linkTitle += ".html";
        }
	}
  String title = properties.get("title","");
%>
  <%= shortDesc %>
  <a href="<%= linkTitle %>">Continue &gt;</a>
