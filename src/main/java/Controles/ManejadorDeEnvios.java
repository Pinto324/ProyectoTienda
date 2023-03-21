/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controles;

import BaseDeDatos.Envios;
import BaseDeDatos.Productos;
import Objetos.Envio;
import Objetos.ListaDeProductoPyE;
import java.sql.SQLException;
import java.text.ParseException;

/**
 *
 * @author branp
 */
public class ManejadorDeEnvios {
        private final Envios BDEnvios = new Envios();
        private final Productos ListaProductos = new Productos();
        private final BaseDeDatos.ListaDeProductosPyE BDLista = new BaseDeDatos.ListaDeProductosPyE();
    public ManejadorDeEnvios() {
    }
    
    public boolean ComprobarSiExisteEnvio(int id) throws SQLException{
        return BDEnvios.comprobarCodigoEnvio(id);
    }
    
    public void SubirEnvio(Envio pedido) throws SQLException, ParseException{
        if(BDEnvios.comprobarCodigoEnvio(pedido.getId())){
            BDEnvios.modificarTotal(pedido);
        }else{
            BDEnvios.CrearEnvio(pedido);
        }
    }
    public double DetectarSumaOResta(ListaDeProductoPyE pedido){
        String[] DatosAntes = BDLista.BuscarPorIDyProductoEnvio(pedido.getIdDelSolicitante(),pedido.getCodigoDelProducto());
        String[] Producto = ListaProductos.BuscarPorCodigo(pedido.getCodigoDelProducto());
        double TotalAntes = Double.parseDouble(DatosAntes[1])*Double.parseDouble(Producto[2]);
        double TotalAhora = pedido.getCantidad()*Double.parseDouble(Producto[2]);
        double CantidadEnviada = 0;
            if(Integer.parseInt(DatosAntes[1])>pedido.getCantidad()){
                CantidadEnviada = -(TotalAhora - TotalAntes);
                return CantidadEnviada;
            }else{
                CantidadEnviada =  (TotalAntes - TotalAhora);  
                return CantidadEnviada; 
            }
    }
    
    public void DescontarExistenciasEnvios(int codigoEnvio){
        BDLista.restarExistenciasDeEnvio(codigoEnvio);
    }
}
