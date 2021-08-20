package com.fsyj.crm.workbench.service.impl;

import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.utils.BeanUtil;
import com.fsyj.crm.utils.SqlSessionUtil;
import com.fsyj.crm.workbench.bean.ActivityRemark;
import com.fsyj.crm.workbench.bean.ClueRemark;
import com.fsyj.crm.workbench.mapper.ClueRemarkMapper;
import com.fsyj.crm.workbench.service.ClueRemarkService;

import java.util.List;

/**
 * @author fsyj
 */
public class ClueRemarkServiceImpl implements ClueRemarkService {

    @Override
    public List<ActivityRemark> getRemarkList(String id) {
        ClueRemarkMapper remarkMapper = SqlSessionUtil.getSqlSession().getMapper(ClueRemarkMapper.class);
        assert id != null && !"".equals(id);
        return remarkMapper.listById(id);
    }

    @Override
    public void addRemark(String content, User user, String clueId) {
        ClueRemarkMapper remarkMapper = SqlSessionUtil.getSqlSession().getMapper(ClueRemarkMapper.class);
        ClueRemark remark = BeanUtil.createObject(ClueRemark.class, user.getId());
        remark.setClueId(clueId);
        remark.setEditFlag("0");
        remark.setNoteContent(content);
        remarkMapper.addRemark(remark);
    }
}
