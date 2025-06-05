package org.example.controller;

import org.example.dao.ProductDAO;
import org.example.model.Product;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class ProductController {
    private ProductDAO productDAO;

    public void setProductDAO(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

        @RequestMapping("/products")
    public ModelAndView listProducts() {
        List<Product> products = productDAO.getAllProducts();
        return new ModelAndView("listProducts", "products", products);
    }

    @RequestMapping("/hello")
    public ModelAndView helloPage() {
        return new ModelAndView("hello", "message", "Welcome to Product Catalog");
    }
    @GetMapping({"/", "/dashboard"})
    public String showDashboard() {
        return "dashboard"; // will resolve to /WEB-INF/views/dashboard.jsp
    }
}
