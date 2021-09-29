package zgfx.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import weaver.conn.RecordSet;
import weaver.conn.RecordSetTrans;
import weaver.formmode.data.ModeDataIdUpdate;
import weaver.formmode.setup.ModeRightInfo;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.RequestInfo;
import weaver.workflow.workflow.WorkflowComInfo;
import weaver.interfaces.workflow.action.Action;

public class ZgFosunBankDataExportForPrivateAction extends BaseBean implements Action {
    private String fkrzh;
    private String fkrmc;
    private String skrzh;
    private String skrmc;
    private String skrkhh;
    private String khhmc;
    private String cnaps;
    private String khywbh;
    private String fkje;
    private String ffzh;
    private String zdfkrq;
    private String yt;
    private String clyxj;
    private String skremail;
    private String sqr;
    private String sqrq;
    private String sqjl;

    public String getFkrzh()
    {
        return this.fkrzh;
    }

    public void setFkrzh(String fkrzh)
    {
        this.fkrzh = fkrzh;
    }

    public String getFkrmc()
    {
        return this.fkrmc;
    }

    public void setFkrmc(String fkrmc)
    {
        this.fkrmc = fkrmc;
    }

    public String getSkrzh()
    {
        return this.skrzh;
    }

    public void setSkrzh(String skrzh)
    {
        this.skrzh = skrzh;
    }

    public String getSkrmc()
    {
        return this.skrmc;
    }

    public void setSkrmc(String skrmc)
    {
        this.skrmc = skrmc;
    }

    public String getSkrkhh()
    {
        return this.skrkhh;
    }

    public void setSkrkhh(String skrkhh)
    {
        this.skrkhh = skrkhh;
    }

    public String getKhhmc()
    {
        return this.khhmc;
    }

    public void setKhhmc(String khhmc)
    {
        this.khhmc = khhmc;
    }

    public String getCnaps()
    {
        return this.cnaps;
    }

    public void setCnaps(String cnaps)
    {
        this.cnaps = cnaps;
    }

    public String getKhywbh()
    {
        return this.khywbh;
    }

    public void setKhywbh(String khywbh)
    {
        this.khywbh = khywbh;
    }

    public String getFkje()
    {
        return this.fkje;
    }

    public void setFkje(String fkje)
    {
        this.fkje = fkje;
    }

    public String getFfzh()
    {
        return this.ffzh;
    }

    public void setFfzh(String ffzh)
    {
        this.ffzh = ffzh;
    }

    public String getZdfkrq()
    {
        return this.zdfkrq;
    }

    public void setZdfkrq(String zdfkrq)
    {
        this.zdfkrq = zdfkrq;
    }

    public String getYt()
    {
        return this.yt;
    }

    public void setYt(String yt)
    {
        this.yt = yt;
    }

    public String getClyxj()
    {
        return this.clyxj;
    }

    public void setClyxj(String clyxj)
    {
        this.clyxj = clyxj;
    }

    public String getSkremail()
    {
        return this.skremail;
    }

    public void setSkremail(String skremail)
    {
        this.skremail = skremail;
    }

    public String getSqr()
    {
        return this.sqr;
    }

    public void setSqr(String sqr)
    {
        this.sqr = sqr;
    }

    public String getSqrq()
    {
        return this.sqrq;
    }

    public void setSqrq(String sqrq)
    {
        this.sqrq = sqrq;
    }

    public String getSqjl()
    {
        return this.sqjl;
    }

    public void setSqjl(String sqjl)
    {
        this.sqjl = sqjl;
    }

    public String execute(RequestInfo request)
    {
        try
        {
            char flag = Util.getSeparator();
            WorkflowComInfo workflowComInfo = new WorkflowComInfo();
            int requestid = Util.getIntValue(request.getRequestid());
            int workflowid = Util.getIntValue(request.getWorkflowid());
            int formid = Util.getIntValue(workflowComInfo.getFormId("" + workflowid));
            String maintablename = "formtable_main_" + -1 * formid;
            writeLog("requestid = " + requestid);
            writeLog("workflowid = " + workflowid);
            writeLog("formid = " + formid);


            String requestmark = "";
            RecordSetTrans rsts = request.getRsTrans();
            if (rsts != null)
            {
                try
                {
                    rsts.executeSql("select requestmark from workflow_requestbase where requestid = " + request.getRequestid());
                    if (rsts.next()) {
                        requestmark = Util.null2String(rsts.getString("requestmark"));
                    }
                }
                catch (Exception e)
                {
                    writeLog("ZgFosunBankDataExportForPrivateAction: " + e);
                }
            }
            else
            {
                RecordSet rs = new RecordSet();
                rs.execute("select requestmark from workflow_requestbase where requestid = " + request.getRequestid());
                if (rs.next()) {
                    requestmark = Util.null2String(rs.getString("requestmark"));
                }
            }
            RecordSet rs = new RecordSet();
            String qryMain = "select accountid1 as skrzh,field3 as skrmc,bankname as khhmc,cnapsh," + this.fkje + ",requestname as yt,lastname as sqrmc,d.id as sqrid," + this.sqrq + " from " + maintablename + " a  left join cus_fielddata b on a." + this.sqr + "=b.id  left join HrmResource d on a." + this.sqr + "=d.id  left join workflow_requestbase e on a.requestid=e.requestid  left join HrmBank f on d.bankid1=f.id  left join uf_cnapdzb c on f.bankname=c.yxmc  where a.requestid =" + requestid;







            writeLog("qryMain => ", qryMain);
            rs.execute(qryMain);
            if (rs.next())
            {
                String skrzhval = Util.null2String(rs.getString("skrzh"));
                String skrmcval = Util.null2String(rs.getString("skrmc"));
                String khhmcval = Util.null2String(rs.getString("khhmc"));
                String cnapsval = Util.null2String(rs.getString("cnapsh"));
                String fkjeval = Util.null2String(rs.getString("je"));
                String ytval = Util.null2String(rs.getString("yt"));
                String sqrval = Util.null2String(rs.getString("sqrid"));
                String sqrqval = Util.null2String(rs.getString("sqrq"));



                Date d = new Date();
                SimpleDateFormat sdfd = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat sdft = new SimpleDateFormat("HH:mm:ss");
                String date = sdfd.format(d);
                String time = sdft.format(d);
                ModeDataIdUpdate modeDataIdUpdate = new ModeDataIdUpdate();
                int id_1 = modeDataIdUpdate.getModeDataNewIdByUUID("uf_yhdjdcds", 53, 1, 0, date, time);

                RecordSet rs_update = new RecordSet();
                String sql = "update uf_yhdjdcds set fkrzh='" + this.fkrzh + "',fkrmc='" + this.fkrmc + "',skrzh='" + skrzhval + "',skrmc='" + skrmcval + "',skrkhh='" + this.skrkhh + "', khhmc='" + khhmcval + "',cnaps='" + cnapsval + "',khywbh='" + this.khywbh + "',fkje='" + fkjeval + "',ffzh='" + this.ffzh + "',zdfkrq='', yt='" + ytval + "',clyxj='" + this.clyxj + "',skremail='" + this.skremail + "',sqr='" + sqrval + "',sqrq='" + sqrqval + "',sqjl='" + requestid + "',lcbh='" + requestmark + "' where id=" + id_1;


                writeLog("rs_update sql => ", sql);
                rs_update.execute(sql);

                ModeRightInfo moderightinfo = new ModeRightInfo();
                moderightinfo.setNewRight(true);
                moderightinfo.editModeDataShare(1, 53, id_1);
            }
        }
        catch (Exception ex)
        {
            writeLog(ex);
        }
        return "1";
    }
}
