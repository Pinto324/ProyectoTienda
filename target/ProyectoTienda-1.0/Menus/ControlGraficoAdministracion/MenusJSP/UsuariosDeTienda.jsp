<%-- 
    Document   : UsuariosDeTienda
    Created on : 21/03/2023, 00:55:02
    Author     : branp
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de usuarios de tienda</title>
        <link rel="stylesheet" href="../MenusCSS/UsuariosDeTienda.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Caveat+Brush&display=swap" rel="stylesheet">
    </head>
    <body>
        <!--Variables-->
         <jsp:useBean id="cn" class="BaseDeDatos.Conexion" scope="page"></jsp:useBean>
         <jsp:useBean id="Lista" class="BaseDeDatos.Pedidos" scope="page"></jsp:useBean> 
         <jsp:useBean id="Cadena" class="BaseDeDatos.TiendasDeUsuarioDeBodega" scope="page"></jsp:useBean>
         <jsp:useBean id="Usuario" class="BaseDeDatos.Usuarios" scope="page"></jsp:useBean>
         <jsp:useBean id="ManejadorUsuarios" class="Controles.ManejadorUsuario" scope="page"></jsp:useBean>
        <!--Logeo en la pagina-->
        <%
            HttpSession Sesion = request.getSession();
            ResultSet Rs = cn.IniciarConexion().executeQuery("select * from Usuarios WHERE Tipo = 'Tienda';");
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
                            <label>Crear un usuario nuevo</label>
                            <button type="submit" name='btnCrear' id='btnAñadir'>Crear Usuario</button>
                        </div>
                    </form> 
                        <div class="divSeparadorInterno">    
                            <h1>Los usuarios de tienda son:</h1>
                                <%
                                // Reiniciamos el cursor
                                Rs.beforeFirst();
                                // Crear la tabla HTML
                                out.println("<table align='center' cellspacing='2' cellpadding='2' border='1' bgcolor=dddddd>");
                                out.println("<tr>");
                                out.println("<td>Codigo:</td>");
                                out.println("<td>Nombre:</td>");
                                out.println("<td>UserName:</td>"); 
                                out.println("<td>Email:</td>");
                                out.println("<td>Codigo de la tienda encargada:</td>");
                                out.println("</tr>");
                                while (Rs.next()) {
                                    int codigo = Rs.getInt("Codigo");
                                    String nombre = Rs.getString("Nombre");
                                    String user = Rs.getString("UserName");
                                    String email = Rs.getString("Email");
                                    int tienda = Rs.getInt("CodigoDeTienda");
                                    out.println("<tr>");
                                    out.println("<td>" + codigo + "</td>");
                                    out.println("<td>"+ nombre +"</td>");
                                    out.println("<td>"+ user +"</td>");
                                    out.println("<td>"+ email +"</td>");
                                    out.println("<td>"+ tienda +"</td>");
                                    out.println("<td><a href='UsuariosDeTiendaModificar.jsp?codigo=" + codigo + "'>Modificar</a></td>");
                                    out.println("<td><a href='UsuariosDeTienda.jsp?Eliminar=" + codigo + "'>Eliminar</a></td>");
                                    out.println("</tr>");
                                }
                                out.println("</table>");
                            %>  
                            
                        </div>
                </div>    
            </div>
        </section>
        <%
            if(!(request.getParameter("Eliminar")==null)){
                if(ManejadorUsuarios.EliminarUsuario(Integer.parseInt(request.getParameter("Eliminar")))){
                    out.print("<script type='text/javascript'>alert('Se elimino el usuario exitosamente')</script>");
                    out.print("<script>location.replace('UsuariosDeTienda.jsp');</script>");
                }else{
                    out.print("<script type='text/javascript'>alert('Ocurrio un error al intentar eliminar al usuario')</script>");
                }
            }else if(request.getParameter("btnCrear")!=null){
                out.print("<script>location.replace('UsuarioDeTiendaCrearCodigo.jsp');</script>");
            }
        %>  
    </body>
</html>
