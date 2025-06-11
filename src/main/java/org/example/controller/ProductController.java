package org.example.controller;

import org.example.dao.ProductDAO;
import org.example.model.Product;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

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

    @PostMapping("/addProduct")
    public String addProduct(
            @RequestParam String name,
            @RequestParam String sku,
            @RequestParam String categoryName,
            @RequestParam String size,
            @RequestParam double price,
            @RequestParam int discount
    ) {
        double discountPrice = price - (price * discount / 100.0);
        Product product = new Product();
        product.setName(name);
        product.setSku(sku);
        product.setCategoryName(categoryName);
        product.setSize(size);
        product.setPrice(price);
        product.setDiscount(discount);
        product.setDiscountPrice(discountPrice);

        productDAO.addProduct(product);
        return "redirect:/products";
    }

    @GetMapping("/deleteProduct")
    public String deleteProduct(@RequestParam("id") int id) {
        productDAO.deleteProduct(id);
        return "redirect:/products";
    }
    @GetMapping("/editProduct")
    public String editProduct(@RequestParam int id, Model model) {
        Product product = productDAO.getProductById(id);
        model.addAttribute("productToEdit", product);
        model.addAttribute("products", productDAO.getAllProducts());
        return "listProduct"; // same JSP page
    }

    @PostMapping("/updateProduct")
    public String updateProduct(@ModelAttribute Product product) {
        productDAO.updateProduct(product);
        return "redirect:/products";
    }



}
