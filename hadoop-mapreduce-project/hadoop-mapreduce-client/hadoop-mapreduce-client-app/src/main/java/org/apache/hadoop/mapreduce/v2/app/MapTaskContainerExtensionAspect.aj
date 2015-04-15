package org.apache.hadoop.mapreduce.v2.app;

import org.apache.hadoop.mapreduce.v2.api.records.TaskId;
import org.apache.hadoop.mapreduce.v2.app.rm.ContainerRequestEvent;
import org.apache.hadoop.yarn.api.records.ResourceRequest;

public aspect MapTaskContainerExtensionAspect percflow(wormholeForMap(ContainerRequestEvent, ResourceRequest)){

    pointcut captureContainerRequestForMap(ContainerRequestEvent reqEvent): call(void addMap(ContainerRequestEvent)) && args(reqEvent);
    pointcut addResourceRequestForMap(ResourceRequest req): call(void addResourceRequestToAsk(ResourceRequest)) && args(req);
    pointcut wormholeForMap(ContainerRequestEvent reqEvent, ResourceRequest req): cflow(captureContainerRequestForMap(reqEvent))
    && addResourceRequestForMap(req);

    after(ContainerRequestEvent reqEvent, ResourceRequest req) : wormholeForMap(reqEvent, req) {
        System.out.println("");
        System.out.println("******** Map Task Extension Aspect Start ********");
        TaskId taskId = reqEvent.getAttemptID().getTaskId();
        req.addResourceRequestContext("taskId", taskId.toString());
        String random = taskId.toString();
//        if(random.endsWith("000191")) {
//            System.out.println("MADHU: @@@@@@@@@@@@@@@@@@@@@@@@");
//            System.out.println(req.getResourceName());
//            System.out.println("MADHU: @@@@@@@@@@@@@@@@@@@@@@@@");
//        }
        System.out.println(req.requestResourceToNewString());
        System.out.println("******** Map Task Extension Aspect End ********");
    }
}

