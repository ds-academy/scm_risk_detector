<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String name = request.getParameter("name");
String[] fruits = request.getParameterValues("fruits");


out.println("<html><head><meta charset='UTF-8'></head><body>");
out.println("<h1>선호도 조사 결과</h1>");
out.println("<p>이름: " + name + "</p>");

out.println("<table border='1' style='width:50%; border-collapse: collapse;'>");
out.println("<tr><th>선호하는 과일</th></tr>");

if (fruits != null && fruits.length > 0) {
	
	for (String fruit : fruits) {
		out.println("<tr><td>" + fruit + "</td></tr>");
	}
} else {
	
	out.println("<tr><td>선택한 과일이 없습니다.</td></tr>");
}

out.println("</table>");
out.println("</body></html>");
%>