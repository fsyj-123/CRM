<%--
  Created by IntelliJ IDEA.
  User: fsyj
  Date: 2021/8/24
  Time: 13:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="../../../comm/base.jsp"/>
    <script src="echarts/echarts.min.js"></script>
    <script src="jquery/jquery-1.11.1-min.js"></script>
    <script>
        function getCharts() {
            let dataSet = [];
            $.ajax({
                url: "workbench/tran.do",
                data: {
                    action: "getGroupData"
                },
                dataType: "json",
                type: "post",
                success: function (data) {
                    $.each(data, function (index, item) {
                        dataSet[index] = item;
                    });
                    let chartDom = document.getElementById('main');
                    let myChart = echarts.init(chartDom);
                    let option = {
                        legend: {},
                        tooltip: {},
                        dataset: {
                            dimensions: ['name', 'value'],
                            source: dataSet
                        },
                        xAxis: {type: 'category'},
                        yAxis: {type: 'value'},
                        // Declare several bar series, each will be mapped
                        // to a column of dataset.source by default.
                        series: [
                            {type: 'bar'}
                        ]
                    };
                    option && myChart.setOption(option);
                }
            })
        }

        $(function () {
            // 基于准备好的domDiv，初始化echarts实例
            getCharts();
        })
    </script>
    <title>交易统计图</title>
</head>
<body>
<div id="main" style="width: 900px;height:600px;"></div>
</body>
</html>
