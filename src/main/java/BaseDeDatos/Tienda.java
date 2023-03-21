/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BaseDeDatos;

import Objetos.Pedido;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;

/**
 *
 * @author branp
 */
public class Tienda {
    private Conexion Con;
    private Connection Connection;

    public Tienda() {
    }
    
    public void CrearTienda(int codigo,String Nombre ,String Direc, String Tipo) throws ParseException{
        Con = new Conexion();
        Con.IniciarConexion();
        PreparedStatement ps;
        String sql;
        try {
            sql = "insert into Tienda (Codigo,Nombre,Direccion,Tipo) values (?,?,?,?);";
            Connection = Con.getConexion();
            ps = Connection.prepareStatement(sql);
            ps.setInt(1, codigo);
            ps.setString(2, Nombre);
            ps.setString(3, Direc);
            ps.setString(4, Tipo);
            ps.executeUpdate();          
            Con.CerrarConexiones();
            Connection.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }
}
