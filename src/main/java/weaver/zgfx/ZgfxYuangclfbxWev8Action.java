package weaver.zgfx;

import java.util.*;

import com.greenpineyu.fel.parser.FelParser.integerLiteral_return;

import java.math.*;
import java.text.*;
import java.util.*;
import weaver.conn.*;
import weaver.general.*;
import weaver.hrm.User;
import weaver.hrm.resource.*;
import weaver.soa.workflow.request.RequestInfo;
import weaver.workflow.request.*;
import weaver.workflow.workflow.*;
import weaver.worktask.request.RequestIDManager;
import weaver.interfaces.workflow.action.*;
import weaver.rsa.security.RSA;
/**
 * 直观复星-员工差旅费报销
 * @author chujun
 *
 */
public class ZgfxYuangclfbxWev8Action extends BaseBean implements Action{

	@Override
	public String execute(RequestInfo request) {
		// TODO Auto-generated method stub
		String retStr = Action.SUCCESS;
		try{
			char flag = Util.getSeparator();
			WorkflowComInfo workflowComInfo = new WorkflowComInfo();
			int requestid = Util.getIntValue(request.getRequestid());
			int workflowid = Util.getIntValue(request.getWorkflowid());
			int formid = Util.getIntValue(workflowComInfo.getFormId(""+workflowid));
			String maintablename = "formtable_main_"+((-1)*formid);
			writeLog("requestid = " + requestid);
			writeLog("workflowid = " + workflowid);
			writeLog("formid = " + formid);
			RecordSet rs = new RecordSet();
			RecordSet rs_detail = new RecordSet();
			RecordSet rs0 = new RecordSet();
			String sql = "";

			String requestname = "";
			String lcbh = "";
			RecordSetTrans rst = null;
			if(request.getRequestManager() != null){
				rst = request.getRequestManager().getRsTrans();
			}
			if(rst != null){
				rst.execute("select * from workflow_requestbase where requestid="+requestid);
				if(rst.next()){
					requestname = Util.null2String(rst.getString("requestname"));
					lcbh = Util.null2String(rst.getString("requestmark"));
				}
			}else{
				rs.execute("select * from workflow_requestbase where requestid="+requestid);
				if(rs.next()){
					requestname = Util.null2String(rs.getString("requestname"));
					lcbh = Util.null2String(rs.getString("requestmark"));
				}
			}

			sql = "select * from "+maintablename+" where requestid="+requestid;
			rs.execute(sql);
			if(rs.next()) {
				int mainid = Util.getIntValue(rs.getString("id"), 0);
				int bizhong = Util.getIntValue(rs.getString("bizhong"), 0);
				int cbzx_ = Util.getIntValue(rs.getString("cbzx"), 0);
				int sqr = Util.getIntValue(rs.getString("sqr"), 0);
				String sqrq = Util.null2String(rs.getString("sqrq")).trim();

				String cbzxStr = "";
				rs0.execute("select * from uf_cbzx where id="+cbzx_);
				if(rs0.next()) {
					cbzxStr = Util.null2String(rs0.getString("bh")).trim();
				}

				String gsdm = "";
				String jd = "";
				String kmdm = "";
				String cbzx = "";
				int bz = -1;
				float je = (float)0.00;
				String zy = "";
				int lcjl = requestid;
				String lclj = ""+workflowid;
				String jeStr;

				rs_detail.execute("select * from "+maintablename+"_dt1 where mainid="+mainid);
				while(rs_detail.next()) {
					int fplx = Util.getIntValue(rs_detail.getString("fplx"), 0);
					if(fplx == 0) {
						gsdm = "6300";
						jd = "40";
						kmdm = Util.null2String(rs_detail.getString("fykmdm")).trim();
						cbzx = cbzxStr;
						bz = bizhong;
						//je = ZgfxYhdjUtil.getFloatValue( rs_detail.getString("bhsje"), (float)0.00 );
						jeStr = Util.null2String(rs_detail.getString("bhsje")).trim();
						zy = Util.null2String(rs_detail.getString("mxsm")).trim();
						lcjl = requestid;
						lclj = ""+workflowid;
						ZgfxYhdjUtil.insertUf(gsdm, jd, kmdm, cbzx, bz, jeStr, zy, lcjl, lclj, sqr, sqrq, lcbh);

						gsdm = "6300";
						jd = "40";
						kmdm = "141087";
						cbzx = "";
						bz = bizhong;
						//je = ZgfxYhdjUtil.getFloatValue( rs_detail.getString("se"), (float)0.00 );
						jeStr = Util.null2String(rs_detail.getString("se")).trim();
						zy = Util.null2String(rs_detail.getString("mxsm")).trim();
						lcjl = requestid;
						lclj = ""+workflowid;
						ZgfxYhdjUtil.insertUf(gsdm, jd, kmdm, cbzx, bz, jeStr, zy, lcjl, lclj, sqr, sqrq, lcbh);
					}else if(fplx > 0) {
						gsdm = "6300";
						jd = "40";
						kmdm = Util.null2String(rs_detail.getString("fykmdm")).trim();
						cbzx = cbzxStr;
						bz = bizhong;
						//je = ZgfxYhdjUtil.getFloatValue( rs_detail.getString("mxje"), (float)0.00 );
						jeStr = Util.null2String(rs_detail.getString("mxje")).trim();
						zy = Util.null2String(rs_detail.getString("mxsm")).trim();
						lcjl = requestid;
						lclj = ""+workflowid;
						ZgfxYhdjUtil.insertUf(gsdm, jd, kmdm, cbzx, bz, jeStr, zy, lcjl, lclj, sqr, sqrq, lcbh);
					}
				}
				gsdm = "6300";
				jd = "31";
				kmdm = "302239";
				cbzx = "";
				bz = bizhong;
				//je = ZgfxYhdjUtil.getFloatValue( rs.getString("bbzje"), (float)0.00 );
				jeStr = Util.null2String(rs.getString("bbzje")).trim();
				zy = requestname;
				lcjl = requestid;
				lclj = ""+workflowid;
				ZgfxYhdjUtil.insertUf(gsdm, jd, kmdm, cbzx, bz, jeStr, zy, lcjl, lclj, sqr, sqrq, lcbh);

				gsdm = "6300";
				jd = "21";
				kmdm = "302239";
				cbzx = "";
				bz = bizhong;
				//je = ZgfxYhdjUtil.getFloatValue( rs.getString("bbzje"), (float)0.00 );
				jeStr = Util.null2String(rs.getString("bbzje")).trim();
				zy = requestname;
				lcjl = requestid;
				lclj = ""+workflowid;
				ZgfxYhdjUtil.insertUf(gsdm, jd, kmdm, cbzx, bz, jeStr, zy, lcjl, lclj, sqr, sqrq, lcbh);

				gsdm = "6300";
				jd = "50";
				kmdm = "101500";
				cbzx = "";
				bz = bizhong;
				//je = ZgfxYhdjUtil.getFloatValue( rs.getString("bbzje"), (float)0.00 );
				jeStr = Util.null2String(rs.getString("bbzje")).trim();
				zy = requestname;
				lcjl = requestid;
				lclj = ""+workflowid;
				ZgfxYhdjUtil.insertUf(gsdm, jd, kmdm, cbzx, bz, jeStr, zy, lcjl, lclj, sqr, sqrq, lcbh);
			}
		}catch(Exception ex){
			writeLog(ex);
		}
		return retStr;
	}

}
