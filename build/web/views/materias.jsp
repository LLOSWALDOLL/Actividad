<%@ page import="java.util.List"%>
<%@ page import="beans.Materias"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dao.MateriasDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="conexion.Conexion"%>

<%
    MateriasDAO materiasDao = new MateriasDAO();
    String cuatrimestreSeleccionado = request.getParameter("tfCuatrimestre");
    List<Materias> materias = new ArrayList<>();

    if (cuatrimestreSeleccionado != null && !cuatrimestreSeleccionado.isEmpty()) {
        materias = materiasDao.mostrarPorCuatrimestre(cuatrimestreSeleccionado);
    } else {
        materias = materiasDao.mostrar();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Materias</title>
    <jsp:include page="../components/estilos.jsp" />
</head>
<body>
    <jsp:include page="../components/menu.jsp" />
    <div class="contenido">         
        <button id="toggleButton" class="hidden" onclick="toggleFormVisibility()">Añadir Materia</button>

        <!-- Formulario de Guardado -->
        <div class="cont-entradas" id="form-container">
            <form action="SvMenu" method='post' id='formulario'>
                <div>
                    <label>Clave materia</label>
                    <input type='text' class='controls' name='tfClaveMat'>
                </div>

                <div>
                    <label>Nombre</label>
                    <input type='text' class='controls' name='tfNombre'>
                </div>
                <div class="select-container">
                    <label class="select-label">Selecciona un cuatrimestre</label>
                    <select id="tfCuatrimestre" name="tfCuatrimestre">
                        <option selected>-Cuatrimestre-</option>
                        <option value="1ro">1ro</option>
                        <option value="2do">2do</option>
                        <option value="3ro">3ro</option>
                        <option value="4to">4to</option>
                        <option value="5to">5to</option>
                        <option value="6to">6to</option>
                        <option value="7mo">7mo</option>
                        <option value="8vo">8vo</option>
                        <option value="9no">9no</option>
                        <option value="10mo">10mo</option>
                        <option value="11vo">11vo</option>
                    </select>
                </div>
                <input type="submit" name="btnMateriaNueva" value="Guardar">
            </form>    
        </div>

        <!-- Botón de Filtrado -->
        <div class="select-container">
            <label class="select-label">Filtrar por cuatrimestre</label>
            <select id="tfCuatrimestreFiltro" name="tfCuatrimestreFiltro">
                <option selected>-Cuatrimestre-</option>
                <option value="1ro">1ro</option>
                <option value="2do">2do</option>
                <option value="3ro">3ro</option>
                <option value="4to">4to</option>
                <option value="5to">5to</option>
                <option value="6to">6to</option>
                <option value="7mo">7mo</option>
                <option value="8vo">8vo</option>
                <option value="9no">9no</option>
                <option value="10mo">10mo</option>
                <option value="11vo">11vo</option>
            </select>
            <button onclick="filtrarMaterias()">Filtrar</button>
        </div>

        <!-- Tabla de Materias Filtradas -->
        <div class="tabla-mat">
            <table>
                <thead>
                    <tr>
                        <th scope="col">Clave Materia</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Cuatrimestre</th>
                        <th colspan="2">ACCIONES</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Materias materia : materias) {
                    %>
                        <tr>
                            <td><%= materia.getClaveMateria()%></td>
                            <td><%= materia.getNombre()%></td>
                            <td><%= materia.getCuatrimestre()%></td>
                            <td><a href="SvMenu?accion=editar&claveMateria=<%= materia.getClaveMateria()%>" class="editar">Editar</a></td>
                            <td><a href="SvMenu?accion=eliminar&claveMateria=<%= materia.getClaveMateria()%>" class="eliminar">Eliminar</a></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <jsp:include page="../components/scripts.jsp" />
    <script>
        function filtrarMaterias() {
            var cuatrimestreSeleccionado = document.getElementById('tfCuatrimestreFiltro').value;
            window.location.href = 'TuServletDeFiltrado?tfCuatrimestre=' + cuatrimestreSeleccionado;
        }
    </script>
</body>
</html>



