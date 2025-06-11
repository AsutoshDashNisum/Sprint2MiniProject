package org.example.dao;

import org.example.model.Product;
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

    public List<Product> getAllProducts() {
        String sql = "SELECT * FROM catalog_db2.product  where status='active'";
        return jdbcTemplate.query(sql, new ProductMapper());
    }

    public void addProduct(Product product) {
        String sql = "INSERT INTO Product (name, SKU, categoryName, Size, Price, Discount, DiscountPrice) VALUES (?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, product.getName(), product.getSku(), product.getCategoryName(), product.getSize(),
                product.getPrice(), product.getDiscount(), product.getDiscountPrice());
    }

    public void deleteProduct(int id) {
        String sql ="UPDATE catalog_db2.product SET status = 'inactive' WHERE productId = ?";
        jdbcTemplate.update(sql, id);
    }

    private static class ProductMapper implements RowMapper<Product> {
        public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
            Product product = new Product();
            product.setProductId(rs.getInt("ProductID"));
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
