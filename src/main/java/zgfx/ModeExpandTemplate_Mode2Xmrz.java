package zgfx;

import java.util.*;
import com.weaver.general.BaseBean;
import weaver.conn.RecordSet;
import weaver.general.Util;
import weaver.hrm.User;
import weaver.soa.workflow.request.RequestInfo;
import weaver.formmode.customjavacode.AbstractModeExpandJavaCode;
import weaver.formmode.setup.ModeRightInfo;

/**
 * 说明 修改时 类名要与文件名保持一致 class文件存放位置与路径保持一致。 请把编译后的class文件，放在对应的目录中才能生效 注意
 * 同一路径下java名不能相同。
 * 
 * @author len
 *
 */
public class ModeExpandTemplate_Mode2Xmrz extends AbstractModeExpandJavaCode {
	/**
	 * 执行模块扩展动作
	 * 
	 * @param param param包含(但不限于)以下数据 user 当前用户
	 */
	public void doModeExpand(Map<String, Object> param) throws Exception {
		User user = (User) param.get("user");
		int billid = -1;// 数据id
		int modeid = -1;// 模块id
		RequestInfo requestInfo = (RequestInfo) param.get("RequestInfo");
		if (requestInfo != null) {
			billid = Util.getIntValue(requestInfo.getRequestid());
			modeid = Util.getIntValue(requestInfo.getWorkflowid());
			if (billid > 0 && modeid > 0) {
				RecordSet rs = new RecordSet();
				// ------请在下面编写业务逻辑代码------
				BaseBean bb = new BaseBean();
				bb.writeLog("将建模信息写入项目日志表");

				String modename = ""; // 模块名称
				String formid = ""; // 表单id
				String tablename = "";// 表名
				String cjr = "";// 创建人
				String sql = "";
				int rzModeid = 8;

				sql = "select modename,formid from modeinfo where id=" + modeid;
				rs.execute(sql);
				if (rs.next()) {
					modename = Util.null2String(rs.getString("modename"));
					formid = Util.null2String(rs.getString("formid"));

					sql = "select tablename from workflow_bill where id=" + formid;
					rs.execute(sql);
					if (rs.next()) {
						tablename = Util.null2String(rs.getString("tablename"));// 动态获取表名

						String xmmc = ""; // 项目名称
						int jd = -1; // 阶段
						int jd0 = -1;
						sql = "select xmmc,jd,modedatacreater from " + tablename + " where id=" + billid;
						rs.execute(sql);
						if (rs.next()) {
							cjr = Util.null2String(rs.getString("modedatacreater"));
							xmmc = Util.null2String(rs.getString("xmmc"));
							jd = rs.getInt("jd");
							jd0 = jd;
							jd += 2;

							if (!xmmc.equals("") && xmmc != null) {
								sql = "select id from uf_xmrz where lx=0 and modeId1=" + modeid + " and billid1="
										+ billid;
								rs.execute(sql);
								if (rs.next()) {
									sql = "update uf_xmrz set name='" + modename + "',xm=" + xmmc + ",jd=" + jd
											+ ",jd0=" + jd0 + " where id=" + Util.null2String(rs.getString("id"));
								} else {
									sql = "insert into uf_xmrz(lx,modeId1,billid1,name,xm,jd,jd0,formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime) values(0,"
											+ modeid + "," + billid + ",'" + modename + "'," + xmmc + "," + jd + ","
											+ jd0 + "," + rzModeid + "," + cjr
											+ ",0,CONVERT(varchar(100), GETDATE(),23),CONVERT(varchar(100), GETDATE(),24))";
								}
								bb.writeLog(sql);
								rs.execute(sql);

								// 重构权限
								sql = "select id,modedatacreater from uf_xmrz where lx=0 and modeId1=" + modeid
										+ " and billid1=" + billid;
								rs.execute(sql);
								if (rs.next()) {
									bb.writeLog("uf_xmrz -" + rs.getString("id") + " -- 权限重构");

									int billid_ = Util.getIntValue(rs.getString("id"));
									int modedatacreater_ = Util.getIntValue(rs.getString("modedatacreater"));
									try {
										ModeRightInfo modeRightInfo = new ModeRightInfo();
										modeRightInfo.rebuildModeDataShareByEdit(modedatacreater_, rzModeid, billid_);
										bb.writeLog("成功");
									} catch (Exception ex) {
										bb.writeLog("失败");
										bb.writeLog(ex);
									}
								}

								bb.writeLog("success");
							}
						}
					}
				}
			}
		}
	}
}