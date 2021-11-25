<%-- 
    Document   : index
    Created on : 22/10/2021, 09:43:17
    Author     : gabriel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="img/truck.png"/>
        <!--        <link rel="stylesheet" href="style.css"/>-->
        <title>Portfólio de Transportadoras</title>

        <style>
            body{
                width: 90%;
                margin: 0 auto;
                #transportadora, .Botao1{overflow: auto};
                #filtro, .Botao1 {
                    margin: 1%;
                }
                background-color: white;
                /*                max-width: 940px;
                                min-width: 720px;*/
                margin: 10px auto 10px auto;
                padding: 20px;
            }

            h2 {

            }

            .Botao1 {
                text-decoration: none;
                background-color: green;
                height: 40px; 
                color: #ffffff;
                margin-left: 700px; 
                margin-top: -47px;
                position: absolute;
                left: 200px;
            }

            .Botao1:hover{
                background-color: darkgreen;
            }

            .botao {
                text-decoration: none;
                color: #ffffff;
            }

            #transportadora{
                margin: auto;
                max-width: 940px;
                min-width: 720px;
                margin: 10px auto 10px auto;
                width: 10px;
                position: absolute;
                top: 250px;
                left: 400px;

            }

            #text-nome {
                text-decoration: none;
            }

            table {
                width: 600px;
            }

            td {
                border-bottom: 2px solid #ffffff; 
                text-align: right; 
            }

            #modal {
                text-align: left;
            }

            #loc-uf{
                text-decoration: none;
            }
            
            #loc-cidade{
                text-decoration: none;
            }
            
            #loc-modal{
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <%@page import="Model.DAO, Model.Transportadora, java.util.*"%>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
        <div id="filtro">
            <fieldset>
                <h1>Transportadoras</h1> <button type="button" class="Botao1">
                    <a href="addtransportadoraform.jsp" class="botao">Cadastre Sua Transportadora!</a>
                </button>
            </fieldset>
            <h2 class="h2">Transportadoras</h2>      
            <form action="/crudteste/inicio" method="GET">
                <h3>Nome</h3>
                <input type="text" name="nome" value="${param.nome}">
                <input type="submit" value="Pesquisar">
            </form>     
            <div id="filtragem">
                <h3>Localização(UFs)</h3>
                <c:forEach items="${lista}" var="uf">
                    <ul>
                        <li><a href="" id="loc-uf">${uf.getEstado()}</a></li>
                    </ul> 
                </c:forEach>
                <h3>Localização(Municípios)</h3>
                <c:forEach items="${lista}" var="cidade">
                    <ul>
                        <li><a href="" id="loc-cidade">${cidade.getCidade()}</a></li>
                    </ul>
                </c:forEach>
                <h3>Modal</h3>
                <c:forEach items="${lista}" var="modal">
                    <ul>   
                        <li><a href="" id="loc-modal">${modal.getModal()}</a></li>                 
                    </ul>
                </c:forEach>
            </div>
        </div>        
        <div id="transportadora">
            <fieldset>
                <table>
                    <c:forEach items="${lista}" var ="usuario">
                        <tr>
                            <td id="nome"><a href="editform.jsp?id=${usuario.getId()}" id="text-nome">${usuario.getNome()}</a> - </td><td id="modal">${usuario.getModal()}</td>
                            <td id="cnpj">${usuario.getCnpj()}</td>
                            <td>${usuario.getTelefone()}</td><td>${usuario.getCelular()}</td><td><p id="wpp">Fale Agora:</p>${usuario.getWhatsapp()}</td>
                            <td id="email">${usuario.getEmail()}</td>
        <!--                    <td><a href="editform.jsp?id=${usuario.getId()}">Editar</a></td>-->
        <!--                    <td><a href="deletar.jsp?id=${usuario.getId()}">Deletar</a></td>-->
                        </tr>
                    </c:forEach>
                </table>
            </fieldset>
        </div>       
    </body>
</html>
