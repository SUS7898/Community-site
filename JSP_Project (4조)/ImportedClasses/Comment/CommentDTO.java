package Comment;

import java.sql.Date;

public class CommentDTO {

	private String id;          // 댓글 작성자 아이디
	private String name;        // 댓글 작성자 이름
	private String num;         // 게시글 번호
	private String commentNum;  // 댓글 번호
	private String content;     // 댓글 내용
	private Date postdate;      // 댓글 작성일

	public String getId() {
		
		return id;
	}

	public void setId(String id) {
		
		this.id = id;
	}

	public String getName() {
		
		return name;
	}

	public void setName(String name) {
		
		this.name = name;
	}

	public String getNum() {
		
		return num;
	}

	public void setNum(String num) {
		
		this.num = num;
	}

	public String getCommentNum() {
		
		return commentNum;
	}

	public void setCommentNum(String commentNum) {
		
		this.commentNum = commentNum;
	}

	public String getContent() {
		
		return content;
	}

	public void setContent(String content) {
		
		this.content = content;
	}

	public Date getPostdate() {
		
		return postdate;
	}

	public void setPostdate(Date postdate) {
		
		this.postdate = postdate;
	}
}