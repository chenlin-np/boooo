<%@include file="/libs/foundation/global.jsp"%>
<%
Page newCurrentPage = (Page)request.getAttribute("newCurrentPage");
Design newCurrentDesign= (Design)request.getAttribute("newCurrentDesign");
if (newCurrentPage != null) {
    currentPage = newCurrentPage;
}
%>
<%@include file="/apps/northpoint/components/global.jsp"%>
<%@page session="false" %>
<!--/apps/northpoint/components/page/footer-tracking.jsp-->
<!--Embedded HTML for tracking-->
<%
String tracking = currentSite.get("footerTracking", "");
if (!tracking.isEmpty()) {
    %><%= tracking %><%
}
%>
