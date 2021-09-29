<%--
  Created by IntelliJ IDEA.
  User: REN
  Date: 2021/1/29
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script type="text/javascript">
    var clr_id = WfForm.convertFieldNameToId("clr", "detail_1");
    var kssj_id = WfForm.convertFieldNameToId("kssj", "detail_1");
    var jssj_id = WfForm.convertFieldNameToId("jssj", "detail_1");
    function _customAddFun0(addIndexStr){      //明细2新增成功后触发事件，addIndexStr即刚新增的行标示，添加多行为(1,2,3)
        WfForm.changeFieldValue(clr_id+"_"+addIndexStr, {value: "0",specialobj:[{id:"",name:""}]});
        WfForm.changeFieldValue(kssj_id+"_"+addIndexStr, {value: "0",specialobj:[{id:"",name:""}]});
        WfForm.changeFieldValue(jssj_id+"_"+addIndexStr, {value: "0",specialobj:[{id:"",name:""}]});
    }
</script>
<script type="text/javascript">
    var dqksrq_id = WfForm.convertFieldNameToId("dqksrq", "detail_1");
    var dqjsrq_id = WfForm.convertFieldNameToId("dqjsrq", "detail_1");
    var ksrq_id = WfForm.convertFieldNameToId("kssj", "detail_1");
    var jsrq_id = WfForm.convertFieldNameToId("jssj", "detail_1");


    var cljgms_id= WfForm.convertFieldNameToId("cljgms");
    var zzfkrq_id= WfForm.convertFieldNameToId("zzfkrq");

    var sfdtqtyhtj_id=WfForm.convertFieldNameToId("sfdtqtyhtj");
    var yccs_id=WfForm.convertFieldNameToId("yccs");

    jQuery().ready(function(){

        //不是新增的时候
        var allrowindex=WfForm.getDetailAllRowIndexStr("detail_1");
        if(""!=allrowindex){
            var ids=allrowindex.split(",");
            for(var i=0;i<ids.length;i++){
                //当前开始日期按钮
                jQuery("#"+dqksrq_id+"_"+ids[i]+"span").html("<button  onclick='startbuttonclick("+ids[i]+")' style='background:rgb(46,204,250);border-radius:3px;width:60px;height:25px;text-align:center'>开始日期</button>")
                jQuery("#"+dqjsrq_id+"_"+ids[i]+"span").html("<button  onclick='endbuttonclick("+ids[i]+")' style='background:rgb(46,204,250);border-radius:3px;width:60px;height:25px;text-align:center'>结束日期</button>")
            }
        }
        //新增明细的时候
        WfForm.registerAction(WfForm.ACTION_ADDROW+"1", function(index){
            //下标从0开始，明细1添加行触发事件，注册函数入参为新添加行下标
            jQuery("#"+dqksrq_id+"_"+index+"span").html("<button  onclick='startbuttonclick("+index+")' style='background:rgb(46,204,250);border-radius:3px;width:60px;height:25px;text-align:center'>开始日期</button>")
            jQuery("#"+dqjsrq_id+"_"+index+"span").html("<button  onclick='endbuttonclick("+index+")' style='background:rgb(46,204,250);border-radius:3px;width:60px;height:25px;text-align:center'>结束日期</button>")

        });
    });

    function startbuttonclick(e){
        //开始时间赋值
        var date = new Date();
        var day=date.getDate();
        var month=date.getMonth()+1;
        var year= date.getFullYear();
        var hour=date.getHours();
        var min=date.getMinutes();
        if(day+"".length==1){
            day="0"+day;
        }
        if(month+"".length==1){
            month="0"+month;
        }
        if(hour+"".length==1){
            hour="0"+hour;
        }
        if(min+"".length==1){
            min="0"+min;
        }

        var datestr=year+"-"+month+"-"+day+" "+hour+":"+min;
        WfForm.changeFieldValue(ksrq_id+"_"+e, {value:datestr});
    }
    function endbuttonclick(e){
        //开始日期赋值
        var date = new Date();
        var day=date.getDate();
        var month=date.getMonth()+1;
        var year= date.getFullYear();
        var hour=date.getHours();
        var min=date.getMinutes();
        if(day+"".length==1){
            day="0"+day;
        }
        if(month+"".length==1){
            month="0"+month;
        }
        if(hour+"".length==1){
            hour="0"+hour;
        }
        if(min+"".length==1){
            min="0"+min;
        }
        var datestr=year+"-"+month+"-"+day+" "+hour+":"+min;
        WfForm.changeFieldValue(jsrq_id+"_"+e, {value:datestr});
    }


    var clr_id = WfForm.convertFieldNameToId("clr", "detail_1");
    var kssj_id = WfForm.convertFieldNameToId("kssj", "detail_1");
    var jssj_id = WfForm.convertFieldNameToId("jssj", "detail_1");
    function _customAddFun0(addIndexStr){      //明细2新增成功后触发事件，addIndexStr即刚新增的行标示，添加多行为(1,2,3)
        WfForm.changeFieldValue(clr_id+"_"+addIndexStr, {value: "0",specialobj:[{id:"",name:""}]});
        WfForm.changeFieldValue(kssj_id+"_"+addIndexStr, {value: "0",specialobj:[{id:"",name:""}]});
        WfForm.changeFieldValue(jssj_id+"_"+addIndexStr, {value: "0",specialobj:[{id:"",name:""}]});
    }
</script>



</body>
</html>
