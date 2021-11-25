<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adicionar</title>
    </head>
    <body>
        <%@page import="Model.DAO"%>
        <jsp:useBean id="u" class="Model.Transportadora"></jsp:useBean>
        <jsp:setProperty property="*" name="u"></jsp:setProperty>
        
        <%
            int i = DAO.salvarUsuario(u);
            
            if (i > 0){
                response.sendRedirect("addusuario-success.jsp");
            }else{
                response.sendRedirect("Error.jsp");
            }
        %>
    </body>
</html>
