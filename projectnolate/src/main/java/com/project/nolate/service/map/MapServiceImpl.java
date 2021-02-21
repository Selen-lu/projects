package com.project.nolate.service.map;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nolate.dao.MapDao;
import com.project.nolate.domain.Mapp;

@Service
public class MapServiceImpl implements MapService {

	@Autowired
	private MapDao mapDao;
	public void setMapdDao(MapDao mapDao) {
		this.mapDao = mapDao;
		}
	
	
	@Override
	public List<Mapp> mapList(String id) {
		// TODO Auto-generated method stub
		return mapDao.mapList(id);
	}

	@Override
	public Mapp getMap(int no) {
		// TODO Auto-generated method stub
		return mapDao.getMap(no);
	}

	@Override
	public void insertMap(Mapp map) {
		// TODO Auto-generated method stub
		mapDao.insertMap(map);
	}

	@Override
	public void updateMap(Mapp map) {
		// TODO Auto-generated method stub
		mapDao.updateMap(map);
	}

	@Override
	public void deleteMap(int no) {
		// TODO Auto-generated method stub
		mapDao.deleteMap(no);
	}

	@Override
	public String maps_str(int no) {
		// TODO Auto-generated method stub
		return mapDao.maps_str(no);
	}

	@Override
	public String mape_str(int no) {
		// TODO Auto-generated method stub
		return mapDao.mape_str(no);
	}

	@Override
	public int countMap() {
		
		return mapDao.countMap();
	}


	@Override
	public Integer getMapNo() {
		// TODO Auto-generated method stub
		return mapDao.getMapNo();
	}
	
	

}
