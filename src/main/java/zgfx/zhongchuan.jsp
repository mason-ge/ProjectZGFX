<%@ page import="net.sf.json.JSONObject"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="utf-8"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
    response.setContentType("application/json;charset=UTF-8");
    String id =Util.null2String(request.getParameter("id")).trim();
    boolean res = false;
    String qry = "SELECT d.id,d.departmentname FROM HrmDepartment d,HrmResource h WHERE h.departmentid=d.id AND h.id=" +id;
    rs.execute(qry);
    String deptid="";
    String deptname="";
    if(rs.next()){
        deptid= rs.getString("id");
        deptname= rs.getString("departmentname");
    }
    if(""!=deptid){
        res=true;
    }
    Map result = new HashMap();
    result.put("res", res);
    result.put("deptid", deptid);
    result.put("deptname", deptname);
    JSONObject jo = JSONObject.fromObject(result);
    out.println(jo);
%>

