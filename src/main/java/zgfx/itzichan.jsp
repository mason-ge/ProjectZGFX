<%@ page import="weaver.general.*,weaver.conn.*,java.text.*,java.util.*" %>
<%@ page import="net.sf.json.JSONObject" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
response.setContentType("text/xml;charset=UTF-8");
String yhxm=request.getParameter("yhxm");
String sql = "select * from uf_qxxxb where ','+CONVERT(VARCHAR(MAX),yhxm)+',' like '%,"+yhxm+",%'";
rs.execute(sql);
String yhlx="";
String lx="";
if(rs.next()){
	yhlx=Util.null2String(rs.getString("yhlx"));
	lx=Util.null2String(rs.getString("lx"));
}
	Map result = new HashMap();
	result.put("yhlx", yhlx);
	result.put("lx", lx);
	JSONObject jo = JSONObject.fromObject(result);
	out.println(jo);
%>
