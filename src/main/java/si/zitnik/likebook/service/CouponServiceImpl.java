package si.zitnik.likebook.service;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import si.zitnik.likebook.domain.Campaign;
import si.zitnik.likebook.domain.Coupons;
import si.zitnik.likebook.domain.Likes;
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
public class CouponServiceImpl implements CouponService {

    @PersistenceContext
    private EntityManager entityManager;

    @Inject
    private CampaignService campaignService;

    @Override
    public void save(Coupons coupon) {
        entityManager.persist(coupon);
    }

    @Transactional
    @Override
    public void generateCoupon(User user, Campaign campaign) {
        Query query = entityManager.createQuery("select o from Coupons o where o.campaign = :campaign and o.user = :user");
        query.setParameter("campaign", campaign.getId());
        query.setParameter("user", user.getId());

        int resultsSize = query.getResultList().size();

        if (resultsSize == 0) {
            Coupons coupon = new Coupons();
            coupon.setCampaign(campaign);
            coupon.setUser(user);
            coupon.setCouponCode(RandomStringUtils.random(6, "ABCDEFGHIJKLMNOPRSTUVZ1234567890$%"));

            user.getCoupons().add(coupon);
            campaign.getCoupons().add(coupon);

            entityManager.persist(coupon);
            entityManager.merge(campaign);
            entityManager.merge(user);
        }

    }
}
