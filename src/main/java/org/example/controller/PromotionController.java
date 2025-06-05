package org.example.controller;

import org.example.dao.PromotionDAO;
import org.example.model.Promotion;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class PromotionController {

    private PromotionDAO promotionDAO;

    public void setPromotionDAO(PromotionDAO promotionDAO) {
        this.promotionDAO = promotionDAO;
    }

    @GetMapping("/promotions")
    public String showPromotions(Model model) {
        model.addAttribute("promotions", promotionDAO.getAllPromotions());
        model.addAttribute("promotion", new Promotion()); // For form binding
        return "promotionList";
    }

    @PostMapping("/addPromotion")
    public String addPromotion(@ModelAttribute("promotion") Promotion promo, RedirectAttributes redirectAttributes) {
        promotionDAO.addPromotion(promo);
        return "redirect:/promotions";
    }

    @GetMapping("/deletePromotion")
    public String deletePromotion(@RequestParam int id) {
        promotionDAO.deletePromotion(id);
        return "redirect:/promotions";
    }

    @GetMapping("/editPromotion")
    public String editPromotion(@RequestParam int id, Model model) {
        model.addAttribute("promotion", promotionDAO.getPromotionById(id));
        model.addAttribute("promotions", promotionDAO.getAllPromotions());
        return "promotionList";
    }

    @PostMapping("/updatePromotion")
    public String updatePromotion(@ModelAttribute Promotion promo) {
        promotionDAO.updatePromotion(promo);
        return "redirect:/promotions";
    }
}
