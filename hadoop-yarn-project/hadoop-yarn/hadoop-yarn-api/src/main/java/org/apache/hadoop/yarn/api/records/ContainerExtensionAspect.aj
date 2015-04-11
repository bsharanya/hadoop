package org.apache.hadoop.yarn.api.records;


import java.util.HashMap;
import java.util.Map;

public aspect ContainerExtensionAspect {
    public Map<String, String> Container.containerContext = null;

    public String Container.containerToNewString() {
        return "Container: [ ContainerId: " + getId() + ", NodeId: " + getNodeId() + ", " + " Task ID(s): " + getContainerContext().get("taskId") + " ]";
    }

    public void Container.addContainerContext(String key, String value) {
        if (this.containerContext == null) {
            this.containerContext = new HashMap<String, String>();
        }

        if (this.containerContext.containsKey(key)) {
            String presentValue = this.containerContext.get(key);
            String newValue = presentValue + ":" + value;
            this.containerContext.put(key, newValue);
        } else {
            this.containerContext.put(key, value);
        }
        setContainerContext();
    }

    public void Container.resetContext(String key) {
        if (this.containerContext.containsKey(key)) {
            this.containerContext.remove(key);
        }
        setContainerContext();
    }

    public abstract void Container.setContainerContext();
    public abstract Map<String, String> Container.getContainerContext();
}
