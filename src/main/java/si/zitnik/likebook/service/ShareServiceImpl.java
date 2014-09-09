package si.zitnik.likebook.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import si.zitnik.likebook.domain.Campaign;
import si.zitnik.likebook.domain.Likes;
import si.zitnik.likebook.domain.Shares;
import si.zitnik.likebook.domain.User;

import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 4/29/13
 * Time: 11:00 PM
 * To change this template use Campaign | Settings | Campaign Templates.
 */
@Service
@Transactional
public class ShareServiceImpl implements ShareService {

    @PersistenceContext
    private EntityManager entityManager;

    @Inject
    private CampaignService campaignService;

    @Override
    public void share(User user, Campaign campaign) {
        Shares share = new Shares();
        share.setCampaign(campaign);
        share.setUser(user);

        user.getShares().add(share);
        campaign.getShares().add(share);

        entityManager.persist(share);
        entityManager.merge(campaign);
        entityManager.merge(user);
    }
}
