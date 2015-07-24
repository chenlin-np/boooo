<%@include file="/libs/foundation/global.jsp" %>
<%@include file="/apps/northpoint/components/global.jsp" %>
<%@page import="com.day.cq.wcm.api.WCMMode" %>
<%
String placeholderText = properties.get("placeholder-text","");
String searchAction = properties.get("searchAction", null);
String action = (String)request.getAttribute("altSearchPath");
if ((null==searchAction) && WCMMode.fromRequest(request) == WCMMode.EDIT) {
%>
	Please edit Search Box Component
<%
} else if(searchAction==null){
	%> Search Action Not Configured <%
} else {
    if(action==null || action.trim().isEmpty()){
	  action = currentSite.get(searchAction, String.class);
    }
    if(action==null ||action.trim().isEmpty()){
		%> Please config <%=searchAction%> page<%
    }else{
%>
    <form action="<%=action%>.html" method="get"> 
		<input type="text" name="q" placeholder="<%=placeholderText %>" class="searchField"/>
	</form>
<%  }
}%>
