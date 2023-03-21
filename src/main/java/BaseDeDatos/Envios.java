/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BaseDeDatos;

import Objetos.Envio;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author branp
 */
public class Envios {
    private Conexion Con;
    private Connection Connection;
    private ListaDeProductosPyE Lista = new ListaDeProductosPyE();
    private Productos ListaProductos = new Productos();
    private static final SimpleDateFormat FormatoFecha = new SimpleDateFormat("yyyy-MM-dd");
    public Envios() {

    }
    public void CrearEnvio(Envio envio) throws ParseException{
        Con = new Conexion();
        Con.IniciarConexion();
        PreparedStatement ps;
        String sql;
        try {
            sql = "insert into Envios (Id,CodigoTienda,PedidoVinculado,Usuario,FechaSalida,FechaRecibida,Total,Estado) values (?,?,?,?,?,?,?,?);";
            Connection = Con.getConexion();
            ps = Connection.prepareStatement(sql);
            ps.setInt(1, envio.getId());
            ps.setInt(2, envio.getCodigoDeTienda());
            ps.setInt(3, envio.getPedidoVinculado());
            ps.setString(4, envio.getUsuario());
            ps.setDate(5, envio.getFechaSalida());
            ps.setDate(6, envio.getFechaRecibido());
            ps.setDouble(7, envio.getTotal());
            ps.setString(8, envio.getEstado());
            ps.executeUpdate();          
            Con.CerrarConexiones();
            Connection.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }catch (NullPointerException ex) {
            System.out.println("esCrear");
            System.out.println(ex);
        }
    }
    public String[] BuscarPorIDSinFecha(int ID) throws SQLException{
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM Envios WHERE Id='"+ID+"';");
            String[] Carac = new String[6];
                if(BusquedaID.next()){
                    Carac[0] = String.valueOf(BusquedaID.getInt(1));
                    Carac[1] = String.valueOf(BusquedaID.getInt(2));
                    Carac[2] = String.valueOf(BusquedaID.getInt(3));
                    Carac[3] = BusquedaID.getString(4);
                    Carac[4] = String.valueOf(BusquedaID.getDouble(7));
                    Carac[5] = BusquedaID.getString(8);
                }else{
                    BusquedaID.close();
                    Con.CerrarConexiones();
                    return null;
                }
                BusquedaID.close();
                Con.CerrarConexiones();
                return Carac;            
        } catch (SQLException ex) {
            
        }catch(NullPointerException ex) {
            
        }finally {
            if (Con != null) {
                Con.CerrarConexiones();
            }
        }
        Con.CerrarConexiones();
        return null;
    }
        
    public boolean modificarTotal(Envio pedido){ 
        try{
            String[] Dato = BuscarPorIDSinFecha(pedido.getId());
            Con = new Conexion(); 
            Con.IniciarConexion();   
            Connection = Con.getConexion();
            String Ssql = "UPDATE Envios SET Total=? WHERE Id=?";
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            cambio.setDouble(1, (pedido.getTotal()+Double.parseDouble(Dato[4])));
            cambio.setInt(2, pedido.getId());
            cambio.executeUpdate();
            Con.CerrarConexiones();
            return true;
        }catch(SQLException e){
            return false;
        }catch(NullPointerException e){
            System.out.println(e);
        }
        return false;
    }
    
    public boolean modificarEstado(int codigoEnvio, String Estado){ 
        try{
            Con = new Conexion(); 
            Con.IniciarConexion();   
            Connection = Con.getConexion();
            String Ssql = "UPDATE Envios SET Estado=? WHERE Id=?";
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            cambio.setString(1, Estado);
            cambio.setInt(2, codigoEnvio);
            cambio.executeUpdate();
            Con.CerrarConexiones();
            return true;
        }catch(SQLException e){
            return false;
        }catch(NullPointerException e){
            System.out.println(e);
        }
        return false;
    }
    
    public boolean modificarUsuario(int codigoEnvio, String Usuario){
        try{
            Con = new Conexion(); 
            Con.IniciarConexion();   
            Connection = Con.getConexion();
            String Ssql = "UPDATE Envios SET Usuario=? WHERE Id=?";
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            cambio.setString(1, Usuario);
            cambio.setInt(2, codigoEnvio);
            cambio.executeUpdate();
            Con.CerrarConexiones();
            return true;
        }catch(SQLException e){
            return false;
        }catch(NullPointerException e){
            System.out.println(e);
        }
        return false;
    }
    public boolean ponerFecha(int codigoEnvio, String Fecha){ 
        try{
            java.util.Date utilDate = new java.util.Date();
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            Con = new Conexion(); 
            Con.IniciarConexion();   
            Connection = Con.getConexion();
            String Ssql = "UPDATE Envios SET "+Fecha+"=? WHERE Id=?";
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            cambio.setDate(1, sqlDate);
            cambio.setInt(2, codigoEnvio);
            cambio.executeUpdate();
            Con.CerrarConexiones();
            return true;
        }catch(SQLException e){
            return false;
        }catch(NullPointerException e){
            System.out.println(e);
        }
        return false;
    }
    public boolean comprobarCodigoEnvio(int codigo) throws SQLException{
        Con = new Conexion();
        ResultSet Tabla = Con.IniciarConexion().executeQuery("select * from Envios;");
        while (Tabla.next()){
            if(Tabla.getInt (1)==codigo){
                Con.CerrarConexiones();
                return true;
            }
        }
            Con.CerrarConexiones();
            return false;     
    }
    
    public boolean restarUnaParte (int id, double CantidadRestar){ 
        try{
            String[] Dato = BuscarPorIDSinFecha(id);
            Con = new Conexion(); 
            Con.IniciarConexion();   
            Connection = Con.getConexion();
            String Ssql = "UPDATE Envios SET Total=? WHERE Id=?";
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            cambio.setDouble(1, (Double.parseDouble(Dato[4])-(CantidadRestar)));
            cambio.setInt(2, id);
            cambio.executeUpdate();
            Con.CerrarConexiones();
            return true;
        }catch(SQLException e){
            return false;
        }catch(NullPointerException e){
            System.out.println(e);
            return false;
        }
    }
     public boolean restarTotal (int id, int codigo){ 
        try{
            String[] Dato = BuscarPorIDSinFecha(id);
            int DatosPedido = Lista.BuscarPorIDEnvio(id,codigo);
            double costo = Double.parseDouble(ListaProductos.BuscarPorCodigo(codigo)[2]);
            Double CantidadRestar = (costo * DatosPedido);
            Con = new Conexion(); 
            Con.IniciarConexion();   
            Connection = Con.getConexion();
            String Ssql = "UPDATE Envios SET Total=? WHERE Id=?";
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            cambio.setDouble(1, (Double.parseDouble(Dato[4])-CantidadRestar));
            cambio.setInt(2, id);
            cambio.executeUpdate();
            Con.CerrarConexiones();
            return true;
        }catch(SQLException e){
            return false;
        }catch(NullPointerException e){
            System.out.println(e);
            return false;
        }
    }
}
