<%@ page import="weaver.general.*,weaver.conn.*,java.text.*,java.util.*" %>
<%@ page import="net.sf.json.JSONObject" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
response.setContentType("text/xml;charset=UTF-8");
String fqsqry=request.getParameter("fqsqry");
String fq=request.getParameter("fq");
String type=request.getParameter("type");
String table="";
if("0".equals(type)){
	table="uf_fqryxx";
}else if("1".equals(type)){
	table="uf_fqwpsqjl";
}
String sql = "select * from "+table+" where fqsqry='"+fqsqry+"' and fq='"+fq+"'";
rs.execute(sql);
boolean flag=false;
if(rs.next()){
	flag=true;
}
	Map result = new HashMap();
	result.put("res", flag);
	JSONObject jo = JSONObject.fromObject(result);
	out.println(jo);
%>
