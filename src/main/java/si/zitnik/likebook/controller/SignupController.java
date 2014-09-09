/*
 * Copyright 2013 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package si.zitnik.likebook.controller;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.UserProfile;
import org.springframework.social.connect.web.ProviderSignInUtils;
import org.springframework.social.facebook.api.*;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.context.request.WebRequest;
import si.zitnik.likebook.domain.User;
import si.zitnik.likebook.repository.UserRepository;
import si.zitnik.likebook.util.SignInUtils;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
public class SignupController {
    private final static Logger log = LoggerFactory.getLogger(SignupController.class);

    @Inject
    private UserRepository userRepository;

    @Inject
    private Facebook facebook;

    @RequestMapping(value="/signup", method= {RequestMethod.GET, RequestMethod.POST})
    public String signup(WebRequest request) {
        try {
            Connection<Facebook> connection = (Connection<Facebook>) ProviderSignInUtils.getConnection(request);
            String fbId = connection.createData().getProviderUserId();
            SignInUtils.signin(fbId); // already signed in by implicit signup
            ProviderSignInUtils.handlePostSignUp(fbId, request);
        } catch (Exception e) {
            log.error("The user could not logged in: {}", e.getStackTrace());
        }


        String nextPage = "/";
        return "redirect:" + nextPage;
    }

    @RequestMapping(value="/signinfbTab", method= {RequestMethod.GET, RequestMethod.POST})
    public String signinFbTab(WebRequest request) {
        return "signinfbTab";
    }
}
