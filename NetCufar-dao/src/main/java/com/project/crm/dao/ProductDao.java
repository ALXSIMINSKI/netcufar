package com.project.crm.dao;

import com.project.crm.model.Product;
import com.project.crm.model.enums.ProductStatus;

import java.util.List;

/**
 * Basic Data Access Object interface.
 * Provide operations with {@link Product}.
 */
public interface ProductDao {
    void addProduct(Product product);

    List<Product> getProductsByUsername(String username);

    void editProduct(String id, Product product);

    Product getProductById(String id);

    List<Product> getProductsByKeyWords(String keyWords);

    List<Product> getProductsByCategory(String category);

    List<Product> getProductsBySuperCategory(String superCategory);

    List<Product> getProductsByStatus(ProductStatus status);

    List<Product> getAllProducts();

    void deleteProductById(String id);

    void changeProductStatus(String id, ProductStatus status);
}
