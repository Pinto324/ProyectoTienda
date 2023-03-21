
package Controles;

import BaseDeDatos.Usuarios;
import Objetos.Usuario;
import java.sql.SQLException;

public class ManejadorUsuario {
    private final Usuarios ListaUsuarios = new Usuarios();

    public ManejadorUsuario() {
    }
    public boolean EliminarUsuario(int idUsuario){
        return ListaUsuarios.EliminarUsuario(idUsuario);
    }
    public boolean ModificarTodo(Usuario User) throws SQLException{
        if(ListaUsuarios.BuscarUserNameIgual(User.getUserName())){
            ListaUsuarios.ModificarDatos(User);
            return true;
        }else{
            return false;
        }
    }
    
    public boolean CrearUsuario(Usuario user){
        return ListaUsuarios.CrearUsuario(user);
    } 
    public boolean ComprobarUserNameIgual(String UserName) throws SQLException{
        return ListaUsuarios.BuscarUserNameIgual(UserName);
    }
    public boolean ComprobarCodUsado(int codigo) throws SQLException{
        return ListaUsuarios.BuscarCodigoIgual(codigo);
    }
    
   
}
