
package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAO {
    public static Connection getConnection(){
        Connection con = null;
        
        try{
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/alura", 
                    "postgres", "B12alpha1@");
                        
        }catch(Exception e){
            System.out.println(e);
        }
        return con;
    }
    
    public static int salvarUsuario(Transportadora u){
       int status = 0;
       
       try{
           Connection con = getConnection();
           PreparedStatement ps = con.prepareStatement("INSERT INTO transportadora (nome, email, cnpj, telefone, celular, whatsapp, modal, cep, estado, cidade, bairro, rua, numero) "
                   + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)");
           ps.setString(1, u.getNome());
           ps.setString(2, u.getEmail());
           ps.setString(3, u.getCnpj());
           ps.setString(4, u.getTelefone());
           ps.setString(5, u.getCelular());
           ps.setString(6, u.getWhatsapp());
           ps.setString(7, u.getModal());
           ps.setString(8, u.getCep());
           ps.setString(9, u.getEstado());
           ps.setString(10, u.getCidade());
           ps.setString(11, u.getBairro());
           ps.setString(12, u.getRua());
           ps.setString(13, u.getNumero());
           status = ps.executeUpdate();
       }catch(SQLException e){
           System.out.println(e);
       }
       
       return status;
       
    }
    
    public static Transportadora getRegistroById(int id){
        Transportadora usuario = null;
        
        try{
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM transportadora WHERE id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                usuario = new Transportadora();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setEmail(rs.getString("email"));
                usuario.setCnpj(rs.getString("cnpj"));
                usuario.setTelefone(rs.getString("telefone"));
                usuario.setCelular(rs.getString("celular"));
                usuario.setWhatsapp(rs.getString("whatsapp"));
                usuario.setModal(rs.getString("modal"));
                usuario.setCep(rs.getString("cep"));
                usuario.setEstado(rs.getString("estado"));
                usuario.setCidade(rs.getString("cidade"));
                usuario.setBairro(rs.getString("bairro"));
                usuario.setRua(rs.getString("rua"));
                usuario.setNumero(rs.getString("numero"));
                
            }
        }catch(SQLException e){
            System.out.println(e);
        }
       
        return usuario;
    }
    
    public static int updateTransportadora(Transportadora u){
        int status = 0;
        
        try{
            Connection con = getConnection();
            PreparedStatement ps = (PreparedStatement) con.prepareStatement("UPDATE transportadora SET nome=?, "
                    + "email=?, cnpj=?, telefone=?, celular=?, whatsapp=?, modal=?, "
                    + "cep=?, estado=?, cidade=?, bairro=?, rua=?, numero=? WHERE id=?");
            ps.setString(1, u.getNome());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getCnpj());
            ps.setString(4, u.getTelefone());
            ps.setString(5, u.getCelular());
            ps.setString(6, u.getWhatsapp());
            ps.setString(7, u.getModal());
            ps.setString(8, u.getCep());
            ps.setString(9, u.getEstado());
            ps.setString(10, u.getCidade());
            ps.setString(11, u.getBairro());
            ps.setString(12, u.getRua());
            ps.setString(13, u.getNumero());            
            ps.setInt(14, u.getId());
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }
        
        return status;
    }
    
    public static List<Transportadora> getAllUsuarios(){
        List<Transportadora> list = new ArrayList<>();
        
        try{
            Connection con = getConnection();
            PreparedStatement ps = (PreparedStatement) con.prepareStatement("SELECT * FROM transportadora");
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                Transportadora usuario = new Transportadora();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setEmail(rs.getString("email"));
                usuario.setCnpj(rs.getString("cnpj"));
                usuario.setTelefone(rs.getString("telefone"));
                usuario.setCelular(rs.getString("celular"));
                usuario.setWhatsapp(rs.getString("whatsapp"));
                usuario.setModal(rs.getString("modal"));
                usuario.setCep(rs.getString("cep"));
                usuario.setEstado(rs.getString("estado"));
                usuario.setCidade(rs.getString("cidade"));
                usuario.setBairro(rs.getString("bairro"));
                usuario.setRua(rs.getString("rua"));
                usuario.setNumero(rs.getString("numero"));



                list.add(usuario);                
            }
        }catch(SQLException e){
            System.out.println(e);
        }
        return list;
    }
    
    public static int deletarUsuario(Transportadora u){
        int status = 0;
        
        try{
            Connection con = getConnection();
            PreparedStatement ps = (PreparedStatement) con.prepareStatement("DELETE FROM transportadora WHERE id=?");
            ps.setInt(1, u.getId());
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }
        
        return status;
        
    }
    
    public List<Transportadora> pesquisar(String pesquisa){
        List<Transportadora> list = new ArrayList<>();
        
        try{
            Connection con = getConnection();
            String consulta = "SELECT * FROM transportadora WHERE nome LIKE ?";            
            PreparedStatement ps = (PreparedStatement) con.prepareStatement(consulta);
            ps.setString(1, "%" + pesquisa + "%");
            ResultSet rs = ps.executeQuery();
            System.out.println("Teste");
            
            
            while(rs.next()){
                Transportadora usuario = new Transportadora();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setEmail(rs.getString("email"));
                usuario.setCnpj(rs.getString("cnpj"));
                usuario.setTelefone(rs.getString("telefone"));
                usuario.setCelular(rs.getString("celular"));
                usuario.setWhatsapp(rs.getString("whatsapp"));
                usuario.setModal(rs.getString("modal"));
                usuario.setCep(rs.getString("cep"));
                usuario.setEstado(rs.getString("estado"));
                usuario.setCidade(rs.getString("cidade"));
                usuario.setBairro(rs.getString("bairro"));
                usuario.setRua(rs.getString("rua"));
                usuario.setNumero(rs.getString("numero"));



                list.add(usuario);                
            }
        }catch(SQLException e){
            System.out.println(e);
        }
        return list;
    }
    
     public List<Transportadora> filtroBusca(String busca){
        List<Transportadora> list = new ArrayList<>();
        
        try{
            Connection con = getConnection();
            String filtrar = "SELECT * FROM transportadora WHERE estado LIKE ?";            
            PreparedStatement ps = (PreparedStatement) con.prepareStatement(filtrar);
            ps.setString(1, "%" + busca + "%");
            ResultSet rs = ps.executeQuery();
            System.out.println("Teste");
            
            
            while(rs.next()){
                Transportadora usuario = new Transportadora();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setEmail(rs.getString("email"));
                usuario.setCnpj(rs.getString("cnpj"));
                usuario.setTelefone(rs.getString("telefone"));
                usuario.setCelular(rs.getString("celular"));
                usuario.setWhatsapp(rs.getString("whatsapp"));
                usuario.setModal(rs.getString("modal"));
                usuario.setCep(rs.getString("cep"));
                usuario.setEstado(rs.getString("estado"));
                usuario.setCidade(rs.getString("cidade"));
                usuario.setBairro(rs.getString("bairro"));
                usuario.setRua(rs.getString("rua"));
                usuario.setNumero(rs.getString("numero"));



                list.add(usuario);                
            }
        }catch(SQLException e){
            System.out.println(e);
        }
        return list;
    }
    
    
//    public static List<Transportadora> getRecords(int start, int total){
//        List<Transportadora> list = new ArrayList<Transportadora>();
//        
//        try{
//            Connection con = getConnection();
//            PreparedStatement ps = con.prepareStatement("SELECT * FROM LIMIT" + (start) + ","+total);
//            ResultSet rs = ps.executeQuery();
//            
//            while(rs.next()){
//                Transportadora usuario = new Transportadora();
//                usuario.setId(rs.getInt("id"));
//                usuario.setNome(rs.getString("nome"));
//                usuario.set(rs.getString("password"));
//                usuario.setEmail(rs.getString("email"));
//                usuario.setSexo(rs.getString("sexo"));
//                usuario.setPais(rs.getString("pais"));
//                list.add(usuario);
//            }
//            con.close();
//        }catch(Exception e){
//            System.out.println(e);
//        }
//        return list;
//    }


    }
    

