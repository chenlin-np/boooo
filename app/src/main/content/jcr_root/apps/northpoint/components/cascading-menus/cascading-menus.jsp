<%@page import="java.util.Iterator, java.util.HashSet,java.util.Set, java.util.Arrays, org.slf4j.Logger,org.slf4j.LoggerFactory, javax.jcr.Node" %>
<%@include file="/libs/foundation/global.jsp"%>
<%@include file="/apps/northpoint/components/global.jsp" %>
<cq:includeClientLib categories="apps.northpoint" />
<cq:defineObjects />


<%!public void buildMenu(Iterator<Page> iterPage, String rootPath,
			String language_path, StringBuilder menuBuilder, int levelDepth,
			String ndePath, boolean levelFlag, String eventLeftNavRoot,
			String currPath, String currTitle, String eventDispUnder,
			String showCurrent) throws RepositoryException {
		levelDepth++;
		if(iterPage!=null){
		if (iterPage.hasNext()) {
			if (levelDepth == 1) {
				menuBuilder.append("<ul class=\"side-nav\" style=\"padding:0px\">");
			} else {
				menuBuilder.append("<ul>");
			}
			while (iterPage.hasNext()) {
				Page page = iterPage.next();
				int dept = page.getDepth();
				String nodePath = page.getPath().substring(language_path.length() + 1, page.getPath().length());
				showCurrent = page.getParent().getProperties().get("showCurrent", "false");
				
				// Check to see if the current path startsWith the node which we are traversing
				if (rootPath.startsWith(nodePath)) {
					/**** Check to see if the current folder hideInNav is not set to true, if it's set ********** 
					***** set to true, we don't display is but look to the next node, this is necessary to highlighting the**** 
					***** special form condition.******/

					// This string buffer properly closes dangling li elements
					StringBuffer remainderStrings = new StringBuffer();
					if (!page.isHideInNav()) {
						if (rootPath.equalsIgnoreCase(nodePath) && showCurrent.equals("false")) {
							menuBuilder.append("<li class=\"active current\">");
							menuBuilder.append("<div>");
							menuBuilder.append(createHref(page));
							menuBuilder.append("</div>");
							remainderStrings.append("</li>");
						} else {
							if (levelFlag && page.listChildren().hasNext()) {
								menuBuilder.append("<li class=\"active\">");
								menuBuilder.append("<div>");
								menuBuilder.append(createHref(page));
								menuBuilder.append("</div>");
								remainderStrings.append("</li>");
								levelFlag = false;
							} else {
								if (rootPath.equals(nodePath)) {
									menuBuilder.append("<li class=\"active current\">");
								} else {
									menuBuilder.append("<li>");
								}
								menuBuilder.append("<div>");
								menuBuilder.append(createHref(page));
								menuBuilder.append("</div>");
								remainderStrings.append("</li>");
							}
						}
					}
					Iterator<Page> p = page.listChildren();
					if (p.hasNext()) {
						buildMenu(p, rootPath, language_path, menuBuilder,
								levelDepth, nodePath, levelFlag,
								eventLeftNavRoot, currPath, currTitle,
								eventDispUnder, showCurrent);
					}
					menuBuilder.append(remainderStrings.toString());
				} else {
					/*** Below if eventLeftNavRoot is to handle a special case for events. Events is create at separate location
					 ***  and when event is click event name need to be displayed in the left navigation
					*/
					if (eventLeftNavRoot!=null && page.getPath().indexOf(eventLeftNavRoot) == 0 && eventDispUnder!=null && currPath.indexOf(eventDispUnder) == 0) {
						menuBuilder.append("<li class=\"active\">");
						menuBuilder.append("<div>");
						menuBuilder.append(createHref(page));
						menuBuilder.append("</div>");

						menuBuilder.append("<ul><li class=\"active current\">");
						menuBuilder.append("<div><a href=")
								.append(currPath + ".html").append(">")
								.append(currTitle).append("</a></div>");
						menuBuilder.append("</li></ul>");
                                                menuBuilder.append("</li>");

					} else {
						/*****This showCurrent is for the highligting form *******
						 **** Top folder under which forms resides has a property "showCurrent = true" *****
						 ***** which we are using to display the form it form is in the URL path and parent of it is set ****
						 ***** to "true" else we are not displaying that content *******/
						if (showCurrent.equals("false") && !page.isHideInNav()) {
							menuBuilder.append("<li>");
							menuBuilder.append("<div>");
							menuBuilder.append(createHref(page));
							menuBuilder.append("</div>");
							menuBuilder.append("</li>");
						}
					}
				}
			}
		}
		}
                menuBuilder.append("</ul>");
	}
%>

<%
  // GET THE STRUCTURE FROM THE CURRENTPATH
  int parentLevel = properties.get("parentLevel",3);
  String curPath = currentPage.getPath();
  String curTitle = currentPage.getTitle();
  int levelDepth = 0;
  StringBuilder menuBuilder = new StringBuilder();
  //path example: currentPage = /content/northpoint/en/about/who-we-are'
if(currentPage.getDepth()>3){
  // language path. eg:/content/northpoint/en/
  String language_path = currentPage.getAbsoluteParent(2).getPath();

  //path started from the global nav page. eg:about/who-we-are
  String rootPath = currentPage.getPath().substring(language_path.length()+1, curPath.length());  
  //Level three Global Nav path. eg:/content/northpoint/en/about
  String navigationRoot = currentPage.getAbsoluteParent(parentLevel).getPath();
  String showCurrent = "false";
  
  boolean levelFlag = true;
  Iterator<Page> iterPage = resourceResolver.getResource(navigationRoot).adaptTo(Page.class).listChildren();
 
 // Handling events
  String eventGrandParent = currentPage.getParent().getParent().getPath();
  String eventLeftNavRoot = currentSite.get("leftNavRoot", String.class);
  String eventDisplUnder = currentSite.get("eventPath", String.class);
  boolean includeUL=false;
  String insertAfter="";
 if(eventGrandParent.equalsIgnoreCase(currentSite.get("eventPath", String.class))){
	 if(eventLeftNavRoot!=null){
     	String eventPath = eventLeftNavRoot.substring(0,eventLeftNavRoot.lastIndexOf("/"));
     	iterPage = resourceResolver.getResource(eventPath).adaptTo(Page.class).listChildren();
	   }else{
		iterPage = null;
	   }
 }
 buildMenu(iterPage, rootPath, language_path, menuBuilder, levelDepth,"",levelFlag,eventLeftNavRoot, curPath, curTitle, eventDisplUnder, showCurrent);
}else{
    menuBuilder.append("Cascading Menu is not designed for homepage.");
}

 %>
 <%=menuBuilder %>
<script>
	$(document).ready(function() {
		$('#main .side-nav li.active.current').parent().parent().find(">div>a").css({"font-weight":"bold", "color":"#414141"});
	});
</script>
