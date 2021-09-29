<%--
  Created by IntelliJ IDEA.
  User: REN
  Date: 2020/11/16
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<script type="text/javascript">
    //是否主机安装申请流程上线后
    var sfzjazsqlcsxhid = WfForm.convertFieldNameToId("sfzjazsqlcsxh");
    var zjazsqlcid = WfForm.convertFieldNameToId("zjazsqlc");

    jQuery().ready(function(){
        WfForm.bindFieldChangeEvent(sfzjazsqlcsxhid, function(obj,id,value){
            if("0"==value){
                WfForm.changeFieldAttr(zjazsqlcid, 3);  //字段修改为必填
            }else if("1"==value){
                WfForm.showConfirm("请通过附件上传按钮上传主机安装报告",function(){

                },function(){

                });
            }else{
                WfForm.changeFieldAttr(zjazsqlcid, 2);  //字段修改为可编辑
            }
        });
    })



    var cbzxid = WfForm.convertFieldNameToId("cbzx");
    var zd1id = WfForm.convertFieldNameToId("zd1");
    var zd2id = WfForm.convertFieldNameToId("zd2");
    jQuery().ready(function() {

        WfForm.bindFieldChangeEvent(cbzxid + "," + zd1id, function (obj, id, value) {
            console.log("------" + value);
            //29,25,2
            if (id == cbzxid) {
                if (value == "2") {
                    WfForm.changeFieldAttr(zd1id, 3);  //字段修改为必填
                } else {
                    WfForm.changeFieldAttr(zd1id, 1);  //字段修改为必填
                    WfForm.changeFieldAttr(zd2id, 1);  //字段修改为必填
                }
            } else {
                WfForm.changeFieldValue(zd1id, {value: ""});
                WfForm.changeFieldValue(zd2id, {value: ""});
                WfForm.changeFieldAttr(zd1id, 1);  //字段修改为只读
                WfForm.changeFieldAttr(zd2id, 1);  //字段修改为只读
            }
            if (id == zd1id) {
                if (value == "0") {
                    //Hospital & Clinical Mktg
                    WfForm.changeFieldAttr(zd2id, 3);  //字段修改为必填
                } else if (value == "1") {
                    //Others Mktg
                    WfForm.changeFieldAttr(zd2id, 1);  //字段修改为只读
                } else {
                    WfForm.changeFieldAttr(zd2id, 1);  //字段修改为只读
                }

            }
        });
    })



    jQuery(document).ready(function(){
        jQuery("#field27563").bindPropertyChange(function(obj,id,value){
            console.log("tri...",obj,id,value);
        });
    });


    jQuery().ready(function() {
        //填单人
        var jkbxrid="field9479";
        //填单人部门
        var deptid="field9478";
        var value= jQuery("#field9479").val();
        if ("" != value) {
            $.ajax({
                type: "GET",
                async: false,
                url: "/jsp/zhongchuan.jsp",
                data: {
                    id: value
                },
                datatype: "json",
                success: function (data) {
                    console.log("返回-------" + data);
                    if (data.res) {
                        jQuery("#field9478").val(data.deptid);
                        jQuery("#field9478span").html(data.deptname)
                    }
                }
            });
        }

    });
</script>
<script>
    jQuery(function(){
        WfForm.controlDateRange("field9412",0);
        WfForm.controlDateRange("field9413",0);
        var cbzxid = WfForm.convertFieldNameToId("cbzx");
        var zd1id = WfForm.convertFieldNameToId("zd1");
        var zd2id = WfForm.convertFieldNameToId("zd2");
        var cbzx_value = WfForm.getFieldValue(cbzxid);
        var zd1_value = WfForm.getFieldValue(zd1id);
        if(""!=cbzx_value){
            if("2"==cbzx_value){
                WfForm.changeFieldAttr(zd1id, 3);
                if(""!=zd1_value){
                    if("0"==zd1_value){
                        WfForm.changeFieldAttr(zd2id, 3);
                    }else{
                        WfForm.changeFieldAttr(zd2id, 1);
                    }
                }else{
                    WfForm.changeFieldAttr(zd2id, 1);
                }
            }else{
                WfForm.changeFieldAttr(zd1id, 1);
            }
        }else{
            WfForm.changeFieldAttr(zd1id, 1);
            WfForm.changeFieldAttr(zd2id, 1);
        }

        WfForm.bindFieldChangeEvent(cbzxid+","+zd1id, function(obj,id,value){
            console.log("------"+value);
            //29,25,2
            if(id==cbzxid){
                if(value=="2"){
                    WfForm.changeFieldAttr(zd1id, 3);
                }else{
                    WfForm.changeFieldValue(zd1id, {value:""});
                    WfForm.changeFieldValue(zd2id, {value:""});
                    WfForm.changeFieldAttr(zd1id, 1);
                    WfForm.changeFieldAttr(zd2id, 1);
                }
            }
            if(id==zd1id){
                if(value=="0"){
                    //Hospital & Clinical Mktg
                    WfForm.changeFieldAttr(zd2id, 3);
                }else if(value=="1"){
                    //Others Mktg
                    WfForm.changeFieldValue(zd2id, {value:""});
                    WfForm.changeFieldAttr(zd2id, 1);
                }else{
                    WfForm.changeFieldValue(zd2id, {value:""});
                    WfForm.changeFieldAttr(zd2id, 1);
                }

            }
        });
    });
    var fieldid = ModeForm.convertFieldNameToId("detailid","detail_1");
    ModeForm.bindDetailFieldChangeEvent(fieldid,function(id,rowIndex,value){
        var fieldvalue = ModeForm.getFieldValue(fieldid+"_"+rowIndex);
        console.log("明细1第"+rowIndex+1+"行值是-----"+fieldvalue);
    });
</script>
<script type="text/javascript">
    jQuery(document).ready(function(){
        //文件路径
        var wjljfieldid = ModeForm.convertFieldNameToId("wjlj", "detail_1");

        var allRowIndexStr = ModeForm.getDetailAllRowIndexStr("detail_1");
        var allRowIndexStrArray = allRowIndexStr.split(",");

        for(var i=0; i<allRowIndexStrArray.length; i++){
            var index = allRowIndexStrArray[i];
            jQuery("#"+wjljfieldid+"_"+index+"span").css("cursor","pointer");
            jQuery("#"+wjljfieldid+"_"+index+"span").css("color","#123885");
            (function(index){
                jQuery("#"+wjljfieldid+"_"+index+"span").click(function(){
                    var wjljfieldvalue = ModeForm.getFieldValue(wjljfieldid+"_"+index);
                    if(wjljfieldvalue.startsWith("http")){
                        window.open(wjljfieldvalue,"blank");
                    }else{
                        window.open("http://"+wjljfieldvalue,"blank");
                    }
                });
            })(index);
        }

    });
</script>
<script type="text/javascript">
    //运维管理流程
    var dqksrq_id = WfForm.convertFieldNameToId("dqksrq", "detail_1");
    var dqjsrq_id = WfForm.convertFieldNameToId("dqjsrq", "detail_1");
    var ksrq_id = WfForm.convertFieldNameToId("ksrq", "detail_1");
    var jsrq_id = WfForm.convertFieldNameToId("jsrq", "detail_1");

    var wtclms_id= WfForm.convertFieldNameToId("wtclms", "detail_1");
    var cljgms_id= WfForm.convertFieldNameToId("cljgms");
    var zzfkrq_id= WfForm.convertFieldNameToId("zzfkrq");

    var sfdtqtyhtj_id=WfForm.convertFieldNameToId("sfdtqtyhtj");
    var yccs_id=WfForm.convertFieldNameToId("yccs");

    jQuery().ready(function(){
        WfForm.changeFieldValue(yccs_id, {value:"0"})
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


        WfForm.bindFieldChangeEvent(sfdtqtyhtj_id, function(obj,id,value){
            if("0"==value){
                WfForm.changeFieldValue(yccs_id, {value:"1"})
            }
        });


    });

    function startbuttonclick(e){
        //开始日期赋值
        var date = new Date();
        var day=date.getDate();
        var month=date.getMonth()+1;
        var year= date.getFullYear();
        if(day+"".length==1){
            day="0"+day;
        }
        if(month+"".length==1){
            month="0"+month;
        }
        var datestr=year+"-"+month+"-"+day;
        WfForm.changeFieldValue(ksrq_id+"_"+e, {value:datestr});
    }
    function endbuttonclick(e){
        //开始日期赋值
        var date = new Date();
        var day=date.getDate();
        var month=date.getMonth()+1;
        var year= date.getFullYear();
        if(day+"".length==1){
            day="0"+day;
        }
        if(month+"".length==1){
            month="0"+month;
        }
        var datestr=year+"-"+month+"-"+day;
        WfForm.changeFieldValue(jsrq_id+"_"+e, {value:datestr});
    }
    WfForm.registerCheckEvent(WfForm.OPER_SUBMIT, function(callback){
        var allrowindex=WfForm.getDetailAllRowIndexStr("detail_1");
        if(""!=allrowindex){
            var ids=allrowindex.split(",");
            var res="";
            for(var i=0;i<ids.length;i++){
                let wtclms_value= WfForm.getFieldValue(wtclms_id+"_"+ids[i]);
                if(""!=wtclms_value){
                    res+=wtclms_value+";"+"\n"
                }
            }
            WfForm.changeFieldValue(cljgms_id, {value:res});
        }
        callback();    //继续提交需调用callback，不调用代表阻断
    });
</script>
<script type="text/javascript">
    //门禁指纹开通流程
    var zyr_id = WfForm.convertFieldNameToId("zyr");
    var fq_id = WfForm.convertFieldNameToId("fq", "detail_1");
    jQuery().ready(function () {
        console.log("--------");
        WfForm.registerCheckEvent(WfForm.OPER_SUBMIT, function(callback){
                var flag = true;
                var zyr_value = WfForm.getFieldValue(zyr_id);
                var allrowindex=WfForm.getDetailAllRowIndexStr("detail_1");
                if(""!=allrowindex){
                    var ids=allrowindex.split(",");
                    for(var i=0;i<ids.length;i++){
                        var fq_value=WfForm.getFieldValue(fq_id+"_"+ids[i]);
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
                                            flag=false;

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
                    }
                }
                if(!flag){
                    WfForm.showConfirm("当前被委派人防区已被委派过，不能再次委派！",function(){
                    },function(){
                    });
                    flag=false;
                }
                if(flag){
                    callback();    //继续提交需调用callback，不调用代表阻断
                }
            }
        );
    })
</script>



<script type="text/javascript">
    //门禁指纹开通流程
    var zyr_id = WfForm.convertFieldNameToId("zyr");
    var fq_id = WfForm.convertFieldNameToId("fq", "detail_1");
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



    //门禁指纹开通流程
    var zyr_id = WfForm.convertFieldNameToId("zyr");
    var fq_id = WfForm.convertFieldNameToId("fq", "detail_1");
    jQuery().ready(function () {
        console.log("--------");
        WfForm.registerCheckEvent(WfForm.OPER_SUBMIT, function(callback){
                var flag = true;
                var zyr_value = WfForm.getFieldValue(zyr_id);
                var allrowindex=WfForm.getDetailAllRowIndexStr("detail_1");
                if(""!=allrowindex){
                    var ids=allrowindex.split(",");
                    for(var i=0;i<ids.length;i++){
                        var fq_value=WfForm.getFieldValue(fq_id+"_"+ids[i]);
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
                                            flag=false;

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
                    }
                }
                if(!flag){
                    WfForm.showConfirm("当前被委派人防区已被委派过，不能再次委派！",function(){
                    },function(){
                    });
                    flag=false;
                }
                if(flag){
                    callback();    //继续提交需调用callback，不调用代表阻断
                }
            }
        );
    })







</script>

















<script type="text/javascript">
    var zzfkrq_id= WfForm.convertFieldNameToId("rqcs");

    WfForm.registerCheckEvent(WfForm.OPER_SUBMIT, function(callback){

        var date = new Date();
        var day = date.getDate();
        var month = date.getMonth() + 1;
        var year = date.getFullYear();
        if (day + "".length == 1) {
            day = "0" + day;
        }
        if (month + "".length == 1) {
            month = "0" + month;
        }
        var datestr = year + "-" + month + "-" + day;
        WfForm.changeFieldValue(zzfkrq_id, {value: datestr});
        callback();    //继续提交需调用callback，不调用代表阻断
    });
</script>
<script type="text/javascript">
    //门禁指纹开通流程
    var zyr_id = WfForm.convertFieldNameToId("zyr");
    var fq_id = WfForm.convertFieldNameToId("fq", "detail_1");
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
                    data:{"fqsqry":zyr_value,"fq":fq_value},
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





<script type="text/javascript">
    //采购申请流程
    //部门id 21，63，53
    var sqbm_id= WfForm.convertFieldNameToId("sqbm");
    var itsqlc_id= WfForm.convertFieldNameToId("itsqlc");
    var yccs_id= WfForm.convertFieldNameToId("yccs");

    jQuery().ready(function () {
        var sqbm_value = WfForm.getFieldValue(sqbm_id);
        if(!("21"==sqbm_value || "63"==sqbm_value || "53"==sqbm_value)){
            WfForm.changeFieldAttr(itsqlc_id, 4);
            WfForm.changeFieldValue(yccs_id, { value:"0"});
        }
    })

</script>
<script type="text/javascript">
    //运维管理流程发起节点
    var sfdtqtyhtj_id=WfForm.convertFieldNameToId("sfdtqtyhtj");
    var yccs_id= WfForm.convertFieldNameToId("yccs");
    jQuery().ready(function () {
        WfForm.changeFieldValue(yccs_id, {value:"0"})

        WfForm.bindFieldChangeEvent(sfdtqtyhtj_id, function(obj,id,value){
            if("0"==value){
                WfForm.changeFieldValue(yccs_id, {value:"1"})
            }else{
                WfForm.changeFieldValue(yccs_id, {value:"0"})
            }
        });
    })

</script>

<script type="text/javascript">
    /* * 判断是否为小写英文字母，是则返回true,否则返回false */

    //代码
    function f_check_lowercase(obj)
    {
        if (/[a-z]+/g.test( obj ))
        {
            return true;
        }
        f_alert(obj,"请输入小写英文字母");
        return false;
    }
</script>

<script type="text/javascript">
    var rqcs_id=WfForm.convertFieldNameToId("rqcs");
    var mscs_id=WfForm.convertFieldNameToId("mscs");
    var wtclms_id= WfForm.convertFieldNameToId("wtclms", "detail_1");
    WfForm.registerCheckEvent(WfForm.OPER_SUBMIT, function(callback){
        var allrowindex=WfForm.getDetailAllRowIndexStr("detail_1");
        if(""!=allrowindex){
            var ids=allrowindex.split(",");
            var msvalue="";
            for(var i=0;i<ids.length;i++){
                var wtclms_value= WfForm.getFieldValue(wtclms_id+"_"+ids[i]);
                if(""!=wtclms_value){
                    msvalue+=wtclms_value+";"+"\n"
                }
            }
            WfForm.changeFieldValue(mscs_id, {value:msvalue});
        }
        var date = new Date();
        var day = date.getDate();
        var month = date.getMonth() + 1;
        var year = date.getFullYear();
        if (day + "".length == 1) {
            day = "0" + day;
        }
        if (month + "".length == 1) {
            month = "0" + month;
        }
        var datestr = year + "-" + month + "-" + day;
        WfForm.changeFieldValue(rqcs_id, {value: datestr});
        callback();    //继续提交需调用callback，不调用代表阻断
    });
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
        WfForm.changeFieldValue(clr_id+"_"+addIndexStr, {value: " ",specialobj:[{id:"",name:""}]});
        WfForm.changeFieldValue(kssj_id+"_"+addIndexStr, {value: " ",specialobj:[{id:"",name:""}]});
        WfForm.changeFieldValue(jssj_id+"_"+addIndexStr, {value: " ",specialobj:[{id:"",name:""}]});
    }
</script>
<script type="text/javascript">
    jQuery(".ant-col-10").children("span").eq(1).children("button").show();
    jQuery(".ant-tree-child-tree").children("li").eq(6).children("ul").children("li").eq("1").show()
</script>

<script type="text/javascript">
    //门禁指纹开通流程
    var zyr_id = WfForm.convertFieldNameToId("zyr");
    var fq_id = WfForm.convertFieldNameToId("fq", "detail_1");
    jQuery().ready(function () {
        console.log("--------");
        WfForm.registerCheckEvent(WfForm.OPER_SUBMIT, function(callback){
                var flag = true;
                var zyr_value = WfForm.getFieldValue(zyr_id);
                var allrowindex=WfForm.getDetailAllRowIndexStr("detail_1");
                if(""!=allrowindex){
                    var ids=allrowindex.split(",");
                    for(var i=0;i<ids.length;i++){
                        var fq_value=WfForm.getFieldValue(fq_id+"_"+ids[i]);
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
                                            flag=false;

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
                    }
                }
                if(!flag){
                    WfForm.showConfirm("当前被委派人防区已被委派过，不能再次委派！",function(){
                    },function(){
                    });
                    flag=false;
                }
                if(flag){
                    callback();    //继续提交需调用callback，不调用代表阻断
                }
            }
        );
    })

</script>
</body>
<head>
    <title>Title</title>
</head>
</html>
