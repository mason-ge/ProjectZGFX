package weaver.interfaces.workflow.action;

import weaver.conn.RecordSet;
import weaver.conn.RecordSetTrans;
import weaver.formmode.data.ModeDataIdUpdate;
import weaver.formmode.setup.ModeRightInfo;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.RequestInfo;
import weaver.workflow.workflow.WorkflowComInfo;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 功能说明： 直观复星 银行对接接口Excel导出（对私）
 * 
 * @author tangss  
 * 
 */
public class ZgFosunBankDataExportForPrivateAction extends BaseBean implements Action {

	//银行对接Excel导出（对私） uf_yhdjdcds

	private String fkrzh;		//付款人账户
	private String fkrmc;		//付款人名称
	private String skrzh;		//收款人账户
	private String skrmc;		//收款人名称
	private String skrkhh;		//收款人开户行
	private String khhmc;		//开户行名称
	private String cnaps;		//CNAPS行号
	private String khywbh;		//客户业务编号
	private String fkje;		//付款金额
	private String ffzh;		//付费账号
	private String zdfkrq;		//指定付款日期
	private String yt;			//用途
	private String clyxj;		//处理优先级
	private String skremail;	//收款人Email
	private String sqr;			//申请人
	private String sqrq;		//申请日期
	private String sqjl;		//申请记录

	public String getFkrzh() {
		return fkrzh;
	}

	public void setFkrzh(String fkrzh) {
		this.fkrzh = fkrzh;
	}

	public String getFkrmc() {
		return fkrmc;
	}

	public void setFkrmc(String fkrmc) {
		this.fkrmc = fkrmc;
	}

	public String getSkrzh() {
		return skrzh;
	}

	public void setSkrzh(String skrzh) {
		this.skrzh = skrzh;
	}

	public String getSkrmc() {
		return skrmc;
	}

	public void setSkrmc(String skrmc) {
		this.skrmc = skrmc;
	}

	public String getSkrkhh() {
		return skrkhh;
	}

	public void setSkrkhh(String skrkhh) {
		this.skrkhh = skrkhh;
	}

	public String getKhhmc() {
		return khhmc;
	}

	public void setKhhmc(String khhmc) {
		this.khhmc = khhmc;
	}

	public String getCnaps() {
		return cnaps;
	}

	public void setCnaps(String cnaps) {
		this.cnaps = cnaps;
	}

	public String getKhywbh() {
		return khywbh;
	}

	public void setKhywbh(String khywbh) {
		this.khywbh = khywbh;
	}

	public String getFkje() {
		return fkje;
	}

	public void setFkje(String fkje) {
		this.fkje = fkje;
	}

	public String getFfzh() {
		return ffzh;
	}

	public void setFfzh(String ffzh) {
		this.ffzh = ffzh;
	}

	public String getZdfkrq() {
		return zdfkrq;
	}

	public void setZdfkrq(String zdfkrq) {
		this.zdfkrq = zdfkrq;
	}

	public String getYt() {
		return yt;
	}

	public void setYt(String yt) {
		this.yt = yt;
	}

	public String getClyxj() {
		return clyxj;
	}

	public void setClyxj(String clyxj) {
		this.clyxj = clyxj;
	}

	public String getSkremail() {
		return skremail;
	}

	public void setSkremail(String skremail) {
		this.skremail = skremail;
	}

	public String getSqr() {
		return sqr;
	}

	public void setSqr(String sqr) {
		this.sqr = sqr;
	}

	public String getSqrq() {
		return sqrq;
	}

	public void setSqrq(String sqrq) {
		this.sqrq = sqrq;
	}

	public String getSqjl() {
		return sqjl;
	}

	public void setSqjl(String sqjl) {
		this.sqjl = sqjl;
	}

	@Override
	public String execute(RequestInfo request) {
		try {
			char flag = Util.getSeparator();
			WorkflowComInfo workflowComInfo = new WorkflowComInfo();
			int requestid = Util.getIntValue(request.getRequestid());
			int workflowid = Util.getIntValue(request.getWorkflowid());
			int formid = Util.getIntValue(workflowComInfo.getFormId("" + workflowid));
			String maintablename = "formtable_main_" + ((-1) * formid);
			writeLog("requestid = " + requestid);
			writeLog("workflowid = " + workflowid);
			writeLog("formid = " + formid);

			//获取流程编号
			String requestmark = "";
			RecordSetTrans rsts = request.getRsTrans();
			if(rsts!=null){
				try{
					rsts.executeSql("select requestmark from workflow_requestbase where requestid = " + request.getRequestid());
					if(rsts.next()){
						requestmark = Util.null2String(rsts.getString("requestmark"));
					}
				}catch(Exception e){
					writeLog("ZgFosunBankDataExportForPrivateAction: " + e);
				}
			}else{
				RecordSet rs = new RecordSet();
				rs.execute("select requestmark from workflow_requestbase where requestid = " + request.getRequestid());
				if(rs.next()){
					requestmark = Util.null2String(rs.getString("requestmark"));
				}
			}


			RecordSet rs = new RecordSet();
			String qryMain = "select accountid1 as skrzh,field3 as skrmc,bankname as khhmc,cnapsh,"+this.fkje+",requestname as yt,lastname as sqrmc,d.id as sqrid,"+this.sqrq+
							" from " + maintablename + " a " +
							" left join cus_fielddata b on a."+this.sqr+"=b.id " +
							" left join HrmResource d on a."+this.sqr+"=d.id " +
							" left join workflow_requestbase e on a.requestid=e.requestid " +
							" left join HrmBank f on d.bankid1=f.id " +
							" left join uf_cnapdzb c on f.bankname=c.yxmc " +
							" where a.requestid =" + requestid;
			writeLog("qryMain => ", qryMain);
			rs.execute(qryMain);
			if (rs.next()) {
				String skrzhval = Util.null2String(rs.getString("skrzh"));
				String skrmcval = Util.null2String(rs.getString("skrmc"));
				String khhmcval = Util.null2String(rs.getString("khhmc"));
				String cnapsval = Util.null2String(rs.getString("cnapsh"));
				String fkjeval = Util.null2String(rs.getString("je"));
				String ytval = Util.null2String(rs.getString("yt"));
				String sqrval = Util.null2String(rs.getString("sqrid"));
				String sqrqval = Util.null2String(rs.getString("sqrq"));

				//插入建模数据
				//1.插入新纪录
				Date d = new Date();
				SimpleDateFormat sdfd = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat sdft = new SimpleDateFormat("HH:mm:ss");
				String date = sdfd.format(d);
				String time = sdft.format(d);
				ModeDataIdUpdate modeDataIdUpdate = new ModeDataIdUpdate();
				int id_1 = modeDataIdUpdate.getModeDataNewIdByUUID("uf_yhdjdcds", 53, 1, 0, date, time);
				//2.更新数据数据
				RecordSet rs_update = new RecordSet();
				String sql = "update uf_yhdjdcds set fkrzh='"+this.fkrzh+"',fkrmc='"+this.fkrmc+"',skrzh='"+skrzhval+"',skrmc='"+skrmcval+"',skrkhh='"+this.skrkhh+"'," +
						" khhmc='"+khhmcval+"',cnaps='"+cnapsval+"',khywbh='"+this.khywbh+"',fkje='"+fkjeval+"',ffzh='"+this.ffzh+"',zdfkrq=''," +
						" yt='"+ytval+"',clyxj='"+this.clyxj+"',skremail='"+this.skremail+"',sqr='"+sqrval+"',sqrq='"+sqrqval+"',sqjl='"+requestid+"',lcbh='"+requestmark+"' where id="+id_1;
				writeLog("rs_update sql => ", sql);
				rs_update.execute(sql);
				//3.新建的时候添加共享
				ModeRightInfo moderightinfo = new ModeRightInfo();
				moderightinfo.setNewRight(true);
				moderightinfo.editModeDataShare(1, 53, id_1);
			}
		} catch (Exception ex) {
			writeLog(ex);
		}
		return Action.SUCCESS;
	}
}