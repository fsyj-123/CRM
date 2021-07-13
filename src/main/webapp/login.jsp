<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <jsp:include page="comm/base.jsp"/>
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script>
        function login(loginAct, loginPwd) {
            let actVal = loginAct.val();
            let pwdVal = loginPwd.val();
            let msg = $("#msg");
            if (actVal == "" || pwdVal == "") {
                msg.text("账户或密码为空");
                return false;
            }
            $.ajax({
                url: "settings/user.do",
                data: {
                    action: "login",
                    loginAct: actVal,
                    loginPwd: pwdVal
                },
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data.success) {
                        location.href = "workbench/index.jsp";
                    } else {
                        // 登陆失败，回显错误信息
                        msg.text(data.msg);
                    }
                }
            })
        }

        $(function () {
            if(window.top!==window){
                window.top.location=window.location;
            }
            // 在页面加载完成后自动将光标聚焦账号
            let loginAct = $("#loginAct");
            let loginPwd = $("#loginPwd");
            let msg = $("#msg");
            loginAct.val("");
            loginAct.focus();
            $("#subbtn").click(function () {
                login(loginAct, loginPwd);
            });
            $(document).keydown(function (event) {
                if (event.keyCode == 13) {
                    login(loginAct, loginPwd);
                }
            })
        })
    </script>
</head>
<body>
<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
    <img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
</div>
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">
        CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
</div>

<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
    <div style="position: absolute; top: 0px; right: 60px;">
        <div class="page-header">
            <h1>登录</h1>
        </div>
        <form action="workbench/index.jsp" class="form-horizontal" role="form">
            <div class="form-group form-group-lg">
                <div style="width: 350px;">
                    <input class="form-control" id="loginAct" type="text" placeholder="用户名">
                </div>
                <div style="width: 350px; position: relative;top: 20px;">
                    <input class="form-control" id="loginPwd" type="password" placeholder="密码">
                </div>
                <div class="checkbox" style="position: relative;top: 30px; left: 10px;">

                    <span id="msg" style="color: #b92c28"></span>

                </div>
                <%--
                为了防止form表单自动提交，将button的type改为button
                --%>
                <button type="button" class="btn btn-primary btn-lg btn-block" id="subbtn"
                        style="width: 350px; position: relative;top: 45px;">登录
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>