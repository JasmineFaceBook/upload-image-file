package com.jasmine.wx.mapper;

import com.jasmine.wx.entity.ArticleFileEntity;

public interface ArticleFileEntityMapper {
    int deleteByPrimaryKey(Long articleId);

    int insert(ArticleFileEntity record);

    int insertSelective(ArticleFileEntity record);

    ArticleFileEntity selectByPrimaryKey(Long articleId);

    int updateByPrimaryKeySelective(ArticleFileEntity record);

    int updateByPrimaryKeyWithBLOBs(ArticleFileEntity record);

    int updateByPrimaryKey(ArticleFileEntity record);
}