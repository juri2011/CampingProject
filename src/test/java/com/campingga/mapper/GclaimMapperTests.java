package com.campingga.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.Adminclaim;
import com.campingga.domain.Common;
import com.campingga.mapper.GclaimMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class GclaimMapperTests {
	
	@Autowired
	GclaimMapper mapper;
	
	@Test
	public void testSelectClaims() {
		Common common = new Common();
		List<Adminclaim> claims=mapper.selectClaims(common);
		log.info(claims);
	}

}
