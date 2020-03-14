package com.yyx.wx.service;

import java.util.List;
import java.util.Map;

import com.yyx.wx.entity.PersonInfoEntity;

public interface PersonService {
	int deleteByPrimaryKey(Long personId);

    int insert(PersonInfoEntity record);

    int insertSelective(PersonInfoEntity record);

    List<PersonInfoEntity> selectByPrimaryKey(Map<String, Object> map);

    int updateByPrimaryKeySelective(PersonInfoEntity record);

    int updateByPrimaryKey(PersonInfoEntity record);
    List<PersonInfoEntity> getCity(Map<String, Object> map);
    List<PersonInfoEntity> getCounty(Map<String, Object> map);
    List<PersonInfoEntity> getSchool(Map<String, Object> map);
}
