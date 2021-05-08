package image;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUser;

public class ImageDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public ImageDAO() {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			DBUser DBuser = new DBUser();

			conn = DriverManager.getConnection(DBuser.dbURL, DBuser.dbID, DBuser.dbPassword);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//파일 업로드
	public int upload(int bbsID, String bbsType, String fileName, String fileRealName) { 
		String SQL = "INSERT INTO image VALUES(?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setString(2, bbsType);
			pstmt.setString(3, fileName);
			pstmt.setString(4, fileRealName);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}

	public ImageDTO getFile(int bbsID, String bbsType) {
		String SQL = "SELECT * FROM image WHERE bbsID = ? AND bbsType = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setString(1, bbsType);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				ImageDTO imageDto = new ImageDTO();
				imageDto.setBbsID(rs.getInt(1));
				imageDto.setBbsType(rs.getString(2));
				imageDto.setFileName(rs.getString(3));
				imageDto.setFileRealName(rs.getString(4));
				return imageDto;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;

	}
}