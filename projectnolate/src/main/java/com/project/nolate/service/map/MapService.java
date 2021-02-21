package com.project.nolate.service.map;

import java.util.List;

import com.project.nolate.domain.Mapp;

public interface MapService {

	public abstract List<Mapp> mapList(String id);
	
	public abstract Mapp getMap(int no);
	
	public abstract void insertMap(Mapp map);
	
	public abstract void updateMap(Mapp map);
	
	public abstract void deleteMap(int no);
	
	public abstract String maps_str(int no);
	
	public abstract String mape_str(int no);
	
	public abstract int countMap();
	
	public abstract Integer getMapNo();
}
