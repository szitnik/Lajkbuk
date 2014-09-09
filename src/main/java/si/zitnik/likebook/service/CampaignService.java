package si.zitnik.likebook.service;

import si.zitnik.likebook.domain.Campaign;
import si.zitnik.likebook.domain.FinishType;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 5/10/13
 * Time: 6:48 PM
 * To change this template use Campaign | Settings | Campaign Templates.
 */
public interface CampaignService {
    public void save(Campaign document);
    public List<Campaign> list();
    public List<Campaign> reverseActivatedNotFinishedMyList();
    public List<Campaign> reverseActivatedNotFinishedNotMyList();
    public List<Campaign> reverseActivatedFinishedAllList();
    public List<Campaign> reverseActivatedNotFinishedAllList();
    public Campaign get(Long id);
    public void remove(Long id);

    public void activate(Long campaignId);
    public void deactivate(Long campaignId);
    public void finish(Long campaignId, FinishType finishType);
}
