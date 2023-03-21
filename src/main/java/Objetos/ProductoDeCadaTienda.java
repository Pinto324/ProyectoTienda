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
public class ProductoDeCadaTienda {
    private int id;
    private int codigoDeTienda;
    private int codigoDeProducto;
    private int existencias;

    public ProductoDeCadaTienda() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCodigoDeTienda() {
        return codigoDeTienda;
    }

    public void setCodigoDeTienda(int codigoDeTienda) {
        this.codigoDeTienda = codigoDeTienda;
    }

    public int getCodigoDeProducto() {
        return codigoDeProducto;
    }

    public void setCodigoDeProducto(int codigoDeProducto) {
        this.codigoDeProducto = codigoDeProducto;
    }

    public int getExistencias() {
        return existencias;
    }

    public void setExistencias(int existencias) {
        this.existencias = existencias;
    }
    
}
