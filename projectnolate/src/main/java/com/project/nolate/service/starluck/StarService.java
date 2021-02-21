package com.project.nolate.service.starluck;

import java.util.List;

import com.project.nolate.domain.Star;



public interface StarService {
	
	public abstract List<Star>starList();
	
	public abstract Star getStarLuck(String title);


	
}
