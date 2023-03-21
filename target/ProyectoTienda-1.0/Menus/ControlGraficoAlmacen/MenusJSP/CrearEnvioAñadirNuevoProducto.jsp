<%-- 
    Document   : CrearEnvioAñadirNuevoProducto
    Created on : 19/03/2023, 16:50:20
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
        <title>Crear Pedidos</title>
        <link rel="stylesheet" href="../MenusCSS/CrearEnvio1.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Caveat+Brush&display=swap" rel="stylesheet">
    </head>
    <body>
        <!--Variables-->
         <jsp:useBean id="cn" class="BaseDeDatos.Conexion" scope="page"></jsp:useBean>
         <jsp:useBean id="Lista" class="BaseDeDatos.ListaDeProductosPyE" scope="page"></jsp:useBean> 
         <jsp:useBean id="producto" class="BaseDeDatos.Productos" scope="page"></jsp:useBean> 
        <!--Logeo en la pagina-->
        <%
            HttpSession Sesion = request.getSession();
            ResultSet Rs = cn.IniciarConexion().executeQuery("select * from Productos");
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
                    <p style="font-size: 60px;" id="logo">Creacion de Envios</p>
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
                     <form method="get" action="#">
                        <div class="divSeparadorInterno">    
                            <h1>Ingrese el nombre del producto a añadir:</h1>
                            <select name='producto' id='codigoTienda'>
                                <option name='0'>Seleccione el nombre del producto</option>");
                            <%  while(Rs.next()){ %>
                                <option><%=Rs.getString("Nombre")%></option>
                            <%  } %>   
                            </select>
                            <button name='BtnEnviar'>Añadir</button>                                   
                        </div>
                    </form>
                </div>    
            </div>
        </section>
        <%
                    if(request.getParameter("BtnEnviar")!=null){
                        if(request.getParameter("producto").equals("Seleccione el nombre del producto")){
                            out.print("<script type='text/javascript'>alert('Por favor, llene los campos con los datos requeridos.')</script>");
                            out.print("<script>location.replace('CrearEnvioAñadirNuevoProducto.jsp');</script>");
                        }else{
                            ListaDeProductoPyE nuevo = new ListaDeProductoPyE(Integer.parseInt(Sesion.getAttribute("codigoInicio").toString()),Integer.parseInt(producto.BuscarPorNombre(request.getParameter("producto"))[0]),0);
                            Lista.SubirProductoEnvio(nuevo);
                            out.print("<script>location.replace('CrearEnvio2.jsp');</script>");
                        }
                    }
        %> 
    </body>
</html>
