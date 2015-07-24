<%@page import="java.util.Iterator,
com.day.cq.wcm.api.WCMMode,
com.day.cq.wcm.api.PageManager,
org.apache.sling.api.resource.ValueMap" %>
<%@include file="/libs/foundation/global.jsp"%>
<%@include file="/apps/northpoint/components/global.jsp"%>
<%@page session="false" %>
<cq:defineObjects/>
<%
String rootPath = properties.get("path", "");

if (rootPath.isEmpty()) {
    rootPath = currentSite.get("adsPath", "");
}
if (rootPath.isEmpty()) {
    if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
		%>Advertisement: path not configured.<%
    }
    return;
}
%>
<%
//Setting adCount
String tempAdCount = currentDesign.getStyle("three-column-page/advertisement").get("adCount", "");
int adCount;
if (tempAdCount.isEmpty()) {
	int defaultAdCount = 2;
    adCount = defaultAdCount;
}
else {
    adCount = Integer.parseInt(tempAdCount);
}

Page adRoot = resourceResolver.resolve(rootPath).adaptTo(Page.class);
if (adRoot != null) {
	// For now, there is only one strategy, FIFO, which is the default;
	String loadPath = rootPath + "." + adCount + ".html";
	%>
	<script type="text/javascript">
		$('.advertisement').load('<%= loadPath %>');
	</script>
<% } %>
