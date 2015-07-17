<!--/apps/northpoint/components/eyebrow-navigation/eyebrow-navigation.jsp-->
<%@ page import="com.day.cq.wcm.api.WCMMode" %>
<%@include file="/libs/foundation/global.jsp"%>
<%
String[] links = properties.get("links", String[].class);
request.setAttribute("links", links);
if ((links == null || links.length == 0) && WCMMode.fromRequest(request) == WCMMode.EDIT) {
%>##### Please Edit Eyebrow Navigation #####
<%
} else if (links != null){
%>
   <ul class="inline-list eyebrow-fontsize">
      <cq:include script="main.jsp"/>
   </ul>
<%
}
%>
