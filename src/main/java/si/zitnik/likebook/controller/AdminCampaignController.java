package si.zitnik.likebook.controller;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;
import si.zitnik.likebook.domain.Campaign;
import si.zitnik.likebook.domain.Customer;
import si.zitnik.likebook.domain.FinishType;
import si.zitnik.likebook.service.CampaignService;
import si.zitnik.likebook.service.CustomerService;
import si.zitnik.likebook.util.SignInUtils;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.beans.PropertyEditorSupport;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.Map;

@Controller
@RequestMapping("/admin")
@Transactional
public class AdminCampaignController {

	@Inject
	private CampaignService campaignService;

    @Inject
    private CustomerService customerService;

	@RequestMapping("/campaigns")
	public String campaigns(Map<String, Object> map) {
		try {
			map.put("campaign", new Campaign());
			map.put("campaignList", campaignService.list());
            map.put("customerList", customerService.list());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "admin/campaigns";
	}

    @RequestMapping("/campaigns/edit/{campaignId}")
    public String campaignsEdit(Map<String, Object> map, @PathVariable("campaignId") Long campaignId) {
        try {
            map.put("campaign", campaignService.get(campaignId));
            map.put("campaignList", campaignService.list());
            map.put("customerList", customerService.list());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "admin/campaigns";
    }

	@RequestMapping(value = "/addCampaign", method = RequestMethod.POST)
	public String addCampaign(
            @ModelAttribute("campaign") Campaign campaign,
			@RequestParam("bigImage") MultipartFile bigImage,
            @RequestParam("smallImage") MultipartFile smallImage,
            @RequestParam("terms") MultipartFile terms) {



        //image
        try {
            InputStream in = bigImage.getInputStream();
            byte[] b = new byte[in.available()];
            in.read(b);

            campaign.setBigImageFilename(bigImage.getOriginalFilename());
            campaign.setBigImage(b);
            campaign.setBigImageContentType(bigImage.getContentType());
		} catch (IOException e) {
			e.printStackTrace();
		}
        try {
            InputStream in = smallImage.getInputStream();
            byte[] b = new byte[in.available()];
            in.read(b);

            campaign.setSmallImageFilename(smallImage.getOriginalFilename());
            campaign.setSmallImage(b);
            campaign.setSmallImageContentType(smallImage.getContentType());
        } catch (IOException e) {
            e.printStackTrace();
        }

        //terms
        try {
            InputStream in = terms.getInputStream();
            byte[] b = new byte[in.available()];
            in.read(b);

            campaign.setTermsFilename(terms.getOriginalFilename());
            campaign.setTerms(b);
            campaign.setTermsContentType(terms.getContentType());
        } catch (IOException e) {
            e.printStackTrace();
        }

		try {
            campaign.setCustomer(customerService.get(campaign.getCustomer().getId())); //Bidirectional link - new, to support editing
            campaignService.save(campaign);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/admin/campaigns";
	}


	@RequestMapping("/removeCampaign/{campaignId}")
	public String remove(@PathVariable("campaignId") Long campaignId) {

        campaignService.remove(campaignId);
		return "redirect:/admin/campaigns";
	}

    @RequestMapping(value="/campaigns/preview/{campaignId}", method= RequestMethod.GET)
    public String preview(Model model, @PathVariable("campaignId") Long campaignId) {
        boolean authenticated = SignInUtils.isAuthenticated();
        model.addAttribute("pageName", "home");

        model.addAttribute("isAuthenticated", authenticated);
        model.addAttribute("campaignList", Arrays.asList(new Campaign[]{campaignService.get(campaignId)}));

        return "/home";
    }

    @RequestMapping(value="/campaigns/activate/{campaignId}", method= RequestMethod.GET)
    public String activate(Model model, @PathVariable("campaignId") Long campaignId) {
        campaignService.activate(campaignId);
        return "redirect:/admin/campaigns";
    }

    @RequestMapping(value="/campaigns/deactivate/{campaignId}", method= RequestMethod.GET)
    public String deactivate(Model model, @PathVariable("campaignId") Long campaignId) {
        campaignService.deactivate(campaignId);
        return "redirect:/admin/campaigns";
    }

    @RequestMapping(value="/campaigns/finish/{campaignId}/{finishType}", method= RequestMethod.GET)
    public String finish(Model model, @PathVariable("campaignId") Long campaignId, @PathVariable("finishType") String finishType) {
        campaignService.finish(campaignId, FinishType.valueOf(finishType));
        return "redirect:/admin/campaigns";
    }

    @InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder)
            throws ServletException {

        // Convert multipart object to byte[]
        binder.registerCustomEditor(byte[].class, new ByteArrayMultipartFileEditor());

        binder.registerCustomEditor(Customer.class, "customer", new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) {
                Customer type = customerService.get(Long.parseLong(text));
                setValue(type);
            }
        });
    }

}
