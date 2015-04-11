//package org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity;
//
//
//import org.apache.hadoop.yarn.api.records.Container;
//import org.apache.hadoop.yarn.api.records.Priority;
//import org.apache.hadoop.yarn.api.records.ResourceRequest;
//import org.apache.hadoop.yarn.server.resourcemanager.scheduler.NodeType;
//import org.apache.hadoop.yarn.server.resourcemanager.scheduler.common.fica.FiCaSchedulerNode;
//
//public aspect ContainerContextAdditionAspect
//        percflow(captureContainerAllocationForRequest(NodeType, FiCaSchedulerNode, Priority, ResourceRequest, Container)){
//
//    pointcut captureContainerAllocationForRequest(NodeType nodeType, FiCaSchedulerNode node,
//                                                  Priority priority, ResourceRequest request, Container container)
//            : call(* allocate(NodeType, FiCaSchedulerNode,
//            Priority, ResourceRequest,
//            Container)) && args(nodeType, node, priority, request, container);
//
//    after(NodeType nodeType, FiCaSchedulerNode node,
//           Priority priority, ResourceRequest request, Container container) : captureContainerAllocationForRequest(nodeType, node,
//            priority, request, container) {
//        System.out.println("");
//        System.out.println("******** Capacity Scheduler Extension Aspect Start ********");
//        String taskIds = request.getResourceRequestContext().get("taskId");
//        if (taskIds != null && !taskIds.isEmpty()) {
//            container.addContainerContext("taskId", taskIds);
//            System.out.println("Adding context to Container: TaskID(s)- " + container.getContainerContext().get("taskId"));
//        }
//        System.out.println("******** Capacity Scheduler Extension Aspect End ********");
//    }
//}
