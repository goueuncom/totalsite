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
	// ��ü �� ��������
	public Vector getBoardList(String keyFiled, String keyWord){
		Vector v = new Vector();
		String sql;
		try{
			if(keyWord == null || keyWord.isEmpty() || keyWord.equals("null")){
				sql = "select * from tblboard order by pos";
			}
			else{
				sql = "select * from tblboard where "
						+ keyFiled + " like '%" + keyWord + "%' order by pos";
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
				dto.setFilename("filename");
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
	// �� �����ϱ�
	public void insertBoard(BoardDto dto){
		String sql;
		try{
			sql = "update tblboard set pos=pos+1";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
			sql = "insert into tblboard values(seq_num.nextVal,?,?,?,?,?,?,0,?,sysdate,0,0,?)";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getHomepage());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setString(6, dto.getPass());
			pstmt.setString(7, dto.getIp());
			pstmt.setString(8, dto.getFilename());
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("insertBoard() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt);
		}
	}
	// ������ �� �� �� �ҷ�����
	public BoardDto getBoard(int num){
		BoardDto dto = new BoardDto();
		String sql = "";
		try{
			// ��ȸ�� ����
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
				dto.setPos(rs.getInt("pos"));
				dto.setDepth(rs.getInt("depth"));
				dto.setFilename(rs.getString("filename"));
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
	// �� ����
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
	// �� ����
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
	// ���� ���� pos�� ����
	public void replyUpdatePos(BoardDto dto){
		String sql = null;
		try{
			sql = "update tblboard set pos=pos+1 where pos > ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getPos());
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("replyUpdatePos() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt);
		}
	}
	// �亯
	public void replyBoard(BoardDto dto){
		String sql = null;
		try{
			sql = "insert into tblboard values(seq_num.nextVal,?,?,?,?,?,?,0,?,sysdate,?,?)";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getHomepage());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setString(6, dto.getPass());
			pstmt.setString(7, dto.getIp());
			pstmt.setInt(8, dto.getPos()+1);
			pstmt.setInt(9, dto.getDepth()+1);
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("replyBoard() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt);
		}
	}
	// �鿩 ����
	public String useDepth(int depth){
		String result = "";
		for(int i=0; i<depth*3; i++){
			result += "&nbsp;";
		}
		return result;
	}
}