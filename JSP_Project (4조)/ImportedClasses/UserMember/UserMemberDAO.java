package UserMember;

import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;
import javax.servlet.ServletContext;
import Common.JDBConnect;

public class UserMemberDAO extends JDBConnect {

	public UserMemberDAO(String drv, String url, String id, String pw) {

		super(drv, url, id, pw);
	}

	public UserMemberDAO(ServletContext application) {

		super(application);
	}

	public UserMemberDTO getUserMemberDTO(String id, String pass) {

		UserMemberDTO dto = new UserMemberDTO();
		String query = "SELECT * FROM usermember WHERE id=? AND pass=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, pass);

			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setTel(rs.getString("tel"));
				dto.setBlacklist(rs.getString("blacklist")); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	public UserMemberDTO getCreateAccount(String id, String pass, String name, String gender, String tel) {

		UserMemberDTO dto = new UserMemberDTO();
		String query = "INSERT INTO usermember (id, pass, name, gender, tel,blacklist) values (?, ?, ?, ?, ?,'false')"; // 수정

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, pass);
			psmt.setString(3, name);
			psmt.setString(4, gender);
			psmt.setString(5, tel);

			psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	public UserMemberDTO getDeleteAccount(String id, String pass) {

		UserMemberDTO dto = new UserMemberDTO();
		String query = "DELETE FROM usermember WHERE id = ? AND pass = ?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, pass);

			psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	public UserMemberDTO getUpdateAccount(String id, String pass, String name, String gender, String tel) {

		UserMemberDTO dto = new UserMemberDTO();
		String query = "UPDATE usermember SET pass = ?, name = ?, gender = ?, tel = ? WHERE id = ?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, pass);
			psmt.setString(2, name);
			psmt.setString(3, gender);
			psmt.setString(4, tel);
			psmt.setString(5, id);

			psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	public UserMemberDTO getUpdateBlackListAccount(String id, String blacklist) {

		UserMemberDTO dto = new UserMemberDTO();
		String query = "UPDATE usermember SET blacklist = ? WHERE id = ? ";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, blacklist);
			psmt.setString(2, id);

			psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	public List<UserMemberDTO> getBlackList() {
	    List<UserMemberDTO> blacklist = new ArrayList<>();
	    String query = "SELECT * FROM usermember where blacklist = 'true'";

	    try {
	        stmt = con.prepareStatement(query);
	        rs = stmt.executeQuery(query);

	        while(rs.next()) {
	            UserMemberDTO dto = new UserMemberDTO();

	            String id = rs.getString("id");
	            String name = rs.getString("name");
	            String blacklistStatus = rs.getString("blacklist");

	            dto.setId(id);
	            dto.setName(name);
	            dto.setBlacklist(blacklistStatus);

	            blacklist.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return blacklist;
	}

}