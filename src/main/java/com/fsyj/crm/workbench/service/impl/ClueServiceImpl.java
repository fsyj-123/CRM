package com.fsyj.crm.workbench.service.impl;

import com.fsyj.crm.utils.SqlSessionUtil;
import com.fsyj.crm.utils.UUIDUtil;
import com.fsyj.crm.vo.PageNavigate;
import com.fsyj.crm.workbench.bean.Activity;
import com.fsyj.crm.workbench.bean.Clue;
import com.fsyj.crm.workbench.bean.ClueActivityRelation;
import com.fsyj.crm.workbench.mapper.ClueActivityRelationMapper;
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
    public PageNavigate<Clue> getPageList(Integer pageNo, Integer pageSize) {
        ClueMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ClueMapper.class);
        PageHelper.startPage(pageNo,pageSize);
        List<Clue> clueList = mapper.queryAll();
        // 封装分页模型
        PageNavigate<Clue> navigate = new PageNavigate<>();
        navigate.setPageList(clueList);
        navigate.setTotal(mapper.queryAll().size());
        return navigate;
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

    @Override
    public void bindActivity(String[] activityIds, String clueId) throws Exception {
        ClueActivityRelationMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ClueActivityRelationMapper.class);
        for (String activityId : activityIds) {
            ClueActivityRelation relation = new ClueActivityRelation();
            relation.setId(UUIDUtil.getUUID());
            relation.setActivityId(activityId.substring(1,activityId.length() - 1));
            relation.setClueId(clueId);
            System.out.println(relation);
            int count = mapper.bind(relation);
            if (count != 1) {
                throw new Exception("关联失败");
            }
        }
    }
}
