<%@page import="Model.DAO"%>
<jsp:useBean id="u" class="Model.Transportadora"></jsp:useBean>
<jsp:setProperty property="*" name="u"/>

<%
    int i = DAO.updateTransportadora(u);
    response.sendRedirect("index.jsp");
%>