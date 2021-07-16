<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <jsp:include page="../../comm/base.jsp"/>
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>
    <link href="jquery/bs_pagination/jquery.bs_pagination.min.css" type="text/css" rel="stylesheet">

    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript"
            src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript"
            src="jquery/bs_pagination/en.js"></script>

    <script type="text/javascript">
        <%!Integer pageSize = 2;%>  // 设置页面页码

        /*
        需要调用分页的情况：
            1、点击市场活动
            2、点击分页条
            3、点击查询按钮
            4、点击创建、修改、删除
            5、重置按钮
         */
        function pageList(pageNo, pageSize) {
            // 隐藏条件表单项
            let hide_name = $("#hide-name");
            let hide_owner = $("#hide-owner");
            let hide_startTime = $("#hide-startTime");
            let hide_endTime = $("#hide-endTime");
            // 条件表单项
            let search_name = $("#search-name");
            let search_owner = $("#search-owner");
            let search_startTime = $("#search-startTime");
            let search_endTime = $("#search-endTime");
            search_name.val(hide_name.val())
            search_owner.val(hide_owner.val())
            search_startTime.val(hide_startTime.val())
            search_endTime.val(hide_endTime.val())

            $.ajax({
                url: "workbench/activity.do",
                data: {
                    action: "getPageList",
                    name: $.trim(hide_name.val()),
                    owner: $.trim(hide_owner.val()),
                    startTime: hide_startTime.val(),
                    endTime: hide_endTime.val(),
                    pageNo: pageNo,
                    pageSize: pageSize
                },
                type: "get",
                dataType: "json",
                success: function (data) {
                    let html = "";
                    $.each(data.pageList, function (i, item) {
                        html += "<tr class=\"active\">";
                        html += "<td><input name='checkItem' type=\"checkbox\" value=" + item.id + "/></td>";
                        html += "<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='detail.jsp';\">" + item.name + "</a>";
                        html += "</td>";
                        html += "<td>" + item.owner + "</td>";
                        html += "<td>" + item.startDate + "</td>";
                        html += "<td>" + item.endDate + "</td>";
                        html += "</tr>";
                    })
                    $("#list").html(html);
                    // 展示分页插件
                    let totalPages = data.total / pageSize;
                    totalPages = data.total % pageSize === 0 ? totalPages : parseInt(totalPages) + 1;
                    $("#activityPage").bs_pagination({
                        currentPage: pageNo, // 页码
                        rowsPerPage: pageSize, // 每页显示的记录条数
                        maxRowsPerPage: 20, // 每页最多显示的记录条数
                        totalPages: totalPages, // 总页数
                        totalRows: data.total, // 总记录条数

                        visiblePageLinks: 4, // 显示几个卡片

                        showGoToPage: true,
                        showRowsPerPage: true,
                        showRowsInfo: true,
                        showRowsDefaultInfo: true,

                        onChangePage : function(event, data){
                            pageList(data.currentPage , data.rowsPerPage);
                        }
                    });
                }
            })
        }

        $(function () {

            // 隐藏条件表单项
            let hide_name = $("#hide-name");
            let hide_owner = $("#hide-owner");
            let hide_startTime = $("#hide-startTime");
            let hide_endTime = $("#hide-endTime");
            // 条件表单项
            let search_name = $("#search-name");
            let search_owner = $("#search-owner");
            let search_startTime = $("#search-startTime");
            let search_endTime = $("#search-endTime");

            let selection = $("#create-marketActivityOwner");
            $("#addBtn").click(function () {

                // 发起ajax请求，接收后台用户数据
                $.ajax({
                    url: "workbench/activity.do",
                    data: {
                        action: "getUserList"
                    },
                    type: "get",
                    dataType: "json",
                    success: function (data) {
                        if (data.success) {
                            // 如果接收成功，将用户名称表填入create-marketActivityOwner
                            let userListHtml = "";
                            $.each(data.userList, function (i, item) {
                                console.log(item);
                                userListHtml += "<option value=" + item.id + ">" + item.name + "</option>"
                            });
                            selection.html(userListHtml);
                            // 当打开模态窗口，默认创建人为当前登陆人
                            selection.val("${sessionScope.user.id}");
                            // 模态窗口的两种方式：show和hide
                            $("#createActivityModal").modal("show");
                        } else {
                            alert("市场活动保存失败，请重新创建");
                        }
                    }
                });

            });
            $("#saveBtn").click(function () {
                $("#createActivityModal").modal("hide");
                // 向后台发起ajax请求，保存市场活动信息
                $.ajax({
                    url: "workbench/activity.do",
                    data: {
                        action: "saveActivity",
                        owner: selection.val(),
                        name: $("#create-marketActivityName").val(),
                        startDate: $("#create-startTime").val(),
                        endDate: $("#create-endTime").val(),
                        cost: $("#create-cost").val(),
                        description: $("#create-describe").val()
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        if (data.success) {
                        } else {
                            alert("保存失败，请重试");
                        }
                        // 当打开模态窗口时重置窗口-默认只在保存按钮关闭
                        $("#addActivityForm")[0].reset();
                    }
                })
            });
            $(".time").datetimepicker({
                minView: "month",
                language: 'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "bottom-left"
            });
            // 为查询按钮绑定分页
            $("#search-condition").click(function () {
                /*
                这里直接发起请求出现了一个问题：在条件框中输入条件，但不点击查询按钮，转而触发其他分页方法
                出现了直接将输入的参数携带入条件中
                解决办法：
                新增一个隐藏域，用于保存上次传入的查询参数，每次调用分页方法时
                转而获取隐藏域中保存的数据
                 */


                hide_name.val(search_name.val());
                hide_owner.val(search_owner.val());
                hide_startTime.val(search_startTime.val());
                hide_endTime.val(search_endTime.val());

                pageList(1,<%=pageSize%>);
            })
            // 点击创建、修改、删除
            $("button[name=updatePage]").click(function () {
                pageList(1, <%=pageSize%>)
            })

            // 重置条件表单中的所有表单项（包括隐藏域），并刷新分页
            $("#reset").click(function () {
                hide_name.val("");
                hide_owner.val("");
                hide_startTime.val("");
                hide_endTime.val("");
                search_name.val("")
                search_owner.val("")
                search_startTime.val("")
                search_endTime.val("")

                pageList(1,<%=pageSize%>)
            })
            
            // 为选择框绑定事件
            $("#checkBox").click(function () {
                $("input[name=checkItem]").prop("checked",this.checked);
            })
            /*
            这种绑定方式无效，对于动态生成的元素，普通的绑定方法无效，需要根据动态元素的外层有效元素进行绑定
            语法：
            $(外层有效选择器).on(绑定的事件,需要绑定的jquery对象,回调函数)
            $("input[name=checkItem]").click(function () {
                $("#checkBox").prop("checked",)
            })*/
            $("#list").on("click",$("input[name=checkItem]"),function () {
                $("#checkBox").prop("checked",
                    $("input[name=checkItem]").length==$("input[name=checkItem]:checked").length)
            })
            // 在页面加载完成后调用pageList方法，默认第一页，两条数据
            pageList(1, <%=pageSize%>)
        });
    </script>
</head>
<body>

<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
            </div>
            <div class="modal-body">

                <form id="addActivityForm" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-marketActivityOwner">

                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="create-startTime" readonly>
                        </div>
                        <label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="create-endTime" readonly>
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-cost">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-describe"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="saveBtn" type="button" class="btn btn-primary">保存</button>
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
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
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
                            <input type="text" class="form-control" id="edit-marketActivityName" value="发传单">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-startTime" value="2020-10-10">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-endTime" value="2020-10-20">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost" value="5,000">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe">市场活动Marketing，是指品牌主办或参与的展览会议与公关市场活动，包括自行主办的各类研讨会、客户交流会、演示会、新产品发布会、体验会、答谢会、年会和出席参加并布展或演讲的展览会、研讨会、行业交流会、颁奖典礼等</textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input type="hidden" id="hide-name">
                        <input class="form-control" id="search-name" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input type="hidden" id="hide-owner">
                        <input class="form-control" id="search-owner" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">开始日期</div>
                        <input type="hidden" id="hide-startTime">
                        <input class="form-control time" type="text" id="search-startTime"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">结束日期</div>
                        <input type="hidden" id="hide-endTime">
                        <input class="form-control time" type="text" id="search-endTime">
                    </div>
                </div>
                <button type="button" id="reset" class="btn btn-default">重置</button>
                <button type="button" id="search-condition" class="btn btn-default">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" id="addBtn" name="updatePage" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span>
                    创建
                </button>
                <button type="button" id="updateBtn" name="updatePage" class="btn btn-default" data-toggle="modal"
                        data-target="#editActivityModal"><span class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" name="updatePage" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input id="checkBox" type="checkbox"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="list">
                </tbody>
            </table>
        </div>

        <div style="height: 50px; position: relative;top: 30px;">
            <div id="activityPage">

            </div>
        </div>

    </div>

</div>
</body>
</html>