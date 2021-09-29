<%@ page import="net.sf.json.*"%>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
response.setContentType("application/json;charset=UTF-8");
String uid = Util.null2String(request.getParameter("uid")).trim();
String nystr = Util.null2String(request.getParameter("nystr")).trim();
String type = Util.null2String(request.getParameter("type")).trim();
String did = Util.null2String(request.getParameter("did")).trim();

String didStr = "";
if(!did.equals("-1")){
    didStr = "and a.id not in ("+did+")";
}

//检查该年月是否已经填写报销
boolean hasData = false;
String dt = type.equals("1") ? "formtable_main_129_dt1" : "formtable_main_129_dt2";
String qry = "select * from "+dt+" a join formtable_main_129 b on a.mainid=b.id " +
            " left join workflow_requestLog relog on relog.requestid=a.mainid " +
        " where b.sqr="+uid+" and (a.nf+a.yf) in ("+nystr+") " + didStr+" and and relog.logtype <>'1'";


    rs.execute(qry);
if(rs.getCounts() > 0){
    hasData = true;
}

Map result = new HashMap();
result.put("hasData", hasData);
JSONObject jo = JSONObject.fromObject(result);
out.println(jo);
%>