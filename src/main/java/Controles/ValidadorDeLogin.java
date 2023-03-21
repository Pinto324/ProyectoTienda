/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controles;

import BaseDeDatos.Usuarios;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

/**
 *
 * @author branp
 */
public class ValidadorDeLogin {
    private static String NombreUsuario;
    private String Nick;
    private String Contraseña;
    private Usuarios User = new Usuarios();
    public ValidadorDeLogin(String Nick, String Contraseña) {
        this.Nick = Nick;
        this.Contraseña = Contraseña;
    }

    public ValidadorDeLogin() {
    }
    

    public String getNick() {
        return Nick;
    }

    public void setNick(String Nick) {
        this.Nick = Nick;
    }

    public String getContraseña() {
        return Contraseña;
    }

    public void setContraseña(String Contraseña) {
        this.Contraseña = Contraseña;
    }

    public static String getNombreUsuario() {
        return NombreUsuario;
    }

    public static void setNombreUsuario(String NombreUsuario) {
        ValidadorDeLogin.NombreUsuario = NombreUsuario;
    }
    //Metodos:
    public String ComprobarUsuario() throws SQLException, NoSuchAlgorithmException{      
        String Credenciales = "";
        String[] Datos = User.BuscarPorUsuario(Nick);
        try{
            if(Datos!=null){
                if(User.ComprobarContraseña(Datos[2], Contraseña)){
                    Credenciales = Datos[5];
                }else{
                    Credenciales = "Fail";
                }
            }else{
    
            }
        }catch(NullPointerException e){
            Credenciales = "Fail2";
        }
        return Credenciales;
    }
}
