package servelt1;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/LoginCheck") // 
public class LoginCheck extends HttpServlet {
    private static final long serialVersionUID = 1L;

 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

       
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        
        if ("smart".equals(username) && "1234".equals(password)) {
            
            HttpSession session = request.getSession();
            session.setAttribute("username", username);

          
            response.sendRedirect("main.jsp");
        } else {
           
            response.sendRedirect("loginForm.html");
        }
    }
}
