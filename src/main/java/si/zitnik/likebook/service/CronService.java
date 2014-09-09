package si.zitnik.likebook.service;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.PageRequest;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.facebook.api.*;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import si.zitnik.likebook.domain.User;
import si.zitnik.likebook.repository.UserRepository;
import si.zitnik.likebook.util.SignInUtils;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 16/11/13
 * Time: 10:50
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/admin")
public class CronService {
    private final static Logger log = LoggerFactory.getLogger(CronService.class);

    @Inject
    private Facebook facebook;

    @Inject
    private UserRepository userRepository;

    @RequestMapping(value = "/other", method = RequestMethod.GET)
    public String otherAdmin() {
        return "admin/other";
    }


    //@Scheduled(fixedDelay = 10000)
    @Transactional
    @RequestMapping(value="/processUsers", method= RequestMethod.GET)
    public String processUsers() {
        List<User> users = userRepository.findByProcessedIsNull(new PageRequest(0,1));
        if (!users.isEmpty()) {
            User user = users.get(0);
            updateUser(user);
            userRepository.save(user);
        }
        return "admin/other";
    }

    private User updateUser(User user) {
        try {
            FacebookProfile userProfile = facebook.userOperations().getUserProfile(user.getFbId());

            //user.setFbId(userProfile.getId()); //id - aready set by login
            user.setAbout(userProfile.getAbout()); //user_about_me
            user.setBirthday(userProfile.getBirthday()); //user_birthday
            user.setEmail(userProfile.getEmail()); //email
            if (userProfile.getName() == null || userProfile.getName().isEmpty()) { //name
                user.setName(userProfile.getFirstName()+ " " + userProfile.getMiddleName() + " " + userProfile.getLastName());
            } else {
                user.setName(userProfile.getName());
            }
            user.setGender(userProfile.getGender()); //gender
            user.setPolitical(userProfile.getPolitical()); //user_religion_politics
            user.setRelationshipStatus(userProfile.getRelationshipStatus()); //user_relationships,user_relationship_details
            user.setReligion(userProfile.getReligion()); //user_religion_politics
            user.setUsername(userProfile.getUsername()); //username
            user.setWebsite(userProfile.getWebsite());  //user_website

            
            try {
                List<EducationEntry> educationList = userProfile.getEducation(); //user_education_history
                JSONArray jsonArray = new JSONArray();
                for (EducationEntry e : educationList) {
                    try {
                        JSONObject jsonObj = new JSONObject();
                        jsonObj.put("id", (e.getSchool() != null) ? e.getSchool().getId() : "");
                        jsonObj.put("name", (e.getSchool() != null) ? e.getSchool().getName() : "");
                        jsonObj.put("type", e.getType());
                        jsonObj.put("year", (e.getYear() != null) ? e.getYear().getName() : "");
                        jsonArray.put(jsonObj);
                    } catch (Exception e11) {
                        log.error("Could not get all educations for FB ID: {}.\n\tError message:{}", user.getFbId(), e11.getStackTrace());
                    }
                }
                user.setEducation(jsonArray.toString());
            } catch (Exception e1) {
                log.error("Could not get education for FB ID: {}.\n\tError message:{}", user.getFbId(), e1.getStackTrace());
            }
            

            try {
                JSONObject hometownJsonObj = new JSONObject(); //user_hometown
                hometownJsonObj.put("id", (userProfile.getHometown() != null) ? userProfile.getHometown().getId() : "");
                hometownJsonObj.put("name", (userProfile.getHometown() != null) ? userProfile.getHometown().getName() : "");
                user.setHometown(hometownJsonObj.toString());
            } catch (Exception e2) {
                log.error("Could not get hometown for FB ID: {}.\n\tError message:{}", user.getFbId(), e2.getStackTrace());
            }
        } catch (Exception e) {
            log.error("Could not get user profile for FB ID: {}.\n\tError message:{}", user.getFbId(), e.getStackTrace());
        }


        try {
            int curPos = 0;
            int maxStep = 25;
            boolean newResults = true;
            PagingParameters pagingParameters = new PagingParameters(maxStep, curPos, 0L, System.currentTimeMillis());
            JSONArray jsonArray = new JSONArray();

            while (newResults) {
                PagedList<Page> pagesLiked = facebook.likeOperations().getPagesLiked(user.getFbId(), pagingParameters); //user_likes

                for (Page p : pagesLiked) {
                    try {
                        JSONObject jsonObj = new JSONObject();
                        jsonObj.put("id", p.getId());
                        jsonObj.put("name", p.getName());
                        jsonObj.put("website", p.getWebsite());
                        jsonObj.put("likes", p.getLikes());
                        jsonArray.put(jsonObj);
                    } catch (Exception e) {
                        log.error("Could not get all pages liked for FB ID: {}.\n\tError message:{}", user.getFbId(), e.getStackTrace());
                    }
                }
                if (pagesLiked.size() >= maxStep) {
                    newResults = true;
                    curPos += maxStep;
                    pagingParameters = new PagingParameters(maxStep, curPos, 0L, System.currentTimeMillis());
                } else {
                    newResults = false;
                }
            }
            user.setAllFacebookLikes(jsonArray.toString());
        } catch (Exception e1) {
            log.error("Could not get pages liked for FB ID: {}.\n\tError message:{}", user.getFbId(), e1.getStackTrace());
        }


        try {
            PagedList<Reference> friends = facebook.friendOperations().getFriends(user.getFbId()); //
            JSONArray jsonArray = new JSONArray();
            for (Reference r : friends) {

                JSONObject jsonObj = new JSONObject();
                jsonObj.put("id", r.getId());
                jsonObj.put("name", r.getName());
                jsonArray.put(jsonObj);
            }
            user.setAllFacebookFriends(jsonArray.toString());
        } catch (Exception e) {
            log.error("Could not get friends for FB ID: {}.\n\tError message:{}", user.getFbId(), e.getStackTrace());
        }

        user.setProcessed(GregorianCalendar.getInstance().getTime());

        return user;
    }

}
