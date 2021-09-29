<%--
  Created by IntelliJ IDEA.
  User: REN
  Date: 2021/1/19
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script type="text/javascript">
    var wtclms_id= WfForm.convertFieldNameToId("wtclms", "detail_1");
    var ksrq_id= WfForm.convertFieldNameToId("ksrq", "detail_1");
    var cljgms_id= WfForm.convertFieldNameToId("cljgms");
    var zzfkrq_id= WfForm.convertFieldNameToId("zzfkrq");
    jQuery().ready(function(){
        WfForm.bindDetailFieldChangeEvent(wtclms_id+","+ksrq_id,function(id,rowIndex,value){
            var cljgms_value = WfForm.getFieldValue(cljgms_id);
            var wtclms_value = WfForm.getFieldValue(wtclms_id+"_"+rowIndex);
            if(""!=cljgms_value){
                WfForm.changeFieldValue(cljgms_id, {value:cljgms_value+""+"<br/>"+wtclms_value+";"});
            }else{
                WfForm.changeFieldValue(cljgms_id, {value:wtclms_value+";"});
            }
        });

        var date=new Date();
        var day=date.getDate();
        var month=date.getMonth()+1;
        var year=date.getFullYear();
        if(day+"".length==1){
            day="0"+day;
        }
        if(month+"".length==1){
            month="0"+month;
        }
        var datestr=year+"-"+month+"-"+day;
        WfForm.changeFieldValue(zzfkrq_id, {value:datestr});
    });


</script>

</body>
</html>
