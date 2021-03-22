package users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.Database;

public class UsersDAO {
	UsersDTO user = new UsersDTO();
	//�α���
	public int login(String userID,String userPwd) {
		String sql = "select userPwd from users where userID = ?";
		Connection conn =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = Database.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPwd)) {
					return 1; //�α��� ����
				}else {
					return 0; //��й�ȣ Ʋ��
				}
			}
			return -1; //���̵� ����
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				Database.closeConnection();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -2; //�����ͺ��̽� ����
	}
	
	//ȸ������
	public int join(UsersDTO user) {
		String sql = "insert into users values(?,?,?,?,?,0,1)";
		Connection conn =null;
		PreparedStatement pstmt = null;
		try {
			conn = Database.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getUserID());
			pstmt.setString(3, user.getUserPwd());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserHash());
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				Database.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return -1; //ȸ�� ���� ����
	}
	
	//�̸���üũ
	public int getUserEmailChecked(String userID) {
		String sql = "select userEmailChecked from users where userID =?";
		Connection conn =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = Database.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("userEmailChecked").equals("0")) return 0;
				else return 1;
			}			
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				Database.closeConnection();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //�����ͺ��̽�����
	}
	//�̸��� ������
	public String getUserEmail(String userID) {
		String sql = "select userEmail from users where userID =?";
		Connection conn =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = Database.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				Database.closeConnection();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return null; //�����ͺ��̽� ����
	}
	
	public int setUserEmailChecked(String userID) {
		String sql = "update users set userEmailChecked = 1 where userID =? ";
		Connection conn =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = Database.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				Database.closeConnection();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return 0; //�����ͺ��̽� ����
	}
	
	public ArrayList<UsersDTO> getUsers(){
		String sql = "SELECT name,userID,USEREMAIL,USEREMAILCHECKED FROM users";
		ArrayList<UsersDTO> ar = new ArrayList<UsersDTO>();
		Connection conn =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = Database.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
			UsersDTO usersDto = new UsersDTO(
				rs.getString(1),
				rs.getString(2),
				rs.getString(3),
				rs.getInt(4)
			);
				ar.add(usersDto);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				Database.closeConnection();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return ar;
	}
	
	//���� ����
	public int deleteUser(String userID) {
		String sql = "DELETE FROM users WHERE userID=?";
		Connection conn =null;
		PreparedStatement pstmt = null;
		try {
			conn = Database.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				Database.closeConnection();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //�����ͺ��̽� ����
	}
}
