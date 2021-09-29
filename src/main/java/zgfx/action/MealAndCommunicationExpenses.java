package zgfx.action;

import java.text.DecimalFormat;

import org.apache.commons.lang3.StringUtils;
import org.apache.regexp.recompile;

import weaver.conn.RecordSet;
import weaver.formmode.setup.ModeRightInfo;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.*;
import weaver.workflow.request.RequestManager;
import weaver.workflow.workflow.WorkflowComInfo;
/**
 * 餐费和通讯费报销
 * */
public class MealAndCommunicationExpenses extends BaseBean implements Action {
    @Override
    public String execute(RequestInfo request) {
        //防区退回action
        String retStr = Action.SUCCESS;
        RequestManager rm = request.getRequestManager();
        WorkflowComInfo workflowComInfo = new WorkflowComInfo();
        int requestid = Util.getIntValue(request.getRequestid());   //requestid
        int cjr = Util.getIntValue(request.getCreatorid()); //创建人
        String requestname = Util.null2String(request.getRequestManager().getRequestname());    //标题
        int workflowid = Util.getIntValue(request.getWorkflowid()); //流程id
        int formid = Util.getIntValue(workflowComInfo.getFormId("" + workflowid));  //表单id
        String maintablename = "formtable_main_" + (Math.abs(formid));  //表名
        int wfstatus = request.getRequestManager().getCreater(); //（代码执行时）当前节点
        writeLog("requestid = " + requestid);   //统一日志类
        writeLog("workflowid = " + workflowid);
        writeLog("formid = " + formid);
        String formmodeid="38";

        Property[] properties = request.getMainTableInfo().getProperty();// 获取表单主字段信息
        String bizhong="";
        String sqr="";
        String sqrq="";
        String bbzje="";
        String je="";
        String cbzx="";
        String sfxazhrheadcountblcffy="";
        String bxnr="";
        String vendor="";

        try {
            for (int i = 0; i < properties.length; i++) {
                String field = properties[i].getName();// 主字段名称
                if("bizhong".equalsIgnoreCase(field)){
                    bizhong =Util.null2String(properties[i].getValue());
                }
                if("sqr".equalsIgnoreCase(field)){
                    sqr =Util.null2String(properties[i].getValue());
                }
                if("sqrq".equalsIgnoreCase(field)){
                    sqrq =Util.null2String(properties[i].getValue());
                }
                if("bbzje".equalsIgnoreCase(field)){
                    bbzje =Util.null2String(properties[i].getValue());
                }
                if("je".equalsIgnoreCase(field)){
                    je =Util.null2String(properties[i].getValue());
                }
                if("cbzx".equalsIgnoreCase(field)){
                    cbzx =Util.null2String(properties[i].getValue());
                }
                if("sfxazhrheadcountblcffy".equalsIgnoreCase(field)){
                    sfxazhrheadcountblcffy =Util.null2String(properties[i].getValue());
                }
                if("bxnr".equalsIgnoreCase(field)){
                    bxnr =Util.null2String(properties[i].getValue());
                }
                if("vendor".equalsIgnoreCase(field)){
                    vendor =Util.null2String(properties[i].getValue());
                }

                writeLog("TravelExpenses---field======"+field+"----------"+Util.null2String(properties[i].getValue()));
            }
        //获取明细表数据
        DetailTable[] detailtable = request.getDetailTableInfo().getDetailTable();
        RecordSet rs = new RecordSet();
        RecordSet rs2 = new RecordSet();
        if (detailtable.length > 0) {
            for (int i = 0; i < detailtable.length; i++) {
                DetailTable dt = detailtable[i];// 指定明细表
                if(0==i){
                    //明细1
                    Row[] s = dt.getRow();// 当前明细表的所有数据,按行存储
                    for (int j = 0; j < s.length; j++) {
                        Row r = s[j];// 指定行
                        Cell c[] = r.getCell();// 每行数据再按列存储
                        //发票类型
                        String  fplx="";
                        //不含税金额
                        String  bhsje="";
                        //描述说明
                        String  mxsm="";
                        //费用科目代码
                        String  fykmdm="";
                        //税额
                        String  se="";

                        String  mxje="";
                        String  bxje="";
                        for (int k = 0; k < c.length; k++) {
                            Cell c1 = c[k];// 指定列
                            String name = c1.getName();// 明细字段名称
                            if("fplx".equals(name)){
                                fplx = c1.getValue();// 明细字段的值
                            }
                            if("bhsje".equals(name)){
                                //明细金额
                                bhsje=c1.getValue();// 明细字段的值
                            }
                            if("mxsm".equals(name)){
                                mxsm=c1.getValue();// 明细字段的值
                            }
                            if("fykmdm".equals(name)){
                                fykmdm=c1.getValue();// 明细字段的值
                            }
                            if("se".equals(name)){
                                se=c1.getValue();// 明细字段的值
                            }
                            if("mxje".equals(name)){
                                mxje=c1.getValue();// 明细字段的值
                            }
                            if("bxje".equals(name)){
                                bxje=c1.getValue();// 明细字段的值
                            }
                            //writeLog("TravelExpenses---name======"+name+"-------value---"+c1.getValue());
                        }

                        if(StringUtils.isNotBlank(sqr) && StringUtils.isNotBlank(bxje)){
                            String selectsql="select jan21,costcenter from uf_dcbzxryxxb where chinesename="+sqr;
                            rs.execute(selectsql);
                            Double tempje = getDoubleValue(bxje, (double)0);
                            boolean flag=false;
                            //如果有成本中心则按成本中新拆分，如果没有，按照默认方式拆分
                            while (rs.next()){
                                flag=true;
                                Double jan21=getDoubleValue(rs.getString("jan21"), (double)0);
                                String  costcenter=Util.null2String(rs.getString("costcenter"));
                                String bh = getCostcenterCodeById(costcenter);
                                Double jine =tempje*jan21;
                                String sql1="insert into uf_sapdrmb(gsdm,jd,kmdm,cbzx,bz,je,zy,lcjl,lclj,sqr,sqrq,scrq,formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,fz,lcbh) values('6300','40','"+fykmdm+
                                        "','"+bh+"','"+bizhong+"',"+jine+",'"+mxsm+"','"+requestid+"','"+workflowid+"','"+sqr+"','"+sqrq+"',CONVERT(varchar(100), GETDATE(),23),'"+
                                        formmodeid+"','"+sqr+"','0',CONVERT(varchar(100), GETDATE(),23),CONVERT(varchar(100), GETDATE(),24),'0','"+requestid+"')";
                                writeLog("sq1111======="+sql1);
                                rs2.execute(sql1);
                            }
                            if(!flag){
                                String bh = getCostcenterCodeById(cbzx);

                                String sql1="insert into uf_sapdrmb(gsdm,jd,kmdm,cbzx,bz,je,zy,lcjl,lclj,sqr,sqrq,scrq,formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,fz,lcbh) values('6300','40','"+fykmdm+
                                        "','"+bh+"','"+bizhong+"',"+bxje+",'"+mxsm+"','"+requestid+"','"+workflowid+"','"+sqr+"','"+sqrq+"',CONVERT(varchar(100), GETDATE(),23),'"+
                                        formmodeid+"','"+sqr+"','0',CONVERT(varchar(100), GETDATE(),23),CONVERT(varchar(100), GETDATE(),24),'0','"+requestid+"')";
                                writeLog("sq1222======="+sql1);
                                rs2.execute(sql1);
                            }
                        }
                    }
                }else if(1==i){
                    //明细2
                    Row[] s = dt.getRow();// 当前明细表的所有数据,按行存储
                    for (int j = 0; j < s.length; j++) {
                        Row r = s[j];// 指定行
                        Cell c[] = r.getCell();// 每行数据再按列存储
                        String fykmdm="";
                        String bxje="";
                        String mxsm="";
                        for (int k = 0; k < c.length; k++) {
                            Cell c1 = c[k];// 指定列
                            String name = c1.getName();// 明细字段名称
                            if("fykmdm".equals(name)){
                                fykmdm= c1.getValue();// 明细字段的值
                            }
                            if("bxje".equals(name)){
                                bxje= c1.getValue();// 明细字段的值
                            }
                            if("mxsm".equals(name)){
                                mxsm= c1.getValue();// 明细字段的值
                            }
                        }
                        if(StringUtils.isNotBlank(sqr) && StringUtils.isNotBlank(bxje)){
                            String selectsql="select jan21,costcenter from uf_dcbzxryxxb where chinesename="+sqr;
                            rs.execute(selectsql);
                            Double tempje = getDoubleValue(bxje, (double)0);
                            boolean flag=false;
                            //如果有成本中心则按成本中新拆分，如果没有，按照默认方式拆分
                            while (rs.next()){
                                flag=true;
                                Double jan21=getDoubleValue(rs.getString("jan21"), (double)0);
                                String  costcenter=Util.null2String(rs.getString("costcenter"));
                                String bh = getCostcenterCodeById(costcenter);
                                if((!"".equals(fykmdm)) && fykmdm.startsWith("6")){

                                }else{
                                    bh="";
                                }
                                Double jine =tempje*jan21;
                                String sql1="insert into uf_sapdrmb(gsdm,jd,kmdm,cbzx,bz,je,zy,lcjl,lclj,sqr,sqrq,scrq,formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,fz,lcbh) values('6300','40','"+fykmdm+
                                        "','"+bh+"','"+bizhong+"',"+jine+",'"+mxsm+"','"+requestid+"','"+workflowid+"','"+sqr+"','"+sqrq+"',CONVERT(varchar(100), GETDATE(),23),'"+
                                        formmodeid+"','"+sqr+"','0',CONVERT(varchar(100), GETDATE(),23),CONVERT(varchar(100), GETDATE(),24),'0','"+requestid+"')";
                                rs2.execute(sql1);
                            }
                            if(!flag){
                                String bh = getCostcenterCodeById(cbzx);
                                if((!"".equals(fykmdm)) && fykmdm.startsWith("6")){

                                }else{
                                    bh="";
                                }
                                String sql1="insert into uf_sapdrmb(gsdm,jd,kmdm,cbzx,bz,je,zy,lcjl,lclj,sqr,sqrq,scrq,formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,fz,lcbh) values('6300','40','"+fykmdm+
                                        "','"+bh+"','"+bizhong+"',"+bxje+",'"+mxsm+"','"+requestid+"','"+workflowid+"','"+sqr+"','"+sqrq+"',CONVERT(varchar(100), GETDATE(),23),'"+
                                        formmodeid+"','"+sqr+"','0',CONVERT(varchar(100), GETDATE(),23),CONVERT(varchar(100), GETDATE(),24),'0','"+requestid+"')";
                                writeLog("sq1333======="+sql1);
                                rs2.execute(sql1);
                            }
                        }

                    }
                }
            }
        }
        //根据明细要插入的数据插入完成之后，再插入三行数据
        String bh = "";
        String sql1="insert into uf_sapdrmb(gsdm,jd,kmdm,cbzx,bz,je,zy,lcjl,lclj,sqr,sqrq,scrq,formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,fz,lcbh) values('6300','31','"+vendor+"','"+
                bh+"','"+bizhong+"',"+je+",'"+bxnr+"','"+requestid+"','"+workflowid+"','"+sqr+"','"+sqrq+"',CONVERT(varchar(100), GETDATE(),23),'"+
                formmodeid+"','"+sqr+"','0',CONVERT(varchar(100), GETDATE(),23),CONVERT(varchar(100), GETDATE(),24),'0','"+requestid+"')";
            writeLog("sq1======="+sql1);
        rs2.execute(sql1);

        String sql2="insert into uf_sapdrmb(gsdm,jd,kmdm,cbzx,bz,je,zy,lcjl,lclj,sqr,sqrq,scrq,formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,fz,lcbh) values('6300','21','"+vendor+"','"+
                bh+"','"+bizhong+"',"+je+",'"+bxnr+"','"+requestid+"','"+workflowid+"','"+sqr+"','"+sqrq+"',CONVERT(varchar(100), GETDATE(),23),'"+
                formmodeid+"','"+sqr+"','0',CONVERT(varchar(100), GETDATE(),23),CONVERT(varchar(100), GETDATE(),24),'0','"+requestid+"')";
            writeLog("sql2======="+sql2);
        rs2.execute(sql2);

        String sql3="insert into uf_sapdrmb(gsdm,jd,kmdm,cbzx,bz,je,zy,lcjl,lclj,sqr,sqrq,scrq,formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,fz,lcbh) values('6300','50','101500','"+
                bh+"','"+bizhong+"',"+je+",'"+bxnr+"','"+requestid+"','"+workflowid+"','"+sqr+"','"+sqrq+"',CONVERT(varchar(100), GETDATE(),23),'"+
                formmodeid+"','"+sqr+"','0',CONVERT(varchar(100), GETDATE(),23),CONVERT(varchar(100), GETDATE(),24),'0','"+requestid+"')";
            writeLog("sql3======="+sql3);
        rs2.execute(sql3);

        //数据插入完成后权限重构
        //权限重构
        //主表权限重构
        String billsql = "select id,modedatacreater,formmodeid from uf_sapdrmb where lcjl='"+requestid+"'";
        rs.execute(billsql);
        while (rs.next()) {
            int billid = Util.getIntValue(rs.getString("id"));
            int modedatacreater = Util.getIntValue(rs.getString("modedatacreater"));
            int modeid = Util.getIntValue(rs.getString("formmodeid"));
            ModeRightInfo ModeRightInfo = new ModeRightInfo();
            ModeRightInfo.rebuildModeDataShareByEdit(modedatacreater, modeid, billid);
        }
        } catch (Exception e) {
            writeLog(" error "+e);
        }
        return retStr;
    }
    private static String getCostcenterCodeById(String id){
        RecordSet rs = new RecordSet();
        String sql="select bh from uf_cbzx where id="+id;
        rs.execute(sql);
        String bh="";
        if (rs.next()){
            bh = Util.null2String(rs.getString("bh"));
        }
        return bh;
    }
    
    public static String getDoubleStr(String s, double d){
		String r = "";
		try{
			r = format_(  getDoubleValue(s, d)  );
		}catch(Exception ex){
			//writeLog_(ex);
		}
		return r;
	}
    public static String format_(Double d){
		String s = "";
		try{
			DecimalFormat df = new DecimalFormat("#0.00");
			s = df.format(d);
		}catch(Exception ex){
			//writeLog_(ex);
		}
		return s;
	}

	public static double getDoubleValue(String s, double d) {
		double r = d;
		try{
			
			r = Util.getDoubleValue(   format_(  Util.getDoubleValue(s, d)  )   , d   );
		}catch(Exception ex){
			//writeLog_(ex);
		}
		return r;
	}
}
