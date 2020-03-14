package com.jasmine.wx.service.impl;

import com.jasmine.wx.entity.ArticleFileEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jasmine.wx.mapper.ArticleFileEntityMapper;
import com.jasmine.wx.service.ArticleService;
@Service("articleService")
public class ArticleServiceImpl implements ArticleService
{

	@Autowired(required=false)
	private ArticleFileEntityMapper articleFileEntityMapper;
	@Override
	public int deleteByPrimaryKey(Long articleId) {
		// TODO Auto-generated method stub
		return articleFileEntityMapper.deleteByPrimaryKey(articleId);
	}

	@Override
	public int insert(ArticleFileEntity record) {
		// TODO Auto-generated method stub
		return articleFileEntityMapper.insert(record);
	}

	@Override
	public int insertSelective(ArticleFileEntity record) {
		// TODO Auto-generated method stub
		return articleFileEntityMapper.insertSelective(record);
	}

	@Override
	public ArticleFileEntity selectByPrimaryKey(Long articleId) {
		// TODO Auto-generated method stub
		return articleFileEntityMapper.selectByPrimaryKey(articleId);
	}

	@Override
	public int updateByPrimaryKeySelective(ArticleFileEntity record) {
		// TODO Auto-generated method stub
		return articleFileEntityMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKeyWithBLOBs(ArticleFileEntity record) {
		// TODO Auto-generated method stub
		return articleFileEntityMapper.updateByPrimaryKeyWithBLOBs(record);
	}

	@Override
	public int updateByPrimaryKey(ArticleFileEntity record) {
		// TODO Auto-generated method stub
		return articleFileEntityMapper.updateByPrimaryKey(record);
	}

}
