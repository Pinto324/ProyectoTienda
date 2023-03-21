<%-- 
    Document   : UDBAñadir
    Created on : 21/03/2023, 13:25:27
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
        <title>Gestión de usuarios de bodega</title>
        <link rel="stylesheet" href="../MenusCSS/UDBAñadir.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Caveat+Brush&display=swap" rel="stylesheet">
    </head>
    <body>
        <!--Variables-->
         <jsp:useBean id="cn" class="BaseDeDatos.Conexion" scope="page"></jsp:useBean>
         <jsp:useBean id="Lista" class="BaseDeDatos.ListaDeProductosPyE" scope="page"></jsp:useBean> 
         <jsp:useBean id="Tiendas" class="BaseDeDatos.TiendasDeUsuarioDeBodega" scope="page"></jsp:useBean> 
        <!--Logeo en la pagina-->
        <%
            HttpSession Sesion = request.getSession();
            ResultSet Rs = cn.IniciarConexion().executeQuery("select * from Tienda");
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
                    <p style="font-size: 60px;" id="logo">Gestión de usuarios de Bodega</p>
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
                            <h1>Ingrese el codigo de la tienda que desea añadir:</h1>
                            <select name='producto' id='codigoTienda'>
                            <%  while(Rs.next()){ %>
                                <option><%=Rs.getString("Codigo")%></option>
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
                        int CodigoUsuario = Integer.parseInt(Sesion.getAttribute("codigoValorModificar").toString());
                        int CodigoTiendanueva = Integer.parseInt(request.getParameter("producto"));
                        if( !(Tiendas.ComprobarSiExiteTienda(CodigoUsuario, CodigoTiendanueva)) ){
                            out.print("<script type='text/javascript'>alert('El usuario ya cuenta con esa tienda asignada')</script>");
                            out.print("<script>location.replace('UDBAñadir.jsp');</script>");
                        }else{
                            Tiendas.SubirMuevaTienda(CodigoUsuario,CodigoTiendanueva);
                            out.print("<script type='text/javascript'>alert('Se agrego la nueva tienda con exito')</script>");
                            out.print("<script>location.replace('UDeBodegaModificarTiendas.jsp');</script>");
                        }
                    }
        %> 
    </body>
</html>
