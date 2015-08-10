<%@include file="/libs/foundation/global.jsp"%>
<!-- apps/northpoint/components/components/event-page/popup.jsp -->
<% String eventLink = currentPage.getPath() + ".html"; %>
<cq:include path="data" resourceType="northpoint/components/event" />
<a href="<%= eventLink %>" target="_blank" onclick="window.parent.location='<%= eventLink %>'; return false;">Go to the Event</a>
