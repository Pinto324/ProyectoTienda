<%-- 
    Document   : CrearEnvio2
    Created on : 19/03/2023, 02:12:30
    Author     : branp
--%>

<%@page import="Objetos.ListaDeProductoPyE"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Crear Envio</title>
        <link rel="stylesheet" href="../MenusCSS/CrearEnvio2.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Caveat+Brush&display=swap" rel="stylesheet">
    </head>
    <body>
        <!--Variables-->
         <jsp:useBean id="cn" class="BaseDeDatos.Conexion" scope="page"></jsp:useBean>
         <jsp:useBean id="Lista" class="BaseDeDatos.ListaDeProductosPyE" scope="page"></jsp:useBean> 
         <jsp:useBean id="ModificarEnvios" class="BaseDeDatos.Envios" scope="page"></jsp:useBean> 
         <jsp:useBean id="ModificarPedidos" class="BaseDeDatos.Pedidos" scope="page"></jsp:useBean> 
         <jsp:useBean id="Cadena" class="BaseDeDatos.TiendasDeUsuarioDeBodega" scope="page"></jsp:useBean>
         <jsp:useBean id="Usuario" class="BaseDeDatos.Usuarios" scope="page"></jsp:useBean>
         <jsp:useBean id="productos" class="BaseDeDatos.Productos" scope="page"></jsp:useBean>
         <jsp:useBean id="MP" class="Controles.ManejadorDeEnvios" scope="page"></jsp:useBean>
        <!--Logeo en la pagina-->
        <%
            HttpSession Sesion = request.getSession();
            try{
                if(request.getParameter("codigo")!=null||request.getParameter("codigo").equals("")){
                    Sesion.setAttribute("codigoInicio", request.getParameter("codigo"));
                }
            }
            catch (NullPointerException ex) {
                    
            }
           
            ResultSet Rs = cn.IniciarConexion().executeQuery("select * from ListaDeProductosEnvios JOIN Envios ON ListaDeProductosEnvios.CodigoDelEnvio = Envios.Id JOIN Productos ON ListaDeProductosEnvios.CodigoDelProducto = Productos.Codigo WHERE CodigoDelEnvio="+Sesion.getAttribute("codigoInicio"));
            if(Sesion.getAttribute("user")!=null&&Sesion.getAttribute("nivel")!=null){                    
                }else{
                    out.print("<script>location.replace('../../../Login.jsp');</script>");
                }
         %>  
        <!--Información:-->
        <jsp:useBean id="verificacion" class="Controles.ManejadorDePedidos" scope="page"></jsp:useBean>
        <section>
        <header style="z-index: 4;">
            <div class="contenedorGrande">
                <div class="contenedor">
                    <a href="../MenuInicialAlmacen.jsp" id="logo">Bodega</a>
                </div>
                <div class="contenedor">
                    <p style="font-size: 60px;" id="logo">Creación de Envíos</p>
                </div>
                <div class="contenedor">
                    <a class="nav-link" href="../../../Login.jsp?cerrar=true">
                        <img src="https://cdn-icons-png.flaticon.com/512/2574/2574200.png" width="60" height="60">
                        <label>Cerrar Sesión</label>
                    </a>
                </div>
            </div>
        </header>
    </section>
        <section id="sectionLibro">
            <div class="contenedorPrincipal">
                <div class='divSeparador'>   
                    <form action="" >
                        <div class="divSeparadorInterno"> 
                            <label>Añadir Productos al envio</label>
                            <button type="submit" name='btnAñadir' id='btnAñadir'>añadir</button>
                            <label>Completar Envio</label>
                            <button type="submit" name='btnCompletar' id='btnCompletar'>Completar</button>
                        </div>
                    </form> 
                    <form action="" method="post">
                        <div class="divSeparadorInterno" id='divSeparadorCantidad'> 
                                <label>(Si quieres realizar un cambio en la cantidad de algún producto, solo escribe aquí la nueva cantidad y dale en el botón, después presiona actualizar en dicho producto y listo!)</label>
                                <input name='NuevoValor' type='number' min='1'>  
                            <div id='divBoton'>
                                <a href='CrearEnvio2.jsp'  id='btnCulero'>Quitar Carga de cantidad</a>
                                <button type="submit" id='btnCulero'>Cargar Cantidad</button>    
                            </div>
                        </div>
                    </form>              
                </div>
                             <%
            if((!(request.getParameter("btnAñadir")==null))){ 
                out.print("<script>location.replace('CrearEnvioAñadirNuevoProducto.jsp');</script>");
            }else if(!(request.getParameter("btnCompletar")==null)){
                MP.DescontarExistenciasEnvios(Integer.parseInt(Sesion.getAttribute("codigoInicio").toString()));
                ModificarEnvios.modificarEstado(Integer.parseInt(Sesion.getAttribute("codigoInicio").toString()),"Despachado");
                ModificarEnvios.ponerFecha(Integer.parseInt(Sesion.getAttribute("codigoInicio").toString()),"FechaSalida");
                ModificarEnvios.modificarUsuario(Integer.parseInt(Sesion.getAttribute("codigoInicio").toString()),Sesion.getAttribute("user").toString());
                ModificarPedidos.modificarEstado(Integer.parseInt(ModificarEnvios.BuscarPorIDSinFecha(Integer.parseInt(Sesion.getAttribute("codigoInicio").toString()))[2]), "Enviado");
                out.print("<script type='text/javascript'>alert('Se realizo el envio con exito')</script>");    
                out.print("<script>location.replace('CrearEnvio1.jsp');</script>");
            } 
         %>
            <div class='divSeparador'>             
                <div class="divSeparadorInterno">    
                    <h1>Los Productos pedidos son:</h1>
                                <%
                                // Crear la tabla HTML
                                out.println("<table align='center' cellspacing='2' cellpadding='2' border='1' bgcolor=dddddd>");
                                out.println("<tr>");
                                out.println("<td>Nombre del producto</td>");
                                out.println("<td>Costo por unidad</td>");
                                out.println("<td>Cantidad pedida</td>");
                                out.println("</tr>");
                                while (Rs.next()) {   
                                    int codProducto = Rs.getInt("Codigo");
                                    String Nombre = Rs.getString("Nombre");
                                    double costo = Rs.getDouble("Costo");
                                    int Total = Rs.getInt("Cantidad");
                                    String enlace = "CrearEnvio2.jsp?Actualizar=" + codProducto + "&Cantidad=" + request.getParameter("NuevoValor");
                                    out.println("<tr>");
                                    out.println("<td>" + Nombre + "</td>");
                                    out.println("<td>"+ costo +"</td>");
                                    out.println("<td>"+Total+"</td>");
                                    out.println("<td><a href='"+enlace+"'>Actualizar Producto</a></td>");
                                    out.println("<td><a href='CrearEnvio2.jsp?Eliminar="+codProducto+"'>Eliminar Producto</a></td>");
                                    out.println("</tr>");
                                }
                            %>        
                        </select>
                 </div>
                </div>    
            </div>
        </section>
                        <%
                         if(!(request.getParameter("Eliminar")==null)){
                             if(ModificarEnvios.restarTotal (Integer.parseInt(Sesion.getAttribute("codigoInicio").toString()),Integer.parseInt(request.getParameter("Eliminar"))) && Lista.EliminarPorCodProductoEnvio(Integer.parseInt(request.getParameter("Eliminar")), Integer.parseInt(Sesion.getAttribute("codigoInicio").toString()))){
                                out.print("<script type='text/javascript'>alert('Se elimino el producto del envio con exito')</script>");
                                out.print("<script>location.replace('CrearEnvio2.jsp');</script>");
                             }else{
                                  out.print("<script type='text/javascript'>alert('Ocurrio un error al intentar eliminar')</script>");
                             }
                         }else if(request.getParameter("Cantidad")!=null){ 
                             try{
                            if(Integer.parseInt(request.getParameter("Cantidad"))==0){
                                out.print("<script type='text/javascript'>alert('Ingrese una cantidad valida de producto')</script>");
                            }else{
                                if(Integer.parseInt(productos.BuscarPorCodigo(Integer.parseInt(request.getParameter("Actualizar")))[4])>Integer.parseInt(request.getParameter("Cantidad"))){
                                    ListaDeProductoPyE PedidoActualizado = new ListaDeProductoPyE(Integer.parseInt(Sesion.getAttribute("codigoInicio").toString()),Integer.parseInt(request.getParameter("Actualizar")) ,Integer.parseInt(request.getParameter("Cantidad")));                
                                    if(ModificarEnvios.restarUnaParte(PedidoActualizado.getIdDelSolicitante(), MP.DetectarSumaOResta(PedidoActualizado))){
                                        Lista.ActualizarPedido(PedidoActualizado);
                                        out.print("<script type='text/javascript'>alert('Se Actualizo la cantidad del producto con exito')</script>");
                                        out.print("<script>location.replace('CrearEnvio2.jsp');</script>");
                                    }else{
                                    out.print("<script type='text/javascript'>alert('Ocurrio un error intente más tarde')</script>");
                                    }
                                }else{
                                    out.print("<script type='text/javascript'>alert('No existen las existencias suficientes para realizar la modificación')</script>");
                                }    
                            }
                             }catch(NumberFormatException e){
                                 out.print("<script type='text/javascript'>alert('Ocurrio un error presiona el botón de quitar carga de cantidad')</script>");
                             }
                        }
                            
                        %>  
    </body>
</html>
