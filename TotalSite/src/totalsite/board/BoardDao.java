package totalsite.board;

import java.sql.*;
import java.util.Vector;

import dbcp.DBConnectionMgr;

public class BoardDao {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	
	public BoardDao(){
		try{
			pool = DBConnectionMgr.getInstance();
		}
		catch(Exception err){
			System.out.println("BoardDao() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
	}
	// 전체 글 가져오기
	public Vector getBoardList(String keyFiled, String keyWord){
		Vector v = new Vector();
		String sql;
		try{
			if(keyWord == null || keyWord.isEmpty() || keyWord.equals("null")){
				sql = "select * from tblboard order by num desc";
			}
			else{
				sql = "select * from tblboard where "
						+ keyFiled + " like '%" + keyWord + "%' order by num desc";
			}
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				BoardDto dto = new BoardDto();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setHomepage(rs.getString("homepage"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPass(rs.getString("pass"));
				dto.setCount(rs.getInt("count"));
				dto.setIp(rs.getString("ip"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setPos(rs.getInt("pos"));
				dto.setDepth(rs.getInt("depth"));
				v.add(dto);
			}
		}
		catch(Exception err){
			System.out.println("getBoardList() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
		return v;
	}
	// 글 저장하기
	public void insertBoard(BoardDto dto){
		String sql;
		try{
			sql = "insert into tblboard values(seq_num.nextVal,?,?,?,?,?,?,0,?,sysdate,0,0)";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getHomepage());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setString(6, dto.getPass());
			pstmt.setString(7, dto.getIp());
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("insertBoard() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt);
		}
	}
	// 선택한 글 한 개 불러오기
	public BoardDto getBoard(int num){
		BoardDto dto = new BoardDto();
		String sql = "";
		try{
			// 조회수 증가
			sql = "update tblboard set count=count+1 where num=?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select * from tblboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setSubject(rs.getString("subject"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setHomepage(rs.getString("homepage"));
				dto.setIp(rs.getString("ip"));
				dto.setCount(rs.getInt("count"));
				dto.setContent(rs.getString("content"));
				
				dto.setPass(rs.getString("pass"));
			}
		}
		catch(Exception err){
			System.out.println("getBoard() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
		return dto;
	}
	// 글 수정
	public void updateBoard(BoardDto dto){
		String sql = "";
		try{
			sql = "update tblboard set name=?, email=?, subject=?,"
					+ " content=? where num=?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getNum());
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("updateBoard() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt);
		}
	}
	// 글 삭제
	public void deleteBoard(int num){
		try{
			String sql = "delete from tblboard where num=?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("deleteBoard() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt);
		}
	}
}