package com.woxiaobao.web


import org.springframework.beans.BeanWrapper
import org.springframework.beans.PropertyAccessorFactory

import grails.converters.JSON


class CodeController {

    def index() {
        redirect action:'list'
    }

    def list() {
        def result = [total:0, data:[]]
		def datalist = []


        def data = []
        for (controller in grailsApplication.controllerClasses) {
            def controllerInfo = [:]
            controllerInfo.controller = controller.logicalPropertyName
            controllerInfo.controllerName = controller.fullName
            List actions = []
            BeanWrapper beanWrapper = PropertyAccessorFactory.forBeanPropertyAccess(controller.newInstance())
            for (pd in beanWrapper.propertyDescriptors) {
                String closureClassName = controller.getPropertyOrStaticPropertyOrFieldValue(pd.name, Closure)?.class?.name
                if (closureClassName) actions << pd.name
            }
            controllerInfo.actions = actions.sort()
            data << controllerInfo
        }
        print data as JSON

//		params.offset = params.offset? params.offset as int : 0
//        params.max = params.max? params.max as int : 10
//        def SEARCH_COUNT_N1QL = 'SELECT count(*) as count FROM default where type="code"'
//        if(params.code) {
//            SEARCH_COUNT_N1QL = "$SEARCH_COUNT_N1QL and code like '%$params.code%'"
//        }
//        print SEARCH_COUNT_N1QL
//        N1qlQueryResult countQuery = CBC.bucket.query(N1qlQuery.simple(SEARCH_COUNT_N1QL));
//        def total = countQuery.rows().next().value().count
//        if(total>0) {
//            result.total = total
//            def SEARCH_N1QL = 'SELECT id,code,message,description FROM default where type="code"'
//
//            if(params.code) {
//                SEARCH_N1QL = "$SEARCH_N1QL and code like '%$params.code%' "
//            }
//            SEARCH_N1QL ="$SEARCH_N1QL OFFSET $params.offset LIMIT $params.max"
//            N1qlQueryResult query = CBC.bucket.query(N1qlQuery.simple(SEARCH_N1QL));
//            def it = query.rows()
//            while(it.hasNext()) {
//                result.data << it.next().value()
//            }
//        }
		result
    }

    def edit() {
        def result = []
        result
    }

    def delete() {
        try {
            def docid = "code:$params.id"
            render 'success'
        } catch (Exception e) {
            render e.message
        }
    }

    def save() {
        def result = "success"
        def newData = [:]
       
        render result
    }


    /**
	 * 详情
	 */
	private def getOne(def id) {
		
	}
}
