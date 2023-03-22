<%-- 
    Document   : Archivo
    Created on : 21/03/2023, 18:04:18
    Author     : branp
--%>

<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="sun.security.util.IOUtils"%>
<%@page import="java.io.InputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <jsp:useBean id="cn" class="Controles.CargaDeArchivo" scope="page"></jsp:useBean>
    <body>
<%
   Part archivoPart = request.getPart("archivoJson");
   InputStream archivoInputStream = archivoPart.getInputStream();
   BufferedReader reader = new BufferedReader(new InputStreamReader(archivoInputStream));
   String jsonString = "";
   String line = null;
   while ((line = reader.readLine()) != null) {
      jsonString += line;
   }
   cn.doPost(line);
%>
        <h1>Hello World!</h1>
    </body>
</html>
