<%@ page import="com.day.cq.wcm.api.WCMMode" %>
<%@include file="/libs/foundation/global.jsp"%>
<%@include file="/apps/northpoint/components/global.jsp"%>
<!-- apps/northpoint/components/global-navigation/global-navigation.jsp -->
<%
String[] links = properties.get("links", String[].class);

if ((links == null || links.length == 0) && WCMMode.fromRequest(request) == WCMMode.EDIT) {
%>##### Please Edit Global Navigation #####<%
} else if (links != null){
%>
    <ul class="inline-list">
<% 
String currPath = currentPage.getPath(); 
String rootPath = currentPage.getAbsoluteParent(2).getPath();
String eventLeftNavRoot = currentSite.get("leftNavRoot", String.class);
String eventPath = currentSite.get("eventPath", String.class);
String contentResourceType="";
Design newCurrentDesign= (Design)request.getAttribute("newCurrentDesign");
String designPath = currentDesign == null ? "/" : currentDesign.getPath(); 
for (int i = 0; i < links.length; i++) {
	String[] values = links[i].split("\\|\\|\\|");
	String label = values[0];
	String path = values.length >= 2 ? values[1] : "";
	String menuPath = values.length >= 2 ? values[1] : "";
	path = genLink(resourceResolver, path);
	String clazz = values.length >= 3 ? " "+ values[2] : "";
	String mLabel = values.length >=4 ? " "+values[3] : "";
	String sLabel = values.length >=5 ? " "+values[4] : "";
	Iterator <Page> slingResourceIter;
	String slingResourceType = "northpoint/components/placeholder-page";
	contentResourceType="";
	try {
		contentResourceType = resource.getResourceResolver().getResource(menuPath+"/jcr:content").getResourceType();
		if(contentResourceType.equals(slingResourceType)){
			slingResourceIter = resource.getResourceResolver().getResource(menuPath).adaptTo(Page.class).listChildren();
			if(slingResourceIter.hasNext()){
				Page firstChild =  slingResourceIter.next();
				path = genLink(resourceResolver, firstChild.getPath());
			}
		}
	 }catch(Exception e){}

	String activeStatus = "";
	if(!currPath.equals(rootPath) && (
		(eventPath!=null && currPath.startsWith(eventPath) && eventLeftNavRoot!=null && eventLeftNavRoot.startsWith(menuPath))
		|| menuPath.indexOf(currPath) == 0
		|| currPath.startsWith(menuPath))
	) {
		activeStatus = "active";
	}
%>
	<li class="<%= activeStatus %>">
		<a class="show-for-large-up menu <%= clazz %>" href="<%= path %>"><%= label %></a>
		<a class="show-for-medium-only menu <%= clazz %>" href="<%= path %>"><%= mLabel %></a>
	</li>
<%
}
%>
    </ul>
<%
}
%>
