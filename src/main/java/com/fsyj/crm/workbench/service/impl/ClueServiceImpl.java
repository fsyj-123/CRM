package com.fsyj.crm.workbench.service.impl;

import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.utils.BeanUtil;
import com.fsyj.crm.utils.DateTimeUtil;
import com.fsyj.crm.utils.SqlSessionUtil;
import com.fsyj.crm.utils.UUIDUtil;
import com.fsyj.crm.vo.PageNavigate;
import com.fsyj.crm.workbench.bean.*;
import com.fsyj.crm.workbench.mapper.*;
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
        PageHelper.startPage(pageNo, pageSize);
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
            relation.setActivityId(activityId.substring(1, activityId.length() - 1));
            relation.setClueId(clueId);
            System.out.println(relation);
            int count = mapper.bind(relation);
            if (count != 1) {
                throw new Exception("关联失败");
            }
        }
    }


    @Override
    public boolean convert(String clueId, Tran tran, User creator) {
        boolean flag = true;
        String creatorId = creator.getId();
        /*
            (1) 获取到线索id，通过线索id获取线索对象（线索对象当中封装了线索的信息）
			(2) 通过线索对象提取客户信息，当该客户不存在的时候，新建客户（根据公司的名称精确匹配，判断该客户是否存在！）
			(3) 通过线索对象提取联系人信息，保存联系人
			(4) 线索备注转换到客户备注以及联系人备注
			(5) “线索和市场活动”的关系转换到“联系人和市场活动”的关系
			(6) 如果有创建交易需求，创建一条交易
			(7) 如果创建了交易，则创建一条该交易下的交易历史
			(8) 删除线索备注
			(9) 删除线索和市场活动的关系
			(10) 删除线索
     */
        ClueMapper clueMapper = SqlSessionUtil.getSqlSession().getMapper(ClueMapper.class);
        ClueActivityRelationMapper clueAr = SqlSessionUtil.getSqlSession().getMapper(ClueActivityRelationMapper.class);
        ClueRemarkMapper clueRemarkMapper = SqlSessionUtil.getSqlSession().getMapper(ClueRemarkMapper.class);

        CustomerMapper customerMapper = SqlSessionUtil.getSqlSession().getMapper(CustomerMapper.class);
        CustomerRemarkMapper customerRemarkMapper = SqlSessionUtil.getSqlSession().getMapper(CustomerRemarkMapper.class);

        ContactsMapper contactsMapper = SqlSessionUtil.getSqlSession().getMapper(ContactsMapper.class);
        ContactsRemarkMapper contactsRemarkMapper = SqlSessionUtil.getSqlSession().getMapper(ContactsRemarkMapper.class);
        ContactsActivityRelationMapper contactsAr = SqlSessionUtil.getSqlSession().getMapper(ContactsActivityRelationMapper.class);

        TranMapper tranMapper = SqlSessionUtil.getSqlSession().getMapper(TranMapper.class);
        TranHistoryMapper tranHistoryMapper = SqlSessionUtil.getSqlSession().getMapper(TranHistoryMapper.class);

        Clue clue = clueMapper.queryForOne(clueId);

        String company = clue.getCompany();
        Customer customer = customerMapper.queryByName(company);
        if (customer == null) {
            customer = BeanUtil.createObject(Customer.class, creatorId);
            BeanUtil.convert(customer, clue);
            customer.setName(company);
            customerMapper.createCustom(customer);
        }

        // 3通过线索对象提取联系人信息，保存联系人
        Contacts contacts = contactsMapper.queryByFullName(clue.getFullname());
        if (contacts == null) {
            contacts = BeanUtil.createObject(Contacts.class, creatorId);
            BeanUtil.convert(contacts, clue);
            contacts.setCustomerId(customer.getId());
            contactsMapper.create(contacts);
        }

        // (4) 线索备注转换到客户备注以及联系人备注 -- 查询线索备注
        List<ClueRemark> clueRemarks = clueRemarkMapper.queryById(clueId);
        for (ClueRemark remark : clueRemarks) {
            // 转换到客户备注以及联系人备注
            CustomerRemark customerRemark = new CustomerRemark();
            ContactsRemark contactsRemark = new ContactsRemark();
            BeanUtil.convert(customerRemark, remark);
            BeanUtil.convert(contactsRemark, remark);

            // 存入备注表
            contactsRemarkMapper.add(contactsRemark);
            customerRemarkMapper.add(customerRemark);

            // 删除线索备注
            clueRemarkMapper.deleteRemarkById(remark.getId());
        }

        /*
         (5) “线索和市场活动”的关系转换到“联系人和市场活动”的关系
         1、从clue-activity表中clueID查找
         保存
         2、转换
         3、delete
         */
        List<ClueActivityRelation> relationList = clueAr.queryByClueId(clueId);
        for (ClueActivityRelation relation : relationList) {
            ContactsActivityRelation contactsActivityRelation = BeanUtil.createObject(ContactsActivityRelation.class, null);
            contactsActivityRelation.setActivityId(relation.getActivityId());
            contactsActivityRelation.setContactsId(contacts.getId());
            contactsAr.save(contactsActivityRelation);
            // 删除clue——activity——relation
            clueAr.deleteById(relation.getId());
        }
        /*
        (6) 如果有创建交易需求，创建一条交易
        tran为空则无需创建交易需求
        (7) 如果创建了交易，则创建一条该交易下的交易历史
         */
        if (tran != null) {
            // 完善tran信息
            tran.setId(UUIDUtil.getUUID());
            tran.setCreateBy(creatorId);
            tran.setCreateTime(DateTimeUtil.getSysTime());
            BeanUtil.convert(tran, clue);
            // 保存tran
            tranMapper.save(tran);

            // 创建交易历史
            TranHistory tranHistory = BeanUtil.createObject(TranHistory.class, creatorId);
            // 将tran中的信息转换到history中
            BeanUtil.convert(tranHistory, tran);
            // 保存tranId
            tranHistory.setTranId(tran.getId());
            tranHistoryMapper.save(tranHistory);
        }

        /*
        (10) 删除线索
         */
        clueMapper.deleteById(clueId);


        return flag;
    }
}
