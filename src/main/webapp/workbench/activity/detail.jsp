<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <jsp:include page="../../comm/base.jsp"/>
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

    <script type="text/javascript">

        //默认情况下取消和保存按钮是隐藏的
        let cancelAndSaveBtnDefault = true;

        // 通过Id删除备注
        function deleteRemark(id) {
            // 通过ajax动态删除备注，并刷新备注列表
            $.ajax({
                url: "workbench/activity.do",
                data: {
                    action: "deleteRemark",
                    id: id
                },
                dataType: "json",
                type: "post",
                success: function (data) {
                    if (data.success) {
                        showActivityRemark();
                    } else {
                        alert("删除失败，请刷新重试")
                    }
                }
            })
        }

        // 通过ID修改备注
        function editRemark(id) {
            $("#noteContent").val($("#" + id).text());
            // 为修改模态窗口中id隐藏域赋值
            $("#remarkId").val(id);
            $("#editRemarkModal").modal("show");
        }


        // 展现市场活动备注方法(1、页面加载完毕后，点击修改、删除)
        function showActivityRemark() {
            $.ajax({
                url: "workbench/activity.do",
                data: {
                    action: "activityRemarkList",
                    id: "${requestScope.activity.id}"
                },
                dataType: "json",
                type: "get",
                success: function (data) {
                    if (data.success) {
                        let remarks = data.remarkList;
                        console.log(remarks);
                        let contentNoteHtml = "";
                        // 遍历返回的结果集，拼接备注html
                        $.each(remarks, function (index, item) {
                            let remarkId = item.id;
                            console.log(remarkId);
                            contentNoteHtml += "<div class=\"remarkDiv\" style=\"height: 60px;\">"
                            contentNoteHtml += "<img title=\"zhangsan\" src=\"image/user-thumbnail.png\" style=\"width: 30px; height:30px;\">"
                            contentNoteHtml += "<div style=\"position: relative; top: -40px; left: 40px;\">"
                            contentNoteHtml += "<h5 id='" + remarkId + "'>" + item.noteContent + "</h5>"
                            contentNoteHtml += "<font color=\"gray\">市场活动</font> <font color=\"gray\">-</font> <b>${requestScope.activity.name}</b> <small style=\"color: gray;\">" + (item.editFlag === '0' ? item.createTime : item.editTime) + " 由" + (item.editFlag === '0' ? item.createBy : item.editBy) + "</small>"
                            contentNoteHtml += "<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">"
                            contentNoteHtml += "<a class=\"myHref\" onclick=\"editRemark('" + remarkId + "')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #FF0000;\"></span></a>"
                            contentNoteHtml += "&nbsp;&nbsp;&nbsp;&nbsp;"
                            contentNoteHtml += "<a class=\"myHref\" onclick=\"deleteRemark('" + remarkId + "')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #FF0000;\"></span></a>"
                            contentNoteHtml += "</div>"
                            contentNoteHtml += "</div>"
                            contentNoteHtml += "</div>"
                        })
                        $("#content-note").html(contentNoteHtml);
                    } else {
                        alert("页面加载错误，请刷新重试")
                    }
                }
            })
        }

        /*
        通过内部直接绑定事件的方式传值时，需要注意穿的值需要用引号包围
        如：onclick=\"deleteRemark('" + remarkId + "')\"
         */

        $("#content-note").on("click", $("a[name=delete]"), function () {
            console.log("aass")
        })

        $(function () {
            $("#remark").focus(function () {
                if (cancelAndSaveBtnDefault) {
                    //设置remarkDiv的高度为130px
                    $("#remarkDiv").css("height", "130px");
                    //显示
                    $("#cancelAndSaveBtn").show("2000");
                    cancelAndSaveBtnDefault = false;
                }
            });

            $("#cancelBtn").click(function () {
                //显示
                $("#cancelAndSaveBtn").hide();
                //设置remarkDiv的高度为130px
                $("#remarkDiv").css("height", "90px");
                // 清空输入框
                $("#remark").val("");
                cancelAndSaveBtnDefault = true;
            });

            $(".remarkDiv").mouseover(function () {
                $(this).children("div").children("div").show();
            });

            $(".remarkDiv").mouseout(function () {
                $(this).children("div").children("div").hide();
            });

            $(".myHref").mouseover(function () {
                $(this).children("span").css("color", "red");
            });

            $(".myHref").mouseout(function () {
                $(this).children("span").css("color", "#E6E6E6");
            });

            // 编辑事件
            let $activityId = $("#activityId");
            $("#editBtn").click(function () {
                // 查询用户列表  以及 查询对应市场活动
                $.ajax({
                    url: "workbench/activity.do",
                    data: {
                        action: "getUserListAndAct",
                        id: $activityId.val()
                    },
                    type: "get",
                    dataType: "json",
                    success: function (data) {
                        let userList = data.userList;
                        let activity = data.activity;
                        // 如果接收成功，将用户名称表填入create-marketActivityOwner
                        let userListHtml = "";
                        $.each(userList, function (i, item) {
                            userListHtml += "<option value=" + item.id + ">" + item.name + "</option>"
                        });
                        let $edit_owner = $("#edit-marketActivityOwner");
                        $edit_owner.html(userListHtml);
                        // 展现模态窗口
                        $edit_owner.val(activity.owner);
                        $("#edit-marketActivityName").val(activity.name);
                        $("#edit-startTime").val(activity.startDate);
                        $("#edit-endTime").val(activity.endDate);
                        $("#edit-cost").val(activity.cost);
                        $("#edit-describe").val(activity.description);
                        // 模态窗口的两种方式：show和hide
                        $("#editActivityModal").modal("show");
                    }
                });
            })
            // 更新活动
            $("#updateActivityBtn").click(function () {
                $.ajax({
                    url: "workbench/activity.do",
                    data: {
                        action: "updateActivity",
                        id: $activityId.val(),
                        owner: $("#edit-marketActivityOwner").val(),
                        name: $("#edit-marketActivityName").val(),
                        startDate: $("#edit-startTime").val(),
                        endDate: $("#edit-endTime").val(),
                        cost: $("#edit-cost").val(),
                        description: $("#edit-describe").val()
                    },
                    async: false,
                    type: "get",
                    dataType: "json",
                    success: function (data) {
                        if (!data.success) {
                            alert("更新失败，请重试");
                        }
                    }
                });

                let href = "workbench/activity.do?action=detail&id=" + $activityId.val();
                console.log(href)
                window.location.href = href;
            })
            // 删除活动
            $("#deleteBtn").click(function () {
                if (confirm("你确定要删除" + "${requestScope.activity.name}" + "吗?")) {
                    let ids = [];
                    ids[0] = $activityId.val();
                    $.ajax({
                        url: "workbench/activity.do",
                        data: {
                            action: "deleteActivities",
                            id: ids
                        },
                        dataType: "json",
                        type: "post",
                        success: function (data) {
                            if (data.success) {
                                window.location.href = "workbench/activity/index.jsp"
                            } else {
                                alert("删除失败,请重试")
                            }
                        }
                    })
                }
            })

            // 为更新按钮绑定事件
            $("#updateRemarkBtn").click(function () {
                let note = $.trim($("#noteContent").val());
                if (note !== "") {
                    $.ajax({
                        url: "workbench/activity.do",
                        data: {
                            action: "updateRemark",
                            id: $("#remarkId").val(),
                            content: note
                        },
                        type: "post",
                        dataType: "json",
                        success: function (data) {
                            if (data.success) {
                                showActivityRemark();
                            } else {
                                alert("更新失败，请重试");
                            }
                        }
                    })
                    $("#editRemarkModal").modal("hide");
                } else {
                    alert("内容不能为空")
                }
            })

            $("#saveBtn").click(function () {
                let remark = $.trim($("#remark").val());
                if (remark !== "") {
                    $.ajax({
                        url:"workbench/activity.do",
                        data:{
                            action:"saveRemark",
                            content:remark,
                            activityId:$activityId.val()
                        },
                        dataType:"json",
                        type:"post",
                        success:function (data) {
                            if(data.success) {
                                $("#remark").val("")
                                showActivityRemark()
                            } else {
                                alert("保存失败，请重试")
                            }
                        }
                    })
                }
            })

            showActivityRemark();
            $("#remarkBody").on("mouseover", ".remarkDiv", function () {
                $(this).children("div").children("div").show();
            })

            $("#remarkBody").on("mouseout", ".remarkDiv", function () {
                $(this).children("div").children("div").hide();
            })

        });

    </script>

</head>
<body>

<!-- 修改市场活动备注的模态窗口 -->
<div class="modal fade" id="editRemarkModal" role="dialog">
    <%-- 备注的id --%>
    <input type="hidden" id="remarkId">
    <div class="modal-dialog" role="document" style="width: 40%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel-remark">修改备注</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">内容</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="noteContent"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-marketActivityOwner">

                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-marketActivityName" value="">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-startTime" value="">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-endTime" value="">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost" value="">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateActivityBtn" type="button" class="btn btn-primary">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
    <a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"
                                                                         style="font-size: 20px; color: #DDDDDD"></span></a>
</div>

<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <input type="hidden" id="activityId" value="${requestScope.activity.id}">
    <div class="page-header">
        <h3 id="title">市场活动-${requestScope.activity.name} <small>${requestScope.activity.startDate}
            ~ ${requestScope.activity.endDate}</small></h3>
    </div>
    <div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
        <button id="editBtn" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-edit"></span> 编辑
        </button>
        <button id="deleteBtn" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除
        </button>
    </div>
</div>

<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${requestScope.activity.owner}</b>
        </div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${requestScope.activity.name}</b>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>

    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">开始日期</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${requestScope.activity.startDate}</b>
        </div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${requestScope.activity.endDate}</b>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">成本</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${requestScope.activity.cost}</b>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${requestScope.activity.createBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${requestScope.activity.createTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${requestScope.activity.editBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${requestScope.activity.editTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${requestScope.activity.description}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div id="remarkBody" style="position: relative; top: 30px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>

    <!-- 备注 -->
    <div id="content-note">

    </div>

    <div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
        <form role="form" style="position: relative;top: 10px; left: 10px;">
            <textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"
                      placeholder="添加备注..."></textarea>
            <p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
                <button id="cancelBtn" type="button" class="btn btn-default">取消</button>
                <button id="saveBtn" type="button" class="btn btn-primary">保存</button>
            </p>
        </form>
    </div>
</div>
<div style="height: 200px;"></div>
</body>
</html>