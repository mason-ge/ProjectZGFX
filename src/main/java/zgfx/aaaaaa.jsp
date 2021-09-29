<%--
  Created by IntelliJ IDEA.
  User: REN
  Date: 2021/1/31
  Time: 12:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script type="text/javascript">
    //门禁指纹开通流程
    var zyr_id = WfForm.convertFieldNameToId("zyr");
    var fq_id = WfForm.convertFieldNameToId("fq","detail_1");
    jQuery().ready(function () {
        WfForm.bindDetailFieldChangeEvent(zyr_id+","+fq_id,function(id,rowIndex,value){
            console.log("-----");
            var zyr_value = WfForm.getFieldValue(zyr_id);
            var fq_value=WfForm.getFieldValue(fq_id+"_"+rowIndex);
            if(""!=zyr_value && ""!=fq_value){
                jQuery.ajax({
                    type:"GET",
                    url:"/jsp/zgfosun/queryfangqu.jsp",
                    async:false,
                    data:{"fqsqry":zyr_value,"fq":fq_value,"type":"0"},
                    dataType: "json",
                    success:function(data) {
                        if(data){
                            if(data.res){
                                //说明防区已经申请过
                                //当前申请人已经申请过的防区,先把字段置空
                                WfForm.changeFieldValue(fq_id+"_"+rowIndex, {
                                    value: " ",
                                    specialobj:[
                                        {id:" ",name:""}
                                    ]
                                });
                                WfForm.showConfirm("当前作用人已经申请过该防区！",function(){
                                },function(){
                                });

                            }
                        }
                    },
                    error:function(e){
                        var str = JSON.stringify(e);
                        WfForm.showConfirm(str,function(){
                        },function(){
                        });
                    }
                });
            }

        });
    })

</script>




</body>
</html>
