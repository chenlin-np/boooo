<%@ page import="com.day.cq.tagging.TagManager,java.util.ArrayList,java.util.HashSet,java.text.DateFormat,java.text.SimpleDateFormat,java.util.Date,
                 java.util.Locale,java.util.Map,java.util.Arrays,java.util.Iterator,java.util.HashMap,java.util.List,java.util.Set,com.day.cq.search.result.SearchResult,
                 java.util.ResourceBundle,com.day.cq.search.QueryBuilder,javax.jcr.PropertyIterator,com.northpoint.basics.events.search.SearchResultsInfo,
                 com.day.cq.i18n.I18n,org.apache.sling.api.resource.ResourceResolver,com.northpoint.basics.events.search.EventsSrch,com.northpoint.basics.events.search.FacetsInfo,java.util.Calendar,java.util.TimeZone" %>

<%@include file="/libs/foundation/global.jsp"%>
<!-- apps/northpoint/components/event-search-list/feature-events.jsp -->
<cq:includeClientLib categories="apps.northpoint" />
<cq:defineObjects/>
<% 
  DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.S");
  fromFormat.setCalendar(Calendar.getInstance(TimeZone.getTimeZone("GMT")));
  DateFormat toFormat = new SimpleDateFormat("EEE dd MMM yyyy");
  SearchResultsInfo srchInfo = (SearchResultsInfo)request.getAttribute("eventresults");
  Map<String, String> results = srchInfo.getResults();

  int eventcounts = 0;
  String key="";
  String value="";
  
  if(properties.containsKey("eventcount")){
	  eventcounts =  Integer.parseInt(properties.get("eventcount",String.class));
	  if(eventcounts > results.size()){
		  eventcounts = results.size();
	  }
  }
  
  
  Set<String>set = results.keySet();
  
  Object[] keys = set.toArray();
  
  
  %>
  <div>
            <img src="<%=properties.get("fileReference", String.class)%>"/><%=properties.get("featuretitle",String.class) %>
  </div>
  
  <% 
  
  for(int i=0;i<eventcounts;i++){
	 key =(String) keys[i];
	 value = results.get(key);
	
	 Node node = resourceResolver.getResource(value).adaptTo(Node.class);
	 Node propNode = node.getNode("jcr:content/data");
     String title = propNode.getProperty("jcr:title").getString();
     String href = value+".html";
     String fromdate = propNode.getProperty("start").getString();
     String todate="";
     Date tdt = null;
     if(propNode.hasProperty("end")){
         todate = propNode.getProperty("end").getString();
         tdt = fromFormat.parse(todate);
     }
     //String location = resourceResolver.getResource(propNode.getProperty("location").getString()).adaptTo(Page.class).getTitle();
     
     Date fdt = fromFormat.parse(fromdate);
	  
  
    
%>
  <div>
        <p>
             <a href="<%=href%>"><%=title %></a>
           <br/> Date : <%=toFormat.format(fdt)%> <%if(propNode.hasProperty("end")) {%> to <%=toFormat.format(tdt) %> <%}%>  
        </p>
  </div> 
  
     
 <%}%>
  <div>
    <%
      if(properties.containsKey("urltolink")){
    %>	  
    	<a href="<%=properties.get("urltolink")%>.html"><%=properties.get("linktext")%></a>
    	  
     <% }
    
    %>
  
  </div>
