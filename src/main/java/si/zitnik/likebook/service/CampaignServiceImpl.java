package si.zitnik.likebook.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import si.zitnik.likebook.domain.Campaign;
import si.zitnik.likebook.domain.FinishType;
import si.zitnik.likebook.domain.User;
import si.zitnik.likebook.repository.CampaignRepository;
import si.zitnik.likebook.repository.UserRepository;
import si.zitnik.likebook.util.SignInUtils;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 5/11/13
 * Time: 10:35 AM
 * To change this template use Campaign | Settings | Campaign Templates.
 */
@Service
@Transactional
public class CampaignServiceImpl implements CampaignService {

    @PersistenceContext
    private EntityManager entityManager;

    @Resource
    private CampaignRepository campaignRepository;

    @Resource
    private UserRepository userRepository;

    @Transactional
    public void save(Campaign campaign) {
        if (campaign.getId() == null) {
            entityManager.persist(campaign);
        } else {
            entityManager.merge(campaign);
        }
    }

    @Transactional
    public List<Campaign> list() {
        List<Campaign> campaigns = (List<Campaign>)this.entityManager.createQuery("select c from Campaign c").getResultList();
        return campaigns;
    }

    @Transactional
    public Set<Long> getMyCampaigns() {
        User user = userRepository.findByFbId(SignInUtils.getCurrentUserFbId());
        Query query = this.entityManager.createQuery("select c.id from Campaign c, Likes l where l.campaign = c.id and l.user = :user");
        query.setParameter("user", user.getId());
        return new HashSet<Long>((List<Long>)query.getResultList());
    }

    @Transactional
    public List<Campaign> reverseActivatedNotFinishedNotMyList() {
        Set<Long> myCampaigns = getMyCampaigns();

        List<Campaign> campaigns = list();
        List<Campaign> reverseCampaigns = new ArrayList<Campaign>();
        for (Campaign c : campaigns) {
            if (c.getActive() && !c.getFinished() && !myCampaigns.contains(c.getId())) {
                reverseCampaigns.add(0, c);
            }
        }
        return reverseCampaigns;
    }

    @Transactional
    public List<Campaign> reverseActivatedNotFinishedMyList() {
        Set<Long> myCampaigns = getMyCampaigns();

        List<Campaign> campaigns = list();
        List<Campaign> reverseCampaigns = new ArrayList<Campaign>();
        for (Campaign c : campaigns) {
            if (c.getActive() && !c.getFinished() && myCampaigns.contains(c.getId())) {
                reverseCampaigns.add(0, c);
            }
        }
        return reverseCampaigns;
    }

    @Transactional
    public List<Campaign> reverseActivatedFinishedAllList() {
        List<Campaign> campaigns = list();
        List<Campaign> reverseCampaigns = new ArrayList<Campaign>();
        for (Campaign c : campaigns) {
            if (c.getActive() && c.getFinished()) {
                reverseCampaigns.add(0, c);
            }
        }
        return reverseCampaigns;
    }

    @Transactional
    public List<Campaign> reverseActivatedNotFinishedAllList() {
        List<Campaign> campaigns = list();
        List<Campaign> reverseCampaigns = new ArrayList<Campaign>();
        for (Campaign c : campaigns) {
            if (c.getActive() && !c.getFinished()) {
                reverseCampaigns.add(0, c);
            }
        }
        return reverseCampaigns;
    }


    @Transactional
    public Campaign get(Long id) {
        return campaignRepository.findById(id);
    }


    @Transactional
    public void remove(Long id) {
        campaignRepository.delete(id);
    }

    @Transactional
    public void activate(Long campaignId) {
        Campaign campaign = this.get(campaignId);
        campaign.setActive(true);
        save(campaign);
    }

    @Transactional
    public void deactivate(Long campaignId) {
        Campaign campaign = this.get(campaignId);
        campaign.setActive(false);
        save(campaign);
    }

    @Transactional
    public void finish(Long campaignId, FinishType finishType) {
        Campaign campaign = this.get(campaignId);
        campaign.setDateFinished(GregorianCalendar.getInstance().getTime());
        campaign.setFinished(true);
        campaign.setFinishType(finishType);
        save(campaign);
    }
}
