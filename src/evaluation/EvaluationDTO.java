package evaluation;

public class EvaluationDTO {
	private int rnum;
	private int postNum;
	private String area;
	private String address;
	private String storeTitle;
	private String title;
	private String userID;
	private String content;
	private String purpose;
	private Double taste;
	private Double mood;
	private Double kind;
	private Double facility;
	private Double totalScore;
	private int recoCount;
	public int getPostNum() {
		return postNum;
	}
	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getStoreTitle() {
		return storeTitle;
	}
	public void setStoreTitle(String storeTitle) {
		this.storeTitle = storeTitle;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public Double getTaste() {
		return taste;
	}
	public void setTaste(Double taste) {
		this.taste = taste;
	}
	public Double getMood() {
		return mood;
	}
	public void setMood(Double mood) {
		this.mood = mood;
	}
	public Double getKind() {
		return kind;
	}
	public void setKind(Double kind) {
		this.kind = kind;
	}
	public Double getFacility() {
		return facility;
	}
	public void setFacility(Double facility) {
		this.facility = facility;
	}
	public Double getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(Double totalScore) {
		this.totalScore = totalScore;
	}
	public int getRecoCount() {
		return recoCount;
	}
	public void setRecoCount(int recoCount) {
		this.recoCount = recoCount;
	}
	public EvaluationDTO(int postNum, String area, String address, String storeTitle, String title, String userID,
			String content, String purpose, Double taste, Double mood, Double kind, Double facility, Double totalScore,
			int recoCount) {
		super();
		this.postNum = postNum;
		this.area = area;
		this.address = address;
		this.storeTitle = storeTitle;
		this.title = title;
		this.userID = userID;
		this.content = content;
		this.purpose = purpose;
		this.taste = taste;
		this.mood = mood;
		this.kind = kind;
		this.facility = facility;
		this.totalScore = totalScore;
		this.recoCount = recoCount;
	}
	
	public EvaluationDTO(int postNum , String title,String content, String purpose, 
			Double taste, Double mood, Double kind, Double facility, Double totalScore){
		super();
		this.postNum = postNum;
		this.title = title;
		this.content = content;
		this.purpose = purpose;
		this.taste = taste;
		this.mood = mood;
		this.kind = kind;
		this.facility = facility;
		this.totalScore = totalScore;
		
	}
	
	public EvaluationDTO(int rnum,int postNum, String area, String address, String storeTitle, String title, String userID,
			String content, String purpose, Double taste, Double mood, Double kind, Double facility, Double totalScore,
			int recoCount) {
		super();
		this.rnum = rnum;
		this.postNum = postNum;
		this.area = area;
		this.address = address;
		this.storeTitle = storeTitle;
		this.title = title;
		this.userID = userID;
		this.content = content;
		this.purpose = purpose;
		this.taste = taste;
		this.mood = mood;
		this.kind = kind;
		this.facility = facility;
		this.totalScore = totalScore;
		this.recoCount = recoCount;
	}
	
	public EvaluationDTO() {}
	
	
	
}
