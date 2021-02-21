package com.project.nolate.dao;

import java.util.List;

import com.project.nolate.domain.Star;



public interface StarDao {
	
	public abstract List<Star>starList();
	
	public abstract Star getStarLuck(String title);
	
	public abstract void updateStar();
	

}
