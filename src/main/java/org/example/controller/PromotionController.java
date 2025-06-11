package org.example.controller;

import org.example.dao.PromotionDAO;
import org.example.model.Promotion;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class PromotionController {

    private PromotionDAO promotionDAO;

    public void setPromotionDAO(PromotionDAO promotionDAO) {
        this.promotionDAO = promotionDAO;
    }

    @RequestMapping("/promotions")
    public String showPromotions(Model model) {
        model.addAttribute("promotions", promotionDAO.getAllPromotions());
        model.addAttribute("promotion", new Promotion());
        return "promotionList";
    }

    @PostMapping("/addPromotion")
    public String addPromotion(@ModelAttribute("promotion") Promotion promo) {
        promotionDAO.addPromotion(promo);
        return "redirect:/promotions";
    }

    @PostMapping("/updatePromotion")
    public String updatePromotion(@ModelAttribute("promotion") Promotion promo) {
        promotionDAO.updatePromotion(promo);
        return "redirect:/promotions";
    }

    @GetMapping("/editPromotion")
    public String editPromotion(@RequestParam("id") int id, Model model) {
        model.addAttribute("promotion", promotionDAO.getPromotionById(id));
        model.addAttribute("promotions", promotionDAO.getAllPromotions());
        return "promotionList";
    }

    @GetMapping("/deletePromotion")
    public String deletePromotion(@RequestParam("id") int id) {
        promotionDAO.deletePromotion(id);
        return "redirect:/promotions";
    }

}
