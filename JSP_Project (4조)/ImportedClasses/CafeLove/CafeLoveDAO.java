package CafeLove;

import java.util.*;

import javax.servlet.ServletContext;

import Common.JDBConnect;


public class CafeLoveDAO extends JDBConnect {
	
	public CafeLoveDAO(String drv, String url, String id, String pw) {
		
		super(drv, url, id, pw);
	}

	public CafeLoveDAO(ServletContext application) {
		
		super(application);
	}

	public int insertLoveRecord(CafeLoveDTO ldto) {
		
		int result = 0;
		String query = "INSERT INTO likes (num, id, title)  VALUES (?, ?, ?)";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, ldto.getNum());
			psmt.setString(2, ldto.getId());
			psmt.setString(3, ldto.getTitle());
			
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int deleteLoveRecord(CafeLoveDTO ldto) {
		
		int result = 0;
		String query = "DELETE FROM likes WHERE num = ? ";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, ldto.getNum());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public List<CafeLoveDTO> selectlikesList(String id) {
		
		List<CafeLoveDTO> likesList = new ArrayList<>();
		String query = "SELECT * FROM likes WHERE id = ?";
		query += " ORDER BY num DESC ";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();

			while (rs.next()) {
				String num = rs.getString("num");
				String title = rs.getString("title");

				CafeLoveDTO dto = new CafeLoveDTO();
				dto.setNum(num);
				dto.setId(id);
				dto.setTitle(title);

				likesList.add(dto);
			}
		} catch (Exception e) {
			System.out.println("좋아요 리스트 출력 중 오류 발생");
			e.printStackTrace();
		}
		return likesList;
	}

	public boolean checkLove(CafeLoveDTO ldto) {

		boolean result = false;
		String query = " SELECT * FROM likes  WHERE num = ? AND id = ? AND title = ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, ldto.getNum());
			psmt.setString(2, ldto.getId());
			psmt.setString(3, ldto.getTitle());
			rs = psmt.executeQuery();

			if (rs.next()) {
				result = true; // 이미 좋아요를 누른 경우
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}
}