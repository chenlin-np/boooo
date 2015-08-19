<%@include file="/libs/foundation/global.jsp"%>
<%@include file="/apps/northpoint/components/global.jsp" %>
<%@page import="com.day.cq.wcm.api.WCMMode" %>

<%!
	int MAX_TITLE = 58;
	public String trimTitle(String str) {
                String ret = str;
                int titleLength = ret.length();
                if (ret.length() > MAX_TITLE) {
                        ret = ret.substring(0,MAX_TITLE) + "...";
                }
		return ret;
	}
%>
<nav class="breadcrumbs">
<%
	Resource resrc = resource.getResourceResolver().getResource(currentPage.getPath() +"/jcr:content");
	String t_resourse = resrc.getResourceType();
	String delimStr = currentStyle.get("delim", "");
	String trailStr = currentStyle.get("trail", "");
	String delim = "";
	String title="";

	if(resrc.isResourceType("northpoint/components/event-page") || resrc.isResourceType("northpoint/components/news-page")){
		String breadcrumb = currentSite.get("leftNavRoot", String.class);
        if(resrc.isResourceType("northpoint/components/news-page")){
			breadcrumb = currentSite.get("newsPath",String.class);
        }
		String absolutePath = currentPage.getAbsoluteParent(2).getPath();
        if(breadcrumb!=null && breadcrumb.length()>= absolutePath.length()+1){
            String[] actualPaths = breadcrumb.substring(absolutePath.length()+1, breadcrumb.length()).split("/");
            if(actualPaths !=null){
                for(String str: actualPaths) {
                absolutePath += "/"+str;
                Page parentNode = resource.getResourceResolver().getResource(absolutePath).adaptTo(Page.class);
                title = parentNode.getTitle();
        %>
            <%= xssAPI.filterHTML(delim) %><a href="<%= xssAPI.getValidHref(parentNode.getPath()+".html") %>"><%= xssAPI.encodeForHTML(title) %></a>
        <%
                }
            }
        }
		String displayTitle = trimTitle(currentPage.getTitle());
%>
	<%= xssAPI.filterHTML(delim) %><span class="breadcrumbCurrent"><%= xssAPI.encodeForHTML(displayTitle) %></span>
<%
	}else {
		Page trail = null;
		long level = 3;
		int currentLevel = currentPage.getDepth();
		while (level < currentLevel - 1) {
			trail = currentPage.getAbsoluteParent((int) level);
			if (trail == null) {
				break;
			}
			title = trail.getNavigationTitle();
			if (title == null || title.equals("")) {
				title = trail.getNavigationTitle();
			}
			if (title == null || title.equals("")) {
				title = trail.getTitle();
			}
			if (title == null || title.equals("")) {
				title = trail.getName();
			}
%>
	<%= xssAPI.filterHTML(delim) %><a href="<%= xssAPI.getValidHref(trail.getPath()+".html") %>"><%= xssAPI.encodeForHTML(title) %></a>
<%
			delim = delimStr;
			level++;
		}
		trail = currentPage.getAbsoluteParent((int) level);
		if(trail != null){
			title = trail.getNavigationTitle();
		    
			if (title == null || title.equals("")) {
			    title = trail.getNavigationTitle();
			}
			if (title == null || title.equals("")) {
			    title = trail.getTitle();
			}
			if (title == null || title.equals("")) {
			    title = trail.getName();
			}
			String displayTitle = trimTitle(title);
%>
<span class="breadcrumbCurrent"><%= xssAPI.filterHTML(delim) %><%= xssAPI.encodeForHTML(displayTitle) %></span>
<%
			if (trailStr.length() > 0) {
			    %><%= xssAPI.filterHTML(trailStr) %><%
			}
		}
	}//end of else
%>
</nav>
