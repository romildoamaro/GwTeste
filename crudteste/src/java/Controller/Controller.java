
package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Model.DAO;
import Model.Transportadora;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;


@WebServlet("/")
public class Controller extends HttpServlet {
    private static final long serialVersionUID = 1L;
DAO dao = new DAO();
Transportadora usuario = new Transportadora();

public Controller(){
    super();
}
      
    @Override
    protected void doGet (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        String action = request.getServletPath();
        System.out.println(action);
        switch (action) {
            case "/inicio":
                consultar(request, response);
                break;
                
            case "/update":
                editarTransportadora(request, response);
                break;
                
            case "/inserir":
                try {
                    novoCadastro(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
                }   break;
                
            case "/delete":
                try {
                    removerTransportadora(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
                }   break;
                
            case "/pesquisa":
                consultar(request, response);
                break;
                
            case "/filtroUf":
                buscarUf(request, response);
                break;
                 
            default:
                  transportadoras(request, response);
                break;
        }
    }
    
    //Listar Contatos
    protected void transportadoras(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException{
        //objeto q vai receber os dados javabeans
        List<Transportadora> lista = DAO.getAllUsuarios();
        
        request.setAttribute("lista", lista);
        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.forward(request, response);
    }
    
    //Novo contato
    protected void novoCadastro(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, SQLException{
        usuario.setEmail(request.getParameter("email"));
        usuario.setNome(request.getParameter("nome"));
        usuario.setCnpj(request.getParameter("cnpj"));
        usuario.setTelefone(request.getParameter("telefone"));
        usuario.setCelular(request.getParameter("celular"));
        usuario.setWhatsapp(request.getParameter("whatsapp"));
        usuario.setModal(request.getParameter("modal"));
        usuario.setCep(request.getParameter("cep"));
        usuario.setEstado(request.getParameter("estado"));
        usuario.setCidade(request.getParameter("cidade"));
        usuario.setBairro(request.getParameter("bairro"));
        usuario.setRua(request.getParameter("rua"));
        usuario.setNumero(request.getParameter("numero"));
        
        
        DAO.salvarUsuario(usuario);
        //redirecionar para o transportadora.jsp
        response.sendRedirect("lista");
        

    }        
    
//    protected void listarContato(HttpServletRequest request, HttpServletResponse response) 
//            throws IOException, ServletException{
//        String id = request.getParameter("id");
//        DAO.getAllUsuarios();
//        
//        request.setAttribute("id", usuario.getId());
//        request.setAttribute("email", usuario.getEmail());
//        request.setAttribute("nome", usuario.getNome());
//        request.setAttribute("cnpj", usuario.getCnpj());
//        request.setAttribute("telefone", usuario.getTelefone());
//        request.setAttribute("celular", usuario.getCelular());
//        request.setAttribute("whatsapp", usuario.getWhatsapp());
//        request.setAttribute("modal", usuario.getModal());
//        request.setAttribute("Cep", usuario.getCep());
//        request.setAttribute("Estado", usuario.getEstado());
//        request.setAttribute("cidade", usuario.getCidade());
//        request.setAttribute("bairro", usuario.getBairro());
//        request.setAttribute("rua", usuario.getRua());
//        request.setAttribute("numero", usuario.getNumero());
//        
//        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
//        rd.forward(request, response);
//        
//    }
    
        
    
    protected void editarTransportadora(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException{
        usuario.setId(request.getParameter("id"));
        usuario.setId(request.getParameter("email"));
        usuario.setId(request.getParameter("nome"));
        usuario.setId(request.getParameter("cnpj"));
        usuario.setId(request.getParameter("telefone"));
        usuario.setId(request.getParameter("celular"));
        usuario.setId(request.getParameter("whatsapp"));
        usuario.setId(request.getParameter("modal"));
        usuario.setId(request.getParameter("cep"));
        usuario.setId(request.getParameter("estado"));
        usuario.setId(request.getParameter("cidade"));
        usuario.setId(request.getParameter("bairro"));
        usuario.setId(request.getParameter("rua"));
        usuario.setId(request.getParameter("numero"));
        //Executar o metodo alterarContato
        DAO.updateTransportadora(usuario);
        
        response.sendRedirect("lista");
        
    }
    
     protected void consultar(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException{
        String pesquisa = request.getParameter("nome"); 
        List<Transportadora> listaTransportadoras = dao.pesquisar(pesquisa);
        
        request.setAttribute("lista", listaTransportadoras);
        
         System.out.println("Testar impressão"); 
               
        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.forward(request, response);
        
     }
     
     protected void buscarUf(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException{
        String busca = request.getParameter("estado"); 
        List<Transportadora> listaTransportadoras = dao.filtroBusca(busca);
        
        request.setAttribute("lista", listaTransportadoras);
        
         System.out.println("Testar impressão"); 
               
        RequestDispatcher rd = request.getRequestDispatcher("lista");
        rd.forward(request, response);
        
     }
    
    protected void removerTransportadora(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException, SQLException{
        System.out.println("id parameter: "+request.getParameter("id"));
        String id = request.getParameter("id");
        System.out.println("id: "+usuario.getId());
        usuario.setId(id);
        DAO.deletarUsuario(usuario);
        response.sendRedirect("lista");
    }
      

   
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    }

