package zgfx.action;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.workflow.request.RequestManager;
import weaver.workflow.workflow.WorkflowComInfo;

import java.util.HashMap;
/**
 * 防区退回时把标题更新成以前的标题
 */
public class BTAction extends BaseBean implements Action {

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


        Property[] properties = request.getMainTableInfo().getProperty();// 获取表单主字段信息
        String btcs="";
        String lcbh="";
        String gzflcs="";
        String bmname="";
        String zyrname="";
       // [系统.标题]=[主表.标题参数]+'_'+[主表.流程编号]+'_'+[主表.故障分类参数]+'_'+[主表.部门name]+'_'+[主表.作用人name]
        for (int i = 0; i < properties.length; i++) {
            String field = properties[i].getName();// 主字段名称
            if("btcs".equalsIgnoreCase(field)){
                btcs =Util.null2String(properties[i].getValue());
            }

            if("lcbh".equalsIgnoreCase(field)){
                lcbh =Util.null2String(properties[i].getValue());
            }
            if("gzflcs".equalsIgnoreCase(field)){
                gzflcs =Util.null2String(properties[i].getValue());
            }
            if("bmname".equalsIgnoreCase(field)){
                bmname =Util.null2String(properties[i].getValue());
            }
            if("zyrname".equalsIgnoreCase(field)){
                zyrname =Util.null2String(properties[i].getValue());
            }
        }
        String bt=btcs+"_"+lcbh+"_"+gzflcs+"_"+bmname+"_"+zyrname;

        writeLog("lcbh===="+lcbh);
        RecordSet rs = new RecordSet();
        String updatesql="update workflow_requestbase set requestname='"+bt+"' where requestid='"+requestid+"'";
        writeLog("lcbh=updatesql========="+updatesql);
        boolean res = rs.execute(updatesql);
        if(!res){
            retStr=Action.FAILURE_AND_CONTINUE;
            rm.setMessagecontent("更新流程标题失败！");
        }
        return retStr;
    }
}
