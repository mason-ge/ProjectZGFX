<%--
  Created by IntelliJ IDEA.
  User: REN
  Date: 2021/1/27
  Time: 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script type="text/javascript">
    var xlh_id = WfForm.convertFieldNameToId("xlh", "detail_1");
    WfForm.registerCheckEvent(WfForm.OPER_SUBMIT, function(callback){
        var allrowindex=WfForm.getDetailAllRowIndexStr("detail_1");
        var flag=false;
        if(""!=allrowindex){
            var ids=allrowindex.split(",");
            var msvalue="";
            for(var i=0;i<ids.length;i++){
                var xlh_value= WfForm.getFieldValue(xlh_id+"_"+ids[i]);
               var res =checklowercase(xlh_value);
                if("1"==res){
                    flag=true;
                }
            }
        }
        if(!flag){
            callback();
        }else{
            WfForm.showConfirm("序列号中包含小写字母，请检查后提交！",function(){
            },function(){
            });
        }
    });

    /* * 判断是否为小写英文字母，是则返回true,否则返回false */
    function checklowercase(obj){
        var flag="0";
        if(""!=obj){
            if (/^[a-z]+$/.test(obj)) {
                flag="1";
            }
        }
        return flag;
    }
</script>
</body>
</html>
