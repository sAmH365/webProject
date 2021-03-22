package recommend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import util.Database;

public class RecommendDAO {
	//추천 등록
	public int addReco(int postNum, String userID) {
		String sql="insert into recommend values(?,?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = Database.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, postNum);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			
		}finally {
			try {
				Database.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return -1; // 추천 중복
	}
	
}//edn RecommendDAO
