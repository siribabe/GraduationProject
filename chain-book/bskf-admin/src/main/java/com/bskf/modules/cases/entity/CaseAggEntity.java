package com.bskf.modules.cases.entity;

import java.io.Serializable;

public class CaseAggEntity implements Serializable {
    /**
     *
     */
    private static final long serialVersionUID = 1L;
    private String cKey;
    private int cValue;

    /**
     * @return the cKey
     */
    public String getcKey() {
        return cKey;
    }

    /**
     * @param cKey the cKey to set
     */
    public void setcKey(String cKey) {
        this.cKey = cKey;
    }

    /**
     * @return the cValue
     */
    public int getcValue() {
        return cValue;
    }

    /**
     * @param cValue the cValue to set
     */
    public void setcValue(int cValue) {
        this.cValue = cValue;
    }
}
