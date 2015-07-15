<%@ page session="false" %>
<%@page import="com.day.cq.wcm.api.WCMMode"%>
<%@include file="/libs/foundation/global.jsp" %>
<%@include file="/apps/northpoint/components/global.jsp"%>
<!-- apps/northpoint/components/page/headlibs.jsp -->
<cq:includeClientLib categories="cq.foundation-main"/><%
%><cq:include script="/libs/cq/cloudserviceconfigs/components/servicelibs/servicelibs.jsp"/>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- Begin: Include NP Basics clientlibs -->
<!-- Artifact Browser -->
<!--[if lt IE 9]>
	<cq:includeClientLib categories="apps.northpoint.ie8" />
<![endif]-->
<!-- Modern Browser -->
<!--[if gt IE 8]><!-->
	<cq:includeClientLib categories="apps.northpoint.modern" />
<!--<![endif]-->
<% if (WCMMode.fromRequest(request) == WCMMode.EDIT) { %>
	<cq:includeClientLib categories="apps.northpoint.authoring" />
<% } %>
<% currentDesign.writeCssIncludes(pageContext); %>
<!-- End: Include NP Basics clientlibs -->


