package users;

public class UsersDTO {
	private String name;
	private String userID;
	private String userPwd;
	private String userEmail;
	private String userHash;
	private int userEmailChecked;
	private int admin;
	
	public UsersDTO() {
		
	}
	
	public UsersDTO(String name, String userID, String userPwd, String userEmail, String userHash,
			int userEmailChecked) {
		super();
		this.name = name;
		this.userID = userID;
		this.userPwd = userPwd;
		this.userEmail = userEmail;
		this.userHash = userHash;
		this.userEmailChecked = userEmailChecked;
	}
	
	public UsersDTO(String name, String userID, String userEmail,int userEmailChecked) {
		super();
		this.name = name;
		this.userID = userID;
		this.userEmail = userEmail;
		this.userEmailChecked = userEmailChecked;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public int getUserEmailChecked() {
		return userEmailChecked;
	}
	public void setUserEmailChecked(int userEmailChecked) {
		this.userEmailChecked = userEmailChecked;
	}
	public String getUserHash() {
		return userHash;
	}
	public void setUserHash(String userHash) {
		this.userHash = userHash;
	}

	public int getAdmin() {
		return admin;
	}

	public void setAdmin(int admin) {
		this.admin = admin;
	}
}
