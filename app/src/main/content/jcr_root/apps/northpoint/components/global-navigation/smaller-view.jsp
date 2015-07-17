<%@ page import="com.day.cq.wcm.api.WCMMode" %>
<%@include file="/libs/foundation/global.jsp"%>
<%@include file="/apps/northpoint/components/global.jsp"%>
<!-- apps/northpoint/components/global-navigation/global-navigation.jsp -->
<div id="right-canvas-menu"> 
	<ul class="side-nav" style="padding:0px"> 
<%
String[] links = properties.get("links", String[].class);
request.setAttribute("globalNavigation", links);
if(links!=null){
    for (int i = 0; i < links.length; i++) {
            String[] values = links[i].split("\\|\\|\\|");
            String label = values[0];
            String path = values.length >= 2 ? values[1] : "";
            path = genLink(resourceResolver, path);
            String clazz = values.length >= 3 ? " "+ values[2] : "";
            String mLabel = values.length >=4 ? " "+values[3] : "";
            String sLabel = values.length >=5 ? " "+values[4] : "";
%>
            <li>
                <a class="<%= clazz %> homepage" href="<%= path %>"><%= mLabel %></a>
            </li>
<%
    }
}
%>
	</ul>
</div>

    
 
