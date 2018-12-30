package vo;

public class User {
	private String userNum;
	private String name;
	private String id;
	private String pw;
	private int borrowCurrentCount; //현재 대출 권수
	private int borrowCount; //총 대출 권수
	private int overdueCount; //연체 횟수
	private boolean suspend;
	private String birthday;
	
	public User() {
		
	}
	public User(String userNum, String name, String id, String pw, String birthday ) {
		this.userNum = userNum;
		this.name = name;
		this.id = id;
		this.pw = pw;
		this.birthday = birthday;
	}
	public User(String userNum, String name, String id, String pw, String birthday, int borrowCurrentCount, int borrowCount, int overdueCount, boolean suspend) {
		this(userNum, name, id, pw, birthday);
		this.borrowCurrentCount = borrowCurrentCount;
		this.borrowCount = borrowCount;
		this.overdueCount = overdueCount;
		this.suspend = suspend;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public int getBorrowCurrentCount() {
		return borrowCurrentCount;
	}
	public void setBorrowCurrentCount(int borrowCurrentCount) {
		this.borrowCurrentCount = borrowCurrentCount;
	}
	public int getBorrowCount() {
		return borrowCount;
	}
	public void setBorrowCount(int borrowCount) {
		this.borrowCount = borrowCount;
	}
	public int getOverdueCount() {
		return overdueCount;
	}
	public void setOverdueCount(int overdueCount) {
		this.overdueCount = overdueCount;
	}
	public boolean isSuspend() {
		return suspend;
	}
	public void setSuspend(boolean suspend) {
		this.suspend = suspend;
	}
	
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	@Override
	public String toString() {
		return "User" + userNum + ", name=" + name + ", id=" + id + ", pw=" + pw + ", borrowCurrentCount="
				+ borrowCurrentCount + ", borrowCount=" + borrowCount + ", overdueCount=" + overdueCount + ", suspend="
				+ suspend + ", birthday=" + birthday;
	}
	
	
	
	
}
