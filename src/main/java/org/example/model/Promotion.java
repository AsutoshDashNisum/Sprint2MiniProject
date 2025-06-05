package org.example.model;

public class Promotion {
    private int id;
    private String promoType;
    private String description;
    private String promoCode;
    private double amount;

    // Getters and Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getPromoType() {
        return promoType;
    }
    public void setPromoType(String promoType) {
        this.promoType = promoType;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public String getPromoCode() {
        return promoCode;
    }
    public void setPromoCode(String promoCode) {
        this.promoCode = promoCode;
    }

    public double getAmount() {
        return amount;
    }
    public void setAmount(double amount) {
        this.amount = amount;
    }
}
