/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Objetos;

/**
 *
 * @author branp
 */
public class ListaDeProductoPyE {
    private int idDelSolicitante;
    private int codigoDelProducto;
    private int cantidad;

    public ListaDeProductoPyE() {
    }

    public ListaDeProductoPyE(int idDelSolicitante, int codigoDelProducto, int cantidad) {
        this.idDelSolicitante = idDelSolicitante;
        this.codigoDelProducto = codigoDelProducto;
        this.cantidad = cantidad;
    }
    

    public int getIdDelSolicitante() {
        return idDelSolicitante;
    }

    public void setIdDelSolicitante(int idDelSolicitante) {
        this.idDelSolicitante = idDelSolicitante;
    }

    public int getCodigoDelProducto() {
        return codigoDelProducto;
    }

    public void setCodigoDelProducto(int codigoDelProducto) {
        this.codigoDelProducto = codigoDelProducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
    
}
