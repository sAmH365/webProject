package evaluation;

import java.sql.Connection;   
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.Database;



public class EvaluationDAO {
	//지점 세팅
	public ArrayList<String> setStoreList(String area)  {
		String sql = "SELECT title FROM storelist WHERE storelist.area = ? ORDER BY title asc";
		ArrayList<String> ar = new ArrayList<String>();
		Connection conn =null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
		conn=Database.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, area);
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			ar.add(rs.getString("TITLE"));
		}
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				Database.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return ar;
	}
	
	//평가 등록
	public int registerEvaluation(EvaluationDTO evaluation) {
		String sql="INSERT INTO EVALUATION values(seq_postNum.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = Database.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, evaluation.getArea());
			pstmt.setString(2, evaluation.getAddress());
			pstmt.setString(3, evaluation.getStoreTitle());
			pstmt.setString(4, evaluation.getTitle());
			pstmt.setString(5, evaluation.getUserID());
			pstmt.setString(6, evaluation.getContent());
			pstmt.setString(7, evaluation.getPurpose());
			pstmt.setDouble(8, evaluation.getTaste());
			pstmt.setDouble(9, evaluation.getMood());
			pstmt.setDouble(10, evaluation.getKind());
			pstmt.setDouble(11, evaluation.getFacility());
			pstmt.setDouble(12, evaluation.getTotalScore());
			pstmt.setInt(13, evaluation.getRecoCount());
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				Database.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return -1; //데이터베이스 오류
	}
	//유저아이디찾기
	public String getUserID(String postNum) {
		String sql = "select userid from evaluation where postNum =?";
		Connection conn =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = Database.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, postNum);
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
		return null; //존재하지 않는 아이디
	}
	//주소 찾기
		public String getAddress(String storeTitle) {
			String sql="SELECT ADDRESS FROM storelist WHERE storelist.title = ?";
			String address="a";
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = Database.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, storeTitle);
							
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					address = rs.getString(1);
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
					Database.closeConnection();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			return address;
		}
	//지역 세팅
	public String getArea(String storeTitle) {
		String sql="SELECT area FROM STORELIST WHERE storelist.TITLE =?";
		String area="a";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = Database.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, storeTitle);
						
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				area = rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				Database.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return area;
	}
	
	//리스트불러오기
	
	public ArrayList<EvaluationDTO> getList(int pageNum){
		String sql = "SELECT * FROM(SELECT * FROM"
				+ "(SELECT rownum rnum, a.* FROM (SELECT * FROM EVALUATION ORDER BY POSTNUM desc) a )WHERE rnum <="+pageNum*5+")"
						+ " WHERE rnum>="+(5*pageNum-4);
		ArrayList<EvaluationDTO> ar = new ArrayList<EvaluationDTO>();
		Connection conn =null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
		conn=Database.getConnection();
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			EvaluationDTO evaluation = new EvaluationDTO(
					rs.getInt(1),
					rs.getInt(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getString(6),
					rs.getString(7),
					rs.getString(8),
					rs.getString(9),
					rs.getDouble(10),
					rs.getDouble(11),
					rs.getDouble(12),
					rs.getDouble(13),
					rs.getDouble(14),
					rs.getInt(15)
					);

			ar.add(evaluation);
		}
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				Database.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return ar;
		
	}
	
	public ArrayList<EvaluationDTO> getList(int pageNum, String search){
		String sql = "SELECT * FROM("
				+ "SELECT * FROM("
				+ "SELECT rownum rnum, a.* FROM ("
				+ "SELECT * FROM EVALUATION WHERE concat(concat(concat(concat(concat(address, storeTitle),title),userID),content),PURPOSE) "
				+ "LIKE ? ORDER BY POSTNUM desc) a )"
				+ "WHERE rnum <="+pageNum*5+") WHERE rnum>="+(5*pageNum-4);
		ArrayList<EvaluationDTO> ar = new ArrayList<EvaluationDTO>();
		Connection conn =null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
		conn=Database.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setNString(1, "%"+search+"%");
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			EvaluationDTO evaluation = new EvaluationDTO(
					rs.getInt(1),
					rs.getInt(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getString(6),
					rs.getString(7),
					rs.getString(8),
					rs.getString(9),
					rs.getDouble(10),
					rs.getDouble(11),
					rs.getDouble(12),
					rs.getDouble(13),
					rs.getDouble(14),
					rs.getInt(15)
					);

			ar.add(evaluation);
		}
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				Database.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return ar;
		
	}
	
	
	public int deleteEvaluation(String postNum) {
		String sql ="DELETE FROM EVALUATION WHERE postNum = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = Database.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, postNum);
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				Database.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return -1; //DB오류
	}
	//리스트 총개수
	public int getTotalList(String search) {
		String sql="SELECT count(*) FROM(SELECT * FROM EVALUATION WHERE concat(concat(concat(concat(concat(address, storeTitle),title),userID),content),PURPOSE) LIKE ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = Database.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setNString(1, "%"+search+"%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getInt("COUNT(*)");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				Database.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return -2; // 데이터베이스오류
	}
	
	//추천
	public int recommend(int postNum) {
		PreparedStatement pstmt = null;
		Connection conn =null;
		try {
			conn = Database.getConnection();
			String sql = "UPDATE EVALUATION SET recoCount = recoCount + 1 WHERE postNum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,postNum);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				Database.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	
		return -1;
	}
	
	//수정
	public ArrayList<EvaluationDTO> getModifyList(int postNum) {
		PreparedStatement pstmt = null;
		Connection conn =null;
		ResultSet rs = null;
		ArrayList<EvaluationDTO> ar = new ArrayList<EvaluationDTO>();
		try {
			conn = Database.getConnection();
			String sql = "SELECT * FROM EVALUATION WHERE postnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,postNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				EvaluationDTO dto = new EvaluationDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getDouble(9),
						rs.getDouble(10),
						rs.getDouble(11),
						rs.getDouble(12),
						rs.getDouble(13),
						rs.getInt(14)
						);
				ar.add(dto);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				Database.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	
		return ar;
	}
	public int modify(EvaluationDTO evaluation) {
		String sql="UPDATE EVALUATION SET TITLE =? , content= ?, purpose= ?," + 
				"taste=?, mood=?, kind=?, facility=?, TOTALSCORE =?" + 
				"WHERE postNum=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = Database.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, evaluation.getTitle());
			pstmt.setString(2, evaluation.getContent());
			pstmt.setString(3, evaluation.getPurpose());
			pstmt.setDouble(4, evaluation.getTaste());
			pstmt.setDouble(5, evaluation.getMood());
			pstmt.setDouble(6, evaluation.getKind());
			pstmt.setDouble(7, evaluation.getFacility());
			pstmt.setDouble(8, evaluation.getTotalScore());
			pstmt.setInt(9, evaluation.getPostNum());
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				Database.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return -1; //데이터베이스 오류
	}
}
