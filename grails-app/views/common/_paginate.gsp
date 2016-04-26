<g:set var="offset" value="${Long.valueOf(params.offset?:0)}" />
<g:set var="max" value="${Long.valueOf(params.max?:10)}" />
<g:set var="total" value="${totalCount?:0}" />
<g:set var="currentPageNum" value="${(offset/max)+1 as int}" />
<g:set var="totalPageNum" value="${Math.ceil(total/max) as int}" />

<div class="col-xs-3"><div style="padding:5px 0px;">

    <g:if test="${totalCount>0}">
    ${offset + 1}-${currentPageNum<totalPageNum? offset + max : totalCount}  共 ${totalCount} 条
    </g:if>
    <g:else>无查询结果</g:else>
    </div></div>
<div class="col-xs-9">
    <ul class="pagination pagination-sm no-margin pull-right">
    	<g:if test="${currentPageNum > 1}">
        <li><a href="${createLink(controller: controllerName, action: actionName,params: params << [offset: 0, max: max])}">首页</a></li>
        <li><a href="${createLink(controller: controllerName, action: actionName,params: params << [offset: (offset-max), max: max])}">« 上一页</a></li>
      </g:if>
    	
    	<g:set var="minPageNum" value="${currentPageNum > 1 ? (currentPageNum - 1) : 1}" />
    	<g:set var="maxPageNum" value="${minPageNum+2}" />	  	
	  	
		<g:if test="${maxPageNum>=totalPageNum-2}">
			<g:set var="maxPageNum" value="${totalPageNum>0? totalPageNum: 1}" />
			<g:set var="minPageNum" value="${minPageNum==1? minPageNum : (totalPageNum-4>0 ? totalPageNum-4 : 1)}" />
		</g:if>
	  	<g:each var="p" in="${minPageNum..maxPageNum}">
	  		<g:if test="${p == currentPageNum}"><li class="active"><a href="#">${p}</a></li></g:if>
	  		<g:else><li><a href="${createLink(controller: controllerName, action: actionName,params: params << [offset: (p-1)*max, max: max])}">${p}</a></li></g:else>
	  	</g:each>
        <g:if test="${maxPageNum<totalPageNum}">
        	<li class="disable"><a>...</a></li>
        	<li><a href="${createLink(controller: controllerName, action: actionName,params: params << [offset: (totalPageNum-1)*max, max: max])}">${totalPageNum}</a></li>	
        </g:if>
        <g:if test="${totalPageNum > currentPageNum}"><li><a href="${createLink(controller: controllerName, action: actionName,params: params << [offset: (offset+max), max: max])}">下一页 »</a></li></g:if>
    </ul>
</div>