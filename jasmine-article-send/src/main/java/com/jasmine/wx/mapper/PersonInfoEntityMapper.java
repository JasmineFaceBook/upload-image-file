package com.jasmine.wx.mapper;

import com.jasmine.wx.entity.PersonInfoEntity;

import java.util.List;
import java.util.Map;

public interface PersonInfoEntityMapper {
    int deleteByPrimaryKey(Long personId);

    int insert(PersonInfoEntity record);

    int insertSelective(PersonInfoEntity record);

    List<PersonInfoEntity> selectByPrimaryKey(Map<String, Object> map);

    int updateByPrimaryKeySelective(PersonInfoEntity record);

    int updateByPrimaryKey(PersonInfoEntity record);
    /***
     * @author: libingyao
     * @description: //TODO 获取区域地址
     * @date: 17:11 2020/3/15
     * @param: [map]
     * @return: java.util.List<com.jasmine.wx.entity.PersonInfoEntity>
     **/
    List<PersonInfoEntity> getPlace(Map<String, Object> map);

    /***
     * @author: libingyao
     * @description: //TODO
     * @date: 18:30 2020/3/15
     * @param: [map]
     * @return: java.util.List<com.jasmine.wx.entity.PersonInfoEntity>
     **/
    List<PersonInfoEntity> getSchool(Map<String, Object> map);
}