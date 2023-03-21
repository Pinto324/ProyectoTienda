<%-- 
    Document   : UsuariosDeTiendaModificar
    Created on : 21/03/2023, 01:47:01
    Author     : branp
--%>

<%@page import="Objetos.Usuario"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Modificar Usuario</title>
        <link rel="stylesheet" href="../MenusCSS/UDeBodegaModificarTiendas.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Caveat+Brush&display=swap" rel="stylesheet">
    </head>
    <body>
        <!--Variables-->
         <jsp:useBean id="cn" class="BaseDeDatos.Conexion" scope="page"></jsp:useBean>
         <jsp:useBean id="Usuario" class="BaseDeDatos.Usuarios" scope="page"></jsp:useBean>
        <jsp:useBean id="Tiendas" class="BaseDeDatos.TiendasDeUsuarioDeBodega" scope="page"></jsp:useBean>
        <jsp:useBean id="ManejadorUsuario" class="Controles.ManejadorUsuario" scope="page"></jsp:useBean> 
        
        <!--Logeo en la pagina-->
        <%
            HttpSession Sesion = request.getSession();
            try{
                if(request.getParameter("codigo")!=null||request.getParameter("codigo").equals("")){
                    Sesion.setAttribute("codigoValorModificar", request.getParameter("codigo"));
                }
            }
            catch (NullPointerException ex) {    
            }
            ResultSet Rs = cn.IniciarConexion().executeQuery("select * from TiendasDeUsuariosDeBodega WHERE CodigoDeEncargado = '"+ Sesion.getAttribute("codigoValorModificar").toString()+"';");
            ResultSet ListaTiendas = cn.IniciarConexion().executeQuery("select * from Tienda;");
            if(Sesion.getAttribute("user")!=null&&Sesion.getAttribute("nivel")!=null){                    
                }else{
                    out.print("<script>location.replace('../../../Login.jsp');</script>");
                }
         %>  
        <section>
        <header style="z-index: 4;">
            <div class="contenedorGrande">
                <div class="contenedor">
                    <a href="../MenuInicialAdmin.jsp" id="logo">Administración</a>
                </div>
                <div class="contenedor">
                    <p style="font-size: 60px;" id="logo">Gestión de usuarios de tienda</p>
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
                            <label>Guardar cambios de tiendas</label>
                            <button type="submit" name='btnGuardar' id='btnCompletar'>Guardar</button>
                        </div>
                    </form>  
                    <form action="" method="post" >      
                        <div class="divSeparadorInterno" id='divSeparadorCantidad'> 
                                <label>(Si quieres realizar un cambio en el codigo de alguna tienda, selecciona aquí el nuevo codigo y dale en el botón, después presiona actualizar en la tabla y listo!)</label>
                                 <!--Codigo para combobox:--> 
                                    <select name='codSelec'>
                                        <%
                                            while(ListaTiendas.next()){          
                                        %>
                                        <option name="NM"><%=ListaTiendas.getInt("Codigo")%></option>       
                                        <% }%>  
                                    </select>
                            <div id='divBoton'>
                                <a href='UDeBodegaModificarTiendas.jsp'  id='btnCulero'>Quitar Carga de codigo</a>       
                                <button type="submit" id='btnCulero'>Cargar Codigo</button>    
                            </div>
                        </div>
                    </form>  
                    </div> 
         <%
            if(request.getParameter("btnGuardar")!=null){
                out.print("<script type='text/javascript'>alert('Los cambios fueron guardados con exito')</script>");    
                out.print("<script>location.replace('UDeBodega.jsp');</script>"); 
            }else if(request.getParameter("btnAñadir")!=null){
               out.print("<script>location.replace('UDBAñadir.jsp');</script>");
            } 
         %>            
            <div class='divSeparador'>   
                <div class="divSeparadorInterno">    
                    <h1>Los datos del usuario son:</h1>
                     <%
                                // Reiniciamos el cursor
                                Rs.beforeFirst();
                                //rs de los codigos de tienda:
                                ResultSet CT = cn.IniciarConexion().executeQuery("select * from Tienda;");
                                // Crear la tabla HTML
                                out.println("<table align='center' cellspacing='2' cellpadding='2' border='1' bgcolor=dddddd>");
                                out.println("<tr>");
                                out.println("<td>Codigos de tiendas asignadas:</td>");
                                out.println("<td>Modificar:</td>");
                                out.println("<td>Eliminar:</td>");
                                out.println("</tr>");
                                while (Rs.next()) {
                                    int tienda = Rs.getInt("CodigoDeTienda");
                                    String enlace = "UDeBodegaModificarTiendas.jsp?Actualizar=" + tienda + "&Cantidad=" + request.getParameter("codSelec");
                                    out.println("<tr>");
                                    out.println("<td>"+tienda+"</td>");    
                                    out.println("<td><a href='" + enlace + "'>Modificar</a></td>");
                                    out.println("<td><a href='UDeBodegaModificarTiendas.jsp?Eliminar=" + tienda + "'>Eliminar</a></td>");
                                    out.println("</tr>");
                                }
                                out.println("</table>");
                            %>       
                        </select>
                        </div>
                        </div>
                </div>
            </div>
        </section>
                         <%
                         if(!(request.getParameter("Eliminar")==null)){
                            String[] datos = Usuario.BuscarPorCodigo(Integer.parseInt(Sesion.getAttribute("codigoValorModificar").toString()));
                            int codUsuario = Integer.parseInt(datos[0]);
                            int Tienda = Integer.parseInt(request.getParameter("Eliminar"));
                             if(Tiendas.EliminarTienda(codUsuario,Tienda)){
                                out.print("<script type='text/javascript'>alert('Se elimino la tienda con exito')</script>");
                                out.print("<script>location.replace('UDeBodegaModificarTiendas.jsp');</script>");
                             }else{
                                  out.print("<script type='text/javascript'>alert('Ocurrio un error al intentar eliminar')</script>");
                             }
                         }else if(request.getParameter("Cantidad")!=null){ 
                            String[] datos = Usuario.BuscarPorCodigo(Integer.parseInt(Sesion.getAttribute("codigoValorModificar").toString()));
                            int codUsuario = Integer.parseInt(datos[0]);
                            int codTiendaNueva = Integer.parseInt(request.getParameter("Cantidad"));
                            try{
                            if(Tiendas.ComprobarSiExiteTienda(codUsuario, codTiendaNueva)){
                                int codATienda = Integer.parseInt(request.getParameter("Actualizar"));
                                int IdDelDato= Tiendas.BuscarCodigo(codUsuario, codATienda);
                                    if(Tiendas.ModificarDatos(IdDelDato, codTiendaNueva)){
                                        out.print("<script type='text/javascript'>alert('Se Actualizo el nuevo codigo de la tienda correctamente')</script>");
                                        out.print("<script>location.replace('UDeBodegaModificarTiendas.jsp');</script>");
                                    }else{
                                        out.print("<script type='text/javascript'>alert('Ocurrio un error al intentar actualizar el codigo de tienda')</script>");
                                        out.print("<script>location.replace('UDeBodegaModificarTiendas.jsp');</script>");
                                    }
                                }else{
                                    out.print("<script type='text/javascript'>alert('El usuario ya cuenta con esa tienda asignada')</script>");
                                }    
                             }catch(NumberFormatException e){
                                 out.print("<script type='text/javascript'>alert('Ocurrio un error presiona el botón de quitar carga de cantidad')</script>");
                             }
                        }
                            
                        %> 
    </body>
</html>
