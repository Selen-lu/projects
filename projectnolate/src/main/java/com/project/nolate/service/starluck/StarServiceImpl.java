package com.project.nolate.service.starluck;


import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nolate.dao.StarDao;
import com.project.nolate.domain.Star;


@Service
public class StarServiceImpl implements StarService {
	
	@Autowired
	private StarDao starDao;
	
	
	@Override
	public List<Star> starList() {
		
		return starDao.starList();
	}

	@Override
	public Star getStarLuck(String title) {
		
		return starDao.getStarLuck(title);
	}
}
