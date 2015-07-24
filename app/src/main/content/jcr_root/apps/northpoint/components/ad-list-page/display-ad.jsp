<%@include file="/libs/foundation/global.jsp"%>
<%@include file="/apps/northpoint/components/global.jsp"%>

<%
final String AD_ATTR = "apps.northpoint.components.ad-list-page.currentAd";
Page currentAd = (Page)request.getAttribute(AD_ATTR);
if (currentAd != null) {
	String adName = currentAd.getProperties().get("jcr:title", "");
	String path = currentAd.getPath();
	String adLink = currentAd.getProperties().get("link", "");

	if (adLink != null && !adLink.isEmpty()) {
		adLink = genLink(resourceResolver, adLink);
	} else {
		adLink = genLink(resourceResolver, path);	
	}
%>
	<a href="<%=adLink%>"><cq:include path= "<%=path +"/jcr:content/image"%>" resourceType="foundation/components/image" />
	<cq:include path= "<%=path +"/jcr:content/text"%>" resourceType="foundation/components/text" />
	</a>
<%
	request.removeAttribute(AD_ATTR);
} 
%>
