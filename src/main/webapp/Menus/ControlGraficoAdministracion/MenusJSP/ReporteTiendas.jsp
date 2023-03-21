<%-- 
    Document   : ReporteDePedidos
    Created on : 20/03/2023, 23:33:44
    Author     : branp
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reporte De Tiendas</title>
        <link rel="stylesheet" href="../MenusCSS/ReporteTiendas.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Caveat+Brush&display=swap" rel="stylesheet">
    </head>
    <body>
        <!--Variables-->
         <jsp:useBean id="cn" class="BaseDeDatos.Conexion" scope="page"></jsp:useBean>
         <jsp:useBean id="Lista" class="BaseDeDatos.Pedidos" scope="page"></jsp:useBean> 
         <jsp:useBean id="Tienda" class="BaseDeDatos.Usuarios" scope="page"></jsp:useBean>
         <jsp:useBean id="Usuario" class="BaseDeDatos.Usuarios" scope="page"></jsp:useBean>
        <!--Logeo en la pagina-->
        <%
            HttpSession Sesion = request.getSession();
            String sql = "SELECT id, COUNT(*) AS cantidad " +
             "FROM tabla " +
             "GROUP BY id " +
             "ORDER BY cantidad DESC " +
             "LIMIT 5";

            ResultSet Rs = cn.IniciarConexion().executeQuery("SELECT CodigoTienda, COUNT(*) AS cantidad FROM Pedidos GROUP BY CodigoTienda ORDER BY cantidad DESC LIMIT 5");
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
                    <a href="../MenuInicial.jsp" id="logo">Tienda</a>
                </div>
                <div class="contenedor">
                    <p style="font-size: 60px;" id="logo">Reporte de Pedidos</p>
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
                    <form action="#">
                        <div class="divSeparadorInterno"> 
                            <label for="fecha_inicio">Fecha inicio:</label>
                            <input type="date" id="fecha_inicio" name="fecha_inicio">
                            <label for="fecha_fin">Fecha fin:</label>
                            <input type="date" id="fecha_fin" name="fecha_fin">
                            <button type="submit" name='btnFiltrar' id='btnEnviar'>Filtrar</button>    
                            <button type="submit" name='btnDesFiltrar' id='btnEnviar'>Desfiltra</button>
                        </div>
                    </form>
                    <div class="divSeparadorInterno">    
                            <h1>Las tiendas con más pedidos:</h1>
                             <%
             if(request.getParameter("btnFiltrar")!=null){
                if(Date.valueOf(request.getParameter("fecha_inicio")).compareTo(Date.valueOf(request.getParameter("fecha_fin"))) < 0){
                     Rs = cn.IniciarConexion().executeQuery("SELECT CodigoTienda, COUNT(*) AS cantidad FROM Pedidos WHERE fecha BETWEEN '"+Date.valueOf(request.getParameter("fecha_inicio"))+ "' AND '"+ Date.valueOf(request.getParameter("fecha_fin")) +"'  GROUP BY CodigoTienda ORDER BY cantidad DESC LIMIT 5");
                }else if(Date.valueOf(request.getParameter("fecha_inicio")).compareTo(Date.valueOf(request.getParameter("fecha_fin"))) > 0){
                    out.print("<script type='text/javascript'>alert('No puedes poner una fecha final menor que la fecha inicial')</script>");    
                    out.print("<script>location.replace('ReporteDePedidos.jsp');</script>");
                }else{
                    out.print("<script type='text/javascript'>alert('No puedes poner las dos fechas en el mismo día')</script>");    
                    out.print("<script>location.replace('ReporteDePedidos.jsp');</script>");
                }
             }else if(request.getParameter("btnDesFiltrar")!=null){
                Rs = cn.IniciarConexion().executeQuery("SELECT CodigoTienda, COUNT(*) AS cantidad FROM Pedidos GROUP BY CodigoTienda ORDER BY cantidad DESC LIMIT 5");
            }
                                // Reiniciamos el cursor
                                Rs.beforeFirst();
                                // Crear la tabla HTML         
                                out.println("<table align='center' cellspacing='2' cellpadding='2' border='1' bgcolor=dddddd>");
                                out.println("<tr>");
                                out.println("<td>Codigo de la tiendas con más pedidos ordenados:</td>");
                                out.println("</tr>");
                                while (Rs.next()) {
                                    int id = Rs.getInt("CodigoTienda");
                                    int cantidad = Rs.getInt("cantidad");
                                    out.println("<tr>");
                                    out.println("<td>" + "Codigo de la tienda: " + id + " Cantidad de pedidos hechos: " + cantidad + "</td>");
                                    out.println("</tr>");
                                }                               
                                out.println("</table>");
                            %>               
                        </div>
                </div>    
            </div>
        </section>
    </body>
</html>
