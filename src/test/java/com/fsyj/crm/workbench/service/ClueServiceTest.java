package com.fsyj.crm.workbench.service;

import com.fsyj.crm.workbench.bean.Clue;
import com.fsyj.crm.workbench.service.impl.ClueServiceImpl;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class ClueServiceTest {

    @Test
    public void getPageList() {
        ClueService service = new ClueServiceImpl();
        List<Clue> pageList = service.getPageList(1, 3);
        for (Clue clue : pageList) {
            System.out.println(clue);
        }
    }

    @Test
    public void queryClueById() {
        ClueService clueService = new ClueServiceImpl();
        Clue clue = clueService.queryClueById("e6a07660b0d545ec93cf780ccbd38d34");
        System.out.println(clue);
    }
}