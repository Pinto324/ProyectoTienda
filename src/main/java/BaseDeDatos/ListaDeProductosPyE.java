/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BaseDeDatos;

import Objetos.ListaDeProductoPyE;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author branp
 */
public class ListaDeProductosPyE {
    private Conexion Con;
    private Connection Conn;
    public ListaDeProductosPyE(){
    }
     public void SubirProductoPedido(ListaDeProductoPyE Producto){
        Con = new Conexion();
        Con.IniciarConexion();
        PreparedStatement ps;
        String sql;
        try {
            sql = "insert into ListaDeProductosPedidos (IdDelSolicitante,CodigoDelProducto,Cantidad) values (?,?,?);";            
            Conn = Con.getConexion();
            ps = Conn.prepareStatement(sql);
            ps.setInt(1, Producto.getIdDelSolicitante());
            ps.setInt(2, Producto.getCodigoDelProducto());
            ps.setInt(3, Producto.getCantidad());
            ps.executeUpdate();      
            Con.CerrarConexiones();
            Conn.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }  
    }
    public void SubirProductoEnvio(ListaDeProductoPyE Producto){
        Con = new Conexion();
        Con.IniciarConexion();
        PreparedStatement ps;
        String sql;
        try {
            sql = "insert into ListaDeProductosEnvios (CodigoDelEnvio,CodigoDelProducto,Cantidad) values (?,?,?);";            
            Conn = Con.getConexion();
            ps = Conn.prepareStatement(sql);
            ps.setInt(1, Producto.getIdDelSolicitante());
            ps.setInt(2, Producto.getCodigoDelProducto());
            ps.setInt(3, Producto.getCantidad());
            ps.executeUpdate();      
            Con.CerrarConexiones();
            Conn.close();
        } catch (SQLException ex) {
            System.out.println(ex+"fail en envios");
        }
    }
    public boolean EliminarPorCodProductoEnvio(int ID, int pedido){
        try{
            Con = new Conexion();        
            Con.IniciarConexion();
            PreparedStatement Borrador = Con.getConexion().prepareStatement("delete from ListaDeProductosEnvios where CodigoDelProducto=? AND CodigoDelEnvio=?");
            Borrador.setInt(1, ID);
            Borrador.setInt(2, pedido);
            Borrador.executeUpdate();
            Con.CerrarConexiones();
            Borrador.close();
            return true;
        }catch(SQLException ex){
            System.out.println(ex);
            return false;
        }
    }
    public String[] BuscarPorIDyProductoEnvio(int ID, int IDproducto){
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM ListaDeProductosEnvios WHERE CodigoDelEnvio='"+ID+"' AND CodigoDelProducto='"+IDproducto+"';");
            String[] Carac = new String[2];
                if(BusquedaID.next()){
                    Carac[1] = String.valueOf(BusquedaID.getInt(4));
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
    public int BuscarPorIDEnvio(int ID, int producto){
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM ListaDeProductosEnvios WHERE CodigoDelEnvio="+ID+" AND CodigoDelProducto="+producto +";");
            int Carac;
            
                if(BusquedaID.next()){
                    Carac = BusquedaID.getInt(4);
                }else{
                    BusquedaID.close();
                    Con.CerrarConexiones();
                    return -1;
                }
                BusquedaID.close();
                Con.CerrarConexiones();
                return Carac;            
        } catch (SQLException ex) {
        }
        return -1;
    }
    public boolean ActualizarPedido(ListaDeProductoPyE Producto){
        try{
            Con = new Conexion();
            Con.IniciarConexion();
            String Ssql = "UPDATE ListaDeProductosEnvios SET Cantidad=? WHERE CodigoDelEnvio=? AND CodigoDelProducto=?";
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            cambio.setInt(1, Producto.getCantidad());
            cambio.setInt(2, Producto.getIdDelSolicitante());
            cambio.setInt(3, Producto.getCodigoDelProducto());
            cambio.executeUpdate();
            Con.CerrarConexiones();
            return true;
        }catch(SQLException e){
            return false;
        }
    }
    public boolean restarExistenciasDeEnvio (int idEnvio){
        try{
            Con = new Conexion();   
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM ListaDeProductosEnvios JOIN Productos ON ListaDeProductosEnvios.CodigoDelProducto = Productos.Codigo WHERE CodigoDelEnvio="+idEnvio+";");
            String Ssql = "UPDATE Productos SET Existencias=? WHERE Codigo=?";
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            while(BusquedaID.next()){
                int codigoProducto = BusquedaID.getInt("Codigo");
                int ExistenciasNuevas = (BusquedaID.getInt("Existencias")-BusquedaID.getInt("Cantidad"));
                cambio.setInt(1,ExistenciasNuevas);
                cambio.setInt(2,codigoProducto);
                cambio.executeUpdate();
            }
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
