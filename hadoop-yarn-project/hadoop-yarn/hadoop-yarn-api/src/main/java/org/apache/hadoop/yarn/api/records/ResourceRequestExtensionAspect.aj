package org.apache.hadoop.yarn.api.records;


import java.util.HashMap;
import java.util.Map;

public aspect ResourceRequestExtensionAspect {
    public Map<String, String> ResourceRequest.resourceRequestContext = null;

    public String ResourceRequest.requestResourceToNewString() {
            return "Resource Request: [ Location: " + getResourceName()
                + ", Relax Locality: " + getRelaxLocality() + ", Number of Containers: " + getNumContainers()
                    + "TaskAttempt ID(s): " + getResourceRequestContext().get("taskAttemptID") +  " ]";
    }

    public void ResourceRequest.addResourceRequestContext(String key, String value){
        if (this.resourceRequestContext == null) {
            this.resourceRequestContext = new HashMap<String, String>();
        }

        if (this.resourceRequestContext.containsKey(key)) {
            String presentValue = this.resourceRequestContext.get(key);
            String newValue = presentValue + ":" + value;
            this.resourceRequestContext.put(key, newValue);
        } else {
            this.resourceRequestContext.put(key, value);
        }
        setResourceRequestContext();
    }

    public abstract void ResourceRequest.setResourceRequestContext();
    public abstract Map<String, String> ResourceRequest.getResourceRequestContext();
}
