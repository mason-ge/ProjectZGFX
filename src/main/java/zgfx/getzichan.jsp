<%@ page import="weaver.general.*,weaver.conn.*,java.text.*,java.util.*" %>
<%@ page import="net.sf.json.JSONObject" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
response.setContentType("text/xml;charset=UTF-8");
	String zyr=request.getParameter("zyr");
	String itzc=request.getParameter("itzc");
	String startdate=request.getParameter("startdate");
	String enddate=request.getParameter("enddate");

String sql = "select COUNT(1) count from uf_zcsqjlb where zyr ='"+zyr+"' and sb='"+itzc+"' and rq BETWEEN '"+startdate+"' and '"+enddate+"'";
rs.execute(sql);
int count=0;
if(rs.next()){
	count = rs.getInt("count");
}
boolean flag=false;
if(count>=1){
	flag=true;
}
	Map result = new HashMap();
	result.put("flag", flag);
	JSONObject jo = JSONObject.fromObject(result);
	out.println(jo);
%>
