<%@page import="com.day.cq.wcm.api.components.IncludeOptions"%>
<%@include file="/libs/foundation/global.jsp" %>
<!-- apps/northpoint/components/page/footer.jsp -->
<%@include file="/apps/northpoint/components/global.jsp"%>
<%
// Force currentPage and currentDesign from request
Page newCurrentPage = (Page)request.getAttribute("newCurrentPage");
Design newCurrentDesign= (Design)request.getAttribute("newCurrentDesign");
if (newCurrentPage != null) {
    currentPage = newCurrentPage;
}
if (newCurrentDesign != null) {
    currentDesign = newCurrentDesign;
}
String footerPath = currentPage.getAbsoluteParent(2).getContentResource().getPath() + "/footer";
String logoPath = currentPage.getAbsoluteParent(2).getContentResource().getPath() + "/header";
%>
<!-- /apps/northpoint/components/page/footer.jsp -->
<div class="hide-for-print">
 <!--footer menu links-->
	<div id="footer" class="row">
		<cq:include path="<%= footerPath + "/nav"%>" resourceType="northpoint/components/footer-navigation"/>
	</div>
	<!--logo for the mobile footer-->
	<div id="mobile-footer" class="row show-for-small">
		<%
			request.setAttribute("noLink", true);
		%>
		<cq:include path="<%= logoPath + "/logo"%>" resourceType="northpoint/components/logo" />
	</div>
</div>

<cq:include script="google-analytics.jsp" />
<cq:include script="footer-tracking.jsp" />
