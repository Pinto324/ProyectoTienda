<%-- 
    Document   : RecibirEnvio
    Created on : 20/03/2023, 16:14:33
    Author     : branp
--%>

<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Crear Envio</title>
        <link rel="stylesheet" href="../MenusCSS/RecibirEnvio.css">
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
            ResultSet Rs = cn.IniciarConexion().executeQuery("select * from Envios WHERE Estado = 'Despachado' AND CodigoTienda = '"+Tienda.BuscarPorUsuario(Sesion.getAttribute("user").toString())[6]+"';");
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
                    <form action="#">
                        <div class="divSeparadorInterno"> 
                        <select name="codigo" id='codigoTienda'>
                            <!--Codigo para combobox:--> 
                            <option name="0" id="option">Seleccione el codigo del Envio que desea ver</option> 
                            <%
                                while(Rs.next()){          
                            %>
                            <option name="NM"><%=Rs.getInt("CodigoTienda")%></option>       
                         <% }%>  
                        </select>
                        <button type="submit" name='btnFiltrar' id='btnEnviar'>Filtrar</button>
                        </div>
                    </form>
                             <%
             if(request.getParameter("btnFiltrar")!=null){
                 if(request.getParameter("codigo").equals("Seleccione un codigo para filtrar")){
                    out.print("<script type='text/javascript'>alert('Ingrese un codigo para filtrar valido')</script>");
                    out.print("<script>location.replace('RecibirEnvio.jsp');</script>");
                 }else{
                     Rs = cn.IniciarConexion().executeQuery("select * from Envios WHERE Id="+request.getParameter("codigo")
                     );
                 }
            }
         %>
                        <div class="divSeparadorInterno">    
                            <h1>Los Envios pendientes de recibir son:</h1>
                                <%
                                // Reiniciamos el cursor
                                Rs.beforeFirst();
                                // Crear la tabla HTML
                                out.println("<table align='center' cellspacing='2' cellpadding='2' border='1' bgcolor=dddddd>");
                                out.println("<tr>");
                                out.println("<td>Usuario que realizo el envio</td>");
                                out.println("<td>Codigo del pedido vinculado a este envio</td>");
                                out.println("<td>Fecha de salida del envio</td>");
                                out.println("<td>Total del envio</td>"); 
                                out.println("</tr>");
                                SimpleDateFormat FormatoFecha = new SimpleDateFormat("yyyy-MM-dd");
                                while (Rs.next()) {
                                    String user = Rs.getString("Usuario");
                                    String codigo = Rs.getString("PedidoVinculado");
                                    String fecha = FormatoFecha.format(Rs.getDate("FechaSalida"));
                                    int Total = Rs.getInt("Total");
                                    int c = Rs.getInt("Id");
                                    out.println("<tr>");
                                    out.println("<td>" + user + "</td>");
                                    out.println("<td>"+ codigo +"</td>");
                                    out.println("<td>"+ fecha +"</td>");
                                    out.println("<td>"+ Total +" Q</td>");
                                    out.println("<td><a href='RecibirEnvio2.jsp?codigo=" + c + "'>Ver detalle</a></td>");
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
