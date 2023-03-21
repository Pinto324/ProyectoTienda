/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BaseDeDatos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import Objetos.ProductoDeCadaTienda;
import java.sql.ResultSet;

/**
 *
 * @author branp
 */
public class ProductosDeCadaTienda {
    private Conexion Con;
    private Connection Conn;
    private Envios envio = new Envios();
    public ProductosDeCadaTienda() {
    }
    public void CrearProducto(ProductoDeCadaTienda ProductoDCT){
        Con = new Conexion();
        Con.IniciarConexion();
        PreparedStatement ps;
        String sql;
        try {
            sql = "insert into ProductosDeCadaTienda (Id,CodigoDeTienda,CodigoDeProducto,Existencias) values (?,?,?,?);";
            Conn = Con.getConexion();
            ps = Conn.prepareStatement(sql);
            ps.setInt(1, ProductoDCT.getId());
            ps.setInt(2, ProductoDCT.getCodigoDeTienda());
            ps.setInt(3, ProductoDCT.getCodigoDeProducto());
            ps.setInt(4, ProductoDCT.getExistencias());
            ps.executeUpdate();          
            Con.CerrarConexiones();
            Conn.close();
        } catch (SQLException ex) {
        }
    }
    
        public String[] BuscarPorNombre(int CodDeProducto){
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM ProductosDeCadaTienda WHERE CodigoDeProducto='"+CodDeProducto+"';");
            String[] Carac = new String[3];
                if(BusquedaID.next()){
                    Carac[0] = String.valueOf(BusquedaID.getInt(2));
                    Carac[1] = String.valueOf(BusquedaID.getInt(3));
                    Carac[2] = String.valueOf(BusquedaID.getInt(4));
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
        
    public boolean revisarSiExiste(int CodDeProducto, int tienda){
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM ProductosDeCadaTienda WHERE CodigoDeProducto='"+CodDeProducto+"' AND CodigoDeTienda='"+tienda +"';");
            return BusquedaID.next();       
        } catch (SQLException ex) {
            return false;
        }
    }
    public void sumarExistenciasDeEnvioRecibido (int idEnvio) throws SQLException{
        try{
            Con = new Conexion();   
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM ListaDeProductosEnvios JOIN Productos ON ListaDeProductosEnvios.CodigoDelProducto = Productos.Codigo WHERE CodigoDelEnvio="+idEnvio+";");
            String Ssql = "UPDATE ProductosDeCadaTienda SET Existencias=? WHERE CodigoDeProducto=? AND CodigoDeTienda=?";
            String sql = "insert into ProductosDeCadaTienda (CodigoDeTienda,CodigoDeProducto,Existencias) values (?,?,?);";
            Conn = Con.getConexion();
            PreparedStatement ps;
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            int codTienda = Integer.parseInt(envio.BuscarPorIDSinFecha(idEnvio)[1]);
            while(BusquedaID.next()){
                //Si existe el producto se actualiza:
                if(revisarSiExiste(BusquedaID.getInt("CodigoDelProducto"),codTienda)){
                    int codigoProducto = BusquedaID.getInt("Codigo");
                    int ExistenciasNuevas = (BusquedaID.getInt("Existencias")+BusquedaID.getInt("Cantidad"));
                    cambio.setInt(1,ExistenciasNuevas);
                    cambio.setInt(2,codigoProducto);
                    cambio.setInt(3, codTienda);
                    cambio.executeUpdate();
                }else{
                    //si no existe el producto se crea:
                    ps = Conn.prepareStatement(sql);
                    ps.setInt(1, BusquedaID.getInt("CodigoDeTienda"));
                    ps.setInt(2, BusquedaID.getInt("CodigoDelProducto"));
                    ps.setInt(3, BusquedaID.getInt("Cantidad"));
                    ps.executeUpdate();          
                }
            }
            cambio.close();
            Conn.close();
            Con.CerrarConexiones();
        }catch(SQLException e){
            System.out.println(e);
        }catch(NullPointerException e){
            System.out.println(e);
        }
    }
}
