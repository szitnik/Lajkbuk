package si.zitnik.likebook.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.web.SignedRequestDecoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import si.zitnik.likebook.config.MainConfig;
import si.zitnik.likebook.config.SocialConfig;
import si.zitnik.likebook.domain.*;
import si.zitnik.likebook.repository.CouponRepository;
import si.zitnik.likebook.service.*;
import si.zitnik.likebook.util.SignInUtils;

@Controller
@Transactional
public class CampaignController {
    private final static Logger log = LoggerFactory.getLogger(CampaignController.class);

	@Inject
	private CampaignService campaignService;

    @Inject
    private UserService userService;

    @Inject
    private LikeService likeService;

    @Inject
    private ShareService shareService;

    @Resource
    private CouponRepository couponRepository;

    @Inject
    private CouponService couponService;

    @Inject
    private Facebook facebook;

    @RequestMapping("/bigImage/{campaignId}")
    public String bigImage(
            @PathVariable("campaignId") Long campaignId,
            HttpServletResponse response) {

        Campaign doc = campaignService.get(campaignId);
        try {
            response.setHeader("Content-Disposition", "inline;filename=\"" + doc.getBigImageFilename() + "\"");
            OutputStream out = response.getOutputStream();
            response.setContentType(doc.getBigImageContentType());
            IOUtils.copy(new ByteArrayInputStream(doc.getBigImage()), out);
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    @RequestMapping("/smallImage/{campaignId}")
    public String smallImage(
            @PathVariable("campaignId") Long campaignId,
            HttpServletResponse response) {

        Campaign doc = campaignService.get(campaignId);
        try {
            response.setHeader("Content-Disposition", "inline;filename=\"" + doc.getSmallImageFilename() + "\"");
            OutputStream out = response.getOutputStream();
            response.setContentType(doc.getSmallImageContentType());
            IOUtils.copy(new ByteArrayInputStream(doc.getSmallImage()), out);
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    @RequestMapping("/finishDocument/{campaignId}")
    public String finishDocument(
            @PathVariable("campaignId") Long campaignId,
            HttpServletResponse response) {

        Campaign doc = campaignService.get(campaignId);
        try {
            response.setHeader("Content-Disposition", "inline;filename=\"" + doc.getFinishDocumentFilename() + "\"");
            OutputStream out = response.getOutputStream();
            response.setContentType(doc.getFinishDocumentContentType());
            IOUtils.copy(new ByteArrayInputStream(doc.getFinishDocument()), out);
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    @RequestMapping("/terms/{campaignId}")
    public String terms(
            @PathVariable("campaignId") Long campaignId,
            HttpServletResponse response) {

        Campaign doc = campaignService.get(campaignId);
        try {
            response.setHeader("Content-Disposition", "inline;filename=\"" + doc.getTermsFilename() + "\"");
            OutputStream out = response.getOutputStream();
            response.setContentType(doc.getTermsContentType());
            IOUtils.copy(new ByteArrayInputStream(doc.getTerms()), out);
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Transactional
    @RequestMapping(value="/campaign/{campaignId}", method = {RequestMethod.POST, RequestMethod.GET})
    public String campaign(Model model, @PathVariable("campaignId") Long campaignId, HttpServletRequest request, HttpServletResponse response) {
        boolean authenticated = SignInUtils.isAuthenticated();
        //if already liked
        if (authenticated) {
            try {
                Campaign campaign = campaignService.get(campaignId);
                User user = userService.getByFbId(SignInUtils.getCurrentUserFbId());


                if (likeService.hasLiked(user, campaign)) {
                    model.addAttribute("hasLiked", true);
                } else if (request.getParameterMap().containsKey("signed_request")) {
                    SignedRequestDecoder decoder = new SignedRequestDecoder(campaign.getFacebookAppSecret());


                        Map<String, ?> map = decoder.decodeSignedRequest(request.getParameter("signed_request"));
                        Boolean liked = ((HashMap<String, Boolean>)map.get("page")).get("liked");

                        if (liked) {
                            //do lajk

                            likeService.updateLike(user, campaign, liked);
                            if (campaign.getEnabledFeatures().contains(Feature.COUPON)) {
                                couponService.generateCoupon(user, campaign);
                            }
                        }
                    model.addAttribute("hasLiked", liked);
                } else {
                    model.addAttribute("hasLiked", false);
                }
            } catch (Exception e) {
                e.printStackTrace();
                log.error("There was an error when user tried to like the game: {}", e.getStackTrace());
                model.addAttribute("hasLiked", false);
            }
        }

        model.addAttribute("isAuthenticated", authenticated);
        model.addAttribute("campaign", campaignService.get(campaignId));
        return "campaign";
    }

    @Transactional
    @RequestMapping(value="/campaignProxy/{campaignId}", method = {RequestMethod.POST, RequestMethod.GET})
    public String proxy(Model model, @PathVariable("campaignId") Long campaignId, HttpServletRequest request, HttpServletResponse response) {
        Campaign campaign = campaignService.get(campaignId);

        return "redirect:"+ campaign.getLikeLink();
    }

    @Transactional
    @RequestMapping(value="/campaign/share/{campaignId}/{userFbId}", method = {RequestMethod.POST, RequestMethod.GET})
    public void campaignShare(Model model, @PathVariable("campaignId") Long campaignId, @PathVariable("userFbId") String fbId, HttpServletRequest request, HttpServletResponse response) {
        if (request.getHeader("host").equals("lajkbuk.si")) {
            try {
                Campaign campaign = campaignService.get(campaignId);
                User user = userService.getByFbId(fbId);

                shareService.share(user, campaign);
            } catch (Exception e) {
                e.printStackTrace();
                log.error("There was an error when user tried to share the game: {}", e.getStackTrace());
            }
        }
        return;
    }


    @RequestMapping(value="/campaign/coupon/{campaignId}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String getCampaignCoupon(Model model, @PathVariable("campaignId") Long campaignId, HttpServletRequest request, HttpServletResponse response) {
        User user = userService.getByFbId(SignInUtils.getCurrentUserFbId());
        Campaign campaign = campaignService.get(campaignId);

        Coupons coupon = couponRepository.findById(new CampaignAndUserPK(campaign, user));
        return coupon.getCouponCode();
    }




}
