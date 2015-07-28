<%@include file="/libs/foundation/global.jsp" %>
<%@ page import="java.io.IOException,
   com.day.cq.wcm.foundation.forms.FormsHelper,
   com.day.cq.wcm.foundation.forms.LayoutHelper,
    
   java.util.Locale,
   java.util.ResourceBundle,
   com.day.cq.i18n.I18n"%><%
   
	final Locale pageLocale = currentPage.getLanguage(true);
	final ResourceBundle resourceBundle = slingRequest.getResourceBundle(pageLocale);
	I18n i18n = new I18n(resourceBundle);  
	
    final String title = FormsHelper.getTitle(resource, i18n.get("Captcha"));
    final boolean required = FormsHelper.isRequired(resource);
    final boolean hideTitle = properties.get("hideTitle", false);
   
%>
<script type="text/javascript">
    var captchaStartTime = 0;

    function captchaRefresh() {
        var captchakey = ("" + Math.random()).substring(3, 8);
        var captchaimg = document.getElementById("cq_captchaimg");
        var captchakeyelem = document.getElementById("cq_captchakey");
        captchaimg.src = CQ.shared.HTTP.getXhrHookedURL(CQ.shared.HTTP.externalize("<%= resource.getPath() %>.captcha.png?id=" + captchakey));
        captchakeyelem.value = captchakey;
        captchaStartTime = new Date().getTime();
    }

    function captchaTimer() {
        var now = new Date().getTime();
        if ((now - captchaStartTime) > 60000) {
            captchaRefresh();
        }
        var captchatimer = document.getElementById("cq_captchatimer");
        if (!captchatimer) {
            // captcha has been removed
            return;
        }
        var width = Math.floor((60000 - (now - captchaStartTime)) / 60000 * 64);
        captchatimer.innerHTML = "<div class=\"form_captchatimer_bar\" style=\"width:" + width + "px;\"></div>";
        window.setTimeout(captchaTimer, 500);
    }
</script>
<input type="hidden" name=":cq:captchakey" id="cq_captchakey" value=""/>
<div class="form_row">
    <% LayoutHelper.printTitle(":cq:captcha", title, required, hideTitle, out); %>
    <div class="form_rightcol">
        <div class="form_captcha_input"><input type="text" id=":cq:captcha" name=":cq:captcha" class="<%= FormsHelper.getCss(properties, "form_field form_field_text") %>" size="6"/></div>
        <div class="form_captcha_img"><img id="cq_captchaimg" src="<%= resource.getPath() %>.captcha.png?id=123" alt=""></div>
        <div class="form_captcha_refresh">
            <%--use a tag instead of button in foundation--%>
        	<a href="#" onclick="captchaRefresh(); return false;">Refresh</a>
        </div>
    </div>
</div>
<%--remove the timer bar--%>
<%-- <div class="form_row">
    <%// LayoutHelper.printTitle(null, null, false, hideTitle, out); %>
    <div class="form_rightcol"><div id="cq_captchatimer" class="form_captchatimer" style="width: 63px;"></div></div>
</div>
--%>
<script type="text/javascript">
        captchaTimer();
</script><%
    LayoutHelper.printDescription(FormsHelper.getDescription(resource, ""), out);
    LayoutHelper.printErrors(slingRequest, ":cq:captcha", hideTitle, out);
%>
