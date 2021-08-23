# CRM
### crm项目
详情请参考：[CRM](https://www.bilibili.com/video/BV1fT4y1E7a6)  

### 项目简介

该项目为贸易行业的客户关系管理系统，主要针对企业客户，单方面的对客户做出的一些管理，例如售前、售中、售后；前台包括的模块有：工作台、动态、审批、客户公海、市场活动、线索、客户、联系人、交易、售后回访、统计图表、报表、销售订单、发货单、跟进、产品、报价；后台包括的模块有：个人设置、部门维护、权限管理、数据字典表等  

### 项目介绍  

本项目基于动力节点的CRM项目的基础上做了以下改动

1. 对servlet的访问抽取出BaseServlet，避免重复设置url

2. 编写BeanUtil，用于解决一些重复的get、set方法

3. jquery封装表单数据为json
   1. 给你的form表单取个id值    id="zq_form"
   
   2. 然后js封装  【温馨下提示：这里可将此类多处会使用到的代码抽取出来单独存放去引入】  
   
      ```javascript
      //序列化表单字段为json对象
      $.fn.serializeFormToJson = function(){
            let arr = $(this).serializeArray();//form表单数据 name：value
            let param = {};
            $.each(arr,function(i,obj){ //将form表单数据封装成json对象
                param[obj.name] = obj.value;
            })
            return param;
        }
      ```
   
   3. 使用
      `var formData = $("#zq_form").serializeFormToJson();
      console.debug(formData);` 
   
4. 对于交易阶段中的可能性，为了不破坏bean结构以及为了前端jsp页面的可维护性，将可能性的处理放在前端利用json处理

   ```javascript
   // 初始化s2p
   let s2p = ${applicationScope.s2p};
   
   "<td>" + s2p[item.stage] + "</td>";
   ```
