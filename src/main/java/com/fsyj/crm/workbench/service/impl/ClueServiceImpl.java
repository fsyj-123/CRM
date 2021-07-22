package com.fsyj.crm.workbench.service.impl;

import com.fsyj.crm.utils.SqlSessionUtil;
import com.fsyj.crm.workbench.bean.Clue;
import com.fsyj.crm.workbench.mapper.ClueMapper;
import com.fsyj.crm.workbench.service.ClueService;

/**
 * @author fsyj
 */
public class ClueServiceImpl implements ClueService {
    @Override
    public void saveClue(Clue clue) {
        ClueMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ClueMapper.class);
        mapper.save(clue);
    }
}
