package com.project.crm.services.impl;

import com.project.crm.dao.LikeDao;
import com.project.crm.model.Product;
import com.project.crm.services.LikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public class LikeServiceImpl implements LikeService {

    @Autowired
    private LikeDao likeDao;

    @Override
    @Transactional
    public void addProductToFavorites(String productId, String username) {
        likeDao.addProductToFavorites(productId, username);
    }

    @Override
    @Transactional
    public void removeProductFromFavorites(Product product) {
        likeDao.removeProductFromFavorites(product);
    }

    @Override
    @Transactional
    public List<Product> getFavoriteProductsByUsername(String userName) {
        return likeDao.getFavoriteProductsByUsername(userName);
    }
}