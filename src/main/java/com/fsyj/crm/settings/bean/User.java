package com.fsyj.crm.settings.bean;

public class User {
    /*
    常用的两种表示时间的方式
    1、yyyy-MM-dd（日期）
    2、yyyy-MM-dd HH:mm:ss（日期+时间）
     */

    /*
    用户登陆验证
    User user = select * from tbl_user where loginAct = ? and loginPwd = ?
    if (user == null) {
        账号或密码错误
    } else {
        1、验证失效时间
        2、验证锁定状态
        3、验证IP地址
    }
     */
    private String id;  // 主键
    private String loginAct;  // 登陆账号
    private String name;  // 用户真实姓名
    private String loginPwd;  // 登陆密码
    private String email;  // 用户邮箱
    private String expireTime;  // 失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。
    private String lockState;  // 锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。
    private String deptno;  // 部门编号
    private String allowIps;  // 运行登陆的IP地址
    private String createTime;  // 创建时间
    private String createBy;  // 创建人
    private String editTime;  // 上一次修改时间
    private String editBy;  // 上一次修改人

    public User() {
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLoginAct() {
        return loginAct;
    }

    public void setLoginAct(String loginAct) {
        this.loginAct = loginAct;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLoginPwd() {
        return loginPwd;
    }

    public void setLoginPwd(String loginPwd) {
        this.loginPwd = loginPwd;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(String expireTime) {
        this.expireTime = expireTime;
    }

    public String getLockState() {
        return lockState;
    }

    public void setLockState(String lockState) {
        this.lockState = lockState;
    }

    public String getDeptno() {
        return deptno;
    }

    public void setDeptno(String deptno) {
        this.deptno = deptno;
    }

    public String getAllowIps() {
        return allowIps;
    }

    public void setAllowIps(String allowIps) {
        this.allowIps = allowIps;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getEditTime() {
        return editTime;
    }

    public void setEditTime(String editTime) {
        this.editTime = editTime;
    }

    public String getEditBy() {
        return editBy;
    }

    public void setEditBy(String editBy) {
        this.editBy = editBy;
    }

    @Override
    public String toString() {
        return "User{" +
                "id='" + id + '\'' +
                ", loginAct='" + loginAct + '\'' +
                ", name='" + name + '\'' +
                ", loginPwd='" + loginPwd + '\'' +
                ", email='" + email + '\'' +
                ", expireTime='" + expireTime + '\'' +
                ", lockState='" + lockState + '\'' +
                ", deptno='" + deptno + '\'' +
                ", allowIps='" + allowIps + '\'' +
                ", createTime='" + createTime + '\'' +
                ", createBy='" + createBy + '\'' +
                ", editTime='" + editTime + '\'' +
                ", editBy='" + editBy + '\'' +
                '}';
    }
}
