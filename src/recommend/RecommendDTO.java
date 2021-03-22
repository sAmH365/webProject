package recommend;

public class RecommendDTO {
	private int postNum;
	private String userID;
	
	public int getPostNum() {
		return postNum;
	}
	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	public RecommendDTO(int postNum, String userID) {
		super();
		this.postNum = postNum;
		this.userID = userID;
	}
	public RecommendDTO() {}
}
