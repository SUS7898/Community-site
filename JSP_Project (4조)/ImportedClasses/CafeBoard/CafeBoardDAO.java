package CafeBoard;

import java.util.*;
import java.util.Vector;

import javax.servlet.ServletContext;
import Common.JDBConnect;

public class CafeBoardDAO extends JDBConnect {

	public CafeBoardDAO(String drv, String url, String id, String pw) {

		super(drv, url, id, pw);
	}

	public CafeBoardDAO(ServletContext application) {

		super(application);
	}

public int insertWrite(CafeBoardDTO dto) {
		
	    int result = 0;

	    try {
	        String query = "INSERT INTO cafeboard (num, title, content, id, category, visitcount, love, filename) "
	                + "VALUES (seq_cafeboard_num.NEXTVAL, ?, ?, ?, ?, 0, 0, ?)";

	        psmt = con.prepareStatement(query);
	        
	        psmt.setString(1, dto.getTitle());
	        psmt.setString(2, dto.getContent());
	        psmt.setString(3, dto.getId());
	        psmt.setString(4, dto.getCategory());  // 수정된 부분: 카테고리 값 설정
	        psmt.setString(5, dto.getFileName());  // 이미지 파일명 설정
	        
	        result = psmt.executeUpdate();
	    } catch (Exception e) {
	        System.out.println("게시물 입력 중 예외 발생");
	        e.printStackTrace();
	    }
	    return result; 
	}

	// 게시물 목록을 반환합니다.
	public List<CafeBoardDTO> selectList(int pageNum, int postsPerPage) {
		List<CafeBoardDTO> bbs = new Vector<CafeBoardDTO>();

		int startRow = (pageNum - 1) * postsPerPage + 1; // 시작 행을 계산합니다. 수정
		int endRow = startRow + postsPerPage - 1; // 끝 행을 계산합니다. 수정

		String query = "SELECT * FROM ("                       //수정
				     + "  SELECT rownum rnum, A.* FROM ("
				     + "    SELECT * FROM cafeboard ORDER BY num DESC"
				     + "  ) A"
				     + "  WHERE rownum <= ?"
				     + ") WHERE rnum >= ?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, endRow);
			psmt.setInt(2, startRow);
			
			rs = psmt.executeQuery();

			while (rs.next()) {
				CafeBoardDTO dto = new CafeBoardDTO();

				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setLove(rs.getString("love"));
				dto.setCategory(rs.getString("category"));

				bbs.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return bbs;
	}

	// 지정한 게시물의 조회수를 1 증가시킵니다.
	public void updateVisitCount(String num) {
		// 쿼리문 준비
		String query = "UPDATE cafeboard SET visitcount=visitcount+1 WHERE num=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num); // 인파라미터를 일련번호로 설정
			
			psmt.executeQuery(); // 쿼리 실행
		} catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}

	// 지정한 게시물의 좋아요수를 1 증가시킵니다.
	public int updateLove(CafeBoardDTO dto) {
		// 쿼리문 준비
		String query = "UPDATE cafeboard SET love=love+1 WHERE num=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getNum()); // 인파라미터를 일련번호로 설정

			psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
		return 1;  // 결과 반환
	}

	// 지정한 게시물을 수정합니다.
	public int updateEdit(CafeBoardDTO dto) {

		int result = 0;

		try {
			// 쿼리문 템플릿
			String query = "UPDATE cafeboard SET title=?, content=?, category=?, filename=? WHERE num=?";
			// 쿼리문 완성
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getCategory());
			psmt.setString(4, dto.getFileName());
			psmt.setString(5, dto.getNum());
			// 쿼리문 실행
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		return result; // 결과 반환
	}

	public CafeBoardDTO selectView(String num) {// 게시글 목록 출력

		CafeBoardDTO dto = new CafeBoardDTO();
		// 쿼리문 준비
		String query = "SELECT B.*, M.name FROM usermember M INNER JOIN cafeboard B ON M.id=B.id WHERE num=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num); // 인파라미터를 일련번호로 설정

			rs = psmt.executeQuery(); // 쿼리 실행
			// 결과 처리
			if (rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setLove(rs.getString("love"));
				dto.setCategory(rs.getString("category"));
				dto.setFileName(rs.getString("filename"));
			}
		} catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto; // 게시물의 개수를 반환합니다.
	}

	public int selectCount() { // 게시글 수 반환

		int totalCount = 0; // 결과(게시물 수)를 담을 변수
		// 게시물 수를 얻어오는 쿼리문 작성
		String query = "SELECT COUNT(*) FROM cafeboard";

		try {
			stmt = con.createStatement(); // 쿼리문 생성
			rs = stmt.executeQuery(query); // 쿼리 실행

			if (rs.next()) { // 커서를 첫 번째 행으로 이동
				totalCount = rs.getInt(1); // 첫 번째 칼럼 값을 가져옴
			}
		} catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}

	// 지정한 게시물을 삭제합니다.
	public int deletePost(CafeBoardDTO dto) {

		int result = 0;

		try {
			// 쿼리문 템플릿
			String query = "DELETE FROM cafeboard WHERE num=?";

			// 쿼리문 완성
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getNum());

			// 쿼리문 실행
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result; // 결과 반환
	}
	
	// 게시글 검색
	public List<CafeBoardDTO> searchBoard(String searchField, String searchWord) {

		List<CafeBoardDTO> boardList = new ArrayList<>();

		try {
			String query = "SELECT B.*, M.name FROM usermember M INNER JOIN cafeboard B ON M.id=B.id ";

			if (searchField.equals("title")) {
				query += "WHERE B.title LIKE ?";
			} else if (searchField.equals("content")) {
				query += "WHERE B.content LIKE ?";
			} else if (searchField.equals("category")) {
				query += "WHERE B.category LIKE ?";
			}

			psmt = con.prepareStatement(query);
			psmt.setString(1, "%" + searchWord + "%");

			rs = psmt.executeQuery();

			while (rs.next()) {
				CafeBoardDTO dto = new CafeBoardDTO();
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setLove(rs.getString("love"));
				dto.setCategory(rs.getString("category"));

				boardList.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 검색 중 예외 발생");
			e.printStackTrace();
		}
		return boardList;
	}

	// 좋아요가 가장 많은 3개의 게시물 조회
	public List<CafeBoardDTO> getTop3ByLikes() {

		List<CafeBoardDTO> top3List = new ArrayList<>();
		String query = "SELECT * FROM (SELECT num, title FROM cafeboard ORDER BY love DESC) WHERE ROWNUM <= 3";
		
		try {
			stmt = con.createStatement();

			rs = stmt.executeQuery(query);

			while (rs.next()) {
				CafeBoardDTO dto = new CafeBoardDTO();

				String num = rs.getString("num");
				String title = rs.getString("title");

				dto.setNum(num);
				dto.setTitle(title);

				top3List.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return top3List;
	}

	// 카테고리별 게시물 수 조회
	public int selectCountByCategory(String category) {

		int count = 0;

		try {
			String sql = "SELECT COUNT(*) FROM cafeboard WHERE category = ?";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, category);

			rs = psmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// 카테고리별 게시글 리스트 가져오기 (페이지네이션 적용)
	public List<CafeBoardDTO> selectListByCategory(String category, int pageNum, int postsPerPage) {

	    List<CafeBoardDTO> boardLists = new ArrayList<>();

	    try {
	        // 페이지네이션 적용을 위한 시작 위치와 끝 위치 계산
	        int startRow = (pageNum - 1) * postsPerPage + 1;
	        int endRow = startRow + postsPerPage - 1;

	        String sql = "SELECT * FROM ("
	            + "  SELECT /*+ FIRST_ROWS(n) */ a.*, ROWNUM rnum FROM ("
	            + "    SELECT * FROM cafeboard";

	        if (category != null && !category.isEmpty()) {
	            sql += " WHERE category = ?"; // 카테고리 필터 추가
	        }
	        sql += " ORDER BY num DESC"
	            + "  ) a WHERE ROWNUM <= ?" // 최대 행 수 지정
	            + ") WHERE rnum >= ?"; // 최소 행 수 지정

	        psmt = con.prepareStatement(sql);

	        if (category != null && !category.isEmpty()) { // 카테고리가 비어있지 않을 때
	            psmt.setString(1, category);
	            psmt.setInt(2, endRow);
	            psmt.setInt(3, startRow);
	        } else {
	            psmt.setInt(1, endRow);
	            psmt.setInt(2, startRow);
	        }

	        rs = psmt.executeQuery();

	        while (rs.next()) {
	            CafeBoardDTO dto = new CafeBoardDTO();

	            dto.setNum(rs.getString("num"));
	            dto.setTitle(rs.getString("title"));
	            dto.setContent(rs.getString("content"));
	            dto.setPostdate(rs.getDate("postdate"));
	            dto.setId(rs.getString("id"));
	            dto.setVisitcount(rs.getString("visitcount"));
	            dto.setLove(rs.getString("love"));
	            dto.setCategory(rs.getString("category"));

	            // 필요한 필드 추가
	            boardLists.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return boardLists;
	}

}