<%--
  Created by IntelliJ IDEA.
  User: REN
  Date: 2021/1/15
  Time: 14:12
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

        var userinfo =ModeForm.getCurrentUserInfo();
        var userid=userinfo.userid;
        var allrowindex=  ModeForm.getDetailAllRowIndexStr("detail_1");


        var owner_value=ModeForm.getFieldValue(owner);
        var xmfzr_value=ModeForm.getFieldValue(xmfzr);
        var qtqxry_value=ModeForm.getFieldValue(qtqxry);
        var xsry_value=ModeForm.getFieldValue(xsry);

        //先判断当前登录人员是不是supser或者custom
        var yhlx="-1";
        console.log("------");
        var lx_value=ModeForm.getFieldValue(lx);
        if(""!=userid){
            jQuery.ajax({
                type:"GET",
                url:"/jsp/zgfosun/getQuanXian.jsp",
                async:false,
                data:{"yhxm":userid},
                dataType: "json",
                success:function(data) {
                    if(data){
                        //0-s 1-o 2-c
                        if(data.yhlx =="0" && data.lx==lx_value){
                            yhlx=0;
                            //设置所有字段可编辑
                            ModeForm.changeFieldAttr(xmfzrsfywh, 2);
                            ModeForm.changeFieldAttr(xmmc, 2);
                            ModeForm.changeFieldAttr(xmbh, 2);
                            ModeForm.changeFieldAttr(lx, 1);
                            ModeForm.changeFieldAttr(owner, 1);
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
                                    ModeForm.changeFieldAttr(sjscrq+"_"+idarry[i], 2);
                                    ModeForm.changeFieldAttr(zt+"_"+idarry[i], 2);
                                }
                            }
                        }else if(data.yhlx =="2"){
                            yhlx=2;
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
        if(yhlx =="-1" || yhlx =="2"){
            //说明不是super-user
            //此人是owner
            if(owner_value ==userid && (yhlx =="2" || xmfzr_value==userid  ||  ","+qtqxry_value+",".indexOf(","+userid+","))){
                //owner和项目负责人，其他人员，销售人员是同一个人
                ModeForm.changeFieldAttr(xmmc, 2);
                ModeForm.changeFieldAttr(xmbh, 2);
                ModeForm.changeFieldAttr(lx, 1);
                ModeForm.changeFieldAttr(ksrq, 2);
                ModeForm.changeFieldAttr(yy, 2);
                ModeForm.changeFieldAttr(xmfzr, 2);
                ModeForm.changeFieldAttr(xmjsrq, 2);
                ModeForm.changeFieldAttr(qtqxry, 2);
                ModeForm.changeFieldAttr(xmbz, 2);
                ModeForm.changeFieldAttr(xsry, 2);
                ModeForm.changeFieldAttr(gs, 2);
                ModeForm.changeFieldAttr(xmfzrsfywh, 2);
                if(owner_value ==userid && xmfzr_value==userid){
                    if(""!=allrowindex){
                        var ids=allrowindex.split(",");
                        for(var i=0;i<ids.length;i++){
                            ModeForm.changeFieldAttr(wjmc+"_"+ids[i], 3);
                            ModeForm.changeFieldAttr(wjzrr+"_"+ids[i], 3);
                            ModeForm.changeFieldAttr(zwscrq+"_"+ids[i], 3);
                            ModeForm.changeFieldAttr(wjlj+"_"+ids[i], 3);
                        }
                    }
                }else{
                    if(""!=allrowindex){
                        var ids=allrowindex.split(",");
                        for(var i=0;i<ids.length;i++){
                            ModeForm.changeFieldAttr(wjmc+"_"+ids[i], 2);
                            ModeForm.changeFieldAttr(wjzrr+"_"+ids[i], 2);
                            ModeForm.changeFieldAttr(zwscrq+"_"+ids[i], 2);
                            ModeForm.changeFieldAttr(wjlj+"_"+ids[i], 2);
                            ModeForm.changeFieldAttr(sjscrq+"_"+ids[i], 2);
                            ModeForm.changeFieldAttr(zt+"_"+ids[i], 2);
                        }
                    }
                }
            }
            else if(owner_value==userid){
                ModeForm.changeFieldAttr(xmmc, 2);
                ModeForm.changeFieldAttr(xmbh, 2);
                ModeForm.changeFieldAttr(lx, 1);
                ModeForm.changeFieldAttr(ksrq, 2);
                ModeForm.changeFieldAttr(yy, 2);
                ModeForm.changeFieldAttr(xmfzr, 2);
                ModeForm.changeFieldAttr(xmjsrq, 2);
                ModeForm.changeFieldAttr(qtqxry, 2);
                ModeForm.changeFieldAttr(xmbz, 2);
                ModeForm.changeFieldAttr(xsry, 2);
                ModeForm.changeFieldAttr(gs, 2);
                ModeForm.changeFieldAttr(xmfzrsfywh, 2);
                if(""!=allrowindex){
                    var ids=allrowindex.split(",");
                    for(var i=0;i<ids.length;i++){
                        ModeForm.changeFieldAttr(wjmc+"_"+ids[i], 2);
                        ModeForm.changeFieldAttr(wjzrr+"_"+ids[i], 2);
                        ModeForm.changeFieldAttr(zwscrq+"_"+ids[i], 2);
                        ModeForm.changeFieldAttr(wjlj+"_"+ids[i], 2);
                        ModeForm.changeFieldAttr(sjscrq+"_"+ids[i], 2);
                        ModeForm.changeFieldAttr(zt+"_"+ids[i], 2);
                    }
                }
            }
            else if(xmfzr_value==userid){
                //项目负责人
                ModeForm.changeFieldAttr(xmfzrsfywh, 2);
                ModeForm.changeFieldAttr("", 3);  //字段修改为只读
                if(""!=allrowindex){
                    var ids=allrowindex.split(",");
                    for(var i=0;i<ids.length;i++){
                        ModeForm.changeFieldAttr(wjmc+"_"+ids[i], 3);
                        ModeForm.changeFieldAttr(wjzrr+"_"+ids[i], 3);
                        ModeForm.changeFieldAttr(zwscrq+"_"+ids[i], 3);
                        ModeForm.changeFieldAttr(wjlj+"_"+ids[i], 3);
                    }
                }



            }else if(xmfzr_value==userid && (yhlx =="2" || ","+qtqxry_value+",".indexOf(","+userid+","))){
                // 项目负责人和其他人员,销售人员,为c的人员
                ModeForm.changeFieldAttr(xmfzrsfywh, 2);
            }else  if( ","+qtqxry_value+",".indexOf(","+userid+",") ||  yhlx =="2") {
                //其他人员，销售，为c的人员
                jQuery("#addbutton1").hide();
                jQuery("#delbutton1").hide();
                jQuery("#copybutton1").hide();
                if(""!=allrowindex){
                    var array=allrowindex.split(",");
                    for (let i = 0; i <array.length ; i++) {
                        var wjzrr_value=ModeForm.getFieldValue(wjzrr+"_"+array[i]);
                        if(wjzrr_value == userid){
                            //此人是文件负责人
                            //sjscrq  zt
                            ModeForm.changeFieldAttr(wjzrr+"_"+array[i], 3);
                            ModeForm.changeFieldAttr(wjmc+"_"+array[i], 1);
                            ModeForm.changeFieldAttr(zwscrq+"_"+array[i], 1);
                            ModeForm.changeFieldAttr(wjlj+"_"+array[i], 1);
                            ModeForm.changeFieldAttr(sjscrq+"_"+array[i], 3);
                            ModeForm.changeFieldAttr(zt+"_"+array[i], 3);
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
            }else{
                //文件负责人
                jQuery("#addbutton1").hide();
                jQuery("#delbutton1").hide();
                jQuery("#copybutton1").hide();
                var array=allrowindex.split(",");
                for (let i = 0; i <array.length ; i++) {
                    var wjzrr_value=ModeForm.getFieldValue(wjzrr+"_"+array[i]);
                    if(wjzrr_value == userid){
                        //此人是文件负责人
                        //sjscrq  zt
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
    })

    function _customAddFun1(addIndexStr){
        console.log("addIndexStr======"+addIndexStr);
        var wjmc =ModeForm.convertFieldNameToId("wjmc","detail_1");
        var wjzrr =ModeForm.convertFieldNameToId("wjzrr","detail_1");
        var zwscrq =ModeForm.convertFieldNameToId("zwscrq","detail_1");
        var wjlj =ModeForm.convertFieldNameToId("wjlj","detail_1");
        var zt =ModeForm.convertFieldNameToId("zt","detail_1");
        var sjscrq =ModeForm.convertFieldNameToId("sjscrq","detail_1");
        ModeForm.changeFieldAttr(wjmc+"_"+addIndexStr, 3);
        ModeForm.changeFieldAttr(wjzrr+"_"+addIndexStr, 3);
        ModeForm.changeFieldAttr(zwscrq+"_"+addIndexStr, 3);
        ModeForm.changeFieldAttr(wjlj+"_"+addIndexStr, 3);
        ModeForm.changeFieldAttr(sjscrq+"_"+addIndexStr, 2);
        ModeForm.changeFieldAttr(zt+"_"+addIndexStr, 2);
    }



</script>
</body>
</html>
