<%-- 
    Document   : MenuInicialAlmacen
    Created on : 19/03/2023, 00:29:25
    Author     : branp
--%>

<%@page import="java.io.File"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Menu Admin</title>
        <link rel="stylesheet" href="MenuInicialAdmin.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Caveat+Brush&display=swap" rel="stylesheet">
    </head>
    <body>
        <!--Logeo en la pagina-->
        <%
            HttpSession Sesion = request.getSession();
                if(Sesion.getAttribute("user")!=null&&Sesion.getAttribute("nivel")!=null){     
                }else{
                    out.print("<script>location.replace('../../Login.jsp');</script>");
                }
         %>
          <jsp:useBean id="cn" class="Controles.CargaDeArchivo" scope="page"></jsp:useBean>
         <section>
        <header style="z-index: 4;">
            <div class="contenedorGrande">
                <div class="contenedor">
                    <div class="nav-link" id="menuReportes">
                        <img src="https://cdn-icons-png.flaticon.com/512/4701/4701237.png" width="60" height="60">
                        <label>Reportes</label>
                    </div>
                    <a href="MenusJSP/UsuariosDeTienda.jsp" class="nav-link">
                        <img src="https://cdn-icons-png.flaticon.com/512/3624/3624080.png" width="60" height="60">
                        <label>Usuarios de tienda</label>
                    </a>
                </div>
                <div class="contenedor">
                    <a href="MenuInicialAlmacen.jsp" id="logo">Administración</a>
                </div>
                <div class="contenedor">
                    <a href="MenusJSP/UDeBodega.jsp" class="nav-link">
                        <img src="https://cdn-icons-png.flaticon.com/512/5430/5430734.png" width="60" height="60">
                        <label>Usuarios de bodega</label>
                    </a>
                    <a href="" class="nav-link">
                        <img src="https://cdn-icons-png.flaticon.com/512/9770/9770725.png" width="60" height="60">
                        <label>Usuarios Supervisores</label>
                    </a>
                    <a class="nav-link" href="../../Login.jsp?cerrar=true">
                        <img src="https://cdn-icons-png.flaticon.com/512/2574/2574200.png" width="60" height="60">
                        <label>Cerrar Sesión</label>
                    </a>
                </div>
            </div>
        </header>
    </section>
        <section id="sectionLibro">
            <div class="contenedorPrincipal">
                <div class="menuDesplegable">
                    <ul class="nav">
                       <a href="MenusJSP</ReporteTiendas.jsp" class="link">Reporte de Tiendas</a>
                       <a href="#" class="link">Reporte de Envios</a>
                       <a href="#" class="link">Reporte de Pedidos</a>
                       <a href="#" class="link">Reporte de Producto</a>
                    </ul>
                </div>
                <div class="">
                    <div class=""></div>
                    <ul>
<form action="upload.jsp" method="post" enctype="multipart/form-data">
    <input type="file" name="jsonFile">
    <input type="submit" value="Enviar">
</form>
                    </ul>
                </div>
            </div>
        </section>
        <script src="MenuInicialAdmin.js"></script>
        <%@ page import="java.io.*, com.fasterxml.jackson.databind.*" %>
     <%   
    // Obtener el archivo enviado en el formulario
    Part filePart = request.getPart("jsonFile");

    // Leer el contenido del archivo y convertirlo en un objeto JSON
    InputStream fileContent = filePart.getInputStream();
    ObjectMapper mapper = new ObjectMapper();
    JsonNode jsonNode = mapper.readTree(fileContent);
    JSONObject jsonObject = new JSONObject(jsonNode.toString());
    cn.doPost(jsonObject);
        %>
    </body>
</html>
