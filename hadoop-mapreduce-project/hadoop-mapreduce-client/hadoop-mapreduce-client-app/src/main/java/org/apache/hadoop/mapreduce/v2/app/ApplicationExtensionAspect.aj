package org.apache.hadoop.mapreduce.v2.app;

import org.apache.hadoop.mapreduce.v2.app.rm.ContainerRequestEvent;
import org.apache.hadoop.yarn.api.records.ResourceRequest;

public aspect ApplicationExtensionAspect {

    pointcut addTaskId(ContainerRequestEvent reqEvent): call(void addMap(ContainerRequestEvent)) && args(reqEvent);
            pointcut addResourceRequest(ResourceRequest req): call(void addResourceRequestToAsk(ResourceRequest)) && args(req);
    pointcut wormhole(ContainerRequestEvent reqEvent, ResourceRequest req): cflow(addTaskId(reqEvent))
    && addResourceRequest(req);

    after(ContainerRequestEvent reqEvent, ResourceRequest req) : wormhole(reqEvent, req) {
        System.out.println("========== * ==========");
        Integer taskId = reqEvent.getAttemptID().getTaskId().getId();
        System.out.println(taskId);
        req.addContext("taskId", taskId.toString());
        System.out.println("========== * ==========");
    }
//    private Integer taskId = -1;
//
//    before(ContainerRequestEvent req): addTaskId(req){
//        System.out.println("========== * ==========");
//        System.out.println("Aspect got called 1.");
//        taskId = req.getAttemptID().getTaskId().getId();
//        System.out.println(req.getAttemptID().getTaskId().getId());
//        System.out.println("========== * ==========");
//    }
//
//    before(ResourceRequest req): addResourceRequest(req) {
//        System.out.println("=============== Remote Request 2 ================");
//        req.addContext("taskId", taskId.toString());
//        req.setContext();
//        System.out.println(req.context);
//        System.out.println("=============== Remote Request 2 ================");
//    }
}