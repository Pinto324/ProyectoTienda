<%-- 
    Document   : UsuariosDeTiendaCrear
    Created on : 21/03/2023, 09:47:29
    Author     : branp
--%>

<%@page import="Objetos.Usuario"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Crear Usuario</title>
        <link rel="stylesheet" href="../MenusCSS/UsuariosDeTienda.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Caveat+Brush&display=swap" rel="stylesheet">
    </head>
    <body>
        <!--Variables-->
         <jsp:useBean id="cn" class="BaseDeDatos.Conexion" scope="page"></jsp:useBean>
         <jsp:useBean id="Usuario" class="BaseDeDatos.Usuarios" scope="page"></jsp:useBean>
        <!--Logeo en la pagina-->
        <%
            HttpSession Sesion = request.getSession();
            ResultSet CT = cn.IniciarConexion().executeQuery("select * from Tienda;");     
            if(Sesion.getAttribute("user")!=null&&Sesion.getAttribute("nivel")!=null){                    
                }else{
                    out.print("<script>location.replace('../../../Login.jsp');</script>");
                }
         %>  
        <!--Información:-->
        <jsp:useBean id="verificacion" class="Controles.ManejadorDePedidos" scope="page"></jsp:useBean>
        <jsp:useBean id="ManejadorUsuarios" class="Controles.ManejadorUsuario" scope="page"></jsp:useBean>
        <section>
        <header style="z-index: 4;">
            <div class="contenedorGrande">
                <div class="contenedor">
                    <a href="../MenuInicialAdmin.jsp" id="logo">Administración</a>
                </div>
                <div class="contenedor">
                    <p style="font-size: 60px;" id="logo">Gestión de usuarios de tienda</p>
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
                    <form action="" method="post" >
                        <div class="divSeparadorInterno"> 
                            <label>Crear Nuevo Usuario de tienda</label>
                            <button type="submit" name='btnGuardar' id='btnCompletar'>Crear</button>  
                        </div>
                        <div class="divSeparadorInterno"> 
                            <table align='center' cellspacing='2' cellpadding='2' border='1' bgcolor=dddddd>
                                <tr>
                                <td>Codigo:</td>
                                <td>Nombre:</td>
                                <td>UserName:</td>
                                <td>Contraseña:</td>
                                <td>Email:</td>
                                <td>Codigo de la tienda encargada:</td>
                                </tr><tr>
                                <td><%=Sesion.getAttribute("Codigo").toString()%></td>
                                <td><input name='user'></td>
                                <td><input name='nombre'></td>
                                <td><input type='password' name='pass'></td>
                                <td><input name='email'></td>
                                <td><select name='tienda'>
                                <%while(CT.next()){%>
                                <option><%=CT.getInt("Codigo")%></option>
                                <%}%>
                                </select></td>
                                </tr>
                            </table>
                        </div>
                             
                             <%
            if(request.getParameter("btnGuardar")!=null){
                int codigo = Integer.parseInt(Sesion.getAttribute("Codigo").toString());
                String Nombre = request.getParameter("nombre");
                String user = request.getParameter("user");
                String contraseña = Usuario.EncriptarContraseña(request.getParameter("pass"));
                String email = request.getParameter("email");
                int tienda = Integer.parseInt(request.getParameter("tienda"));
                Usuario User = new Usuario(codigo,Nombre,user,contraseña,email,"Tienda",tienda);
                if(ManejadorUsuarios.ComprobarUserNameIgual(user)){
                    if(ManejadorUsuarios.CrearUsuario(User)){
                        out.print("<script type='text/javascript'>alert('Se creo el usuario con exito')</script>"); 
                        out.print("<script>location.replace('UsuariosDeTienda.jsp');</script>");
                    }else{
                        out.print("<script type='text/javascript'>alert('Ocurrio un error al intentar crear')</script>");    
                        out.print("<script>location.replace('UsuariosDeTiendaCrear.jsp');</script>");
                    }
                }else{
                    out.print("<script type='text/javascript'>alert('No puede haber 2 usuarios con el UserName Igual, cambielo porfavor')</script>"); 
                    out.print("<script>location.replace('UsuariosDeTiendaCrear.jsp');</script>");
                }   
            } 
         %>            
                        </div>
                    </form>  
                </div>    
            </div>
        </section>
    </body>
</html>
