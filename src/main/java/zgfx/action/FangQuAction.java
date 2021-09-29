package zgfx.action;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;
import weaver.workflow.request.RequestManager;
import weaver.workflow.workflow.WorkflowComInfo;
/**
 *
 * 防区委派流程退回时，删除建模表中对应的防区人员
 *
 * */
public class FangQuAction extends BaseBean implements Action {
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

        RecordSet rs = new RecordSet();
        String sql="delete from uf_fqryxx where lcid='"+requestid+"'";
        boolean res = rs.execute(sql);
        if(!res){
            retStr=Action.FAILURE_AND_CONTINUE;
            rm.setMessagecontent("删除防区数据失败，请联系管理员！");
        }
        return retStr;
    }
}
