package controlador;

import dao.CalificacionesDAO1;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;

@WebServlet("/capturarCalificaciones")
public class CapturarCalificacionesServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            String materiaSeleccionada = request.getParameter("materia");
            String parcialSeleccionado = request.getParameter("parcial");
            session.setAttribute("materiaSeleccionada", materiaSeleccionada);
            session.setAttribute("parcialSeleccionado", parcialSeleccionado);

            if (materiaSeleccionada != null && parcialSeleccionado != null) {
                CalificacionesDAO1 calificacionesDAO = new CalificacionesDAO1();

                // Obtener el nombre de la materia
                String nombreMateria = calificacionesDAO.obtenerNombreMateria(materiaSeleccionada);
                request.setAttribute("nombreMateria", nombreMateria);

                // Agregar la lógica para manejar la selección de "Todos"
                if ("Todos".equals(parcialSeleccionado)) {
                    // Lógica para recuperar todas las calificaciones de todos los parciales
                    ResultSet rsAlumnos = calificacionesDAO.obtenerTodasLasCalificaciones(materiaSeleccionada);

                    List<AlumnoCalificacion> listaAlumnos = new ArrayList<>();

                    while (rsAlumnos.next()) {
                        String matriculaAlumno = rsAlumnos.getString("MatriculaAlumno");
                        String nombreAlumno = rsAlumnos.getString("NombreAlumno");
                        double calificacionParcial1 = rsAlumnos.getDouble("Parcial1");
                        double calificacionParcial2 = rsAlumnos.getDouble("Parcial2");
                        double calificacionParcial3 = rsAlumnos.getDouble("Parcial3");

                        AlumnoCalificacion alumno = new AlumnoCalificacion(matriculaAlumno, nombreAlumno, nombreMateria, calificacionParcial1, calificacionParcial2, calificacionParcial3);
                        listaAlumnos.add(alumno);
                    }

                    request.setAttribute("parcialSeleccionado", "Todos");
                    request.setAttribute("alumnos", listaAlumnos);
                } else {
                    // Lógica para recuperar calificaciones del parcial seleccionado
                    ResultSet rsAlumnos = calificacionesDAO.obtenerAlumnosConParcial(materiaSeleccionada, parcialSeleccionado);

                    List<AlumnoCalificacion> listaAlumnos = new ArrayList<>();

                    while (rsAlumnos.next()) {
                        String matriculaAlumno = rsAlumnos.getString("MatriculaAlumno");
                        String nombreAlumno = rsAlumnos.getString("NombreAlumno");
                        double calificacionParcial = rsAlumnos.getDouble(parcialSeleccionado);

                        AlumnoCalificacion alumno = new AlumnoCalificacion(matriculaAlumno, nombreAlumno, nombreMateria, calificacionParcial);
                        listaAlumnos.add(alumno);
                    }

                    request.setAttribute("parcialSeleccionado", parcialSeleccionado);
                    request.setAttribute("alumnos", listaAlumnos);
                }
            } else {
                request.setAttribute("mensaje", "No hay calificaciones disponibles para el parcial y materia seleccionados.");
            }

            // Almacenar los valores en la sesión
            request.getRequestDispatcher("/views/capturarCalificaciones.jsp").forward(request, response);
        } catch (SQLException | NamingException | ServletException | IOException e) {
            // Manejo de excepciones...
        }
    }
}



