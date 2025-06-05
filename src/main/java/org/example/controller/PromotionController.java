package org.example.controller;

import org.example.dao.PromotionDAO;
import org.example.model.Promotion;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class PromotionController {

    private PromotionDAO promotionDAO;

    // Setter injection for PromotionDAO
    public void setPromotionDAO(PromotionDAO promotionDAO) {
        this.promotionDAO = promotionDAO;
    }

    // Mapping to show list of promotions
    @GetMapping("/promotions")
    public String showPromotions(Model model) {
        List<Promotion> promotions = promotionDAO.getAllPromotions();
        model.addAttribute("promotions", promotions);
        return "promotionList";  // JSP page to render (create promotionList.jsp)
    }
}
