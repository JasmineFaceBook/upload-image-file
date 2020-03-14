package com.yyx.wx.service;

import com.yyx.wx.entity.ArticleFileEntity;

public interface ArticleService {
	int deleteByPrimaryKey(Long articleId);

    int insert(ArticleFileEntity record);

    int insertSelective(ArticleFileEntity record);

    ArticleFileEntity selectByPrimaryKey(Long articleId);

    int updateByPrimaryKeySelective(ArticleFileEntity record);

    int updateByPrimaryKeyWithBLOBs(ArticleFileEntity record);

    int updateByPrimaryKey(ArticleFileEntity record);

}
