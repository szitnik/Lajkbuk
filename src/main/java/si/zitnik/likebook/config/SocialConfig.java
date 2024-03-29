package si.zitnik.likebook.config;

import org.springframework.context.annotation.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.encrypt.Encryptors;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.social.connect.ConnectionFactoryLocator;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.connect.jdbc.JdbcUsersConnectionRepository;
import org.springframework.social.connect.support.ConnectionFactoryRegistry;
import org.springframework.social.connect.web.ConnectController;
import org.springframework.social.connect.web.ProviderSignInController;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.connect.FacebookConnectionFactory;
import org.springframework.social.facebook.web.DisconnectController;
import si.zitnik.likebook.repository.UserRepository;
import si.zitnik.likebook.util.SimpleSignInAdapter;
import si.zitnik.likebook.util.UserConnectionSignUp;

import javax.inject.Inject;
import javax.sql.DataSource;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 4/1/13
 * Time: 1:09 AM
 * To change this template use Campaign | Settings | Campaign Templates.
 */
@Configuration
public class SocialConfig {
    private final String facebookClientId = "208956702576053";
    public static final String facebookClientSecret = "b13f007e86ea3369921f495ffc4565cf";

    @Inject
    private ConnectionRepository connectionRepository;

    @Inject
    private UsersConnectionRepository usersConnectionRepository;

    @Inject
    private DataSource dataSource;

    @Inject
    private UserRepository userRepository;

    @Bean
    @Scope(value="singleton", proxyMode=ScopedProxyMode.INTERFACES)
    public UsersConnectionRepository usersConnectionRepository() {
        JdbcUsersConnectionRepository repository = new JdbcUsersConnectionRepository(
                dataSource, connectionFactoryLocator(), Encryptors.noOpText());
        repository.setConnectionSignUp(new UserConnectionSignUp(userRepository));
        return repository;
    }

    @Bean
    @Scope(value="request", proxyMode=ScopedProxyMode.INTERFACES)
    public ConnectionRepository connectionRepository() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            throw new IllegalStateException("Unable to get a ConnectionRepository: no user signed in");
        }
        return usersConnectionRepository().createConnectionRepository(authentication.getName());
    }

    @Bean
    public ConnectionFactoryLocator connectionFactoryLocator() {
        ConnectionFactoryRegistry registry = new ConnectionFactoryRegistry();
        registry.addConnectionFactory(new FacebookConnectionFactory(
                facebookClientId,
                facebookClientSecret));
        return registry;
    }

    @Bean
    @Scope(value="request", proxyMode=ScopedProxyMode.INTERFACES)
    public Facebook facebook() {
        return connectionRepository.getPrimaryConnection(Facebook.class).getApi();
    }

    @Bean
    public ProviderSignInController providerSignInController(RequestCache requestCache) {
        return new ProviderSignInController(connectionFactoryLocator(), usersConnectionRepository(), new SimpleSignInAdapter(requestCache));
    }

    @Bean
    public ConnectController connectController() {
        ConnectController connectController = new ConnectController(connectionFactoryLocator(), connectionRepository());
        return connectController;
    }

    @Bean
    public DisconnectController disconnectController() {
        return new DisconnectController(usersConnectionRepository(), facebookClientSecret);
    }

}
