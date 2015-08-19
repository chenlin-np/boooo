<%@include file="/libs/foundation/global.jsp"%>
<%@include file="/apps/northpoint/components/global.jsp"%>
<%@ page import="com.day.cq.wcm.api.WCMMode" %>

<!-- apps/northpoint/components/components/event-page/left.jsp -->
<%
    String eventPath = currentSite.get("eventPath", String.class);
	String eventLeftNavRoot = currentSite.get("leftNavRoot", String.class);
if(eventPath == null || eventPath.isEmpty() || eventLeftNavRoot==null || eventLeftNavRoot.isEmpty()){
    if(WCMMode.fromRequest(request) == WCMMode.EDIT){
%>    ### Please configure EventPath and EventLeftNavRoot properties from the homepage to display navigation for Event pages. ###<br><br>
<%        }
}else{
%>
<cq:include path="content/left/cascading-menus" resourceType="northpoint/components/cascading-menus" />
<% }
%>
<cq:include path="content/left/par" resourceType="northpoint/components/styled-parsys" />
