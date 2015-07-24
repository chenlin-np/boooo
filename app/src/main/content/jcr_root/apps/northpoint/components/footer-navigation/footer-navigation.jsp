<%@ page import="com.day.cq.wcm.api.WCMMode" %>
<%@include file="/libs/foundation/global.jsp"%>
<%@include file="/apps/northpoint/components/global.jsp"%>
<%
  String[] links = properties.get("links", String[].class);
  String[] socialIcons = properties.get("socialIcons", String[].class);
%>
<!-- Footer Navigation Links-->
<div class="columns large-16 medium-16 small-19 small-centered large-uncentered medium-uncentered">
  <ul>
  <% 
    if ((links == null || links.length == 0) && WCMMode.fromRequest(request) == WCMMode.EDIT) {
      %> ##### Please Edit Footer Navigation ##### <% }
      else if(links!=null){
        for (int i = 0; i < links.length; i++) {
          String[] values = links[i].split("\\|\\|\\|");
          String label = values[0];
          String path = values.length >= 2 ? values[1] : "";
          path = genLink(resourceResolver, path);
          String linkClass = values.length >= 3 ? "class=\"" + values[2] + "\"" : "";
  %> 
    <li><a <%= linkClass%> href="<%= path %>"><%= label %></a></li>
  <% } 
  } %>
  </ul>
</div>
<!--Social Media links-->
<div class="columns large-8 medium-8">
  <ul>
  <% if (socialIcons != null) { 
    for (String settingStr : socialIcons) {
      String[] settings = settingStr.split("\\|\\|\\|");
      if (settings.length < 2) {
          continue;
      }
      String url = settings[0];
      String iconPath = settings[1];
      String iconClass = settings.length >= 3 ? " "+ settings[2] : "";
    %>
    <li><a href="<%= url %>"><img src="<%= iconPath %>"/></a></li>
    <% } 
    } %>
  </ul>
</div>
