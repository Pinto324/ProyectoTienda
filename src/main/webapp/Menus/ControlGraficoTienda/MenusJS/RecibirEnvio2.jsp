<%-- 
    Document   : RecibirEnvio2
    Created on : 20/03/2023, 16:37:36
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
        <title>Recibir Envio</title>
        <link rel="stylesheet" href="../MenusCSS/RecibirEnvio2.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Caveat+Brush&display=swap" rel="stylesheet">
    </head>
    <body>
        <!--Variables-->
         <jsp:useBean id="cn" class="BaseDeDatos.Conexion" scope="page"></jsp:useBean>
         <jsp:useBean id="ModificarEnvios" class="BaseDeDatos.Envios" scope="page"></jsp:useBean>
         <jsp:useBean id="ModificarPedidos" class="BaseDeDatos.Pedidos" scope="page"></jsp:useBean> 
         <jsp:useBean id="ModificarProductoTienda" class="BaseDeDatos.ProductosDeCadaTienda" scope="page"></jsp:useBean> 
        <!--Logeo en la pagina-->
        <%
            HttpSession Sesion = request.getSession();
                if(Sesion.getAttribute("user")!=null&&Sesion.getAttribute("nivel")!=null){     
                }else{
                    out.print("<script>location.replace('../../Login.jsp');</script>");
                }
                //Codigo del usuario
        try{
                if(request.getParameter("codigo")!=null||request.getParameter("codigo").equals("")){
                    Sesion.setAttribute("codigoInicio", request.getParameter("codigo"));
                }
            }
            catch (NullPointerException ex) {
                    
            }
            ResultSet Rs = cn.IniciarConexion().executeQuery("select * from ListaDeProductosEnvios JOIN Envios ON ListaDeProductosEnvios.CodigoDelEnvio = Envios.Id JOIN Productos ON ListaDeProductosEnvios.CodigoDelProducto = Productos.Codigo WHERE CodigoDelEnvio="+Sesion.getAttribute("codigoInicio"));
         %>
       <section>
<section>
        <header style="z-index: 4;">
            <div class="contenedorGrande">
                <div class="contenedor">
                    <a href="../MenuInicial.jsp" id="logo">Tienda</a>
                </div>
                <div class="contenedor">
                    <p style="font-size: 60px;" id="logo">Recepción de envios</p>
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
                            <label>Marcar como envio recibido:</label>
                            <button type="submit" name='btnCompletar' id='btnCompletar'>Completar</button>
                            <label>(Nota: recuerda que si hay algún problema con el envio puedes generar una incidencia o devolución)</label>
                        </div>
                    </form>              
                             <%
            if(!(request.getParameter("btnCompletar")==null)){
                ModificarEnvios.modificarEstado(Integer.parseInt(Sesion.getAttribute("codigoInicio").toString()),"Recibido");
                ModificarEnvios.ponerFecha(Integer.parseInt(Sesion.getAttribute("codigoInicio").toString()),"FechaRecibida");
                ModificarPedidos.modificarEstado(Integer.parseInt(ModificarEnvios.BuscarPorIDSinFecha(Integer.parseInt(Sesion.getAttribute("codigoInicio").toString()))[2]), "Completado");
                ModificarProductoTienda.sumarExistenciasDeEnvioRecibido(Integer.parseInt(Sesion.getAttribute("codigoInicio").toString()));
                out.print("<script type='text/javascript'>alert('Se recibio el envio correctamente')</script>");    
                out.print("<script>location.replace('RecibirEnvio.jsp');</script>");
            } 
         %>    
                <div class="divSeparadorInterno">    
                    <h1>Los Productos pedidos son:</h1>
                                <%
                                // Crear la tabla HTML
                                out.println("<table align='center' cellspacing='2' cellpadding='2' border='1' bgcolor=dddddd>");
                                out.println("<tr>");
                                out.println("<td>Nombre del producto</td>");
                                out.println("<td>Costo por unidad</td>");
                                out.println("<td>Cantidad Enviada</td>");
                                out.println("<td>Costo Total por todos los productos</td>");
                                out.println("</tr>");
                                double TotalEnvio =0;
                                while (Rs.next()) {   
                                    String Nombre = Rs.getString("Nombre");
                                    double costo = Rs.getDouble("Costo"); 
                                    int Cantidad = Rs.getInt("Cantidad");
                                    double Total = (costo*Cantidad);
                                    TotalEnvio = Rs.getDouble("Total");
                                    out.println("<tr>");
                                    out.println("<td>" + Nombre + "</td>");
                                    out.println("<td>"+ costo +" Q</td>");
                                    out.println("<td>"+ Cantidad +"</td>");
                                    out.println("<td>"+Total+" Q</td>");
                                    out.println("</tr>");
                                }
                                out.println("<tr>");
                                    out.println("<td>Total del envio:</td>");
                                    out.println("<td</td>");
                                    out.println("<td></td>");
                                    out.println("<td></td>");
                                    out.println("<td>"+TotalEnvio+" Q</td>");
                                    out.println("</tr>");
                            %>        
                        </select>
                 </div>
                </div>
            </div>
        </section>
    </body>
</html>
