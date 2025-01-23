package servelt1;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginCon")
public class LoginCon extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");

        BookDAO dao = new BookDAO();
        BookDTO user = dao.getMember(id);

        if (user != null && user.getPw().equals(pw)) {
            HttpSession session = request.getSession();
            session.setAttribute("id", id);
            session.setAttribute("nickname", user.getNick());
            response.sendRedirect("Main2.jsp");
        } else {
            response.sendRedirect("Login.jsp");
        }
    }
}
