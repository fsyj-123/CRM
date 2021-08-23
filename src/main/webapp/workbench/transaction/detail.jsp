<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <jsp:include page="../../comm/base.jsp"/>
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>

    <style type="text/css">
        .mystage {
            font-size: 20px;
            vertical-align: middle;
            cursor: pointer;
        }

        .closingDate {
            font-size: 15px;
            cursor: pointer;
            vertical-align: middle;
        }
    </style>

    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

    <script type="text/javascript">

        //默认情况下取消和保存按钮是隐藏的
        var cancelAndSaveBtnDefault = true;

        // 初始化s2p
        let s2p = ${applicationScope.s2p};

        // 根据可能性处理交易失败的断点 --- 由于json中的键值对是无序的，所以将断点获取放在后端(listener )处理
        let stagePoint = parseInt(${applicationScope.stagePoint});

        let currentStageIndex = parseInt(${requestScope.currentStageIndex});


        // 拼接阶段图标
        function refreshStage() {
            let stageSize = Object.keys(s2p).length;
            let currentStage = "${requestScope.tran.stage}";
            let children = $("#stage").children("span");
            // 在有可能性阶段
            if (currentStageIndex < stagePoint) {
                console.log("处理成功阶段");
                // 处理0到currentStageIndex
                for (let i = 0; i < currentStageIndex; i++) {
                    $(children[i]).prop("style", "color: #90F790;");
                    $(children[i]).prop("class", "glyphicon glyphicon-ok-circle mystage");
                }
                // 处理currentStageIndex
                $(children[currentStageIndex]).prop("style", "color: #90F790;");
                $(children[currentStageIndex]).prop("class", "glyphicon glyphicon-map-marker mystage");
                // 处理currentStageIndex到stagePoint
                for (let i = currentStageIndex + 1; i < stagePoint; i++) {
                    $(children[i]).prop("style", "color: #000000;");
                    $(children[i]).prop("class", "glyphicon glyphicon-record mystage");
                }
                // 处理stagePoint到stageSize
                for (let i = stagePoint; i < stageSize; i++) {
                    $(children[i]).prop("style", "color: #000000;");
                    $(children[i]).prop("class", "glyphicon glyphicon-remove mystage");
                }
            } else {
                console.log("处理失败阶段");
                // 处理从0到stagePoint（黑圈）
                for (let i = 0; i < stagePoint; i++) {
                    $(children[i]).prop("style", "color: #000000;");
                    $(children[i]).prop("class", "glyphicon glyphicon-record mystage");
                }
                // 处理从stagePoint到currentStageIndex（黑叉）
                for (let i = stagePoint; i < currentStageIndex; i++) {
                    $(children[i]).prop("style", "color: #000000;");
                    $(children[i]).prop("class", "glyphicon glyphicon-remove mystage");
                }
                // 处理currentStageIndex（红叉）
                $(children[currentStageIndex]).prop("style", "color: #FF0000;");
                $(children[currentStageIndex]).prop("class", "glyphicon glyphicon-remove mystage");
                // 处理currentStageIndex + 1到stageSize
                for (let i = currentStageIndex + 1; i < stageSize; i++) {
                    $(children[i]).prop("style", "color: #000000;");
                    $(children[i]).prop("class", "glyphicon glyphicon-remove mystage");
                }
            }

            // 定位到当前点
            // 改进：在前端页面加载是处理currentStageIndex
            /*if (children[i].dataset.content === currentStage) {
                // 情况一：当前点位于有可能性阶段
                if (i < stagePoint) {
                    // 先处理当前点
                    $(children[i]).prop("style", "color: #90F790");
                    $(children[i]).prop("class", "glyphicon glyphicon-map-marker mystage");

                    // 处理当前点之前的点
                    for (let j = 0; j < i; j++) {
                        $(children[i]).prop("style", "color: #90F790;");
                        $(children[j]).prop("class", "glyphicon glyphicon-ok-circle mystage");
                    }
                    // 处理i+1到stagePoint的点
                    for (let j = i + 1; j < stagePoint; j++) {
                        $(children[i]).prop("style", "color: #000000;");
                        $(children[j]).prop("class", "glyphicon glyphicon-record mystage");
                    }
                    // 处理stagePoint到stageSize的点
                    for (let j = stagePoint; j < stageSize; j++) {
                        $(children[i]).prop("style", "color: #000000;");
                        $(children[j]).prop("class", "glyphicon glyphicon-remove mystage");
                    }
                }
            }*/
        }

        // 刷新可能性方法
        function refreshPossibility(stage) {
            console.log(stage)
            if (stage === null) {
                $("#possibility").text(s2p["${requestScope.tran.stage}"])
            } else {
                $("#possibility").text(s2p[stage])
            }
        }

        // 局部刷新交易历史
        function refreshHistory() {
            $.ajax({
                url: "workbench/tran.do",
                data: {
                    action: "getHistoryList",
                    tranId: "${requestScope.tran.id}"
                },
                dataType: "json",
                type: "post",
                success: function (data) {
                    let html = "";
                    $.each(data, function (index, item) {
                        html += "<tr>";
                        html += "<td>" + item.stage + "</td>";
                        html += "<td>" + item.money + "</td>";
                        html += "<td>" + s2p[item.stage] + "</td>";
                        html += "<td>" + item.expectedDate + "</td>";
                        html += "<td>" + item.createTime + "</td>";
                        html += "<td>" + item.createBy + "</td>";
                        html += "</tr>";
                    });
                    $("#historyBody").html(html);
                }
            })
        }

        // 总的局部刷新方法
        function refresh(data) {
            console.log(data)
            // 刷新交易的详细信息
            if (data !== null) {
                $("#tranStage").html(data.stage);
                $("#tranEditBy").html(data.editBy);
                $("#tranEditTime").html(data.editTime);
            }
            refreshStage();
            refreshHistory();
            refreshPossibility(data == null ? null : data.stage);
        }

        /*
         阶段变更方法
         stage: 需要变更的阶段
         index：需要变更到的阶段index
         */
        function stageChange(stage, index) {
            index = index - 1;
            if (index === currentStageIndex) {
                // 如果需要变更的是当前阶段，则直接返回
                return;
            }
            $.ajax({
                url: "workbench/tran.do",
                data: {
                    action: "stageChange",
                    tranId: "${requestScope.tran.id}",
                    index:index,
                    currentStageIndex:currentStageIndex,
                    stage: stage
                },
                dataType: "json",
                type: "post",
                success: function (data) {
                    currentStageIndex = index;
                    // 刷新
                    refresh(data);
                }
            })
        }


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

            //阶段提示框
            $(".mystage").popover({
                trigger: 'manual',
                placement: 'bottom',
                html: 'true',
                animation: false
            }).on("mouseenter", function () {
                var _this = this;
                $(this).popover("show");
                $(this).siblings(".popover").on("mouseleave", function () {
                    $(_this).popover('hide');
                });
            }).on("mouseleave", function () {
                var _this = this;
                setTimeout(function () {
                    if (!$(".popover:hover").length) {
                        $(_this).popover("hide")
                    }
                }, 100);
            });

            refresh(null);
        });


    </script>

</head>
<body>

<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
    <a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"
                                                                         style="font-size: 20px; color: #DDDDDD"></span></a>
</div>

<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <div class="page-header">
        <h3>${requestScope.tran.customerId}-${requestScope.tran.name} <small>￥${requestScope.tran.money}</small></h3>
    </div>
    <div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
        <button type="button" class="btn btn-default" onclick="window.location.href='workbench/transaction/edit.jsp';">
            <span class="glyphicon glyphicon-edit"></span> 编辑
        </button>
        <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
    </div>
</div>

<!-- 阶段状态 -->
<div style="position: relative; left: 40px; top: -50px;" id="stage">
    阶段&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <c:forEach items="${applicationScope.stage}" var="item">
        <span data-toggle="popover" onclick="stageChange('${item.value}','${item.orderNo}')" data-placement="bottom"
              data-content="${item.text}"></span>
        -----------
    </c:forEach>
    <script>
        // 一个小BUG：这里需要再次去调用function才能使鼠标悬停事件触发，如果注释掉将无法触发鼠标悬停事件，图标能展示
        refreshStage();
    </script>
    <%--<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom"
           data-content="资质审查" style="color: #90F790;"></span>
     -----------
     <span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom"
           data-content="需求分析" style="color: #90F790;"></span>
     -----------
     <span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom"
           data-content="价值建议" style="color: #90F790;"></span>
     -----------
     <span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom"
           data-content="确定决策者" style="color: #90F790;"></span>
     -----------
     <span class="glyphicon glyphicon-map-marker mystage" data-toggle="popover" data-placement="bottom"
           data-content="提案/报价" style="color: #90F790;"></span>
     -----------
     <span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom"
           data-content="谈判/复审"></span>
     -----------
     <span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom"
           data-content="成交"></span>
     -----------
     <span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom"
           data-content="丢失的线索"></span>
     -----------
     <span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom"
           data-content="因竞争丢失关闭"></span>
     -------------%>
    <span class="closingDate">2010-10-10</span>
</div>

<!-- 详细信息 -->
<div style="position: relative; top: 0px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${requestScope.tran.owner}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">金额</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${requestScope.tran.money}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;">
            <b>${requestScope.tran.customerId}-${requestScope.tran.name}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">预计成交日期</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${requestScope.tran.expectedDate}</b>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">客户名称</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${requestScope.tran.customerId}</b>
        </div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">阶段</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="tranStage">${requestScope.tran.stage}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">类型</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${requestScope.tran.type}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">可能性</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="possibility"></b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">来源</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${requestScope.tran.source}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">市场活动源</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${requestScope.tran.activityId}</b>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">联系人名称</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${requestScope.tran.contactsId}</b>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 60px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${requestScope.tran.createBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${requestScope.tran.createTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 70px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="tranEditBy">${requestScope.tran.editBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;" id="tranEditTime">${requestScope.tran.editTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 80px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${requestScope.tran.description}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 90px;">
        <div style="width: 300px; color: gray;">联系纪要</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                &nbsp;${requestScope.tran.contactSummary}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 100px;">
        <div style="width: 300px; color: gray;">下次联系时间</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${requestScope.tran.nextContactTime}&nbsp;</b>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div style="position: relative; top: 100px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>

    <!-- 备注1 -->
    <div class="remarkDiv" style="height: 60px;">
        <img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">
        <div style="position: relative; top: -40px; left: 40px;">
            <h5>哎呦！</h5>
            <font color="gray">交易</font> <font color="gray">-</font> <b>动力节点-交易01</b> <small style="color: gray;">
            2017-01-22 10:10:10 由zhangsan</small>
            <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit"
                                                                   style="font-size: 20px; color: #E6E6E6;"></span></a>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove"
                                                                   style="font-size: 20px; color: #E6E6E6;"></span></a>
            </div>
        </div>
    </div>

    <!-- 备注2 -->
    <div class="remarkDiv" style="height: 60px;">
        <img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">
        <div style="position: relative; top: -40px; left: 40px;">
            <h5>呵呵！</h5>
            <font color="gray">交易</font> <font color="gray">-</font> <b>动力节点-交易01</b> <small style="color: gray;">
            2017-01-22 10:20:10 由zhangsan</small>
            <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit"
                                                                   style="font-size: 20px; color: #E6E6E6;"></span></a>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove"
                                                                   style="font-size: 20px; color: #E6E6E6;"></span></a>
            </div>
        </div>
    </div>

    <div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
        <form role="form" style="position: relative;top: 10px; left: 10px;">
            <textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"
                      placeholder="添加备注..."></textarea>
            <p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
                <button id="cancelBtn" type="button" class="btn btn-default">取消</button>
                <button type="button" class="btn btn-primary">保存</button>
            </p>
        </form>
    </div>
</div>

<!-- 阶段历史 -->
<div>
    <div style="position: relative; top: 100px; left: 40px;">
        <div class="page-header">
            <h4>阶段历史</h4>
        </div>
        <div style="position: relative;top: 0px;">
            <table id="activityTable" class="table table-hover" style="width: 900px;">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td>阶段</td>
                    <td>金额</td>
                    <td>可能性</td>
                    <td>预计成交日期</td>
                    <td>创建时间</td>
                    <td>创建人</td>
                </tr>
                </thead>
                <tbody id="historyBody">
                <%--<tr>
                    <td>谈判/复审</td>
                    <td>5,000</td>
                    <td>90</td>
                    <td>2017-02-07</td>
                    <td>2017-02-09 10:10:10</td>
                    <td>zhangsan</td>
                </tr>--%>
                </tbody>
            </table>
        </div>

    </div>
</div>

<div style="height: 200px;"></div>

</body>
</html>