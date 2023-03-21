<%-- 
    Document   : UsuariosDeTiendaModificar
    Created on : 21/03/2023, 01:47:01
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
        <title>Modificar Usuario</title>
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
            try{
                if(request.getParameter("codigo")!=null||request.getParameter("codigo").equals("")){
                    Sesion.setAttribute("codigoInicio", request.getParameter("codigo"));
                }
            }
            catch (NullPointerException ex) {    
            }
           
            ResultSet Rs = cn.IniciarConexion().executeQuery("select * from Usuarios WHERE Codigo='"+Sesion.getAttribute("codigoInicio")+"';");
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
                            <label>Guardar cambios</label>
                            <button type="submit" name='btnGuardar' id='btnCompletar'>Guardar</button>
                        </div>
                             
                             <%
            if(request.getParameter("btnGuardar")!=null){
                int codigo = Integer.parseInt(Sesion.getAttribute("codigoInicio").toString());
                String Nombre = request.getParameter("nombre");
                String user = request.getParameter("user");
                    String contraseña = Usuario.EncriptarContraseña(request.getParameter("pass"));
                    String email = request.getParameter("email");
                    int tienda = Integer.parseInt(request.getParameter("tienda"));
                    Usuario User = new Usuario(codigo,Nombre,user,contraseña,email,"Tienda",tienda);
                    if(ManejadorUsuarios.ModificarTodo(User)){
                        out.print("<script type='text/javascript'>alert('Se modifico el usuario con exito')</script>");    
                        response.sendRedirect("UsuariosDeTienda.jsp");
                    }else{
                        out.print("<script type='text/javascript'>alert('Al modificar no puedes dejar el usuario con el mismo nombre, no se guardaron los cambios')</script>");    
                        response.sendRedirect("UsuariosDeTiendaModificar.jsp");
                    }   
            } 
         %>            
                <div class="divSeparadorInterno">    
                    <h1>Los datos del usuario son:</h1>
                     <%
                                // Reiniciamos el cursor
                                Rs.beforeFirst();
                                //rs de los codigos de tienda:
                                ResultSet CT = cn.IniciarConexion().executeQuery("select * from Tienda;");
                                // Crear la tabla HTML
                                out.println("<table align='center' cellspacing='2' cellpadding='2' border='1' bgcolor=dddddd>");
                                out.println("<tr>");
                                out.println("<td>Codigo:</td>");
                                out.println("<td>Nombre:</td>");
                                out.println("<td>UserName:</td>");
                                out.println("<td>Contraseña:</td>");
                                out.println("<td>Email:</td>");
                                out.println("<td>Codigo de la tienda encargada:</td>");
                                out.println("</tr>");
                                while (Rs.next()) {
                                    int codigo = Rs.getInt("Codigo");
                                    String nombre = Rs.getString("Nombre");
                                    String user = Rs.getString("UserName");
                                    String email = Rs.getString("Email");
                                    String Contra = Rs.getString("Password");
                                    int tienda = Rs.getInt("CodigoDeTienda");
                                    out.println("<tr>");
                                    out.println("<td>" + codigo + "</td>");
                                    out.println("<td><input name='nombre' value='"+ nombre +"'></td>");
                                    out.println("<td><input name='user' value='"+ user +"'></td>");
                                    out.println("<td><input name='pass' value='"+Contra+"'</td>");
                                    out.println("<td><input name='email' value='"+ email +"'</td>");
                                    out.println("<td><select name='tienda'><option name='0' id='option'>"+tienda+"</option>");
                                    while(CT.next()){
                                        out.println("<option>"+CT.getInt("Codigo")+"</option>");
                                    }
                                    out.println("</select></td>");                     
                                    out.println("</tr>");
                                }
                                out.println("</table>");
                            %>       
                        </select>
                        </div>
                    </form>  
                </div>    
            </div>
        </section>
    </body>
</html>
