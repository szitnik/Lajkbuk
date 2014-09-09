package si.zitnik.likebook.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionSignUp;
import org.springframework.social.connect.UserProfile;
import org.springframework.social.connect.web.ProviderSignInUtils;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.WebRequest;
import si.zitnik.likebook.domain.User;
import si.zitnik.likebook.repository.UserRepository;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 16/11/13
 * Time: 13:44
 * To change this template use File | Settings | File Templates.
 */
public class UserConnectionSignUp implements ConnectionSignUp {
    private final static Logger log = LoggerFactory.getLogger(UserConnectionSignUp.class);

    private final UserRepository userRepository;

    public UserConnectionSignUp(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public String execute(Connection<?> connection) {
        try {
            UserProfile userProfile = connection.fetchUserProfile();

            User user = new User();
            user.setFbId(connection.createData().getProviderUserId());
            user.setEmail(userProfile.getEmail()); //email
            if (userProfile.getName() == null || userProfile.getName().isEmpty()) { //name
                user.setName(userProfile.getFirstName()+ " " + userProfile.getLastName());
            } else {
                user.setName(userProfile.getName());
            }
            userRepository.save(user);



            SignInUtils.signin(user.getFbId());
            return user.getUsername();
        } catch (Exception e) {
            log.error("There was an error during the implicit signup procedure: {}", e.getStackTrace());
            return null;  //this will redirect to the signup page
        }
    }
}
