package org.example.dao;

import org.example.model.Product;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ProductDAO {

    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Get all active products
    public List<Product> getAllProducts() {
        String sql = "SELECT * FROM catalog_db2.product WHERE status = 'active'";
        return jdbcTemplate.query(sql, new ProductMapper());
    }

    // Add a new product
    public void addProduct(Product product) {
        String sql = "INSERT INTO catalog_db2.product " +
                "(name, SKU, categoryName, Size, Price, Discount, DiscountPrice, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, 'active')";
        jdbcTemplate.update(sql,
                product.getName(),
                product.getSku(),
                product.getCategoryName(),
                product.getSize(),
                product.getPrice(),
                product.getDiscount(),
                product.getDiscountPrice());
    }

    // Soft delete (mark inactive)
    public void deleteProduct(int id) {
        String sql = "UPDATE catalog_db2.product SET status = 'inactive' WHERE productId = ?";
        jdbcTemplate.update(sql, id);
    }

    // Get product by ID
    public Product getProductById(int id) {
        String sql = "SELECT * FROM catalog_db2.product WHERE productId = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Product.class), id);
    }

    // Update product
    public void updateProduct(Product product) {
        String sql = "UPDATE catalog_db2.product SET " +
                "name = ?, SKU = ?, categoryName = ?, Size = ?, Price = ?, Discount = ?, DiscountPrice = ? " +
                "WHERE productId = ?";
        jdbcTemplate.update(sql,
                product.getName(),
                product.getSku(),
                product.getCategoryName(),
                product.getSize(),
                product.getPrice(),
                product.getDiscount(),
                product.getDiscountPrice(),
                product.getProductId());
    }

    // RowMapper
    private static class ProductMapper implements RowMapper<Product> {
        public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
            Product product = new Product();
            product.setProductId(rs.getInt("productId"));
            product.setName(rs.getString("name"));
            product.setSku(rs.getString("SKU"));
            product.setCategoryName(rs.getString("categoryName"));
            product.setSize(rs.getString("Size"));
            product.setPrice(rs.getDouble("Price"));
            product.setDiscount(rs.getInt("Discount"));
            product.setDiscountPrice(rs.getDouble("DiscountPrice"));
            return product;
        }
    }
}