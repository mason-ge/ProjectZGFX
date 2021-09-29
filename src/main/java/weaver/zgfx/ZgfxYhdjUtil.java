package weaver.zgfx;

import java.util.*;


import java.math.*;
import java.text.*;
import java.util.*;
import weaver.conn.*;
import weaver.general.*;
/**
 * 直观复星-银行对接
 * @author chujun
 *
 */
public class ZgfxYhdjUtil extends BaseBean {

	public static boolean insertUf(String gsdm, String jd, String kmdm, String cbzx, int bz, float je, String zy, int lcjl, String lclj, int sqr, String sqrq,String lcbh) {
		boolean flag = false;
		ConnStatement statement = null;
		String sqlInsert = "insert into uf_sapdrmb(gsdm, jd, kmdm, cbzx, bz, je, zy, lcjl, lclj, sqr, sqrq, scrq, modeuuid,lcbh) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			String uuidStr = UUID.randomUUID().toString();
			statement = new ConnStatement();
			statement.setStatementSql(sqlInsert);

			statement.setString(1, gsdm);
			statement.setString(2, jd);
			statement.setString(3, kmdm);
			statement.setString(4, cbzx);
			statement.setInt(5, bz);
			statement.setFloat(6, je);
			statement.setString(7, zy);//asset_name
			statement.setInt(8, lcjl);
			statement.setString(9, lclj);
			statement.setInt(10, sqr);
			statement.setString(11, sqrq);
			statement.setString(12, TimeUtil.getCurrentDateString());
			statement.setString(13, uuidStr);
			statement.setString(14, lcbh);

			statement.executeUpdate();
		}catch(Exception ex) {
			
		}finally{
			try{
				if(statement != null){
					statement.close();
				}
			}catch(Exception exx){
				//
			}
		}

		return flag;
	}

	public static boolean insertUf(String gsdm, String jd, String kmdm, String cbzx, int bz, String je, String zy, int lcjl, String lclj, int sqr, String sqrq,String lcbh) {
		boolean flag = false;
		ConnStatement statement = null;
		RecordSet rs = new RecordSet();
		BaseBean baseBean = new BaseBean();

		String sqlInsert = "insert into uf_sapdrmb(gsdm, jd, kmdm, cbzx, bz, je, zy, lcjl, lclj, sqr, sqrq, scrq, modeuuid,lcbh) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			BigDecimal jeDecimal=new BigDecimal(je);

			String uuidStr = UUID.randomUUID().toString();
			statement = new ConnStatement();
			statement.setStatementSql(sqlInsert);

			statement.setString(1, gsdm);
			statement.setString(2, jd);
			statement.setString(3, kmdm);
			statement.setString(4, cbzx);
			statement.setInt(5, bz);
			statement.setString(6,je);
			statement.setString(7, zy);//asset_name
			statement.setInt(8, lcjl);
			statement.setString(9, lclj);
			statement.setInt(10, sqr);
			statement.setString(11, sqrq);
			statement.setString(12, TimeUtil.getCurrentDateString());
			statement.setString(13, uuidStr);
			statement.setString(14, lcbh);
			statement.executeUpdate();


//			boolean flagRe = rs.executeUpdate(sqlInsert,gsdm,jd,kmdm,cbzx,bz,jeDecimal,zy,lcjl,lclj,sqr,sqrq, TimeUtil.getCurrentDateString(),uuidStr);
//			String aa = rs.getMsg();
//			String bb = rs.getExceptionMsg();
//			baseBean.writeLog("flagRe:"+flagRe);
//			baseBean.writeLog("aa:"+aa);
//			baseBean.writeLog("bb:"+bb);
		}catch(Exception ex) {
			ex.printStackTrace();
			baseBean.writeLog("ex:"+ex.getMessage());
		}finally{
			try{
				if(statement != null){
					statement.close();
				}
			}catch(Exception exx){
				//
			}
		}

		return flag;
	}

	public static String format_(float d){
		String s = "";
		try{
			DecimalFormat df = new DecimalFormat("#0.00");
			s = df.format(d);
		}catch(Exception ex){
			//writeLog_(ex);
		}
		return s;
	}

	public static float getFloatValue(String s, float d) {
		float r = d;
		try{

			r = Util.getFloatValue(   format_(  Util.getFloatValue(s, d)  )   , d   );
		}catch(Exception ex){
			//writeLog_(ex);
		}
		return r;
	}
}
