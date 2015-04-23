package org.apache.hadoop.mapreduce.v2.app;

import org.apache.hadoop.mapreduce.v2.api.records.TaskAttemptId;
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
        TaskAttemptId taskAttemptId = reqEvent.getAttemptID();
        req.addResourceRequestContext("taskAttemptID", taskAttemptId.toString());
        System.out.println(req.requestResourceToNewString());
        System.out.println("******** Map Task Extension Aspect End ********");
    }
}

