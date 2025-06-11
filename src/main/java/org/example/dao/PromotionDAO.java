package org.example.dao;

import org.example.model.Promotion;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class PromotionDAO {

    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

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

    public List<Promotion> getAllPromotions() {
        String sql = "SELECT * FROM promotions";
        return jdbcTemplate.query(sql, new PromotionMapper());
    }

    public int addPromotion(Promotion promo) {
        String sql = "INSERT INTO promotions (PromoType, Description, PromoCode, PromoAmount) VALUES (?, ?, ?, ?)";
        return jdbcTemplate.update(sql, promo.getPromoType(), promo.getDescription(), promo.getPromoCode(), promo.getAmount());
    }

    public int deletePromotion(int id) {
        String sql = "DELETE FROM promotions WHERE PromoTypeId = ?";
        return jdbcTemplate.update(sql, id);
    }

    public int updatePromotion(Promotion promo) {
        String sql = "UPDATE promotions SET PromoType = ?, Description = ?, PromoCode = ?, PromoAmount = ? WHERE PromoTypeId = ?";
        return jdbcTemplate.update(sql, promo.getPromoType(), promo.getDescription(), promo.getPromoCode(), promo.getAmount(), promo.getId());
    }

    public Promotion getPromotionById(int id) {
        try {
            String sql = "SELECT * FROM promotions WHERE PromoTypeId = ?";
            return jdbcTemplate.queryForObject(sql, new Object[]{id}, new PromotionMapper());
        } catch (Exception e) {
            return null;
        }
    }
}
