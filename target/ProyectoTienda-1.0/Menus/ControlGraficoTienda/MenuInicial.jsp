<%-- 
    Document   : MenuInicial
    Created on : 26/02/2023, 19:09:51
    Author     : branp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Menu Tienda</title>
        <link rel="stylesheet" href="MenuInicial2.css">
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
        <section>
        <header style="z-index: 4;">
            <div class="contenedorGrande">
                <div class="contenedor">
                    <div class="nav-link" id="menuReportes">
                        <img src="https://cdn-icons-png.flaticon.com/512/4701/4701237.png" width="60" height="60">
                        <label>Reportes</label>
                    </div>
                    <a href="MenusJS/CrearPedidos1.jsp" class="nav-link">
                        <img src="https://cdn-icons-png.flaticon.com/512/3624/3624080.png" width="60" height="60">
                        <label>Crear Pedido</label>
                    </a>
                    <a href="MenusJS/RecibirEnvio.jsp" class="nav-link">
                        <img src="https://cdn-icons-png.flaticon.com/512/6384/6384822.png" width="60" height="60">
                        <label>Recibir Envio</label>
                    </a>
                </div>
                <div class="contenedor">
                    <a href="MenuInicial.jsp" id="logo">Tienda</a>
                </div>
                <div class="contenedor">
                    <a href="" class="nav-link">
                        <img src="https://cdn-icons-png.flaticon.com/512/4931/4931082.png" width="60" height="60">
                        <label>Crear Incidencia</label>
                    </a>
                    <a href="" class="nav-link">
                        <img src="https://cdn-icons-png.flaticon.com/512/2279/2279674.png" width="60" height="60">
                        <label>Crear Devolución</label>
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
                       <a href="MenusJS/ReporteDeProductos.jsp" class="link">Reporte de productos</a>
                       <a href="MenusJS/ReporteDePedidos.jsp" class="link">Reporte de pedidos</a>
                       <a href="#" class="link">Reporte de envíos</a>
                       <a href="#" class="link">Reporte de incidencias</a>
                       <a href="#" class="link">Reporte de devoluciones</a>
                    </ul>
                </div>
                <div class="slider">
                    <div class="slide"></div>
                    <ul>
                        <a href="MenusJS/CrearPedidos1.jsp">
                            <li>
                                <div class="contenedorSlider">
                                    <p>Te quedaste sin productos? Crea un pedido!</p>
                                    <div class="slider-inner">
                                        <img src="https://img.freepik.com/vector-gratis/recepcion-pedidos-telefono-centro-contacto-tienda-atencion-al-cliente-pedido-facil-entrega-rapida-servicio-comercial-personaje-dibujos-animados-operador-centro-llamadas_335657-2564.jpg?w=740&t=st=1677741388~exp=1677741988~hmac=2ee355176b925579e2188745be8e09908c6093d1693093442f3b41b873f59925" alt="Imagen de crear un pedido">
                                        <p>Clickea para ir</p>
                                    </div>
                                </div>
                            </li>
                        </a>
                        <a href="!">
                            <li>
                                <div class="contenedorSlider">
                                    <p>Tu pedido tiene algún problema? Puedes devolverlo</p>
                                    <div class="slider-inner">
                                        <img style="width: 9vw; height: 18vh;" src="https://track-gear.com/sites/default/files/sites/default/files/devoluciones/prepara-el-producto-blanco_0.svg" alt="Imagen de crear un pedido">
                                        <p>Clickea para más info!</p>
                                    </div>
                                </div>
                            </li>
                        </a>
                        <a href="MenusJS/RecibirEnvio.jsp">
                            <li>
                                <div class="contenedorSlider">
                                    <p>Recibiste algún envio? recuerda confirmar que lo recibiste!</p>
                                    <div class="slider-inner">
                                        <p>Clickea para confirmar</p>
                                        <img style="width: 9vw; height: 18vh;" src="https://storage.googleapis.com/ivoy-cms-production-664d3763/media/order_delivered_2_1_3f428cdde7/order_delivered_2_1_3f428cdde7.png" alt="Imagen de crear un pedido">
                                    </div>
                                </div>
                            </li>
                        </a>
                    </ul>
                </div>
            </div>
        </section>
        <script src="MenuInicial.js"></script>
    </body>
</html>
