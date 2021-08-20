<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <jsp:include page="../../comm/base.jsp"/>
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>

    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <script type="text/javascript">
        //序列化表单字段为json对象
        $.fn.serializeFormToJson = function () {
            let arr = $(this).serializeArray();//form表单数据 name：value
            let param = {};
            $.each(arr, function (i, obj) { //将form表单数据封装成json对象
                param[obj.name] = obj.value;
            })
            return param;
        }
        // 创建交易 选择市场活动源
        function submitAct() {
            /*
            1、将选中的市场活动名称填入activityName
            2、将市场活动ID填入activityId
             */
            let tr = $("input[name=activity]:checked").parent().parent();
            $("#activityName").val(tr.children()[1].innerText);
            $("#activityId").val($("input[name=activity]:checked").val());
            $("#searchActivityModal").modal("hide")
        }
        $(function () {

            // 时间控件
            $(".time").datetimepicker({
                minView: "month",
                language: 'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "bottom-left"
            });

            $("#isCreateTransaction").click(function () {
                if (this.checked) {
                    $("#create-transaction2").show(200);
                } else {
                    $("#create-transaction2").hide(200);
                }
            });

            // 转换---
            $("#convertBtn").click(function () {
                let checked = $("#isCreateTransaction").prop("checked");
                let json = $("#activityForm").serializeFormToJson();
                // 填充json对象
                json["clueId"] = "${param.id}";
                json["checked"] = checked;
                json["action"] = "convert";
                console.log(json)
                $.ajax({
                    url: "workbench/clue.do",
                    data: json,
                    dataType: "json",
                    type:"post",
                    success: function (data) {
                        if (data.success) {
                            window.location.href = "workbench/clue/index.jsp"
                        }
                    }
                })
            })


            // 模态窗口---搜索市场活动
            $("#search-activity").keydown(function (event) {
                if (event.keyCode === 13) {
                    /*
                    1、获取输入框内容
                    2、将数据解析显示
                     */
                    let text = $.trim($(this).val());
                    if (text === "") {
                        alert("输入不能为空")
                        return false;
                    }
                    $.ajax({
                        url: "workbench/activity.do",
                        data: {
                            action: "listActionByCondition",
                            text: text
                        },
                        dataType: "json",
                        type: "get",
                        success: function (data) {
                            if (data.success) {
                                let html = "";
                                $.each(data.actionList, function (index, item) {
                                    console.log(item)
                                    html += "<tr>";
                                    html += "<td><input type=\"radio\" name=\"activity\" value=" + item.id + "></td>"
                                    html += "<td>" + item.name + "</td>";
                                    html += "<td>" + item.startDate + "</td>";
                                    html += "<td>" + item.endDate + "</td>";
                                    html += "<td>" + item.owner + "</td>";
                                    html += "</tr>";
                                })
                                $("#bindBody").html(html);
                            }
                        }
                    })
                    return false;
                }
            })

        });
    </script>

</head>
<body>

<!-- 搜索市场活动的模态窗口 -->
<div class="modal fade" id="searchActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">搜索市场活动</h4>
            </div>
            <div class="modal-body">
                <div class="btn-group" style="position: relative; top: 18%; left: 8px;">
                    <form class="form-inline" role="form">
                        <div class="form-group has-feedback">
                            <input type="text" id="search-activity" class="form-control" style="width: 300px;"
                                   placeholder="请输入市场活动名称，支持模糊查询">
                            <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>
                    </form>
                </div>
                <table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
                    <thead>
                    <tr style="color: #B3B3B3;">
                        <td></td>
                        <td>名称</td>
                        <td>开始日期</td>
                        <td>结束日期</td>
                        <td>所有者</td>
                        <td></td>
                    </tr>
                    </thead>
                    <tbody id="bindBody">
                    <%--
                    市场活动
                    --%>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="submitAct()">提交</button>
            </div>
        </div>
    </div>
</div>

<div id="title" class="page-header" style="position: relative; left: 20px;">
    <h4>转换线索 <small>${param.fullname}${param.appellation}-${param.company}</small></h4>
</div>
<div id="create-customer" style="position: relative; left: 40px; height: 35px;">
    新建客户：${param.company}
</div>
<div id="create-contact" style="position: relative; left: 40px; height: 35px;">
    新建联系人：${param.fullname}${param.appellation}
</div>
<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
    <input type="checkbox" id="isCreateTransaction"/>
    为客户创建交易
</div>
<div id="create-transaction2"
     style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;">

    <form id="activityForm">
        <div class="form-group" style="width: 400px; position: relative; left: 20px;">
            <label for="amountOfMoney">金额</label>
            <input name="money" type="text" class="form-control" id="amountOfMoney">
        </div>
        <div class="form-group" style="width: 400px;position: relative; left: 20px;">
            <label for="tradeName">交易名称</label>
            <input name="name" type="text" class="form-control" id="tradeName" value="动力节点-">
        </div>
        <div class="form-group" style="width: 400px;position: relative; left: 20px;">
            <label for="expectedClosingDate">预计成交日期</label>
            <input name="expectedDate" type="text" class="form-control time" id="expectedClosingDate">
        </div>
        <div class="form-group" style="width: 400px;position: relative; left: 20px;">
            <label for="stage">阶段</label>
            <select name="stage" id="stage" class="form-control">
                <option></option>
                <c:forEach items="${applicationScope.stage}" var="item">
                    <option value="${item.value}">${item.text}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group" style="width: 400px;position: relative; left: 20px;">
            <label for="activityName">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal"
                                                      data-target="#searchActivityModal" style="text-decoration: none;"><span
                    class="glyphicon glyphicon-search"></span></a></label>
            <input type="text" class="form-control" id="activityName" placeholder="点击上面搜索" readonly>
            <input name="activityId" type="hidden" id="activityId">
        </div>
    </form>

</div>

<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
    记录的所有者：<br>
    <b>${param.owner}</b>
</div>
<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
    <input class="btn btn-primary" id="convertBtn" type="button" value="转换">
    &nbsp;&nbsp;&nbsp;&nbsp;
    <input class="btn btn-default" type="button" value="取消">
</div>
</body>
</html>