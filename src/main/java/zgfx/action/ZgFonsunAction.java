package zgfx.action;

import weaver.conn.RecordSet;
import weaver.formmode.setup.ModeRightInfo;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.*;
import weaver.workflow.workflow.WorkflowComInfo;
/**
 * 医生服务费用报销，可配置化的
 *
 * */
public class ZgFonsunAction extends BaseBean implements Action {
    //付款人账号
    private String fkrzh;
    //付款人名称
    private String fkrmc;
    //付费账号
    private String ffzh;
    //处理优先级
    private String clyxj;

    public String getClyxj() {
        return clyxj;
    }

    public void setClyxj(String clyxj) {
        this.clyxj = clyxj;
    }

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

    public String getFfzh() {
        return ffzh;
    }

    public void setFfzh(String ffzh) {
        this.ffzh = ffzh;
    }

    @Override
    public String execute(RequestInfo request) {
        String retStr = Action.SUCCESS;
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

        Property[] properties = request.getMainTableInfo().getProperty();// 获取表单主字段信息
        String sqr="";
        String sqrq="";
        String lcbh="";
         for (int i = 0; i < properties.length; i++) {
             String name = properties[i].getName();// 主字段名称
             if("sqr".equals(name)){
                 sqr=Util.null2String(properties[i].getValue());
             }
            if("sqrq".equals(name)){
                sqrq=Util.null2String(properties[i].getValue());
            }
             if("lcbh".equals(name)){
                 lcbh=Util.null2String(properties[i].getValue());
             }

         }
         //获取明细表数据
        DetailTable[] detailtable = request.getDetailTableInfo().getDetailTable();
        RecordSet rs2 = new RecordSet();
        if (detailtable.length > 0) {
            String yxzh="";
            String qyztyf="";
            String khyx="";
            String je="";
            String skrkhx="";
            String cnaps="";
            for (int i = 0; i < detailtable.length; i++) {
                DetailTable dt = detailtable[i];// 指定明细表
                 Row[] s = dt.getRow();// 当前明细表的所有数据,按行存储
                 for (int j = 0; j < s.length; j++) {
                 Row r = s[j];// 指定行
                 Cell c[] = r.getCell();// 每行数据再按列存储
                 for (int k = 0; k < c.length; k++) {
                     Cell c1 = c[k];// 指定列
                     String name = c1.getName();// 明细字段名称
                     if("yxzh".equals(name)){
                         yxzh = c1.getValue();// 明细字段的值
                     }
                     if("qyztyf".equals(name)){
                         qyztyf=c1.getValue();// 明细字段的值
                     }
                     if("khyx".equals(name)){
                         khyx=c1.getValue();// 明细字段的值
                     }
                     if("je".equals(name)){
                         je=c1.getValue();// 明细字段的值
                     }
                     if("skrkhx".equals(name)){
                         skrkhx=c1.getValue();// 明细字段的值
                         cnaps=getCnapsCode(skrkhx);
                     }

                 }
                  //明细中每有一行数据，建模表中插入一行数据
                     String sql="insert into uf_yhdjdcds(formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,fkrzh,fkrmc,skrzh,skrmc,khhmc,fkje,ffzh,yt,clyxj,sqr,sqrq,sqjl,skrkhh,cnaps,lcbh) values(" +
                             "53,1,0,CONVERT(varchar(100), GETDATE(),23),'"+this.fkrzh+"','"+this.fkrmc+"','"+yxzh+"','"+qyztyf+"','"+khyx+"','"+je+"','"+this.ffzh+"','"+requestname+"','"
                             +this.clyxj+"','"+sqr+"','"+sqrq+"','"+requestid+"','"+skrkhx+"','"+cnaps+"','"+lcbh+"')";
                     rs2.execute(sql);
                 }

            }
        }
        //权限重构
        //主表权限重构
        RecordSet rsmode = new RecordSet();
        String billsql = "select id,modedatacreater,formmodeid from uf_yhdjdcds where sqjl='"+requestid+"'";
        rsmode.execute(billsql);
        while (rsmode.next()) {
            int billid = Util.getIntValue(rsmode.getString("id"));
            int modedatacreater = Util.getIntValue(rsmode.getString("modedatacreater"));
            int modeid = Util.getIntValue(rsmode.getString("formmodeid"));
            ModeRightInfo ModeRightInfo = new ModeRightInfo();
            ModeRightInfo.rebuildModeDataShareByEdit(modedatacreater, modeid, billid);
        }

        return retStr;
    }
    private static String getCnapsCode(String name){
        String sql="select cnapsh from uf_cnapdzb where yxmc='"+name+"'";
        String cnacode="";
        RecordSet rs = new RecordSet();
        rs.execute(sql);
        if(rs.next()){
            cnacode=Util.null2String(rs.getString("cnapsh"));
        }
        return cnacode;
    }
}
