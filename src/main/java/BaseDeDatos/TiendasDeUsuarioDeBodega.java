/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BaseDeDatos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author branp
 */
public class TiendasDeUsuarioDeBodega {
    private Conexion Con;
    private ResultSet Rs;
    private Connection Conn;
    
    public String CadenaParaLasTiendas(int CodigoDelBodega) throws SQLException{
        Con = new Conexion();
        Rs = Con.IniciarConexion().executeQuery("select * from TiendasDeUsuariosDeBodega WHERE CodigoDeEncargado='"+CodigoDelBodega+"';");
        String Cadena = "";
        while (Rs.next()){
             Cadena += "CodigoTienda='"+Rs.getInt(3) + "' OR";
        }
        String nuevaCadena = "";
        if(Cadena.length() > 3){
        nuevaCadena = Cadena.substring(0, Cadena.length() - 3);
        nuevaCadena+=";";
        }else{
        nuevaCadena = "1=0";
        }
        Rs.close();
        Con.CerrarConexiones();
        return nuevaCadena;
    }
       public boolean EliminarTienda(int IdUsuario, int IdTienda){
        try{
            Con = new Conexion();        
            Con.IniciarConexion();
            PreparedStatement Borrador = Con.getConexion().prepareStatement("delete from TiendasDeUsuariosDeBodega where CodigoDeEncargado='" + IdUsuario + "' AND CodigoDeTienda='"+IdTienda+"';");
            Borrador.executeUpdate();
            Con.CerrarConexiones();
            Borrador.close();
            return true;
        }catch(SQLException ex){
            return false;
        }
    }
    public boolean ComprobarSiExiteTienda(int IdUsuario, int CodTiendaAComprobar) throws SQLException{
        Con = new Conexion();
        ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM TiendasDeUsuariosDeBodega WHERE CodigoDeEncargado='"+IdUsuario+"';");
        while (BusquedaID.next()){
            if(BusquedaID.getInt(3)==CodTiendaAComprobar){
                return false;
            }
        }
        BusquedaID.close();
        Con.CerrarConexiones();
        return true;
    }
    
        public boolean ModificarDatos(int Id ,int idNuevatienda){
        try{
            Con = new Conexion();
            Con.IniciarConexion();
            String Ssql = "UPDATE TiendasDeUsuariosDeBodega SET CodigoDeTienda=? WHERE ID=?";
            PreparedStatement cambio = Con.getConexion().prepareStatement(Ssql);
            cambio.setInt(1, idNuevatienda);
            cambio.setInt(2, Id);
            cambio.executeUpdate();
            Con.CerrarConexiones();
            return true;
        }catch(SQLException e){
            return false;
        }
    }
    public int BuscarCodigo(int CodUsuario,int CodTienda){
        Con = new Conexion();
        try {
            ResultSet BusquedaID = Con.IniciarConexion().executeQuery("SELECT * FROM TiendasDeUsuariosDeBodega WHERE CodigoDeEncargado='"+CodUsuario+"' AND CodigoDeTienda='"+CodTienda +"';");
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
    
    public void SubirMuevaTienda(int codigoEncargado, int codigoTienda){
        Con = new Conexion();
        Con.IniciarConexion();
        PreparedStatement ps;
        String sql;
        try {
            sql = "insert into TiendasDeUsuariosDeBodega (CodigoDeEncargado,CodigoDeTienda) values (?,?);";            
            Conn = Con.getConexion();
            ps = Conn.prepareStatement(sql);
            ps.setInt(1, codigoEncargado);
            ps.setInt(2, codigoTienda);
            ps.executeUpdate();      
            Con.CerrarConexiones();
            Conn.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }  
    }
}
