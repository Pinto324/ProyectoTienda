<%-- 
    Document   : Login
    Created on : 26/02/2023, 19:01:53
    Author     : branp
--%>

<%@page import="javax.swing.JOptionPane"%>
<%@page session="true" %>
<%@page import="java.util.Set"%>
<%@page import="Controles.ValidadorDeLogin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Mi Mueblería</title>
            
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/solid.css">
        <script src="https://use.fontawesome.com/releases/v5.0.7/js/all.js"></script>

        <link rel="stylesheet" type="text/css" href="resources/index.css" th:href="@{/resources/index.css}">
    </head>
    <body> 
        <!--Login:-->
                <div class="modal-dialog text-center">
                    <div class="col-sm-8 main-section">
                        <div class="modal-content">
                            <div class="col-12 user-img">
                                <img src="resources/Imagenes/avatar.png" th:src="@{img/avatar.png}"/>
                            </div>
                            <form class="col-12" th:action="@{/login}" method="get">
                                <div class="form-group" id="user-group">
                                    <input type="text" class="form-control" placeholder="Nombre de usuario" name="user" value=""/>
                                </div>
                                <div class="form-group" id="contrasena-group">
                                    <input type="password" class="form-control" placeholder="Contraseña" name="pass"/>
                                </div>
                                <button type="submit" class="btn btn-primary" name="Comprobar"><i class="fas fa-sign-in-alt"></i>  Ingresar </button>
                            </form>
                            <div id="Creador">
                                <p> Hecho por: Brandon Pinto</p>
                            </div>
                        </div>
                    </div>
                </div>                                   
    </body>
    <!--Seleccion de login:-->
    <% 
        if(request.getParameter("Comprobar")!=null){
            String CampoU = request.getParameter("user");
            String CampoP = request.getParameter("pass");
            if(!(CampoU.equals(""))&&!(CampoP.equals(""))){
                ValidadorDeLogin Inicio = new ValidadorDeLogin(CampoU,CampoP);
                String Us = Inicio.ComprobarUsuario();
                if(!(Us.equals("Fail2"))){
                    HttpSession Sesion = request.getSession();
                    switch(Us){
                        case "Fail":
                            out.print("<script type='text/javascript'>alert('El nombre de usuario o la contraseña no coinciden')</script>");
                            break;
                        case "Tienda":
                            Sesion.setAttribute("user", CampoU);
                            Sesion.setAttribute("nivel", "1");
                            Inicio.setNombreUsuario(CampoU);
                            response.sendRedirect("Menus/ControlGraficoTienda/MenuInicial.jsp");
                            break;
                        case "Supervisor":
                            Sesion.setAttribute("user", CampoU);
                            Sesion.setAttribute("nivel", "2");
                            Inicio.setNombreUsuario(CampoU);
                            response.sendRedirect("Menus/Ventas.jsp");
                            break;
                        case "Bodega":
                            Sesion.setAttribute("user", CampoU);
                            Sesion.setAttribute("nivel", "3");
                            Inicio.setNombreUsuario(CampoU);
                            response.sendRedirect("Menus/ControlGraficoAlmacen/MenuInicialAlmacen.jsp");
                            break;
                        case "Admin":
                            Sesion.setAttribute("user", CampoU);
                            Sesion.setAttribute("nivel", "4");
                            Inicio.setNombreUsuario(CampoU);
                            response.sendRedirect("Menus/ControlGraficoAdministracion/MenuInicialAdmin.jsp");
                            break;
                        default:
                            break;
                    }
                }else{
                     out.print("<script type='text/javascript'>alert('No se encontró un usuario en el sistema con ese nombre')</script>");
                    }
            }else{ 
                out.print("<script type='text/javascript'>alert('llene los campos deseados')</script>");
            }
        }
        //Cerrando sesion
        if(request.getParameter("cerrar")!=null){
            session.invalidate();
            ValidadorDeLogin Inicio = new ValidadorDeLogin();
            Inicio.setNombreUsuario(null);
        }
    %>
</html>
