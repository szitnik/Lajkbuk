package si.zitnik.likebook.domain;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 4/1/13
 * Time: 12:21 AM
 * To change this template use Campaign | Settings | Campaign Templates.
 */
@Entity
public class User {

    @Id
    @GeneratedValue
    private Long id;
    @Column(unique = true)
    private String fbId;
    private String username;
    private String email;
    private String name;
    private String about;
    private String birthday;
    private String gender;
    private String political;
    private String relationshipStatus;
    private String religion;
    private String website;
    @Type(type = "text")
    private String education;
    @Type(type = "text")
    private String hometown;
    @Type(type = "text")
    private String allFacebookLikes;
    @Type(type = "text")
    private String allFacebookFriends;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL)
    private Set<Likes> likes = new HashSet<Likes>(0);

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL)
    private Set<Shares> shares = new HashSet<Shares>(0);

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL)
    private Set<Coupons> coupons = new HashSet<Coupons>(0);

    @Temporal(TemporalType.TIMESTAMP)
    private Date processed = null;

    public User() {}


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFbId() {
        return fbId;
    }

    public void setFbId(String fbId) {
        this.fbId = fbId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPolitical() {
        return political;
    }

    public void setPolitical(String political) {
        this.political = political;
    }

    public String getRelationshipStatus() {
        return relationshipStatus;
    }

    public void setRelationshipStatus(String relationshipStatus) {
        this.relationshipStatus = relationshipStatus;
    }

    public String getReligion() {
        return religion;
    }

    public void setReligion(String religion) {
        this.religion = religion;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getHometown() {
        return hometown;
    }

    public void setHometown(String hometown) {
        this.hometown = hometown;
    }

    public String getAllFacebookLikes() {
        return allFacebookLikes;
    }

    public void setAllFacebookLikes(String allFacebookLikes) {
        this.allFacebookLikes = allFacebookLikes;
    }

    public String getAllFacebookFriends() {
        return allFacebookFriends;
    }

    public void setAllFacebookFriends(String allFacebookFriends) {
        this.allFacebookFriends = allFacebookFriends;
    }

    public Set<Likes> getLikes() {
        return likes;
    }

    public void setLikes(Set<Likes> likes) {
        this.likes = likes;
    }

    public Set<Coupons> getCoupons() {
        return coupons;
    }

    public void setCoupons(Set<Coupons> coupons) {
        this.coupons = coupons;
    }

    public Date getProcessed() {
        return processed;
    }

    public void setProcessed(Date processed) {
        this.processed = processed;
    }

    public Set<Shares> getShares() {
        return shares;
    }

    public void setShares(Set<Shares> shares) {
        this.shares = shares;
    }
}
