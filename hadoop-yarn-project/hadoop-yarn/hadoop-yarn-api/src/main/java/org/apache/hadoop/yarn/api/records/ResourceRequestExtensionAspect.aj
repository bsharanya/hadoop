package org.apache.hadoop.yarn.api.records;


import java.util.HashMap;
import java.util.Map;

public aspect ResourceRequestExtensionAspect {
    public Map<String, String> ResourceRequest.context = null;

    public void ResourceRequest.addContext(String key, String value) {
        if (this.context == null) {
            this.context = new HashMap<String, String>();
        }
        this.context.put(key, value);
        setContext();
    }

    public abstract void ResourceRequest.setContext();
    public abstract Map<String, String> ResourceRequest.getContext();
}
