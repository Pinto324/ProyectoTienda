<%-- 
    Document   : CrearPedidos4
    Created on : 18/03/2023, 13:06:06
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
                <form action="#" class="form">
                <div class='divDePedido'>
                        <div class="divForm">
                            <div class='divSeparador'>                          
                                <div class="divSeparadorInterno">    
                                    <form method="post" action="CrearPedidos1.jsp">
                                        <h2>El pedido a sido creado correctamente!</h2>
                                        <button type="submit" name="btnRegresar">Hacer otro pedido</button>
                                        <button type="submit" name="btnMenu">Volver al menu inicial</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>     
                </form>
            </div>
        </section>
        <%
            if(request.getParameter("btnRegresar")!=null){
                out.print("<script>location.replace('CrearPedidos1.jsp');</script>");
            }else if(request.getParameter("btnMenu")!=null){
                out.print("<script>location.replace('../MenuInicial.jsp');</script>");
            }                
                %> 
    </body>
</html>
