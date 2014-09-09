package si.zitnik.likebook.controller;

import org.apache.commons.io.IOUtils;
import org.codehaus.jackson.map.util.JSONPObject;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.facebook.api.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import si.zitnik.likebook.domain.User;
import si.zitnik.likebook.repository.UserRepository;
import si.zitnik.likebook.service.CampaignService;
import si.zitnik.likebook.util.SignInUtils;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 4/12/13
 * Time: 6:34 PM
 * To change this template use Campaign | Settings | Campaign Templates.
 */
@Controller
public class FacebookController {


    @Inject
    private Facebook facebook;

    @Resource
    private UserRepository userRepository;

    @Inject
    private ConnectionRepository connectionRepository;

    @RequestMapping(value="/channel", method= RequestMethod.GET)
    public String channel(Model model) {
        return "channel";
    }

    @RequestMapping(value="/myProfileImage", method = RequestMethod.GET)
    public String unlike(RequestMethod model, HttpServletResponse response) {
        byte[] image = facebook.userOperations().getUserProfileImage();

        try {
            OutputStream out = response.getOutputStream();
            IOUtils.copy(new ByteArrayInputStream(image), out);
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    @RequestMapping(value="/signin", method=RequestMethod.GET)
    public void signin() {
    }


}
