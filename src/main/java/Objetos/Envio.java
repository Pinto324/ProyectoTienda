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
public class Envio {
    private int Id;
    private int codigoDeTienda;
    private int pedidoVinculado;
    private String Usuario;
    private Date FechaSalida;
    private Date FechaRecibido;
    private double total;
    private String estado;

    public Envio(int Id, int codigoDeTienda, int pedidoVinculado, String Usuario, Date FechaS, Date FechaR, double total, String estado) {
        this.Id = Id;
        this.codigoDeTienda = codigoDeTienda;
        this.pedidoVinculado = pedidoVinculado;
        this.Usuario = Usuario;
        this.FechaSalida = FechaS;
        this.FechaRecibido = FechaR;
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

    public int getPedidoVinculado() {
        return pedidoVinculado;
    }

    public void setPedidoVinculado(int pedidoVinculado) {
        this.pedidoVinculado = pedidoVinculado;
    }

    public String getUsuario() {
        return Usuario;
    }

    public void setUsuario(String Usuario) {
        this.Usuario = Usuario;
    }

    public Date getFechaSalida() {
        return FechaSalida;
    }

    public void setFechaSalida(Date FechaSalida) {
        this.FechaSalida = FechaSalida;
    }

    public Date getFechaRecibido() {
        return FechaRecibido;
    }

    public void setFechaRecibido(Date FechaRecibido) {
        this.FechaRecibido = FechaRecibido;
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
