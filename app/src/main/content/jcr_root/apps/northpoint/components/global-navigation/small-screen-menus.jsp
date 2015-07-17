<%@ page import="java.util.Iterator, java.util.HashSet,java.util.Set, java.util.Arrays,org.apache.sling.api.resource.ResourceResolver, org.slf4j.Logger,org.slf4j.LoggerFactory,org.apache.sling.api.resource.ResourceUtil, com.day.cq.wcm.api.WCMMode"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@include file="/apps/northpoint/components/global.jsp" %>
<!-- apps/northpoint/components/global-navigation/global-navigation.jsp -->
<%
   String currPath = currentPage.getPath();  
   String[] links = properties.get("links", String[].class);
   request.setAttribute("globalNavigation", links);
  
   int levelDepth = 0;
   String insertAfter="";
   String currTitle = currentPage.getTitle();
   String eventPath = currentSite.get("eventPath", String.class);
   String gs_us_path = currentPage.getAbsoluteParent(2).getPath();
   String rootPath = currentPage.getPath().substring(gs_us_path.length()+1, currPath.length()); 

   String eventGrandParent = null;
   try {
       eventGrandParent = currentPage.getParent().getParent().getPath();
   } catch (Exception e) {}

   String eventLeftNavRoot = currentSite.get("leftNavRoot", String.class);
   String eventDisplUnder = currentSite.get("eventPath", String.class);
   boolean levelFlag = true;
   String contentResourceType="";
%>
<%!
 
public void buildMenu(Iterator<Page> iterPage, String rootPath, String gs_us_path,StringBuilder menuBuilder,int levelDepth,String ndePath, boolean levelFlag,String eventLeftNavRoot,String currPath, String currTitle, String eventDispUnder) throws RepositoryException{
	levelDepth++;
	menuBuilder.append("<ul>");
	if(iterPage.hasNext()){
		while(iterPage.hasNext()){
			Page page = iterPage.next();
			// CHECK FOR THE HIDEINNAV
			if(!page.isHideInNav()){ 
				int dept = page.getDepth();
				String nodePath = page.getPath().substring(gs_us_path.length()+1, page.getPath().length());
				if(rootPath.indexOf(nodePath) == 0){
					// This string buffer properly closes dangling li elements
					StringBuffer remainderStrings = new StringBuffer();

					// CHECK IF CURRENTLY WE ARE ON THE PAGE ELSE DONT HIGHLIGHT
					if(rootPath.equalsIgnoreCase(nodePath) ){
						menuBuilder.append("<li class=\"active\">");
						menuBuilder.append("<div>");
						menuBuilder.append(createHref(page));
						menuBuilder.append("</div>");
						remainderStrings.append("</li>");
					}else{
						menuBuilder.append("<li>");
						menuBuilder.append("<div>");
						menuBuilder.append(createHref(page));
						menuBuilder.append("</div>");
                                                remainderStrings.append("</li>");
					}
					Iterator<Page> p = page.listChildren(); 
					if(p.hasNext()){
						buildMenu(p, rootPath,gs_us_path, menuBuilder, levelDepth,nodePath, levelFlag,eventLeftNavRoot,currPath, currTitle, eventDispUnder);           
					}
					menuBuilder.append(remainderStrings.toString());

				} else{
					// CHECKING FOR THE EVENT SPECIAL CASE 
					if(page.getPath().indexOf(eventLeftNavRoot)==0 && currPath.indexOf(eventDispUnder)==0){
						menuBuilder.append("<li>");
						menuBuilder.append("<div>");
						menuBuilder.append("<a href=").append(createHref(page));
						menuBuilder.append("</div>");
						//menuBuilder.append("</li>");

						menuBuilder.append("<ul><li class=\"active\">");
						menuBuilder.append("<div>");
						menuBuilder.append("<a href=").append(currPath+".html").append(">").append(currTitle).append("</a>");
						menuBuilder.append("</div>");
						menuBuilder.append("</li></ul>");
						//menuBuilder.append("</li>");

					} else {
						menuBuilder.append("<li>");
						menuBuilder.append("<div>");
						menuBuilder.append("<a href=").append(createHref(page));
						menuBuilder.append("</div>");
						menuBuilder.append("</li>");
					}
				}
			}// end of if
		}//while
		menuBuilder.append("");
	}
	menuBuilder.append("</ul>"); 
	// return menuBuilder;
}
%>

<div id="right-canvas-menu"> 
 <ul class="side-nav" style="padding:0px"> 
 
<% 
String slingResourceType = "northpoint/components/placeholder-page";
if(links!=null){
for (int i = 0; i < links.length; i++){
	String[] values = links[i].split("\\|\\|\\|");
	String label = values[0];
	String path = values.length >= 2 ? values[1] : "";
	String menuPath = values.length >= 2 ? values[1] : "";
	path = genLink(resourceResolver, path);
	String clazz = values.length >= 3 ? " "+ values[2] : "";
	String mLabel = values.length >=4 ? " "+values[3] : "";
	String sLabel = values.length >=5 ? " "+values[4] : "";
	Set<String> navigationPath;
	Iterator<Page> menuLevel1;
	String navigation="";
	StringBuilder menuBuilder = new StringBuilder();
	Iterator<Page> iterPage=null;
	Boolean resourceFlag = false;
	String startingPoint = "";
	Iterator <Page> slingResourceIter;
	contentResourceType = "";
	try{
		contentResourceType = resource.getResourceResolver().getResource(menuPath+"/jcr:content").getResourceType();
		if(contentResourceType.equals(slingResourceType)){
			slingResourceIter = resource.getResourceResolver().getResource(menuPath).adaptTo(Page.class).listChildren();
			if(slingResourceIter.hasNext()){
				Page firstChild =  slingResourceIter.next();
				path = genLink(resourceResolver, firstChild.getPath());
			}
		}
	}catch(Exception e){}

	if(!path.isEmpty() && !path.equalsIgnoreCase("#") && path.indexOf(currentPage.getAbsoluteParent(2).getPath()) == 0) {
		startingPoint = menuPath.substring(currentPage.getAbsoluteParent(2).getPath().length()+1,menuPath.length());
		if(startingPoint.indexOf("/")>0) {
			startingPoint = startingPoint.substring(0, startingPoint.indexOf("/"));
		}
		Resource pathResource = resourceResolver.getResource(gs_us_path+"/"+startingPoint);
		if(pathResource==null || ResourceUtil.isNonExistingResource(pathResource) || !pathResource.getResourceType().equalsIgnoreCase("cq:Page")){
			resourceFlag = true;
		}
	}

	if(!resourceFlag){
		iterPage = resourceResolver.getResource(gs_us_path+"/"+startingPoint).adaptTo(Page.class).listChildren();
		if(!currPath.equals(rootPath) && !menuPath.equals('#')){
			//This if to handle the special case for the events
			if(currPath.startsWith(eventPath) && eventLeftNavRoot.startsWith(menuPath)){
%>
<li id="sub-active">
	<div><a href="<%= path %>"><%= sLabel %></a></div>
<%
				if(eventGrandParent.equalsIgnoreCase(currentSite.get("eventPath", String.class))){
					eventPath = eventLeftNavRoot.substring(0,eventLeftNavRoot.lastIndexOf("/"));
					iterPage = resourceResolver.getResource(eventPath).adaptTo(Page.class).listChildren();
				}
				buildMenu(iterPage, rootPath, gs_us_path, menuBuilder, levelDepth,"",levelFlag,eventLeftNavRoot, currPath, currTitle, eventDisplUnder);
%>
<%=menuBuilder%> 
<%
// end main

			//This is handle the case for when on the current page and need to display children below
			} else if((menuPath.indexOf(currPath) == 0) || (currPath.startsWith(menuPath))) {
				if(currPath.equals(menuPath)){
%>
	<li class="active">
<%
				} else {
%>
	 <li id="sub-active">
<%
				}
				if (!"".equals(sLabel)) {
%>
		<div><a href="<%= path %>"><%= sLabel %></a></div>
<% 
				}
				if(currPath.indexOf(menuPath)==0 || (!eventPath.isEmpty() && menuPath.equals(eventPath))){
					buildMenu(iterPage, rootPath, gs_us_path, menuBuilder, levelDepth,"",levelFlag,eventLeftNavRoot, currPath, currTitle, eventDisplUnder);
				}
%>
<%=menuBuilder%>   
<%
			 // This else is to highlight everything when you are on the Home page
			 } else {
%>
		 <li>
			<div><a href="<%= path %>"><%= sLabel %></a></div>
<%
			}
		// Else to handle rest of the menu items 
		} else {
%>
			<div><li><a href="<%= path %>"><%= sLabel %></a></div>
<%
		}
	}
%>  
		</li> 
<% } 
}%>
	</ul> 
</div>
