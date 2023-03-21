<%-- 
    Document   : ReporteDeProductos
    Created on : 20/03/2023, 22:07:36
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
        <title>Reporte De Productos</title>
        <link rel="stylesheet" href="../MenusCSS/ReporteDeProductos.css">
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
            ResultSet Rs = cn.IniciarConexion().executeQuery("select * From ProductosDeCadaTienda WHERE CodigoDeTienda = '"+Tienda.BuscarPorUsuario(Sesion.getAttribute("user").toString())[6]+"';");
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
                    <p style="font-size: 60px;" id="logo">Reporte de productos</p>
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
                            <label>Filtrar por existencias menores a la cantidad siguiente:</label>
                            <input name="cantidad" type="number" min="0">
                        <button type="submit" name='btnFiltrar' id='btnEnviar'>Filtrar</button>
                        <button type="submit" name='btnDesFiltrar' id='btnEnviar'>Desfiltra</button>
                        </div>
                    </form>
                             <%
             if(request.getParameter("btnFiltrar")!=null){
                Rs = cn.IniciarConexion().executeQuery("select * From ProductosDeCadaTienda WHERE Existencias < "+ request.getParameter("cantidad")+" AND CodigoDeTienda = '"+Tienda.BuscarPorUsuario(Sesion.getAttribute("user").toString())[6]+"';");
             }else if(request.getParameter("btnDesFiltrar")!=null){
                Rs = cn.IniciarConexion().executeQuery("select * From ProductosDeCadaTienda WHERE CodigoDeTienda = '"+Tienda.BuscarPorUsuario(Sesion.getAttribute("user").toString())[6]+"';");
            }
         %>
                        <div class="divSeparadorInterno">    
                            <h1>Productos que tiene actualmente la tienda:</h1>
                                <%
                                // Reiniciamos el cursor
                                Rs.beforeFirst();
                                // Crear la tabla HTML         
                                out.println("<table align='center' cellspacing='2' cellpadding='2' border='1' bgcolor=dddddd>");
                                out.println("<tr>");
                                out.println("<td>Nombre del producto</td>");
                                out.println("<td>Precio de venta</td>");
                                out.println("<td>Existencias en la tienda</td>");
                                out.println("</tr>");
                                ResultSet Ps;
                                while (Rs.next()) {
                                    Ps = cn.IniciarConexion().executeQuery("select * From Productos WHERE Codigo='"+ Rs.getInt("CodigoDeProducto")+"';");
                                    Ps.next();
                                    String nombre = Ps.getString("Nombre");
                                    double Precio = Ps.getDouble("Precio");
                                    int existencias = Rs.getInt("Existencias");
                                    out.println("<tr>");
                                    out.println("<td>" + nombre + "</td>");
                                    out.println("<td>"+ Precio +"</td>");
                                    out.println("<td>"+ existencias +"</td>");
                                    out.println("</tr>");
                                    Ps.close();
                                }
                                out.println("</table>");
                            %>               
                        </div>
                </div>    
            </div>
        </section>
    </body>
</html>
