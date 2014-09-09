package si.zitnik.likebook.service;

import si.zitnik.likebook.domain.Campaign;
import si.zitnik.likebook.domain.Likes;
import si.zitnik.likebook.domain.User;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 4/29/13
 * Time: 10:59 PM
 * To change this template use Campaign | Settings | Campaign Templates.
 */
public interface LikeService {
    public void save(Likes like);
    public boolean hasLiked(User user, Campaign campaign);
    public void updateLike(User user, Campaign campaign, Boolean liked);
}
