<%@include file="/libs/foundation/global.jsp"%>
<%@include file="/apps/northpoint/components/global.jsp"%>
<!-- apps/northpoint/components/page/header.jsp -->
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
  String headerPath = currentPage.getAbsoluteParent(2).getContentResource().getPath() + "/header";
String designPath = currentDesign == null ? "/" : currentDesign.getPath();
  int depth = currentPage.getDepth();
  request.setAttribute("headerPath", headerPath);
  String headerImagePath = currentSite.get("headerImagePath", "");
%>
<!--PAGE STRUCTURE: HEADER-->
<div class="header-wrapper row collapse hide-for-print" <% if(!headerImagePath.equals("") && headerImagePath != null){ %> style="background-image: url('<%= headerImagePath%>')" <%}%> >
<div class='columns'>
  <div id="header" class="row">
    <!--Logo -->
    <div class="large-6 medium-9 columns">
      <cq:include path="<%= headerPath + "/logo" %>" resourceType="northpoint/components/logo" />
    </div>
    <!--eyebrow-nav-->
    <div class="large-18 medium-15 hide-for-small columns topMessage">
        <%setCssClasses("columns noLeftPadding" , request); %>
      <cq:include path="<%= headerPath + "/eyebrow-nav" %>" resourceType="northpoint/components/eyebrow-navigation" />
      <div class="row collapse">
          <!-- just a placeholder for sign in button -->
        <% setCssClasses("large-17 medium-17 small-24 columns", request); %>
        <cq:include path="<%= headerPath + "/login" %>" resourceType="northpoint/components/login" />
          <!--search bar-->
        <% if(!currentSite.get("hideSearch","").equals("true")){ %>
        <% setCssClasses("large-6 medium-6 small-24 columns searchBar", request); %>
        <cq:include path="<%= headerPath + "/search-box" %>" resourceType="northpoint/components/search-box" />
      <%} %>
      </div>
    </div>
      <!--small header icons show for mobile view-->
    <div class="show-for-small small-24 columns topMessage alt">
      <div class="row vtk-login collapse">
        <% setCssClasses("small-19 columns", request); %>
        <cq:include path="<%= headerPath + "/login" %>" resourceType="northpoint/components/login" />
        <div class="small-5 columns">
          <div class="small-search-hamburger">
             <% if(!currentSite.get("hideSearch","").equals("true")){ %>
              <a class="search-icon"><img src="/etc/designs/northpoint/images/search_white.png" width="21" height="21" alt="search icon"/></a>
             <% } %>
            <a class="right-off-canvas-toggle menu-icon"><img src="/etc/designs/northpoint/images/hamburger.png" width="22" height="28" alt="toggle hamburger side menu icon"/></a>
          </div>
        </div>
      </div>
      <!-- show when search icon clicked-->
      <div class="row hide srch-box collapse">
        <% setCssClasses("small-22 columns hide srch-box", request); %>
          <cq:include path="<%= headerPath + "/search-box" %>" resourceType="northpoint/components/search-box" />
        <div class="small-2 columns">
          <a class="right-off-canvas-toggle menu-icon"><img src="/etc/designs/northpoint/images/hamburger.png" width="22" height="28" alt="right side menu hamburger icon"/></a>
        </div>
      </div>
    </div>
  </div>
  <!--PAGE STRUCTURE: HEADER BAR-->
  <div id="headerBar" class="row collapse hide-for-small">
    <% setCssClasses("large-push-5 large-19 medium-23 small-24 columns", request); %>
    <cq:include path="<%= headerPath + "/global-nav" %>" resourceType="northpoint/components/global-navigation" />
    <div class="small-search-hamburger show-for-medium medium-1 columns">
      <a class="show-for-medium right-off-canvas-toggle menu-icon"><img src="/etc/designs/northpoint/images/hamburger.png" width="19" height="28" alt="side menu icon"></a>
    </div>
  </div>
</div>
</div>
<!--[if gt IE 8]><!-->
<!-- SMALL SCREEN CANVAS should be after the global navigation is loaded,since global navigation won't be authorable-->
  <cq:include script="small-screen-menus"/>
<!--<![endif]-->
