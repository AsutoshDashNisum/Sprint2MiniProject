package org.example.dao;

import org.example.model.Promotion;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class PromotionDAO {

    private JdbcTemplate jdbcTemplate;

    // Setter for jdbcTemplate (Spring will inject this)
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // RowMapper to map DB rows to Promotion objects
    private static final class PromotionMapper implements RowMapper<Promotion> {
        @Override
        public Promotion mapRow(ResultSet rs, int rowNum) throws SQLException {
            Promotion promo = new Promotion();
            promo.setId(rs.getInt("PromoTypeId"));
            promo.setPromoType(rs.getString("PromoType"));
            promo.setDescription(rs.getString("Description"));
            promo.setPromoCode(rs.getString("PromoCode"));
            promo.setAmount(rs.getDouble("PromoAmount"));
            return promo;
        }
    }

    // Method to get all promotions
    public List<Promotion> getAllPromotions() {
        String sql = "SELECT * FROM promotions";
        return jdbcTemplate.query(sql, new PromotionMapper());
    }

    // Optional: Add more methods like getById, addPromotion, deletePromotion, etc.
}
