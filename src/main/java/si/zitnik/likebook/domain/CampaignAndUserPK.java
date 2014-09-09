package si.zitnik.likebook.domain;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.ManyToOne;
import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 6/4/13
 * Time: 10:39 PM
 * To change this template use File | Settings | File Templates.
 */
@Embeddable
public class CampaignAndUserPK implements Serializable {

    @ManyToOne(optional = false, cascade = CascadeType.PERSIST)
    private Campaign campaign;
    @ManyToOne(optional = false, cascade = CascadeType.PERSIST)
    private User user;

    public CampaignAndUserPK(Campaign campaign, User user) {
        this.campaign = campaign;
        this.user = user;
    }

    public CampaignAndUserPK() {
    }

    public Campaign getCampaign() {
        return campaign;
    }

    public void setCampaign(Campaign campaign) {
        this.campaign = campaign;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public int hashCode() {
        return campaign.hashCode() + 17 * user.hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        CampaignAndUserPK otherPK = (CampaignAndUserPK)obj;
        if (this.campaign != null && this.campaign.equals(otherPK.campaign) &&
            this.user != null && this.user.equals(otherPK.user)) {
            return true;
        } else {
            return false;
        }
    }
}