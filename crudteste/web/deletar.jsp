<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@page import="Model.DAO"%>
        <jsp:useBean id="u" class="Model.Transportadora"></jsp:useBean>
        <jsp:setProperty property="*" name="u"></jsp:setProperty>
        
        <%
            DAO.deletarUsuario(u);
            response.sendRedirect("lista");
        %>
                     
    </body>
</html>
