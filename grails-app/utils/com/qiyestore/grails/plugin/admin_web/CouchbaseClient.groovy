package com.qiyestore.grails.plugin.admin_web
//import com.couchbase.client.java.CouchbaseCluster
// import com.couchbase.client.java.document.JsonDocument
// import com.couchbase.client.java.document.json.JsonObject


class CouchbaseClient {
	
	private static def host = "127.0.0.1"
	private static def bucketName = "default"
	private static def bucketPassword = ""

    private static def cluster
    private static def bucket
	
	static{
		//cluster = CouchbaseCluster.create(host)
		//bucket = cluster.openBucket(bucketName)
	}
    
//    static connect(def host, def bucketName, def bucketPassword) {
//        cluster = CouchbaseCluster.create(host)
//        bucket = cluster.openBucket(bucketName, bucketPassword)
//    }
    
    
    static disconnect() {
        //cluster.disconnect()
    }
    
    static getBucket() {
        //return bucket
    }
    
}