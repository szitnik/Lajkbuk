package si.zitnik.likebook.domain;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 4/29/13
 * Time: 10:40 PM
 * To change this template use Campaign | Settings | Campaign Templates.
 */
@Entity
public class Shares {


    @Id
    private CampaignAndUserPK id = new CampaignAndUserPK();

    //bidirectional association! Needed to trick hibernate ;P
    @SuppressWarnings("unused")
    @Column(name="campaign_id", nullable=false, updatable=false, insertable=false)
    private Long campaign;

    @SuppressWarnings("unused")
    @Column(name="user_id", nullable=false, updatable=false, insertable=false)
    private Long user;
    //----

    @NotNull
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateShared = GregorianCalendar.getInstance().getTime();

    public CampaignAndUserPK getId() {
        return id;
    }

    public void setId(CampaignAndUserPK id) {
        this.id = id;
    }

    public Date getDateShared() {
        return dateShared;
    }

    public void setDateShared(Date dateShared) {
        this.dateShared = dateShared;
    }

    public Campaign getCampaign() {
        return id.getCampaign();
    }

    public void setCampaign(Campaign campaign) {
        this.id.setCampaign(campaign);
    }

    public User getUser() {
        return id.getUser();
    }

    public void setUser(User user) {
        this.id.setUser(user);
    }
}
