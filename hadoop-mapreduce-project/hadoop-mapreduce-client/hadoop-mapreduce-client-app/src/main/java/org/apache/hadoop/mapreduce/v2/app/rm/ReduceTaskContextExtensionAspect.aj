//package org.apache.hadoop.mapreduce.v2.app.rm;
//
//import org.apache.hadoop.mapreduce.v2.api.records.TaskId;
//import org.apache.hadoop.yarn.api.records.ResourceRequest;
//
//public aspect ReduceTaskContextExtensionAspect percflow(wormholeForReduce(org.apache.hadoop.mapreduce.v2.app.rm.RMContainerRequestor.ContainerRequest, ResourceRequest)){
//
//    pointcut captureContainerRequestForMap(RMContainerAllocator.ContainerRequest reqEvent): call(void addReduce(org.apache.hadoop.mapreduce.v2.app.rm.RMContainerRequestor.ContainerRequest)) && args(reqEvent);
//    pointcut addResourceRequestForMap(ResourceRequest req): call(void addResourceRequestToAsk(ResourceRequest)) && args(req);
//    pointcut wormholeForReduce(RMContainerAllocator.ContainerRequest reqEvent, ResourceRequest req): cflow(captureContainerRequestForMap(reqEvent))
//            && addResourceRequestForMap(req);
//
//    after(RMContainerAllocator.ContainerRequest reqEvent, ResourceRequest req) : wormholeForReduce(reqEvent, req) {
//        System.out.println("");
//        System.out.println("******** Reduce Task Extension Aspect Start ********");
//        TaskId taskId = reqEvent.attemptID.getTaskId();
//        req.addResourceRequestContext("taskId", taskId.toString());
//        System.out.println("Adding context to ResourceRequest: TaskID(s) - " + req.getResourceRequestContext().get("taskId"));
//        System.out.println("******** Reduce Task Extension Aspect End ********");
//    }
//}