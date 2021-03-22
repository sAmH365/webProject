package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Database {
	static Connection conn =null;
	static PreparedStatement pstmt = null;
	static ResultSet rs = null;
	
	public static Connection getConnection() throws NamingException, SQLException {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
		conn = ds.getConnection();
		
		return conn;
	}
	
	public static void closeConnection() throws SQLException {
		if(conn !=null) conn.close();
		if(pstmt != null)pstmt.close();
		if(rs != null)rs.close();
	}
}
