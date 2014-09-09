package si.zitnik.likebook.controller;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 7/16/13
 * Time: 9:31 AM
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/admin")
@Transactional
public class AdminController {
    @RequestMapping("/")
    public String admin() {
        return "redirect:/admin/campaigns";
    }
    @RequestMapping("")
    public String adminAlternative() {
        return "redirect:/admin/campaigns";
    }
}
