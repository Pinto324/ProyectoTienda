/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Objetos;

import java.sql.Date;

/**
 *
 * @author branp
 */
public class Pedido {
    private int Id;
    private int codigoDeTienda;
    private String Usuario;
    private Date Fecha;
    private double total;
    private String estado;

    public Pedido(int Id, int codigoDeTienda, String Usuario, Date Fecha, double total, String estado) {
        this.Id = Id;
        this.codigoDeTienda = codigoDeTienda;
        this.Usuario = Usuario;
        this.Fecha = Fecha;
        this.total = total;
        this.estado = estado;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public int getCodigoDeTienda() {
        return codigoDeTienda;
    }

    public void setCodigoDeTienda(int codigoDeTienda) {
        this.codigoDeTienda = codigoDeTienda;
    }

    public String getUsuario() {
        return Usuario;
    }

    public void setUsuario(String Usuario) {
        this.Usuario = Usuario;
    }

    public Date getFecha() {
        return Fecha;
    }

    public void setFecha(Date Fecha) {
        this.Fecha = Fecha;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
}
