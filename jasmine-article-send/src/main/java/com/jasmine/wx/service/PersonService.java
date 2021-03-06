package com.jasmine.wx.service;

import com.jasmine.wx.entity.PersonInfoEntity;

import java.util.List;
import java.util.Map;

public interface PersonService {
	int deleteByPrimaryKey(Long personId);

    int insert(PersonInfoEntity record);

    int insertSelective(PersonInfoEntity record);

    List<PersonInfoEntity> selectByPrimaryKey(Map<String, Object> map);

    int updateByPrimaryKeySelective(PersonInfoEntity record);

    int updateByPrimaryKey(PersonInfoEntity record);

    List<PersonInfoEntity> getPlace(Map<String, Object> map);

    List<PersonInfoEntity> getSchool(Map<String, Object> map);
}
