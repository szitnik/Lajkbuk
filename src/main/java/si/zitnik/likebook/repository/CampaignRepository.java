package si.zitnik.likebook.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import si.zitnik.likebook.domain.Campaign;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 5/8/13
 * Time: 8:09 PM
 * To change this template use Campaign | Settings | Campaign Templates.
 */
public interface CampaignRepository extends JpaRepository<Campaign, Long> {

    Campaign findById(Long id);




}

