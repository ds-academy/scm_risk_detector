package servelt1;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/JoinCon")
public class JoinCon extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String nick = request.getParameter("nick");
        String email = request.getParameter("email");
        String tel = request.getParameter("tel");

        BookDTO newUser = new BookDTO(id, pw, nick, email, tel);
        BookDAO dao = new BookDAO();

        if (dao.insertMember(newUser)) {
            response.sendRedirect("Login.jsp");
        } else {
            response.sendRedirect("Join.jsp");
        }
    }
}
