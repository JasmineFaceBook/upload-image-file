package com.jasmine.wx.service.impl;

import com.jasmine.wx.entity.PersonInfoEntity;
import com.jasmine.wx.mapper.PersonInfoEntityMapper;
import com.jasmine.wx.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("personService")
public class PersonServiceImpl implements PersonService {

	@Autowired(required=false)
	private PersonInfoEntityMapper personInfoEntityMapper;

	@Override
	public int deleteByPrimaryKey(Long personId) {
		// TODO Auto-generated method stub
		return personInfoEntityMapper.deleteByPrimaryKey(personId);
	}

	@Override
	public int insert(PersonInfoEntity record) {
		// TODO Auto-generated method stub
		return personInfoEntityMapper.insert(record);
	}

	@Override
	public int insertSelective(PersonInfoEntity record) {
		// TODO Auto-generated method stub
		return personInfoEntityMapper.insertSelective(record);
	}

	@Override
	public List<PersonInfoEntity> selectByPrimaryKey(Map<String, Object> map){
		// TODO Auto-generated method stub
		return personInfoEntityMapper.selectByPrimaryKey(map);
	}

	@Override
	public int updateByPrimaryKeySelective(PersonInfoEntity record) {
		// TODO Auto-generated method stub
		return personInfoEntityMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(PersonInfoEntity record) {
		// TODO Auto-generated method stub
		return personInfoEntityMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<PersonInfoEntity> getPlace(Map<String, Object> map) {
		return personInfoEntityMapper.getPlace(map);
	}

	@Override
	public List<PersonInfoEntity> getSchool(Map<String, Object> map) {
		return personInfoEntityMapper.getSchool(map);
	}


}
