/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Objetos;

public class Usuario {
    private int Codigo;
    private String Nombre;
    private String UserName;
    private String Password;
    private String Email;
    private String Tipo;
    private int Tienda;

    public Usuario(int Codigo, String Nombre, String UserName, String Password, String Email, String Tipo, int Tienda) {
        this.Codigo = Codigo;
        this.Nombre = Nombre;
        this.UserName = UserName;
        this.Password = Password;
        this.Email = Email;
        this.Tipo = Tipo;
        this.Tienda = Tienda;
    }

    public int getCodigo() {
        return Codigo;
    }

    public void setCodigo(int Codigo) {
        this.Codigo = Codigo;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String UserName) {
        this.UserName = UserName;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getTipo() {
        return Tipo;
    }

    public void setTipo(String Tipo) {
        this.Tipo = Tipo;
    }

    public int getTienda() {
        return Tienda;
    }

    public void setTienda(int Tienda) {
        this.Tienda = Tienda;
    }
    
}
