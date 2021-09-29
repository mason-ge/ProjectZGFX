<%--
  Created by IntelliJ IDEA.
  User: REN
  Date: 2020/12/23
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script type="text/javascript">
    jQuery().ready(function () {
        //项目负责人

        var xmfzrsfywh=ModeForm.convertFieldNameToId("xmfzrsfywh");
        var xmmc=ModeForm.convertFieldNameToId("xmmc");
        var xmbh=ModeForm.convertFieldNameToId("xmbh");
        var xmfzr=ModeForm.convertFieldNameToId("xmjl");
        var ksrq=ModeForm.convertFieldNameToId("ksrq");
        var owner=ModeForm.convertFieldNameToId("owner");
        var lx=ModeForm.convertFieldNameToId("lx");
        var yy=ModeForm.convertFieldNameToId("yy");
        var xmjsrq=ModeForm.convertFieldNameToId("xmjsrq");
        var qtqxry=ModeForm.convertFieldNameToId("qtqxry");
        var xmbz=ModeForm.convertFieldNameToId("xmbz");
        var xsry=ModeForm.convertFieldNameToId("xsry");
        var gs=ModeForm.convertFieldNameToId("gs");

        var wjmc =ModeForm.convertFieldNameToId("wjmc","detail_1");
        var wjzrr =ModeForm.convertFieldNameToId("wjzrr","detail_1");
        var zwscrq =ModeForm.convertFieldNameToId("zwscrq","detail_1");
        var wjlj =ModeForm.convertFieldNameToId("wjlj","detail_1");
        var sjscrq =ModeForm.convertFieldNameToId("sjscrq","detail_1");
        var zt =ModeForm.convertFieldNameToId("zt","detail_1");
        console.log("wjmc==="+wjmc);
        console.log("wjzrr==="+wjzrr);
        console.log("zwscrq==="+zwscrq);
        console.log("wjlj==="+wjlj);
        console.log("zt==="+zt);

        var userinfo =ModeForm.getCurrentUserInfo();
        var userid=userinfo.userid;
        var allrowindex=  ModeForm.getDetailAllRowIndexStr("detail_1");

        //定义是否是super-user标志
        var flag="0";

        var qtqxry_value=ModeForm.getFieldValue(qtqxry);
        var xmfzr_value=ModeForm.getFieldValue(xmfzr);
        var owner_value=ModeForm.getFieldValue(owner);

        if(xmfzr_value==userid || owner_value==userid || ","+qtqxry_value+"'".indexOf(userid)>-1){
            //此人是项目负责人
            if(xmfzr_value==userid ){
                flag="1";
                ModeForm.changeFieldAttr(xmfzrsfywh, 2);
                /* if(""!=allrowindex){
                     var ids=allrowindex.split(",");
                     for(var i=0;i<ids.length;i++){
                         ModeForm.changeFieldAttr(wjmc+"_"+ids[i], 2);
                         console.log(wjmc+"_"+ids[i]);
                         ModeForm.changeFieldAttr(wjzrr+"_"+ids[i], 2);
                         ModeForm.changeFieldAttr(zwscrq+"_"+ids[i], 2);
                         ModeForm.changeFieldAttr(wjlj+"_"+ids[i], 2);
                         ModeForm.changeFieldAttr(zt+"_"+ids[i], 2);
                     }
                 }*/


            }
            //此人是owner
            if(owner_value==userid){
                //隐藏新增，删除，复制明细按钮
                jQuery("#addbutton1").hide();
                jQuery("#delbutton1").hide();
                jQuery("#copybutton1").hide();
                flag="1"
                ModeForm.changeFieldAttr(xmmc, 2);
                ModeForm.changeFieldAttr(xmbh, 2);
                ModeForm.changeFieldAttr(lx, 2);
                ModeForm.changeFieldAttr(ksrq, 2);
                ModeForm.changeFieldAttr(yy, 2);
                ModeForm.changeFieldAttr(xmfzr, 2);
                ModeForm.changeFieldAttr(xmjsrq, 2);
                ModeForm.changeFieldAttr(qtqxry, 2);
                ModeForm.changeFieldAttr(xmbz, 2);
                ModeForm.changeFieldAttr(xsry, 2);
                ModeForm.changeFieldAttr(gs, 2);
                if(""!=allrowindex){
                    var ids=allrowindex.split(",");
                    for(var i=0;i<ids.length;i++){
                        ModeForm.changeFieldAttr(wjmc+"_"+ids[i], 1);
                        console.log(wjmc+"_"+ids[i]);
                        ModeForm.changeFieldAttr(wjzrr+"_"+ids[i], 1);
                        ModeForm.changeFieldAttr(zwscrq+"_"+ids[i], 1);
                        ModeForm.changeFieldAttr(wjlj+"_"+ids[i], 1);
                        ModeForm.changeFieldAttr(sjscrq+"_"+ids[i], 1);
                        ModeForm.changeFieldAttr(zt+"_"+ids[i], 1);
                    }
                }

            }
            if(","+qtqxry_value+"'".indexOf(userid)>-1){
                //是其他权限人员
                //隐藏新增，删除，复制明细按钮
                jQuery("#addbutton1").hide();
                jQuery("#delbutton1").hide();
                jQuery("#copybutton1").hide();
                flag="1"
            }
        }else {
            jQuery("#addbutton1").hide();
            jQuery("#delbutton1").hide();
            jQuery("#copybutton1").hide();
            flag="1"
            if(""!=allrowindex){
                var array=allrowindex.split(",");
                for (let i = 0; i <array.length ; i++) {
                    var wjzrr_value=ModeForm.getFieldValue(wjzrr+"_"+array[i]);
                    if(wjzrr_value == userid){
                        jQuery("#addbutton1").hide();
                        jQuery("#delbutton1").hide();
                        jQuery("#copybutton1").hide();
                        //此人是文件负责人
                        //sjscrq  zt
                        flag="1";
                        ModeForm.changeFieldAttr(wjzrr+"_"+array[i], 1);
                        ModeForm.changeFieldAttr(wjmc+"_"+array[i], 1);
                        ModeForm.changeFieldAttr(zwscrq+"_"+array[i], 1);
                        ModeForm.changeFieldAttr(wjlj+"_"+array[i], 1);
                        ModeForm.changeFieldAttr(sjscrq+"_"+array[i], 2);
                        ModeForm.changeFieldAttr(zt+"_"+array[i], 2);


                    }else{
                        ModeForm.changeFieldAttr(wjzrr+"_"+array[i], 1);
                        ModeForm.changeFieldAttr(zwscrq+"_"+array[i], 1);
                        ModeForm.changeFieldAttr(sjscrq+"_"+array[i], 1);
                        ModeForm.changeFieldAttr(wjmc+"_"+array[i], 1);
                        ModeForm.changeFieldAttr(zt+"_"+array[i], 1);
                        ModeForm.changeFieldAttr(wjlj+"_"+array[i], 1);
                    }
                }
            }
        }
        if(flag=="0"){
            var lx_value=ModeForm.getFieldValue(lx);
            //判断是不是超级管理员
            jQuery.ajax({
                type:"GET",
                url:"/jsp/zgfosun/getQuanXian.jsp",
                async:false,
                data:{"yhxm":userid},
                dataType: "json",
                success:function(data) {
                    if(data){
                        if(data.yhlx =="S" && data.lx==lx_value){
                            //设置所有字段可编辑
                            ModeForm.changeFieldAttr(xmfzrsfywh, 2);
                            ModeForm.changeFieldAttr(xmmc, 2);
                            ModeForm.changeFieldAttr(xmbh, 2);
                            ModeForm.changeFieldAttr(lx, 2);
                            ModeForm.changeFieldAttr(owner, 2);
                            ModeForm.changeFieldAttr(ksrq, 2);
                            ModeForm.changeFieldAttr(yy, 2);
                            ModeForm.changeFieldAttr(xmfzr, 2);
                            ModeForm.changeFieldAttr(xmjsrq, 2);
                            ModeForm.changeFieldAttr(qtqxry, 2);
                            ModeForm.changeFieldAttr(xmbz, 2);
                            ModeForm.changeFieldAttr(xsry, 2);
                            ModeForm.changeFieldAttr(gs, 2);
                            if(""!=allrowindex){
                                var idarry=allrowindex.split(",");
                                for(var i=0;i<idarry.length;i++){
                                    ModeForm.changeFieldAttr(wjmc+"_"+idarry[i], 2);
                                    ModeForm.changeFieldAttr(wjzrr+"_"+idarry[i], 2);
                                    ModeForm.changeFieldAttr(zwscrq+"_"+idarry[i], 2);
                                    ModeForm.changeFieldAttr(wjlj+"_"+idarry[i], 2);
                                    ModeForm.changeFieldAttr(sjscrq+"_"+array[i], 2);
                                    ModeForm.changeFieldAttr(zt+"_"+idarry[i], 2);
                                }
                            }
                        }else{
                            if(""!=allrowindex){
                                var idarry=allrowindex.split(",");
                                for(var i=0;i<idarry.length;i++){
                                    ModeForm.changeFieldAttr(wjmc+"_"+idarry[i], 1);
                                    ModeForm.changeFieldAttr(wjzrr+"_"+idarry[i], 1);
                                    ModeForm.changeFieldAttr(zwscrq+"_"+idarry[i], 1);
                                    ModeForm.changeFieldAttr(wjlj+"_"+idarry[i], 1);
                                    ModeForm.changeFieldAttr(sjscrq+"_"+array[i], 1);
                                    ModeForm.changeFieldAttr(zt+"_"+idarry[i], 1);
                                }
                            }
                        }
                    }else{
                        ModeList.showConfirm("查询用户权限出错，请联系管理员！",function(){
                        },function(){
                        })
                    }
                },
                error:function(e){
                    var str = JSON.stringify(e);
                    alert(str);
                }
            });
        }
    })

    function _customAddFun1(addIndexStr){
        console.log("addIndexStr======"+addIndexStr);
        var wjmc =ModeForm.convertFieldNameToId("wjmc","detail_1");
        var wjzrr =ModeForm.convertFieldNameToId("wjzrr","detail_1");
        var zwscrq =ModeForm.convertFieldNameToId("zwscrq","detail_1");
        var wjlj =ModeForm.convertFieldNameToId("wjlj","detail_1");
        var zt =ModeForm.convertFieldNameToId("zt","detail_1");
        ModeForm.changeFieldAttr(wjmc+"_"+addIndexStr, 2);
        ModeForm.changeFieldAttr(wjzrr+"_"+addIndexStr, 2);
        ModeForm.changeFieldAttr(zwscrq+"_"+addIndexStr, 2);
        ModeForm.changeFieldAttr(wjlj+"_"+addIndexStr, 2);
        ModeForm.changeFieldAttr(zt+"_"+addIndexStr, 2);
    }



</script>

</body>
</html>
