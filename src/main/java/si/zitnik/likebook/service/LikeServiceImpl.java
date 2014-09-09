package si.zitnik.likebook.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import si.zitnik.likebook.domain.Campaign;
import si.zitnik.likebook.domain.FinishType;
import si.zitnik.likebook.domain.Likes;
import si.zitnik.likebook.domain.User;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.GregorianCalendar;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 4/29/13
 * Time: 11:00 PM
 * To change this template use Campaign | Settings | Campaign Templates.
 */
@Service
@Transactional
public class LikeServiceImpl implements LikeService {

    @PersistenceContext
    private EntityManager entityManager;

    @Inject
    private CampaignService campaignService;

    @Override
    public void save(Likes like) {
        entityManager.persist(like);
    }

    @Override
    public boolean hasLiked(User user, Campaign campaign) {

        Query query = entityManager.createQuery("select o from Likes o where o.campaign = :campaign and o.user = :user");
        query.setParameter("campaign", campaign.getId());
        query.setParameter("user", user.getId());

        int resultsSize = query.getResultList().size();

        return resultsSize > 0;
    }

    @Override
    public void updateLike(User user, Campaign campaign, Boolean liked) {

        Query query = entityManager.createQuery("select o from Likes o where o.campaign = :campaign and o.user = :user");
        query.setParameter("campaign", campaign.getId());
        query.setParameter("user", user.getId());

        int resultsSize = query.getResultList().size();

        if (resultsSize == 0) {
            if (liked) {
                Likes like = new Likes();
                like.setCampaign(campaign);
                like.setUser(user);

                user.getLikes().add(like);
                campaign.getLikes().add(like);

                entityManager.persist(like);

                campaign.setCurrentLikes(campaign.getCurrentLikes() + 1);
                if (campaign.getCurrentLikes() >= campaign.getTargetLikes()) {
                    //finished campaign
                    campaignService.finish(campaign.getId(), FinishType.OK);
                }
                entityManager.merge(campaign);
                entityManager.merge(user);
            }
        }
    }
}
