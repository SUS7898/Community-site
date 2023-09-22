package CafeBoard;

import java.sql.*;

public class CafeBoardDTO {

	private String id;          // 작성자 아이디 (외래키 참조)
	private String title;       // 게시물 제목
	private String num;         // 게시물 번호
	private String content;     // 게시물 내용
	private String visitcount;  // 게시물 조회수
	private String love;        // 게시물 좋아요
	private Date postdate;      // 게시글 작성일
	private String category;
	private String fileName;

	public String getCategory() {
		
		return category;
	}

	public void setCategory(String category) {
		
		this.category = category;
	}

	public String getId() {
		
		return id;
	}

	public void setId(String id) {
		
		this.id = id;
	}
	
	public String getTitle() {
		
		return title;
	}

	public void setTitle(String title) {
		
		this.title = title;
	}

	public String getNum() {
		
		return num;
	}

	public void setNum(String num) {
		
		this.num = num;
	}

	public String getContent() {
		
		return content;
	}

	public void setContent(String content) {
		
		this.content = content;
	}

	public String getVisitcount() {
		
		return visitcount;
	}

	public void setVisitcount(String visitcount) {
		
		this.visitcount = visitcount;
	}

	public String getLove() {
		
		return love;
	}

	public void setLove(String love) {
		
		this.love = love;
	}

	public Date getPostdate() {
		
		return postdate;
	}

	public void setPostdate(Date postdate) {
		
		this.postdate = postdate;
	}
	
	public String getFileName() {
		
        return fileName;
    }

    public void setFileName(String fileName) {
    	
        this.fileName = fileName;
    }
}