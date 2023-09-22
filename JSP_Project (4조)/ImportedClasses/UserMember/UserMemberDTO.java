package UserMember;

public class UserMemberDTO {
	
	private String id;       // 회원 아이디 (외래키 참조)
	private String pass;     // 회원 비밀번호 
	private String name;     // 회원 이름
	private String gender;   // 회원 성별
	private String tel;      // 회원 전화번호
	private String blacklist;
	
	public String getBlacklist() {
		return blacklist;
	}

	public void setBlacklist(String blacklist) {
		this.blacklist = blacklist;
	}

	public String getId() {
		
		return id;
	}
	
	public void setId(String id) {
		
		this.id = id;
	}
	
	public String getPass() {
		
		return pass;
	}
	
	public void setPass(String pass) {
		
		this.pass = pass;
	}
	
	public String getName() {
		
		return name;
	}
	
	public void setName(String name) {
		
		this.name = name;
	}

	public String getGender() {
		
		return gender;
	}

	public void setGender(String gender) {
		
		this.gender = gender;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		
		this.tel = tel;
	}
}