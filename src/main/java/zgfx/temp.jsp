<%--
  Created by IntelliJ IDEA.
  User: REN
  Date: 2021/1/22
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script>
    var yearArr = [2020, 2021, 2022, 2023, 2024, 2025, 2026, 2027, 2028, 2029];
    jQuery(document).ready(function () {
        //年份、月份
        var nf1fieldid = WfForm.convertFieldNameToId("nf", "detail_1");
        var yf1fieldid = WfForm.convertFieldNameToId("yf", "detail_1");
        var nf2fieldid = WfForm.convertFieldNameToId("nf", "detail_2");
        var yf2fieldid = WfForm.convertFieldNameToId("yf", "detail_2");
        //报销限额、报销金额
        var bxxe1fieldid = WfForm.convertFieldNameToId("bxxe", "detail_1");
        var bxje1fieldid = WfForm.convertFieldNameToId("bxje", "detail_1");
        var bxxe2fieldid = WfForm.convertFieldNameToId("bxxe", "detail_2");
        var bxje2fieldid = WfForm.convertFieldNameToId("bxje", "detail_2");
        //餐费报销金额
        var bxje1fieldid = WfForm.convertFieldNameToId("bxje", "detail_1");

        //*********如果选择之前年份，则显示全部月份； 如果选择当年，则显示当前月份及之前月份 start
        //*********员工不可报销入职月份及之前的费用 start
        //获取入职日期 如果入职月份是12月份，则只能从下一年份开始报销
        var entryYear = "2019";
        var entryMonth = "12";
        //var ecUser = ecCom.WeaTools.ls.getJSONObj('theme-account');
        //var uid = ecUser.userid;
        var uid = WfForm.getFieldValue("field8434");
        //uid = 3;
        $.ajax({
            type: "GET",
            async: false,
            url: "/jsp/zgfosun/GetEntryDate.jsp",
            data: {
                uid: uid
            },
            datatype: "json",
            success: function (data) {
                var companystartdate = data.companystartdate;
                if (companystartdate.length == 10) {
                    entryYear = companystartdate.substr(0, 4);
                    entryMonth = companystartdate.substr(5, 2);
                }
            }
        });
        if (entryMonth == "12") {
            entryYear = parseInt(entryYear) + 1;
            entryMonth = 1;
        } else {
            //entryMonth = parseInt(entryMonth) + 1;
            entryMonth = parseInt(entryMonth);
        }
        //获取当前年份、月份
        // var today = new Date();
        var today = $.ajax({
            async: false
        }).getResponseHeader("Date");
        today = new Date(today);
        var tYear = today.getFullYear();
        //tYear = "2023";
        var tMonth = today.getMonth();
        //获取可以显示的年份
        var dspYear = "";
        var startYearIndex = 0;
        for (var i = 0; i < yearArr.length; i++) {
            var y = yearArr[i];
            if (y == entryYear) {
                startYearIndex = i;
            }
        }
        for (var i = startYearIndex; i < yearArr.length; i++) {
            var y = yearArr[i];
            if (parseInt(tMonth) > 2) {
                if (parseInt(tYear) == parseInt(y)) {
                    dspYear += "," + i;
                }
            } else { //每年三月份之前可以选择上一年的数据
                if (parseInt(tYear) == parseInt(y) || parseInt(tYear) - 1 == parseInt(y)) {
                    dspYear += "," + i;
                }
            }
        }
        if (dspYear != "") {
            dspYear = dspYear.substr(1);
        }
        //////////////////新增明细行时
        WfForm.registerAction(WfForm.ACTION_ADDROW + "1", function (index) {
            //年份控制
            WfForm.controlSelectOption(nf1fieldid + "_" + index, dspYear);
            //月份控制
            controlMonthSelectOption(tYear, tMonth, entryYear, entryMonth, nf1fieldid + "_" + index,
                yf1fieldid + "_" + index);
        });

        WfForm.registerAction(WfForm.ACTION_ADDROW + "2", function (index) {
            //年份控制
            WfForm.controlSelectOption(nf2fieldid + "_" + index, dspYear);
            //月份控制
            controlMonthSelectOption(tYear, tMonth, entryYear, entryMonth, nf2fieldid + "_" + index,
                yf2fieldid + "_" + index);
        });

        //////////////////页面打开时遍历明细行
        var allRowIndexStr1 = WfForm.getDetailAllRowIndexStr("detail_1");
        var allRowIndexStrArr1 = allRowIndexStr1.split(",");
        for (var i = 0; i < allRowIndexStrArr1.length; i++) {
            var index = allRowIndexStrArr1[i];
            //年份控制
            WfForm.controlSelectOption(nf1fieldid + "_" + index, dspYear);
            //月份控制
            controlMonthSelectOption(tYear, tMonth, entryYear, entryMonth, nf1fieldid + "_" + index,
                yf1fieldid + "_" + index);
        }

        var allRowIndexStr2 = WfForm.getDetailAllRowIndexStr("detail_2");
        var allRowIndexStrArr2 = allRowIndexStr2.split(",");
        for (var i = 0; i < allRowIndexStrArr2.length; i++) {
            var index = allRowIndexStrArr2[i];
            //年份控制
            WfForm.controlSelectOption(nf2fieldid + "_" + index, dspYear);
            //月份控制
            controlMonthSelectOption(tYear, tMonth, entryYear, entryMonth, nf2fieldid + "_" + index,
                yf2fieldid + "_" + index);
        }

        //////////////////年份字段值改变时
        WfForm.bindDetailFieldChangeEvent(nf1fieldid, function (id, rowIndex, value) {
            //获取报销额度
            getExpenseLimit(1, bxxe1fieldid + "_" + rowIndex);
            //月份控制
            controlMonthSelectOption(tYear, tMonth, entryYear, entryMonth, nf1fieldid + "_" + rowIndex,
                yf1fieldid + "_" + rowIndex);
        });

        WfForm.bindDetailFieldChangeEvent(nf2fieldid, function (id, rowIndex, value) {
            //获取报销额度
            getExpenseLimit(2, bxxe2fieldid + "_" + rowIndex);
            //月份控制
            controlMonthSelectOption(tYear, tMonth, entryYear, entryMonth, nf2fieldid + "_" + rowIndex,
                yf2fieldid + "_" + rowIndex);
        });
        //*********如果选择之前年份，则显示全部月份； 如果选择当年，则显示当前月份及之前月份 end
        //*********员工不可报销入职月份及之前的费用 end
        //*********获取报销额度 start
        //选择年份月份后，根据人员内外勤（主表.nwq）和级别（主表.jibie）自动带出人员的报销额度（报销额度维护表：uf_ygcfbxbz）
        WfForm.bindDetailFieldChangeEvent(yf1fieldid, function (id, rowIndex, value) {
            //获取报销额度
            getExpenseLimit(1, bxxe1fieldid + "_" + rowIndex);
        });

        WfForm.bindDetailFieldChangeEvent(yf2fieldid, function (id, rowIndex, value) {
            //获取报销额度
            getExpenseLimit(2, bxxe2fieldid + "_" + rowIndex);
        });
        //如果该月份报销已经申请过，则报销额度为0。
        //*********获取报销额度 end

        checkCustomize = function () {
            var msg11 = "";
            var msg12 = "";
            var msg21 = "";
            var msg22 = "";
            var msg31 = "";

            var mapNy1 = new Map();
            var nyStr1 = "";
            var didStr1 = "";
            var allRowIndexStr1 = WfForm.getDetailAllRowIndexStr("detail_1");
            var allRowIndexStrArr1 = allRowIndexStr1.split(",");
            for (var i = 0; i < allRowIndexStrArr1.length; i++) {
                var index = allRowIndexStrArr1[i];
                //*********每个明细中月份不允许重复 start
                var nf1fieldvalue = WfForm.getFieldValue(nf1fieldid + "_" + index);
                var yf1fieldvalue = WfForm.getFieldValue(yf1fieldid + "_" + index);
                var bxje1fieldvalue = WfForm.getFieldValue(bxje1fieldid + "_" + index);
                console.log("nf1fieldvalue:nf1fieldvalue -- ", nf1fieldvalue + ":" + yf1fieldvalue);
                var ny1 = nf1fieldvalue + yf1fieldvalue;
                console.log("ny1 -- ", ny1);
                if (mapNy1.has(ny1)) {
                    msg11 = "【餐费】报销月份不能重复";
                } else {
                    mapNy1.set(ny1, ny1);
                    nyStr1 += "," + ny1;
                }
                console.log("nyStr1 -- ", nyStr1);
                //*********每个明细中月份不允许重复 end
                if(bxje1fieldvalue > 400){
                    msg31 = "【餐费】单月报销金额不能超过400元";
                }
                //被打回之后，不要重新检查自己
                didStr1 += "," + WfForm.getDetailRowKey(yf1fieldid + "_" + index);
                console.log("didStr1 -- ", didStr1);
            }
            // alert(didStr1);
            //*********每个明细中月份不允许重复(其他流程是否已经填写) start
            if (nyStr1 != "" && nyStr1 != ",") {
                console.log("nyStr1 --1 ", nyStr1);
                nyStr1 = nyStr1.substr(1);
                console.log("nyStr1 --2 ", nyStr1);
                nyStr1 = nyStr1.replace(new RegExp(",", "gm"), "','");
                console.log("nyStr1 --3 ", nyStr1);
                nyStr1 = "'" + nyStr1 + "'";
                console.log("nyStr1 --4 ", nyStr1);
                didStr1 = didStr1.substr(1);
                console.log("didStr1 -- ", didStr1);

                $.ajax({
                    type: "GET",
                    async: false,
                    url: "/jsp/zgfosun/CheckExpenseMonthUnique.jsp",
                    data: {
                        uid: uid,
                        nystr: nyStr1,
                        type: "1",
                        did: didStr1
                    },
                    datatype: "json",
                    success: function (data) {
                        if (data.hasData == true) {
                            msg11 = "【餐费】其他流程中已经填写相同月份报销";
                        }
                    }
                });
            }
            //*********每个明细中月份不允许重复(其他流程是否已经填写) end

            var mapNy2 = new Map();
            var nyStr2 = "";
            var didStr2 = "";
            var allRowIndexStr2 = WfForm.getDetailAllRowIndexStr("detail_2");
            var allRowIndexStrArr2 = allRowIndexStr2.split(",");
            for (var i = 0; i < allRowIndexStrArr2.length; i++) {
                var index = allRowIndexStrArr2[i];
                //*********每个明细中月份不允许重复 start
                var nf2fieldvalue = WfForm.getFieldValue(nf2fieldid + "_" + index);
                var yf2fieldvalue = WfForm.getFieldValue(yf2fieldid + "_" + index);
                var ny2 = nf2fieldvalue + yf2fieldvalue;
                if (mapNy2.has(ny2)) {
                    msg21 = "【通讯费】报销月份不能重复";
                } else {
                    mapNy2.set(ny2, ny2);
                    nyStr2 += "," + ny2;
                }
                //*********每个明细中月份不允许重复 end

                //被打回之后，不要重新检查自己
                didStr2 += "," + WfForm.getDetailRowKey(yf2fieldid + "_" + index);
            }
            // alert(didStr2);
            //*********每个明细中月份不允许重复(其他流程是否已经填写) start
            if (nyStr2 != "" && nyStr2 != ",") {
                nyStr2 = nyStr2.substr(1);
                nyStr2 = nyStr2.replace(new RegExp(",", "gm"), "','");
                nyStr2 = "'" + nyStr2 + "'";
                didStr2 = didStr2.substr(1);

                $.ajax({
                    type: "GET",
                    async: false,
                    url: "/jsp/zgfosun/CheckExpenseMonthUnique.jsp",
                    data: {
                        uid: uid,
                        nystr: nyStr2,
                        type: "2",
                        did: didStr2
                    },
                    datatype: "json",
                    success: function (data) {
                        if (data.hasData == true) {
                            msg21 = "【通讯费】其他流程中已经填写相同月份报销";
                        }
                    }
                });
            }
            //*********每个明细中月份不允许重复(其他流程是否已经填写) end

            var msg = msg11 + msg12 + msg21 + msg22 + msg31;
            if (msg != "") {
                top.Dialog.alert(msg);
                return false;
            }

            return true;
        }

    });

    function getExpenseLimit(type, bxxeid) {
        //内外勤、级别
        var nwqfieldid = WfForm.convertFieldNameToId("nwq");
        var nwqfieldvalue = WfForm.getFieldValue(nwqfieldid);
        //nwqfieldvalue = 1;
        var jibiefieldid = WfForm.convertFieldNameToId("jibie");
        var jibiefieldvalue = WfForm.getFieldValue(jibiefieldid);
        //jibiefieldvalue = 3;

        if (nwqfieldvalue != "" && jibiefieldvalue != "") {
            $.ajax({
                type: "GET",
                async: true,
                url: "/jsp/zgfosun/GetExpenseLimit.jsp",
                data: {
                    nwq: nwqfieldvalue,
                    jibie: jibiefieldvalue,
                    type: type
                },
                datatype: "json",
                success: function (data) {
                    var bz = data.bz;
                    WfForm.changeFieldValue(bxxeid, {
                        value: bz
                    });
                }
            });
        }
    }

    function controlMonthSelectOption(year, month, entryYear, entryMonth, yearid, monthid) {
        var nffieldvalue = WfForm.getFieldValue(yearid);
        var sYear = yearArr[nffieldvalue];
        if (sYear == year) {
            var startMonthIndex = (sYear == entryYear) ? parseInt(entryMonth) - 1 : 0; //是否入职年份，计算起始月份
            var dspMonth = "";
            for (var i = startMonthIndex; i <= month; i++) {
                dspMonth += "," + i;
            }
            if (dspMonth != "") {
                dspMonth = dspMonth.substr(1);
            }
            WfForm.controlSelectOption(monthid, dspMonth);
        } else {
            if (sYear == entryYear) { //非当前年，且是入职年份
                var dspMonth = "";
                for (var i = parseInt(entryMonth) - 1; i < 12; i++) {
                    dspMonth += "," + i;
                }
                if (dspMonth != "") {
                    dspMonth = dspMonth.substr(1);
                }
                WfForm.controlSelectOption(monthid, dspMonth);
            } else { //非当前年，且非入职年份
                WfForm.controlSelectOption(monthid, "0,1,2,3,4,5,6,7,8,9,10,11");
            }
        }


    }
</script>

</body>
</html>
