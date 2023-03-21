/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controles;

import BaseDeDatos.Pedidos;
import BaseDeDatos.Productos;
import Objetos.ListaDeProductoPyE;
import Objetos.Pedido;
import java.sql.SQLException;
import java.text.ParseException;

/**
 *
 * @author branp
 */
public class ManejadorDePedidos {
    private final Pedidos BDPedidos = new Pedidos();
    private final ListaDeProductoPyE lista = new ListaDeProductoPyE();
    private final Productos productos = new Productos();
    private final BaseDeDatos.ListaDeProductosPyE BDLista = new BaseDeDatos.ListaDeProductosPyE();
    public ManejadorDePedidos() {
    }
    
    public boolean ComprobarSiExistePedido(int idPedido) throws SQLException{
        return BDPedidos.comprobarCodigoPedido(idPedido);
    }
    
    public void SubirPedido(Pedido pedido) throws SQLException, ParseException{
        if(!(BDPedidos.comprobarCodigoPedido(pedido.getId()))){
            BDPedidos.modificarTotal(pedido);
        }else{
            BDPedidos.CrearPedido(pedido);
        }
    }

    
}
