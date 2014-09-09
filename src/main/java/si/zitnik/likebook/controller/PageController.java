package si.zitnik.likebook.controller;

import org.apache.commons.io.IOUtils;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import si.zitnik.likebook.domain.Campaign;
import si.zitnik.likebook.service.CampaignService;
import si.zitnik.likebook.util.SignInUtils;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 3/31/13
 * Time: 9:58 PM
 * To change this template use Campaign | Settings | Campaign Templates.
 */
@Controller
public class PageController {

    @Inject
    private CampaignService campaignService;

    @RequestMapping(value = "/cenik", method= RequestMethod.GET)
    public String cenik(Model model) {
        return "cenik";
    }

    @RequestMapping(value = "/ponudba48", method= RequestMethod.GET)
    public String ponudba48(Model model) {
        boolean authenticated = SignInUtils.isAuthenticated();
        model.addAttribute("isAuthenticated", authenticated);
        model.addAttribute("pageName", "ponudba");

        return "ponudba48";
    }

    @RequestMapping(value="/favicon.ico", method= { RequestMethod.GET, RequestMethod.POST})
    public String favicon(Model model) {
        return "redirect:/resources/images/favicon.ico";
    }

    @RequestMapping(value="/error", method= RequestMethod.GET)
    public String error(Model model) {
        return "error";
    }

    @RequestMapping(value="/yourdata", method= RequestMethod.GET)
    public String yourdata(Model model) {
        boolean authenticated = SignInUtils.isAuthenticated();
        model.addAttribute("isAuthenticated", authenticated);
        model.addAttribute("pageName", "yourdata");
        return "yourdata";
    }

    @RequestMapping(value="/howitworks", method= RequestMethod.GET)
    public String howitworks(Model model) {
        boolean authenticated = SignInUtils.isAuthenticated();
        model.addAttribute("isAuthenticated", authenticated);
        model.addAttribute("pageName", "howitworks");
        return "howitworks";
    }

    @RequestMapping(value="/", method={RequestMethod.GET, RequestMethod.POST})
    public String home(Model model) {
        boolean authenticated = SignInUtils.isAuthenticated();
        model.addAttribute("isAuthenticated", authenticated);
        model.addAttribute("pageName", "home");

        if (authenticated) {
            model.addAttribute("campaignList", campaignService.reverseActivatedNotFinishedNotMyList());
        } else {
            model.addAttribute("campaignList", campaignService.reverseActivatedNotFinishedAllList());
        }

        return "home";
    }

    @RequestMapping(value="/myCampaigns", method= RequestMethod.GET)
    public String myCampaigns(Model model) {
        boolean authenticated = SignInUtils.isAuthenticated();
        model.addAttribute("pageName", "my");

        model.addAttribute("isAuthenticated", authenticated);
        model.addAttribute("campaignList", campaignService.reverseActivatedNotFinishedMyList());

        return "home";
    }

    @RequestMapping(value="/finishedCampaigns", method= RequestMethod.GET)
    public String finishedCampaigns(Model model) {
        boolean authenticated = SignInUtils.isAuthenticated();
        model.addAttribute("pageName", "old");

        model.addAttribute("isAuthenticated", authenticated);
        model.addAttribute("campaignList", campaignService.reverseActivatedFinishedAllList());

        return "home";
    }

    @RequestMapping(value="/about", method= RequestMethod.GET)
    public String about(Model model) {
        boolean authenticated = SignInUtils.isAuthenticated();
        model.addAttribute("isAuthenticated", authenticated);
        model.addAttribute("pageName", "about");
        return "about";
    }
}
