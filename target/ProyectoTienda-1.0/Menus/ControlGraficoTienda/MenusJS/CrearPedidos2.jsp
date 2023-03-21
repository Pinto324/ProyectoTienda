<%-- 
    Document   : CrearPedidos2
    Created on : 17/03/2023, 00:29:04
    Author     : branp
             
                   
--%>

<%@page import="Objetos.Envio"%>
<%@page import="java.sql.Date"%>
<%@page import="Objetos.Pedido"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="Objetos.ListaDeProductoPyE"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Crear Pedidos</title>
        <link rel="stylesheet" href="../MenusCSS/CrearPedido2.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Caveat+Brush&display=swap" rel="stylesheet">
    </head>
    <body>
         <!--Información:-->
         <jsp:useBean id="cn" class="BaseDeDatos.Conexion" scope="page"></jsp:useBean>
         <jsp:useBean id="Lista" class="BaseDeDatos.ListaDeProductosPyE" scope="page"></jsp:useBean> 
         <jsp:useBean id="Productos" class="BaseDeDatos.Productos" scope="page"></jsp:useBean> 
         <jsp:useBean id="Usuario" class="BaseDeDatos.Usuarios" scope="page"></jsp:useBean>
         <jsp:useBean id="verificacion" class="Controles.ManejadorDePedidos" scope="page"></jsp:useBean>
         <jsp:useBean id="envios" class="Controles.ManejadorDeEnvios" scope="page"></jsp:useBean>
         <%
            HttpSession Sesion = request.getSession();
            ResultSet Rs = cn.IniciarConexion().executeQuery("select * from Productos;");
            double costoT = 0.00;
            double costoU = 0.00;
            int Codigo = 0;
            int existencia = 0;
         %>   
         <!--Logeo en la pagina-->
        <%          
                if(Sesion.getAttribute("user")!=null&&Sesion.getAttribute("nivel")!=null){                    
                }else{
                    out.print("<script>location.replace('../../../Login.jsp');</script>");
                }
         %>
         <!--seccion de encabezado-->
        <section>
        <header style="z-index: 4;">
            <div class="contenedorGrande">
                <div class="contenedor">
                    <a href="../MenuInicial.jsp" id="logo">Tienda</a>
                </div>
                <div class="contenedor">
                    <p style="font-size: 60px;" id="logo">Creacion de pedidos</p>
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
          <!--seccion de cuerpo-->
        <section id="sectionLibro">
            <div class="contenedorPrincipal">
                <form  method="post" action="#">
                <div class='divDePedido'>
                        <div class="divForm">
                            <div class='divSeparador'>
                                 <div class="divSeparadorInterno">      
                                    <label>Nombre:</label>
                                    <select name="producto" id='nombreProducto'>
                                        <!--Codigo para combobox:--> 
                                        <option name="0" id="option">Seleccione una opcion</option> 
                                        <%
                                            while(Rs.next()){          
                                        %>
                                        <option name="NM"><%=Rs.getString("Nombre")%></option>       
                                        <% }%>  
                                    </select>
                                    <button type="submit" value="Cargar Existencias" name="BtnEx" <%if(request.getParameter("BtnEx")!=null){ %> disabled <% } %>>Cargar existencias</button>
                                 </div>
                                <div class="divSeparadorInterno">                                 
                                    <label>Cantidad de producto:</label>
                                    <input disabled type='number' name='Cantidad' id='cantidad' min='0' max='<%=existencia%>'>                                      
                                </div>
                                <div class="divSeparadorInterno">    
                                    <label>Costo Total:</label>
                                    <input disabled value='<%=costoT%>'>
                                </div>
                            </div>
                            <div class="divSeparador">
                                <div class="divSeparadorInterno">
                                    <label>Codigo del producto:</label>
                                    <input disabled value='0' name="codigo" id="codigo">
                                </div>
                                <div class="divSeparadorInterno">
                                    <label>Costo Unitario:</label>
                                    <input  disabled value='0' id='CostoU'>
                                </div>
                            </div>
                        </div>
                    </div>        
                    <button type="submit" name='BtnEnviar' id='btnEnviar' disabled>Enviar</button>
                    <button href="CrearPedidos2.jsp" type="submit" value="recargar pagina" name="BtnRecargar" >Recargar Pagina</button>
                </form>
            </div>
        </section>
        <%
                    if(request.getParameter("BtnEx")!=null){
                        if(!(request.getParameter("producto").equals("Seleccione una opcion"))){
                           /**Actualización de los datos de la tabla: **/
                            String[] Datos = Productos.BuscarPorNombre(request.getParameter("producto"));
                            Codigo = Integer.parseInt(Datos[0]);
                            costoU = Double.parseDouble(Datos[2]);
                            existencia = Integer.parseInt(Datos[4]);
                            Sesion.setAttribute("CodProducto", Codigo);
                            Sesion.setAttribute("costoU", costoU);
                            out.println("<script>document.getElementById('btnEnviar').disabled = false;</script>");
                            out.println("<script>document.getElementById('producto').value ="+Datos[1]+";</script>"); 
                            out.println("<script>document.getElementById('nombreProducto').disabled = true;</script>"); 
                            out.println("<script>document.getElementById('codigo').value ="+Codigo+";</script>"); 
                            out.println("<script>document.getElementById('CostoU').value ="+costoU+";</script>"); 
                            out.println("<script>document.getElementById('cantidad').max ="+existencia+";</script>"); 
                            out.println("<script>document.getElementById('cantidad').disabled = false;</script>"); 
                        }else{
                            out.print("<script type='text/javascript'>alert('Seleccione un producto valido')</script>");
                            out.print("<script>location.replace('CrearPedidos2.jsp');</script>");
                        }                
                    }else if(request.getParameter("BtnEnviar")!=null){
                        if(Integer.parseInt(request.getParameter("Cantidad"))==0){
                                out.print("<script type='text/javascript'>alert('Ingrese una cantidad valida de producto')</script>");
                        }else{
                            int valor = Integer.parseInt(Sesion.getAttribute("Codigo").toString());                        
                            ListaDeProductoPyE Nuevo = new ListaDeProductoPyE();
                            String[] Carac = Usuario.BuscarPorUsuario(Sesion.getAttribute("user").toString());
                            Nuevo.setIdDelSolicitante(valor);                      
                            Nuevo.setCodigoDelProducto(Integer.parseInt(Sesion.getAttribute("CodProducto").toString()));
                            Nuevo.setCantidad(Integer.parseInt(request.getParameter("Cantidad")));
                            Lista.SubirProductoPedido(Nuevo);
                            Lista.SubirProductoEnvio(Nuevo);
                            costoT = ((Double.valueOf(Sesion.getAttribute("costoU").toString()))*(Double.valueOf(request.getParameter("Cantidad"))));    
                            java.util.Date utilDate = new java.util.Date();
                            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                            Pedido NuevoPedido = new Pedido(valor,Integer.parseInt(Carac[6]),Carac[2],sqlDate,costoT,"Solicitado");
                            Envio NuevoEnvio = new Envio(valor,Integer.parseInt(Carac[6]),valor,null,null,null,costoT,"None");
                            verificacion.SubirPedido(NuevoPedido);
                            envios.SubirEnvio(NuevoEnvio);
                            out.print("<script>location.replace('CrearPedidos3.jsp');</script>");
                        }         
                    }
                %> 
    </body>
</html>