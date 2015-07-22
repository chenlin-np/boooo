<%@include file="/libs/foundation/global.jsp"%>
<!-- apps/northpoint/components/two-column-page/content.jsp -->
<!--PAGE STRUCTURE: MAIN-->
<div id="main" class="row">
    <!--PAGE STRUCTURE: LEFT CONTENT START-->
    <div class="large-5 hide-for-medium hide-for-small columns mainLeft">
        <div id="leftContent">
            <cq:include script="left.jsp" />
        </div>
    </div>
    <!--PAGE STRUCTURE: LEFT CONTENT STOP-->
    
    <!--PAGE STRUCTURE: MAIN CONTENT START-->
    <div class="large-19 medium-24 small-24 columns mainRight">
        <div class="breadcrumbWrapper">
            <cq:include path="content/middle/breadcrumb" resourceType="northpoint/components/breadcrumb-trail" />
        </div>
        <div class="row mainRightBottom rightBodyLeft">
            <cq:include script="middle.jsp" />
        </div>
    </div>
    <!--PAGE STRUCTURE: MAIN CONTENT STOP-->
</div>
