package dao;

import beans.Materias;
import conexion.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MateriasDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;
    private Materias materias;

    public List<Materias> mostrar() throws ClassNotFoundException {
        String sql = "SELECT * FROM materias";
        List<Materias> materia = new ArrayList();

        try {
            this.conn = Conexion.getConexion();
            this.ps = this.conn.prepareStatement(sql);
            this.rs = this.ps.executeQuery();

            while (this.rs.next()) {
                String claveMat = this.rs.getString("ClaveMateria");
                String nombre = this.rs.getString("Nombre");
                String cuatrimestre = this.rs.getString("Cuatrimestre");

                this.materias = new Materias(claveMat, nombre, cuatrimestre);
                materia.add(this.materias);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            cerrarRecursos();
        }
        return materia;
    }

    public List<Materias> mostrarPorCuatrimestre(String cuatrimestre) throws ClassNotFoundException {
        String sql = "SELECT * FROM materias WHERE Cuatrimestre = ?";
        List<Materias> materia = new ArrayList();

        try {
            this.conn = Conexion.getConexion();
            this.ps = this.conn.prepareStatement(sql);
            this.ps.setString(1, cuatrimestre);
            this.rs = this.ps.executeQuery();

            while (this.rs.next()) {
                String claveMat = this.rs.getString("ClaveMateria");
                String nombre = this.rs.getString("Nombre");
                String cuatrimestreBD = this.rs.getString("Cuatrimestre");

                this.materias = new Materias(claveMat, nombre, cuatrimestreBD);
                materia.add(this.materias);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            cerrarRecursos();
        }
        return materia;
    }

    public boolean agregar(Materias materia) throws ClassNotFoundException {
        String sql = "INSERT INTO materias VALUES('" +
                materia.getClaveMateria() + "'," +
                "'" + materia.getNombre() + "'," +
                "'" + materia.getCuatrimestre() + "')";
        try {
            conn = Conexion.getConexion();
            ps = conn.prepareStatement(sql);
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            cerrarRecursos();
        }

        return true;
    }

    public boolean editar(Materias materia, String old) throws ClassNotFoundException {
        String sql = "UPDATE materias SET " +
                " ClaveMateria      = '" + materia.getClaveMateria() + "'," +
                " Nombre            = '" + materia.getNombre() + "'," +
                " Cuatrimestre      = '" + materia.getCuatrimestre() + "'" +
                " WHERE ClaveMateria = '" + old + "'";
        try {
            conn = Conexion.getConexion();
            ps = conn.prepareStatement(sql);
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            cerrarRecursos();
        }
        return true;
    }

    public boolean eliminar(String claveMateria) throws ClassNotFoundException {
        String sql = "DELETE FROM materias WHERE ClaveMateria ='" + claveMateria + "'";
        try {
            conn = Conexion.getConexion();
            ps = conn.prepareStatement(sql);
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            cerrarRecursos();
        }

        return true;
    }

    public Materias buscar(String claveMateria) throws ClassNotFoundException {
        String sql = "SELECT * FROM materias WHERE ClaveMateria = '" + claveMateria + "'";
        try {
            conn = Conexion.getConexion();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                materias = new Materias();
                materias.setClaveMateria(rs.getString("ClaveMateria"));
                materias.setNombre(rs.getString("Nombre"));
                materias.setCuatrimestre(rs.getString("Cuatrimestre"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            cerrarRecursos();
        }
        return materias;
    }

    // Método para cerrar recursos
    private void cerrarRecursos() {
        try {
            if (this.conn != null) {
                this.conn.close();
            }
            if (this.ps != null) {
                this.ps.close();
            }
            if (this.rs != null) {
                this.rs.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        }
    }
}

