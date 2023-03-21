<%-- 
    Document   : CrearPedidos
    Created on : 17/03/2023, 00:26:44
    Author     : branp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Crear Pedidos</title>
        <link rel="stylesheet" href="../MenusCSS/CrearPedidos1.css">
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
        <section id="sectionLibro">
            <div class="contenedorPrincipal">
                <div class='divSeparador'>   
                     <form method="get" action="#">
                        <div class="divSeparadorInterno">    
                            <h1>Ingrese el codigo del pedido:</h1>
                            <input type="number" id="codigoDePedido" name="codigoDePedido">
                            <button name='BtnEnviar'>Enviar</button>                                   
                        </div>
                    </form>
                </div>    
            </div>
        </section>
        <%
                    if(request.getParameter("BtnEnviar")!=null){
                        if(request.getParameter("codigoDePedido").equals("")){
                            out.print("<script type='text/javascript'>alert('Por favor, llene los campos con los datos requeridos.')</script>");
                            out.print("<script>location.replace('CrearPedidos1.jsp');</script>");
                        }else{
                            if(verificacion.ComprobarSiExistePedido(Integer.parseInt(request.getParameter("codigoDePedido")))){
                                Sesion.setAttribute("Codigo", Integer.parseInt(request.getParameter("codigoDePedido")));
                                out.print("<script>location.replace('CrearPedidos2.jsp');</script>");
                            }else{
                                out.print("<script type='text/javascript'>alert('Ya existe un pedido con ese codigo, porfavor use otro.')</script>");
                                out.print("<script>location.replace('CrearPedidos1.jsp');</script>");
                            }
                        }
                    }
        %> 
    </body>
</html>
