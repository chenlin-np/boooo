<%--

  AD List Page component.

  A page that displays Ads.

--%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page import="com.day.cq.wcm.api.WCMMode" %>
<%@page session="false" %>
<%-- Default strategy is FIFO --%>
<cq:include script="fifo.jsp" />
<%    
if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
%>###Use Scaffolding to create new Ad###<%     
}
%>
