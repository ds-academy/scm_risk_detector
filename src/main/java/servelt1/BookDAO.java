package servelt1;

import java.sql.*;

public class BookDAO {
    private Connection conn;

  

    public boolean insertMember(BookDTO user) {
        String SQL = "INSERT INTO book_member (id, pw, nick, email, tel) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, user.getId());
            pstmt.setString(2, user.getPw());
            pstmt.setString(3, user.getNick());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getTel());
            return pstmt.executeUpdate() > 0; 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; 
    }

    public BookDTO getMember(String id) {
        String SQL = "SELECT * FROM book_member WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {                 return new BookDTO(
                    rs.getString("id"),
                    rs.getString("pw"),
                    rs.getString("nick"),
                    rs.getString("email"),
                    rs.getString("tel")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; 
    }
}
