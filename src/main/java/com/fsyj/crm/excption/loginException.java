package com.fsyj.crm.excption;

public class loginException extends RuntimeException {
    private String msg;
    public loginException(String msg) {
        super(msg);
    }

    public loginException() {
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
