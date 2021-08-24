package com.fsyj.crm.vo;

/**
 * @author fsyj
 */
public class EchartsDataPair {
    private String name;
    private String value;

    public EchartsDataPair() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "EchartsDataPair{" +
                "name='" + name + '\'' +
                ", value='" + value + '\'' +
                '}';
    }
}
