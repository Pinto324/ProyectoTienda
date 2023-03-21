/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controles;

import BaseDeDatos.Envios;
import BaseDeDatos.Usuarios;
import BaseDeDatos.ListaDeProductosPyE;
import BaseDeDatos.Productos;
import BaseDeDatos.ProductosDeCadaTienda;
import BaseDeDatos.Tienda;
import BaseDeDatos.TiendasDeUsuarioDeBodega;
import Objetos.Envio;
import Objetos.ListaDeProductoPyE;
import Objetos.Pedido;
import Objetos.Producto;
import Objetos.ProductoDeCadaTienda;
import Objetos.Usuario;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.json.*;
/**
 *
 * @author branp
 */
public class CargaDeArchivo extends HttpServlet {
    private ManejadorDePedidos ManajadorPedidos = new ManejadorDePedidos();
    private Usuarios MUsuarios = new Usuarios();
    private ManejadorUsuario manejadorUsuario = new ManejadorUsuario();
    private ListaDeProductosPyE ListaEnviosYPedidos = new ListaDeProductosPyE();
    private TiendasDeUsuarioDeBodega UBodega = new TiendasDeUsuarioDeBodega();
    private ProductosDeCadaTienda ListaProductoporTienda = new ProductosDeCadaTienda();
    private Tienda ListaTiendaTienda = new Tienda();
    private Envios Env = new Envios();
    private static final SimpleDateFormat FormatoFecha = new SimpleDateFormat("yyyy-MM-dd");
    private Productos MProducto = new Productos();
    
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  // Obtener el archivo subido
  Part archivoPart = request.getPart("jsonFile");
  InputStream archivoStream = archivoPart.getInputStream();
  
  // Leer el contenido del archivo como un string
  String contenido = new String(archivoStream.readAllBytes(), StandardCharsets.UTF_8);
  
  // Convertir el string a un objeto JSON
  JSONObject objetoJson = new JSONObject(contenido);
  
  // Acceder a los datos del objeto JSON
  //MANEJO DE USUARIOS:
  //ADMINS:
    JSONArray admins = objetoJson.getJSONArray("admins");
    for (int i = 0; i < admins.length(); i++) {
    JSONObject admin = admins.getJSONObject(i);
    int codigo = admin.getInt("codigo");
    String nombre = admin.getString("nombre");
    String username = admin.getString("username");
    String password = admin.getString("password");
    //Subirlo
    Usuario NU = new Usuario(codigo,nombre,username,password,"Admin","Admin",-1);
    manejadorUsuario.CrearUsuario(NU);
  }
  //supervisores:
  JSONArray supervisores = objetoJson.getJSONArray("supervisores");
    for (int i = 0; i < supervisores.length(); i++) {
    JSONObject supervisor = supervisores.getJSONObject(i);
    int codigo = supervisor.getInt("codigo");
    String nombre = supervisor.getString("nombre");
    String username = supervisor.getString("username");
    String password = supervisor.getString("password");
    String email = supervisor.getString("email");
    //Subirlo
    Usuario NU = new Usuario(codigo,nombre,username,password,email,"Super",-1);
    manejadorUsuario.CrearUsuario(NU);
  }
  //Bodega:
  JSONArray encargadosBodega = objetoJson.getJSONArray("encargadosBodega");
    for (int i = 0; i < encargadosBodega.length(); i++) {
    JSONObject Bodega = encargadosBodega.getJSONObject(i);
    int codigo = Bodega.getInt("codigo");
    String nombre = Bodega.getString("nombre");
    String username = Bodega.getString("username");
    String password = Bodega.getString("password");
    String email = Bodega.getString("email");
    JSONArray tiendas = Bodega.getJSONArray("tiendas");
    for (int j = 0; j < tiendas.length(); j++) {
         int numeroTienda = tiendas.getInt(j);
         UBodega.SubirMuevaTienda(codigo, numeroTienda);
    }
    //Subirlo
    Usuario NU = new Usuario(codigo,nombre,username,password,email,"Super",-1);
    manejadorUsuario.CrearUsuario(NU);
  }
   //MANEJO DE Productos:
    JSONArray productos = objetoJson.getJSONArray("productos");
    for (int i = 0; i < productos.length(); i++) {
    JSONObject produc = productos.getJSONObject(i);
    int codigo = produc.getInt("codigo");
    String nombre = produc.getString("nombre");
    double costo = produc.getDouble("costo");
    double precio = produc.getDouble("precio");
    int existencias = produc.getInt("existencias");
    //Subirlo
    Producto NU = new Producto(codigo,nombre,costo,precio,existencias);
    MProducto.CrearProducto(NU);
  }
    //MANEJO DE TIENDAS:
    JSONArray tiendas = objetoJson.getJSONArray("tiendas");
    for (int i = 0; i < tiendas.length(); i++) {
    JSONObject tienda = tiendas.getJSONObject(i);
    int codigo = tienda.getInt("codigo");
    String nombre = tienda.getString("Nombre");
    String direccion = tienda.getString("direccion");
    String tipo = tienda.getString("tipo");
    JSONArray producto = tienda.getJSONArray("productos");
    for (int j = 0; j < producto.length(); j++) {
      JSONObject produco = producto.getJSONObject(j);
      int codig = produco.getInt("codigo");
      int cantidad = produco.getInt("existencias");
      // hacer algo con los datos del producto
      ProductoDeCadaTienda NP = new ProductoDeCadaTienda();
      NP.setCodigoDeProducto(codig);
      NP.setCodigoDeTienda(codigo);
      NP.setExistencias(cantidad);
      ListaProductoporTienda.CrearProducto(NP);
    }
      try {
          ListaTiendaTienda.CrearTienda(codigo,nombre,direccion,tipo);
      } catch (ParseException ex) {
          Logger.getLogger(CargaDeArchivo.class.getName()).log(Level.SEVERE, null, ex);
      }
  }
  
  //MANEJO DE PEDIDOS:
  JSONArray pedidos = objetoJson.getJSONArray("pedidos");
  for (int i = 0; i < pedidos.length(); i++) {
    JSONObject pedido = pedidos.getJSONObject(i);
    int id = pedido.getInt("id");
    int tienda = pedido.getInt("tienda");
    int usuario = pedido.getInt("usuario");
    String fecha = pedido.getString("fecha");
    JSONArray producto = pedido.getJSONArray("productos");
    for (int j = 0; j < producto.length(); j++) {
      JSONObject produco = producto.getJSONObject(j);
      int codigo = produco.getInt("codigo");
      int cantidad = produco.getInt("cantidad");
      // hacer algo con los datos del producto
      ListaDeProductoPyE NP = new ListaDeProductoPyE();
      NP.setIdDelSolicitante(id);
      NP.setCodigoDelProducto(codigo);
      NP.setCantidad(cantidad);
      ListaEnviosYPedidos.SubirProductoPedido(NP);
    }
    double total = pedido.getDouble("total");
    String estado = pedido.getString("estado");
    Date F;
      try {
          // hacer algo con los datos del pedido
          F = (Date) FormatoFecha.parse(fecha);
      } catch (ParseException ex) {
          F = null;
      }
    String[] DataUsuario =  MUsuarios.BuscarPorCodigo(usuario);
    Pedido NuevoPedido = new Pedido(id, tienda, DataUsuario[2], F, total,estado);
      try {
          ManajadorPedidos.SubirPedido(NuevoPedido);
      } catch (SQLException ex) {
          Logger.getLogger(CargaDeArchivo.class.getName()).log(Level.SEVERE, null, ex);
      } catch (ParseException ex) {
          Logger.getLogger(CargaDeArchivo.class.getName()).log(Level.SEVERE, null, ex);
      }
  }
    //MANEJO DE Envios:
    JSONArray envios = objetoJson.getJSONArray("envios");
    for (int i = 0; i < envios.length(); i++) {
    JSONObject envio = envios.getJSONObject(i);
    int id = envio.getInt("id");
    int pedido = envio.getInt("pedido");
    int tienda = envio.getInt("tienda");
    int usuario = envio.getInt("usuario");
    String fechaSalida = envio.getString("fechaSalida");
    String fechaRecibido = envio.getString("fechaRecibido");
    JSONArray producto = envio.getJSONArray("productos");
    for (int j = 0; j < producto.length(); j++) {
      JSONObject produco = producto.getJSONObject(j);
      int codig = produco.getInt("codigo");
      int cantidad = produco.getInt("cantidad");
      // hacer algo con los datos del producto
      ListaDeProductoPyE NP = new ListaDeProductoPyE(id, codig, cantidad);
      ListaEnviosYPedidos.SubirProductoEnvio(NP);
    }
    double total = envio.getDouble("total"); 
    String estado = envio.getString("estado");
    String[] D = MUsuarios.BuscarPorCodigo(usuario);
    Date Fs;
    Date FR;
      try {
          // hacer algo con los datos del pedido
          Fs = (Date) FormatoFecha.parse(fechaSalida);
          FR = (Date) FormatoFecha.parse(fechaRecibido);
      } catch (ParseException ex) {
          Fs = null;
          FR = null;
      }
    Envio nuevo = new Envio(id,tienda,pedido,D[2],Fs,FR,total,estado);
      try {
          Env.CrearEnvio(nuevo);
      } catch (ParseException ex) {
          Logger.getLogger(CargaDeArchivo.class.getName()).log(Level.SEVERE, null, ex);
      }
    
  }
        response.sendRedirect("../../Web Pages/Menus/ControlGraficoAdmin/MenuInicialAdmin.jsp");   
    }
}
