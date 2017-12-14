package com.project.crm.controllers;

import com.project.crm.model.Product;
import com.project.crm.model.enums.ProductStatus;
import com.project.crm.services.AttributeService;
import com.project.crm.services.CommentService;
import com.project.crm.services.ProductService;
import com.project.crm.services.*;
import com.project.crm.validator.ProductValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.RequestContextUtils;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

@Controller
//@RequestMapping("/product")
public class ProductController {

    @Autowired
    ProductService productService;

    @Autowired
    AttributeService attributeService;

    @Autowired
    CommentService commentService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    ProductValidator productValidator;

    @RequestMapping(value= "/product/{id}", method = RequestMethod.GET)
    public String getProduct(@PathVariable String id, Model model) {
        model.addAttribute("productid",productService.getProductById(id));
        return "/productbyid";
    }

    @RequestMapping(value = "/not_moderated_accept", method = RequestMethod.GET)
    public String acceptProduct(@RequestParam String productId){
        productService.changeProductStatus(productId, ProductStatus.APPROVED);
        return "redirect:/product_moderation";
    }

    @RequestMapping(value = "/not_moderated_deny", method = RequestMethod.GET)
    public String denyProduct(@RequestParam String productId){
        productService.changeProductStatus(productId, ProductStatus.CANCELED);
        return "/product_moderation";
    }


    @RequestMapping(value = "/my_products", method = RequestMethod.GET)
    public String allProducts (Model model){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = auth.getName();
        model.addAttribute("products", productService.getProductsByUsername(name));
        return "/my_products";
    }


    // Edition product
    @RequestMapping(value= "/product/edit/{id}", method = RequestMethod.GET)
    public String editProduct(@PathVariable String id, Model model) {
        model.addAttribute("IDProduct", productService.getProductById(id));
        model.addAttribute("ID", id);
        return "/edit_product";
    }

    @RequestMapping(value = "/product/edit/{id}", method = RequestMethod.POST)
    public String editProduct(@PathVariable String id, @ModelAttribute("EditProduct") Product product) {
        productService.editProduct(id, product);
        return "redirect:/my_products";
    }
    /////////////////////////////////

    @RequestMapping(value = "/not_moderated", method = RequestMethod.GET)
    public String notModeratedProducts(Model model){
        //почему-то все возвращается в 2 экземплярах - запрос в бд неправильный?
        model.addAttribute("productCategory", categoryService.getAllTopCategories());
        model.addAttribute("nmod_products", productService.getProductsByStatus(ProductStatus.MODERATION));
        //model.addAttribute("nmod_products", productService.getAllProducts());
        return "/product_moderation";

    }


    @RequestMapping(value = "/new_product", method = RequestMethod.GET)
    public String addProduct(Model model, HttpServletRequest request) {
        Locale locale = RequestContextUtils.getLocale(request);

        ResourceBundle bundle = ResourceBundle.getBundle("locales.messages", locale);
        model.addAttribute("keys", bundle.getKeys());
        model.addAttribute("topCategories", categoryService.getAllTopCategories());
        return "new_product";
    }


    @RequestMapping(value = "/new-product/add", method = RequestMethod.POST)
    public String addProduct(@ModelAttribute Product product, BindingResult bindingResult, HttpServletRequest request,
                             @RequestParam("file") MultipartFile multipartFile) throws IOException {
        product = productService.getProductByHttpServletRequestAndPhoto(request, multipartFile);
        productValidator.validate(product,bindingResult);
        if(bindingResult.hasErrors()){
            return "redirect:/new_product";
        }
       productService.addProduct(product);
        return "redirect:/my_products";
    }

    @RequestMapping(value = "/attributes", method = RequestMethod.GET)
    @ResponseBody
    public List getAttributes(@RequestParam String subCategory){
        return attributeService.getAttributesByCategory(subCategory);
    }

    @RequestMapping(value = "/productSearch", method = RequestMethod.GET)
    @ResponseBody
    public List getProductsBySubString(@RequestParam String subString) throws UnsupportedEncodingException {
        String checkIfEmptyBuf = java.net.URLDecoder.decode(subString,"UTF-8");
        if(!(checkIfEmptyBuf.replaceAll("\\s","")).equals("")) {
            return productService.getProductsByKeyWords(java.net.URLDecoder.decode(subString,"UTF-8"));
        } else {
            return new ArrayList();
        }
    }
}
