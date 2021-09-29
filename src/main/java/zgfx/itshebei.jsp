<%--
  Created by IntelliJ IDEA.
  User: REN
  Date: 2021/1/27
  Time: 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script type="text/javascript">
    //申请日期
    var sqrq_id = WfForm.convertFieldNameToId("sqrq");
    //作用人
    var zyr_id = WfForm.convertFieldNameToId("zyr");
    //设备名称
    var itzc_id = WfForm.convertFieldNameToId("itzc", "detail_1");

    jQuery().ready(function () {
        var sqrq_value =WfForm.getFieldValue(sqrq_id);
        var date = new Date(sqrq_value);
        var year =parseInt(date.getFullYear())-1;
        var mon=date.getMonth();
        var day=date.getDate();
        if(mon+"".length==1){
            mon="0"+mon;
        }
        if(day+"".length==1){
            day="0"+day;
        }
        var zyr_value =WfForm.getFieldValue(zyr_id);
        //12个月之前的日期
        var datestr=year+"-"+mon+"-"+day;

        var allrowindex=WfForm.getDetailAllRowIndexStr("detail_1");
        if(""!=allrowindex){
            var ids=allrowindex.split(",");
            for(var i=0;i<ids.length;i++){
                var itzc_value =WfForm.getFieldValue(itzc_id+"_"+ids[i]);
                var res= sendAjax(zyr_value,itzc_value,datestr,sqrq_value);
                if("1"==res){
                    WfForm.showConfirm("<p style='color: #FF3C3C'>作用人过去12个月已提交过该资产的2张单据！</p>",function(){
                        return;
                    },function(){
                        return;
                    })
                }
            }

        }
    })
    function sendAjax(zyr,itzc,startdate,enddate) {
        var flag="0";
        if(""!=zyr && ""!=itzc && ""!=startdate &&""!=enddate){
            jQuery.ajax({
                type:"GET",
                url:"/jsp/zgfosun/getzichan.jsp",
                async:false,
                data:{"zyr":zyr,"itzc":itzc,"startdate":startdate,"enddate":enddate},
                dataType: "json",
                success:function(data) {
                    if(data){
                        if(data.flag){
                            flag="1";
                        }
                    }
                },
                error:function(e){
                    WfForm.showConfirm("查询资产出错，请联系管理员！",function(){
                    },function(){
                    })
                }
            });
        }
        return flag;
    }

    WfForm.registerCheckEvent(WfForm.OPER_SUBMIT, function(callback){
        var sqrq_value =WfForm.getFieldValue(sqrq_id);
        var date = new Date(sqrq_value);
        var year =parseInt(date.getFullYear())-1;
        var mon=date.getMonth();
        var day=date.getDate();
        if(mon+"".length==1){
            mon="0"+mon;
        }
        if(day+"".length==1){
            day="0"+day;
        }
        var zyr_value =WfForm.getFieldValue(zyr_id);
        //12个月之前的日期
        var datestr=year+"-"+mon+"-"+day;

        var allrowindex=WfForm.getDetailAllRowIndexStr("detail_1");
        var flag=false;
        if(""!=allrowindex){
            var ids=allrowindex.split(",");
            for(var i=0;i<ids.length;i++){
                var itzc_value =WfForm.getFieldValue(itzc_id+"_"+ids[i]);
                var res= sendAjax(zyr_value,itzc_value,datestr,sqrq_value);
                if("1"==res){
                    flag=true;
                }
            }

        }
        if(flag){
            WfForm.showConfirm("<p style='color: #FF3C3C'>作用人过去12个月已提交过该资产的2张单据！</p>",function(){

            },function(){

            })
            callback();
        }
        callback();




    });
    var sfxrz_id = WfForm.convertFieldNameToId("sfxrz");
    var zyr_id = WfForm.convertFieldNameToId("zyr");
    var zyr1_id = WfForm.convertFieldNameToId("zyr1");

    WfForm.bindFieldChangeEvent(sfxrz_id, function(obj,id,value){
        if("0"==value){
            //是的时候清空浏览字段值
            WfForm.changeFieldValue(zyr1_id, {value: " ",specialobj:[{id:"",name:""}]});
        }else if("1"==value){
            //否的时候清空文本字段值
            WfForm.changeFieldValue(zyr_id, {value:""});
        }else{
            WfForm.changeFieldValue(zyr1_id, {value: " ",specialobj:[{id:"",name:""}]});
            WfForm.changeFieldValue(zyr_id, {value:""});
        }
    });

</script>
<script type="text/javascript">
    var jexj_id = WfForm.convertFieldNameToId("jexj", "detail_1");
    var cwzcbh_id = WfForm.convertFieldNameToId("cwzcbh", "detail_1");
    var xlh_id = WfForm.convertFieldNameToId("xlh", "detail_1");
    window.checkCustomize = function(){
        var flag = true;
        var allrowindex=WfForm.getDetailAllRowIndexStr("detail_1");
        if(""!=allrowindex){
            var ids=allrowindex.split(",");
            for(var i=0;i<ids.length;i++){
                var jexj_value =WfForm.getFieldValue(jexj_id+"_"+ids[i]);
                var cwzcbh_value =WfForm.getFieldValue(cwzcbh_id+"_"+ids[i]);
                var xlh_value =WfForm.getFieldValue(xlh_id+"_"+ids[i]);
                var res=checklowercase(jexj_value);
                var res2=checklowercase(cwzcbh_value);
                var res3=checklowercase(xlh_value);

                if("1"==res || "1"==res2 || "1"==res3){
                    flag=false;
                    WfForm.showConfirm("明细中型号、财务资产编号、序列号包含小写字母，请修改后提交！",function(){
                    },function(){
                    })
                    break;
                }

            }

        }
        return flag;
    }
    function checklowercase(field) {
        if(""!=field){
            if (/[a-z]+/g.test(field)){
                return "1";
            }
        }
        return "0";
    }
</script>

<script type="text/javascript">
    //门禁指纹开通流程
    var zyr_id = WfForm.convertFieldNameToId("zyr");
    var fq_id = WfForm.convertFieldNameToId("fq", "detail_1");
    jQuery().ready(function () {
        WfForm.bindDetailFieldChangeEvent(zyr_id+","+fq_id,function(id,rowIndex,value){
            var zyr_value = WfForm.getFieldValue(zyr_id);
            var fq_value=WfForm.getFieldValue(fq_id+"_"+rowIndex);
            if(""!=zyr_value && ""!=fq_value){
                jQuery.ajax({
                    type:"GET",
                    url:"/jsp/zgfosun/queryfangqu.jsp",
                    async:false,
                    data:{"fqsqry":zyr_value,"fq":fq_value,"type":"1"},
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
                                WfForm.showConfirm("当前被委派人已经委派过该防区！",function(){
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
