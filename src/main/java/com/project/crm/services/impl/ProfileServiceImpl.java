package com.project.crm.services.impl;


import com.project.crm.dao.UserDao;
import com.project.crm.model.User;
import com.project.crm.services.ProductService;
import com.project.crm.services.ProfileService;
import com.project.crm.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 1 on 15.11.2017.
 */

@Transactional
@Component
public class ProfileServiceImpl implements ProfileService {


    @Autowired
    private UserDao userDao;

    @Autowired
    private ProductService productService;



    @Override
    public User getUserByID(int id) {
        User user = userDao.getUserById(id);
        user.setUsername(userDao.findUserById(user.getId()).getUsername());
        //user.setUserProductList(productService.getProductsByUsername(user.getUsername()));
        return user;
    }

    @Override
    public User getUserByUsername(String username) {
        int id=userDao.findUserByUsername(username).getId();
        User user = userDao.getUserById(id);
        user.setUsername(username);
        user.setUserProductList(productService.getProductsByUsername(user.getUsername()));
        return user;
    }

    @Override
    public void addUser(User user) {
        userDao.addUser(user);
    }

    @Override
    public void updateUser(User user) {
        //userDao.deleteUser(user);
        //userDao.addUser(user);
        userDao.updateUser(user);
    }

    @Override
    public int getUserIdByEmail(String email) {
        return userDao.getUserIdByEmail(email);
    }

    @Override
    public int getUserIdByTelephone(String telephone) {
        return userDao.getUserIdByTelephone(telephone);
    }

    @Override
    public List<User> getAllUsers() {
        return userDao.getAllUsers();
    }
}
