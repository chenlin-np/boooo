<%@page import="java.util.Set,
	java.util.Arrays,
	java.util.Iterator,
	javax.servlet.jsp.PageContext,
	javax.servlet.jsp.JspWriter,
	org.slf4j.Logger,
	org.slf4j.LoggerFactory,
	org.apache.sling.api.resource.ResourceResolver,
	com.day.cq.dam.commons.util.PrefixRenditionPicker,
	com.day.cq.dam.api.Asset,
	com.day.cq.dam.api.Rendition,
	com.day.cq.wcm.api.Page,
	com.day.cq.wcm.api.components.IncludeOptions,
	java.util.Calendar,
	java.util.Date,
	java.text.DateFormat" %>
<%
Page homepage = currentPage.getAbsoluteParent(2);
ValueMap currentSite = homepage.getContentResource().adaptTo(ValueMap.class);
%>
<%!
public static final int BREAKPOINT_MAX_LARGE = 1120;
public static final int BREAKPOINT_MAX_MEDIUM = 1024;
public static final int BREAKPOINT_MAX_SMALL = 640;

private static Logger log = LoggerFactory.getLogger("northpoint.components.global");
public void setCssClasses(String tags, HttpServletRequest request) {
	IncludeOptions opt = IncludeOptions.getOptions(request, true);
	Set<String> classes = opt.getCssClassNames();
	classes.addAll(Arrays.asList(tags.split(" ")));
}

public void setHtmlTag(String tag, HttpServletRequest request) {
	IncludeOptions opt = IncludeOptions.getOptions(request, true);
	opt.setDecorationTagName(tag);
}

public String genLink(ResourceResolver rr, String link) {
    // This is a Page resource but yet not end with ".html": append ".html"
    if (!link.contains(".html") && rr.resolve(link).getResourceType().equals("cq:Page") ) {
        return link + ".html";
    // Well, do nothing
    } else {
        return link;
    }
}

public String displayRendition(ResourceResolver rr, String imagePath, String renditionStr) {
	return displayRendition(rr, imagePath, renditionStr, null, -1);
}

public String displayRendition(ResourceResolver rr, String imagePath, String renditionStr, String additionalCss, int imageWidth) {
	if (renditionStr == null) return null;
	StringBuffer returnImage = new StringBuffer("<img ");
	try {
		Resource imgResource = rr.resolve(imagePath);
		ValueMap properties = imgResource.adaptTo(ValueMap.class);
		
		String fileReference = properties.get("fileReference", "");
		Asset asset;
		if (!fileReference.isEmpty()) {
		    // fileRefence. Assuming this resource is an image component instance.
			asset = rr.resolve(fileReference).adaptTo(Asset.class);
		} else {
		    // fileRefence empty. Assuming this resource is a DAM asset.
		    asset = imgResource.adaptTo(Asset.class);
		}
		
		boolean isOriginal = false;
		Rendition rendition = asset.getRendition(new PrefixRenditionPicker(renditionStr));
		if (rendition == null) {
		    isOriginal = true;
		    rendition = asset.getOriginal();
		}
		String src = "src=\"" + rendition.getPath() + "\" ";
		
		String alt = properties.get("alt", "");
		if (!alt.isEmpty()) {
		    alt = "alt=\"" + alt + "\" ";
		} else {
			alt=" alt=\"image description unavailable\" ";
		}
		String title = properties.get("jcr:title", "");
		if (!title.isEmpty()) {
		    title= "title=\"" + title+ "\" ";
		}

		String width = "";
		String height = "";
                if (imageWidth > 0) {
                    width = "width=\"" + imageWidth + "\" ";
                } else {
			if (isOriginal) {
			    String[] renditionParams = renditionStr.split("\\.");
			    if (renditionParams.length >= 4) {
				width = "width=\"" + renditionParams[2] + "\" ";
				height = "height=\"" + renditionParams[3] + "\" ";
			    }
			}
                }
		
		String css = "";
		if (additionalCss != null) {
			css = "class=\"" + additionalCss + "\" ";
		}

		returnImage.append(css);
		returnImage.append(title);
		returnImage.append(alt);
		returnImage.append(width);
		returnImage.append(height);
		returnImage.append(src);
	} catch (Exception e) {
		log.error("Cannot include an image rendition: " + imagePath + "|" + renditionStr);
		return "";
	}
	returnImage.append("/>");
        return returnImage.toString();
}
%>
<%!
	public String createHref(Page page) {
		String href = "<a href=" + page.getPath() + ".html" + ">"
				+ page.getTitle() + "</a>";
		return href;
}%>


<%!
public static String getDateTime(Date startDate, Date endDate,DateFormat dateFormat,DateFormat timeFormat,String dateStr){
	 Calendar cal2 = Calendar.getInstance();
     Calendar cal3 = Calendar.getInstance();
     cal2.setTime(startDate);
     cal3.setTime(endDate);
     boolean sameDay = cal2.get(Calendar.YEAR) == cal3.get(Calendar.YEAR) &&
                       cal2.get(Calendar.DAY_OF_YEAR) == cal3.get(Calendar.DAY_OF_YEAR);
     String endDateStr = dateFormat.format(endDate);
     String endTimeStr = timeFormat.format(endDate);
     if (!sameDay) {
 	      dateStr += " - " + endDateStr +", " + endTimeStr;
 	   }else
 	   {
 		   dateStr += " - " + endTimeStr;

 		}
	return dateStr;
}


%>
