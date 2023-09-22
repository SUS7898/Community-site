package Comment;

import java.util.List;
import java.util.Vector;

import javax.servlet.ServletContext;
import Common.JDBConnect;

public class CommentDAO extends JDBConnect {

	public CommentDAO(String drv, String url, String id, String pw) {

		super(drv, url, id, pw);
	}

	public CommentDAO(ServletContext application) {

		super(application);
	}

	// 댓글 입력
	public int insertComment(CommentDTO dto) {

		int result = 0;

		try {
			String query = "INSERT INTO board_comment (num, commentNum, id, name, postdate, content) VALUES (?, seq_board_comment_commentNum.NEXTVAL, ?, ?, SYSDATE, ?)";

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getNum());
			psmt.setString(2, dto.getId());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getContent());

			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("댓글 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	// 지정한 댓글을 삭제
	public int deleteComment(CommentDTO dto) {

		int result = 0;

		try {
			// 쿼리문 템플릿
			String query = "DELETE FROM board_comment WHERE commentNum = ?";

			// 쿼리문 완성
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getCommentNum());

			// 쿼리문 실행
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("댓글 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result; // 결과 반환
	}

	public int updateComment(CommentDTO dto) {
		
	    int result = 0;

	    try {
	        String query = "UPDATE board_comment SET content = ? WHERE commentNum = ?";
	        psmt = con.prepareStatement(query);
	        psmt.setString(1, dto.getContent());
	        psmt.setInt(2, Integer.parseInt(dto.getCommentNum()));

	        result = psmt.executeUpdate();
	    } catch (Exception e) {
	        System.out.println("댓글 수정 중 예외 발생");
	        e.printStackTrace();
	    }
	    return result;
	}


	// 댓글 목록을 조회
	public List<CommentDTO> commentList() {

		List<CommentDTO> bbs = new Vector<CommentDTO>(); // 결과(댓글 목록)를 담을 변수
		String query = "SELECT * FROM board_comment";
		query += " ORDER BY num DESC";

		try {
			stmt = con.createStatement(); // 쿼리문 생성
			rs = stmt.executeQuery(query); // 쿼리 실행

			while (rs.next()) { // 결과를 순화하며...
				// 한 행(댓글 하나)의 내용을 DTO에 저장
				CommentDTO dto = new CommentDTO();

				dto.setId(rs.getString("id")); // 작성자 아이디
				dto.setName(rs.getString("name")); // 작성자 이름
				dto.setNum(rs.getString("num")); // 게시글 번호
				dto.setCommentNum(rs.getString("commentNum")); // 댓글 번호
				dto.setContent(rs.getString("content")); // 내용
				dto.setPostdate(rs.getDate("postdate")); // 작성일

				bbs.add(dto); // 결과 목록에 저장
			}
		} catch (Exception e) {
			System.out.println("댓글 조회 중 예외 발생");
			e.printStackTrace();
		}
		return bbs;
	}

	// 등록된 댓글 수 조회
	public int commentCount() {

		int totalCount = 0; // 결과(댓글 수)를 담을 변수
		// 댓글 수를 얻어오는 쿼리문 작성
		String query = "SELECT COUNT(*) FROM board_comment";

		try {
			stmt = con.createStatement(); // 쿼리문 생성
			rs = stmt.executeQuery(query); // 쿼리 실행

			rs.next(); // 커서를 첫 번째 행으로 이동

			totalCount = rs.getInt(1); // 첫 번째 칼럼 값을 가져옴
		} catch (Exception e) {
			System.out.println("댓글 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}
}