<%@ page import="weaver.general.*,weaver.conn.*,java.text.*,java.util.*" %>
<%@ page import="net.sf.json.JSONObject" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
response.setContentType("text/xml;charset=UTF-8");
String fqsqry=request.getParameter("fqsqry");
String fq=request.getParameter("fq");
String sql = "select * from uf_fqryxx where fqsqry='"+fqsqry+"' and fq='"+fq+"'";
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
