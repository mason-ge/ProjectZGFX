package zgfx.action;

import org.apache.commons.lang3.StringUtils;
import weaver.conn.RecordSet;
import weaver.formmode.setup.ModeRightInfo;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.*;
import weaver.workflow.request.RequestManager;
import weaver.workflow.workflow.WorkflowComInfo;
/**
 * 流程提交的时候把当前申请人对应的成本中心，和对应的比例拼接到一起，
 * 当流程再次打开时可以看到对应成本中心的比例
 */
public class ChengBenAction extends BaseBean implements Action {
    @Override
    public String execute(RequestInfo request) {
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
        RecordSet rs = new RecordSet();
        RecordSet rs2 = new RecordSet();
        Property[] properties = request.getMainTableInfo().getProperty();// 获取表单主字段信息
        String sqr="";
        for (int i = 0; i < properties.length; i++) {
            String field = properties[i].getName();// 主字段名称
            if("sqr".equalsIgnoreCase(field)){
                sqr =Util.null2String(properties[i].getValue());
            }
        }
        String chengben="";
        if(StringUtils.isNotBlank(sqr)){
            String selectsql="select jan21,costcenter from uf_dcbzxryxxb where chinesename="+sqr;
            rs.execute(selectsql);
            while (rs.next()){
                String costcenter = Util.null2String(rs.getString("costcenter"));
                String jan21 = Util.null2String(rs.getString("jan21"));
                //cbzx   uf_cbzx
                String sql="select cbzx from uf_cbzx where id="+costcenter;
                rs2.execute(sql);
                String conname="";
                if(rs2.next()){
                    conname=Util.null2String(rs2.getString("cbzx"));
                }
                chengben+=conname+":"+jan21+",<br>";
            }
            if(!"".equals(chengben) && chengben.length()>5){
                chengben=chengben.substring(0,chengben.length()-5);
            }
            String upsql="update "+maintablename+" set dcbzxxx='"+chengben+"' where requestid="+requestid;
            rs2.execute(upsql);
        }

        return retStr;
    }
}
