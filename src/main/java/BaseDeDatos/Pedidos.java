/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BaseDeDatos;

import Objetos.Pedido;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * en esta clase vamos a hacer todos las conexiones a la base de datos
 */
public class Pedidos {  
    private Conexion Con;
    private Connection Connection;
    private ListaDeProductosPyE Lista;
    private Productos ListaProductos;
    private static final SimpleDateFormat FormatoFecha = new SimpleDateFormat("yyyy-MM-dd");
    public Pedidos() {

    }
    public void CrearPedido(Pedido pedido) throws ParseException{
        Con = new Conexion();
        Con.IniciarConexion();
        PreparedStatement ps;
        String sql;
        try {
            sql = "insert into Pedidos (Id,CodigoTienda,Usuario,Fecha,Total,Estado) values (?,?,?,?,?,?);";
            Connection = Con.getConexion();
            ps = Connection.prepareStatement(sql);
            ps.setInt(1, pedido.getId());
            ps.setInt(2, pedido.getCodigoDeTienda());
            ps.setString(3, pedido.getUsuario());
            ps.setDate(4, pedido.getFecha());
            ps.setDouble(5, pedido.getTotal());
            ps.setString(6, pedido.getEstado());
            ps.executeUpdate();          
            Con.CerrarConexiones();
            Connection.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }
    public String[] BuscarPorID(int ID){
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM Pedidos WHERE Id='"+ID+"';");
            String[] Carac = new String[6];
                if(BusquedaID.next()){
                    Carac[0] = String.valueOf(BusquedaID.getInt(1));
                    Carac[1] = String.valueOf(BusquedaID.getInt(2));
                    Carac[2] = BusquedaID.getString(3);
                    Carac[3] = FormatoFecha.format(BusquedaID.getDate(4));
                    Carac[4] = String.valueOf(BusquedaID.getDouble(5));
                    Carac[5] = BusquedaID.getString(6);
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
        
    public boolean modificarTotal(Pedido pedido){ 
        try{
            String[] Dato = BuscarPorID(pedido.getId());
            Con = new Conexion(); 
            Con.IniciarConexion();   
            Connection = Con.getConexion();
            String Ssql = "UPDATE Pedidos SET Total=? WHERE Id=?";
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            cambio.setDouble(1, (pedido.getTotal()+Double.parseDouble(Dato[4])));
            cambio.setInt(2, pedido.getId());
            cambio.executeUpdate();
            Con.CerrarConexiones();
            return true;
        }catch(SQLException e){
            System.out.println(e);
            return false;
        }
    }   
    public boolean modificarEstado(int codigoPedido, String Estado){ 
        try{
            Con = new Conexion(); 
            Con.IniciarConexion();   
            Connection = Con.getConexion();
            String Ssql = "UPDATE Pedidos SET Estado=? WHERE Id=?";
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            cambio.setString(1, Estado);
            cambio.setInt(2, codigoPedido);
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
    
    public boolean comprobarCodigoPedido(int CodigoPedido) throws SQLException{
        Con = new Conexion();
        ResultSet Tabla = Con.IniciarConexion().executeQuery("select * from Pedidos;");
        while (Tabla.next()){
            if(Tabla.getInt (1)==CodigoPedido){
                Con.CerrarConexiones();
                return false;
            }
        }
            Con.CerrarConexiones();
            return true;     
    }
    public boolean EliminarPorID(int ID){
        
        try{
            Con = new Conexion();        
            Con.IniciarConexion();
            PreparedStatement Borrador = Con.getConexion().prepareStatement("delete from Piezas where Id_Pieza='" + ID + "';");
            Borrador.executeUpdate();
            Con.CerrarConexiones();
            Borrador.close();
            return true;
        }catch(SQLException ex){
            return false;
        }
    }
    public boolean ModificarDatos(int ID, String Nombre, double Costo, int existencias){
        try{
            Con = new Conexion();
            Con.IniciarConexion();
            String Ssql = "UPDATE Piezas SET Nombre_Pieza=?,  Costo=?, existencias=? WHERE Id_Pieza=?";
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            cambio.setString(1, Nombre);
            cambio.setDouble(2, Costo);
            cambio.setInt(3, existencias);
            cambio.setInt(4, ID);
            cambio.executeUpdate();
            Con.CerrarConexiones();
            return true;
        }catch(SQLException e){
            return false;
        }
    }
    public int BuscarPiezaReciente(){
        Con = new Conexion();
        int Id = -1;
        try {
            ResultSet UltimoDato = Con.IniciarConexion().executeQuery("select * from Piezas order by Id_Pieza desc;");        
                if(UltimoDato.next()){
                    Id = UltimoDato.getInt(1);
                    return Id;
                }
        } catch (SQLException ex) {
        }
        return Id;
    }

        public int ExistenciasBuscarPorID(int ID){
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM Piezas WHERE Id_Pieza='"+ID+"';");
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
        return -2;
    }
    public boolean DescontarExistencias(int ID, int existencias){
        try{
            Con = new Conexion();
            Con.IniciarConexion();
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM Piezas WHERE Id_Pieza='"+ID+"';");
            int Carac;
                if(BusquedaID.next()){
                    Carac = BusquedaID.getInt(4);
                }else{
                    Carac = -1;
                }
                    if(Carac!= -1){
                        String Ssql = "UPDATE Piezas SET existencias=? WHERE Id_Pieza=?";
                        PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
                        cambio.setInt(1, (Carac-existencias));
                        cambio.setInt(2, ID);
                        cambio.executeUpdate();
                        Con.CerrarConexiones();
                        return true;
                    }
        }catch(SQLException e){
        }
        return false;
    }
}
