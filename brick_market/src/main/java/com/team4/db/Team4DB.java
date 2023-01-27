package com.team4.db;

import java.sql.Connection;
import javax.sql.*;
import javax.naming.*;


public class Team4DB {
	static DataSource ds;
	
	static {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConn() throws Exception {
		return ds.getConnection();
	}
	
}
