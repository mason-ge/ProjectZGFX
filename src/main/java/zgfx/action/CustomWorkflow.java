/**
 * 文件先注释了，有报错，不好修改，且在 服务器未发现此文件对应的class，日后有需要再看 - 2021-09-29 gyl
 */

//package zgfx.action;
//
//import com.engine.core.cfg.annotation.ServiceDynamicProxy;
//import com.engine.core.cfg.annotation.ServiceMethodDynamicProxy;
//import com.engine.core.impl.aop.AbstractServiceProxy;
//import com.engine.workflow.service.WorkflowTypeService;
//import com.engine.workflow.service.impl.WorkflowTypeServiceImpl;
//import weaver.general.BaseBean;
//import weaver.hrm.User;
//
//import java.util.Map;
//
//@ServiceDynamicProxy(target = WorkflowTypeServiceImpl.class, desc="流程提交后更新流程标题")
//public class CustomWorkflow extends AbstractServiceProxy implements WorkflowTypeService  {
//    /**
//     * 重写保存方法， 在保存完成之后保存自定义信息
//     * @param params
//     * @param user
//     * @return
//     */
//    @Override
//    @ServiceMethodDynamicProxy(desc="保存时， 增加一些日志输入")
//    public Map<String, Object> doSaveOperation(Map<String, Object> params, User user) {
//
//        Map<String, Object> result = (Map<String, Object>)executeMethod(params, user);
//
//        BaseBean bean = new BaseBean();
//        bean.writeLog(getClass().getName() + "LCBH========");
//        return result;
//    }
//
//    @Override
//    public Map<String, Object> doDeleteOperation(Map<String, Object> params, User user) {
//        return null;
//    }
//
//    @Override
//    public Map<String, Object> getConditionInfo(Map<String, Object> params, User user) {
//        return null;
//    }
//
//    @Override
//    public Map<String, Object> getSessionKey(Map<String, Object> params, User user) {
//        return null;
//    }
//}
//
