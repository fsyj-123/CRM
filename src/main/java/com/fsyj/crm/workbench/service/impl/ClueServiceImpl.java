package com.fsyj.crm.workbench.service.impl;

import com.fsyj.crm.utils.SqlSessionUtil;
import com.fsyj.crm.workbench.bean.Activity;
import com.fsyj.crm.workbench.bean.Clue;
import com.fsyj.crm.workbench.mapper.ClueMapper;
import com.fsyj.crm.workbench.service.ClueService;
import com.github.pagehelper.PageHelper;

import java.util.List;

/**
 * @author fsyj
 */
public class ClueServiceImpl implements ClueService {
    @Override
    public void saveClue(Clue clue) {
        ClueMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ClueMapper.class);
        mapper.save(clue);
    }

    @Override
    public List<Clue> getPageList(Integer pageNo, Integer pageSize) {
        ClueMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ClueMapper.class);
        PageHelper.startPage(pageNo,pageSize);
        return mapper.queryAll();
    }

    @Override
    public Clue queryClueById(String id) {
        ClueMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ClueMapper.class);
        return mapper.queryForOne(id);
    }

    @Override
    public List<Activity> getRelation(String clueId) {
        ClueMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ClueMapper.class);
        return mapper.getRelatedActivity(clueId);
    }

    @Override
    public void removeRelation(String relationId) {
        ClueMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ClueMapper.class);
        assert relationId != null && !"".equals(relationId);
        mapper.deleteRelation(relationId);
    }
}
