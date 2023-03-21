/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BaseDeDatos;

import Objetos.Producto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author branp
 */
public class Productos {
    private Conexion Con;
    private Connection Conn;
    public Productos(){
    }
     public void CrearProducto(Producto Producto){
        Con = new Conexion();
        Con.IniciarConexion();
        PreparedStatement ps;
        String sql;
        try {
            sql = "insert into Productos (Codigo,Nombre,Costo,Precio,Existencias) values (?,?,?,?,?);";
            Conn = Con.getConexion();
            ps = Conn.prepareStatement(sql);
            ps.setInt(1, Producto.getCodigo());
            ps.setString(2, Producto.getNombre());
            ps.setDouble(3, Producto.getPrecio());
            ps.setDouble(4, Producto.getPrecio());
            ps.setInt(5, Producto.getExistencias());
            ps.executeUpdate();          
            Con.CerrarConexiones();
            Conn.close();
        } catch (SQLException ex) {
        }
    }
    public String[] BuscarPorCodigo(int Codigo){
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM Productos WHERE Codigo='"+Codigo+"';");
            String[] Carac = new String[5];
                if(BusquedaID.next()){
                    Carac[0] = String.valueOf(BusquedaID.getInt(1));
                    Carac[1] = BusquedaID.getString(2);
                    Carac[2] = String.valueOf(BusquedaID.getDouble(3));
                    Carac[3] = String.valueOf(BusquedaID.getDouble(4));
                    Carac[4] = String.valueOf(BusquedaID.getInt(5));  
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
    public String[] BuscarPorNombre(String Nombre){
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM Productos WHERE Nombre='"+Nombre+"';");
            String[] Carac = new String[5];
                if(BusquedaID.next()){
                    Carac[0] = String.valueOf(BusquedaID.getInt(1));
                    Carac[1] = BusquedaID.getString(2);
                    Carac[2] = String.valueOf(BusquedaID.getDouble(3));
                    Carac[3] = String.valueOf(BusquedaID.getDouble(4));
                    Carac[4] = String.valueOf(BusquedaID.getInt(5));    
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
         
    /**
 *
 * @author branp
 */
    public boolean ComprobarPieza(String Nombre,double Costo) throws SQLException{
        Con = new Conexion();
        ResultSet Tabla = Con.IniciarConexion().executeQuery("select * from Piezas;");
        boolean llave = false;
        while (Tabla.next()){
            if(!(Tabla.getString (2).equals(Nombre))&&!(Tabla.getString(3).equals(Costo))){                
            }else{
                Con.CerrarConexiones();
                llave = true;
            }
        }
        if(llave){
            Con.CerrarConexiones();
            return false;
        }else{
            Con.CerrarConexiones();
            return true;
        }     
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
}

