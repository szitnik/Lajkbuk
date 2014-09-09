package si.zitnik.likebook.domain;

import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
public class Campaign {
	
	@Id
	@GeneratedValue
	private Long id;
    @NotNull
	private String title;
    @NotNull
    @Lob
	private String description;
    @NotNull
    private String facebookAppLink;
    @NotNull
    private String facebookAppKey;
    @NotNull
    private String facebookAppSecret;

    //image
	@Lob
    @NotNull
    @Basic(fetch = FetchType.LAZY)
	private byte[] bigImage;
    @NotNull
    private String bigImageFilename;
    @NotNull
	private String bigImageContentType;

    @Lob
    @NotNull
    @Basic(fetch = FetchType.LAZY)
    private byte[] smallImage;
    @NotNull
    private String smallImageFilename;
    @NotNull
    private String smallImageContentType;

    //terms
    @Lob
    @NotNull
    @Basic(fetch = FetchType.LAZY)
    private byte[] terms;
    @NotNull
    private String termsFilename;
    @NotNull
    private String termsContentType;

    //terms
    @Lob
    //@NotNull
    @Basic(fetch = FetchType.LAZY)
    private byte[] finishDocument;
    //@NotNull
    private String finishDocumentFilename;
    //@NotNull
    private String finishDocumentContentType;

    @NotNull
    private Boolean active;
    @NotNull
    private Boolean finished = false;

    @NotNull
    private String likeLink;
    @NotNull
    private int currentLikes = 0;
    @NotNull
    private int targetLikes;
    @NotNull
    private int numOfWinners;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "campaign", cascade = CascadeType.ALL)
    private Set<Likes> likes = new HashSet<Likes>(0);

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "campaign", cascade = CascadeType.ALL)
    private Set<Shares> shares = new HashSet<Shares>(0);

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "campaign", cascade = CascadeType.ALL)
    private Set<Coupons> coupons = new HashSet<Coupons>(0);


    @ManyToOne(optional = false, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "customer", referencedColumnName = "id")
    private Customer customer;

    @NotNull
    @Temporal(TemporalType.TIMESTAMP)
	private Date dateAdded = GregorianCalendar.getInstance().getTime();
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateFinished;
    @Enumerated(EnumType.STRING)
    private FinishType finishType;


    @ElementCollection
    @Enumerated(EnumType.STRING)
    private Set<Feature> enabledFeatures = new HashSet<Feature>(0);

    public Set<Feature> getEnabledFeatures() {
        return enabledFeatures;
    }

    public void setEnabledFeatures(Set<Feature> enabledFeatures) {
        this.enabledFeatures = enabledFeatures;
    }

    public Set<Coupons> getCoupons() {
        return coupons;
    }

    public void setCoupons(Set<Coupons> coupons) {
        this.coupons = coupons;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFacebookAppLink() {
        return facebookAppLink;
    }

    public void setFacebookAppLink(String facebookAppLink) {
        this.facebookAppLink = facebookAppLink;
    }

    public byte[] getBigImage() {
        return bigImage;
    }

    public void setBigImage(byte[] bigImage) {
        this.bigImage = bigImage;
    }

    public String getBigImageFilename() {
        return bigImageFilename;
    }

    public void setBigImageFilename(String bigImageFilename) {
        this.bigImageFilename = bigImageFilename;
    }

    public String getBigImageContentType() {
        return bigImageContentType;
    }

    public void setBigImageContentType(String bigImageContentType) {
        this.bigImageContentType = bigImageContentType;
    }

    public byte[] getSmallImage() {
        return smallImage;
    }

    public void setSmallImage(byte[] smallImage) {
        this.smallImage = smallImage;
    }

    public String getSmallImageFilename() {
        return smallImageFilename;
    }

    public void setSmallImageFilename(String smallImageFilename) {
        this.smallImageFilename = smallImageFilename;
    }

    public String getSmallImageContentType() {
        return smallImageContentType;
    }

    public void setSmallImageContentType(String smallImageContentType) {
        this.smallImageContentType = smallImageContentType;
    }

    public byte[] getTerms() {
        return terms;
    }

    public void setTerms(byte[] terms) {
        this.terms = terms;
    }

    public String getTermsFilename() {
        return termsFilename;
    }

    public void setTermsFilename(String termsFilename) {
        this.termsFilename = termsFilename;
    }

    public String getTermsContentType() {
        return termsContentType;
    }

    public void setTermsContentType(String termsContentType) {
        this.termsContentType = termsContentType;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public String getLikeLink() {
        return likeLink;
    }

    public void setLikeLink(String likeLink) {
        this.likeLink = likeLink;
    }

    public int getCurrentLikes() {
        return currentLikes;
    }

    public void setCurrentLikes(int currentLikes) {
        this.currentLikes = currentLikes;
    }

    public int getTargetLikes() {
        return targetLikes;
    }

    public void setTargetLikes(int targetLikes) {
        this.targetLikes = targetLikes;
    }

    public int getNumOfWinners() {
        return numOfWinners;
    }

    public void setNumOfWinners(int numOfWinners) {
        this.numOfWinners = numOfWinners;
    }

    public Set<Likes> getLikes() {
        return likes;
    }

    public void setLikes(Set<Likes> likes) {
        this.likes = likes;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Date getDateAdded() {
        return dateAdded;
    }

    public void setDateAdded(Date dateAdded) {
        this.dateAdded = dateAdded;
    }

    public Date getDateFinished() {
        return dateFinished;
    }

    public void setDateFinished(Date dateFinished) {
        this.dateFinished = dateFinished;
    }

    public Boolean getFinished() {
        return finished;
    }

    public void setFinished(Boolean finished) {
        this.finished = finished;
    }

    public String getFacebookAppKey() {
        return facebookAppKey;
    }

    public void setFacebookAppKey(String facebookAppKey) {
        this.facebookAppKey = facebookAppKey;
    }

    public String getFacebookAppSecret() {
        return facebookAppSecret;
    }

    public void setFacebookAppSecret(String facebookAppSecret) {
        this.facebookAppSecret = facebookAppSecret;
    }

    public byte[] getFinishDocument() {
        return finishDocument;
    }

    public void setFinishDocument(byte[] finishDocument) {
        this.finishDocument = finishDocument;
    }

    public String getFinishDocumentFilename() {
        return finishDocumentFilename;
    }

    public void setFinishDocumentFilename(String finishDocumentFilename) {
        this.finishDocumentFilename = finishDocumentFilename;
    }

    public String getFinishDocumentContentType() {
        return finishDocumentContentType;
    }

    public void setFinishDocumentContentType(String finishDocumentContentType) {
        this.finishDocumentContentType = finishDocumentContentType;
    }

    public Set<Shares> getShares() {
        return shares;
    }

    public void setShares(Set<Shares> shares) {
        this.shares = shares;
    }

    public FinishType getFinishType() {
        return finishType;
    }

    public void setFinishType(FinishType finishType) {
        this.finishType = finishType;
    }
}
