/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BaseDeDatos;

import Objetos.Usuario;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author branp
 */
public class Usuarios {
    private Conexion Con;
    private ResultSet Rs;
    private Connection Conn;
    public Usuarios() {
    }
    public boolean ComprobarContraseña(String Usuario, String contra) throws SQLException, NoSuchAlgorithmException{
        Con = new Conexion();
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        Rs = Con.IniciarConexion().executeQuery("select * from Usuarios WHERE UserName='"+Usuario+"';");
        if (Rs.next()) {
            String valorHashAlmacenado = Rs.getString("Password");
            byte[] valorHashCalculado = digest.digest(contra.getBytes());
            String valorHashCalculadoHex = bytesToHex(valorHashCalculado);
            return valorHashAlmacenado.equals(valorHashCalculadoHex);
        } else {
            return false;
        }
    }
    public boolean BuscarUserNameIgual(String UsuarioABuscar) throws SQLException{
        Con = new Conexion();
        Rs = Con.IniciarConexion().executeQuery("select * from Usuarios;");
        while (Rs.next()){
            if(Rs.getString (3).equals(UsuarioABuscar)){
                return false;
            }
        }
        Rs.close();
        Con.CerrarConexiones();
        return true;
    }
    public boolean BuscarCodigoIgual(int codigo) throws SQLException{
        Con = new Conexion();
        Rs = Con.IniciarConexion().executeQuery("select * from Usuarios;");
        while (Rs.next()){
            if(Rs.getInt (1)==codigo){
                return false;
            }
        }
        Rs.close();
        Con.CerrarConexiones();
        return true;
    }
    public int VerTiendaPorNick(String Nick){
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM usuarios WHERE UserName='"+Nick+"';");
            int CodigoTienda;
                if(BusquedaID.next()){  
                    CodigoTienda = BusquedaID.getInt(7);
                }else{
                    BusquedaID.close();
                    Con.CerrarConexiones();
                    return -1;
                }
                BusquedaID.close();
                Con.CerrarConexiones();
                return CodigoTienda;            
        } catch (SQLException ex) {
        }
        return -1;
    }
    public int VerCodigoPorNick(String Nick){
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM usuarios WHERE UserName='"+Nick+"';");
            int CodigoTienda;
                if(BusquedaID.next()){  
                    CodigoTienda = BusquedaID.getInt(1);
                }else{
                    BusquedaID.close();
                    Con.CerrarConexiones();
                    return -1;
                }
                BusquedaID.close();
                Con.CerrarConexiones();
                return CodigoTienda;            
        } catch (SQLException ex) {
        }
        return -1;
    }
    
    public String[] BuscarPorCodigo(int cod){
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM Usuarios WHERE Codigo='"+cod+"';");
            String[] Carac = new String[7];
                if(BusquedaID.next()){  
                Carac[0] = String.valueOf(BusquedaID.getInt (1));
                Carac[1] = BusquedaID.getString (2);
                Carac[2] = BusquedaID.getString (3);
                Carac[3] = BusquedaID.getString (4);
                Carac[4] = BusquedaID.getString (5);
                Carac[5] = BusquedaID.getString (6);
                Carac[6] = String.valueOf(BusquedaID.getInt (7));
                }else{
                    BusquedaID.close();
                    Con.CerrarConexiones();
                    return null;
                }
                BusquedaID.close();
                Con.CerrarConexiones();
                return Carac;            
        } catch (SQLException ex) {
        }
        return null;
    }
    
        public boolean CrearUsuario(Usuario user){
        Con = new Conexion();
        Con.IniciarConexion();
        PreparedStatement ps;
        String sql;
        try {
            sql = "insert into Usuarios (Codigo, Nombre, UserName, Password,Email,Tipo,CodigoDeTienda) values (?,?,?,?,?,?,?);";
            Conn = Con.getConexion();
            ps = Conn.prepareStatement(sql);
            ps.setInt(1, user.getCodigo());
            ps.setString(2, user.getNombre());
            ps.setString(3, user.getUserName());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getTipo());
            ps.setInt(7, user.getTienda());
            ps.executeUpdate();          
            Con.CerrarConexiones();
            Conn.close();
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }
    public String[] BuscarPorUsuario(String Nick){
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM Usuarios WHERE UserName='"+Nick+"';");
            String[] Carac = new String[7];
                if(BusquedaID.next()){  
                Carac[0] = String.valueOf(BusquedaID.getInt (1));
                Carac[1] = BusquedaID.getString (2);
                Carac[2] = BusquedaID.getString (3);
                Carac[3] = BusquedaID.getString (4);
                Carac[4] = BusquedaID.getString (5);
                Carac[5] = BusquedaID.getString (6);
                Carac[6] = String.valueOf(BusquedaID.getInt (7));
                }else{
                    BusquedaID.close();
                    Con.CerrarConexiones();
                    return null;
                }
                BusquedaID.close();
                Con.CerrarConexiones();
                return Carac;            
        } catch (SQLException ex) {
        }
        return null;
    }
    public boolean ModificarDatos(Usuario Nuevo){
        try{
            Con = new Conexion();
            Con.IniciarConexion();
            String Ssql = "UPDATE Usuarios SET Nombre=?, UserName=?, Password=?, Email=?, Tipo=?, CodigoDeTienda=? WHERE Codigo=?";
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            cambio.setString(1, Nuevo.getNombre());
            cambio.setString(2, Nuevo.getUserName());
            cambio.setString(3, Nuevo.getPassword());
            cambio.setString(4, Nuevo.getEmail());
            cambio.setString(5, Nuevo.getTipo());
            cambio.setInt(6, Nuevo.getTienda());
            cambio.setInt(7, Nuevo.getCodigo());
            cambio.executeUpdate();
            Con.CerrarConexiones();
            return true;
        }catch(SQLException e){
            return false;
        }
    }
    
    public boolean EliminarUsuario(int IdUsuario){
        try{
            Con = new Conexion();        
            Con.IniciarConexion();
            PreparedStatement Borrador = Con.getConexion().prepareStatement("delete from Usuarios where Codigo='" + IdUsuario + "';");
            Borrador.executeUpdate();
            Con.CerrarConexiones();
            Borrador.close();
            return true;
        }catch(SQLException ex){
            return false;
        }
    }
    
    public String EncriptarContraseña(String Contra) throws NoSuchAlgorithmException{
        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        byte[] valorHash = messageDigest.digest(Contra.getBytes());
        String valorHashHex = bytesToHex(valorHash);
        return valorHashHex;
    }
    
    private static String bytesToHex(byte[] bytes) {
        StringBuilder stringBuilder = new StringBuilder();
        for (byte b : bytes) {
            stringBuilder.append(String.format("%02x", b));
        }
        return stringBuilder.toString();
    }
}
