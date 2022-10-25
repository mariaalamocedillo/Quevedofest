package org.example.persistencia;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.example.modelo.Artista;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase que implementa los servicios CRUD de Artista con tecnología JDBC
 * @author MariaAlamo
 * @since 16/05/2021
 * @version 1.0
 */
public class ArtistaJDBC {

    // Operaciones a realizar en la BD
    private static final String SELECT_ARTISTA_QUERY = "select * from artista WHERE id = ?";
    private static final String INSERT_ARTISTA_QUERY = "insert into artista values (?,?,?,?,?,?,?,?,?)";
    private static final String UPDATE_ARTISTA_QUERY = "update artista set nombrelegal = ? where id = ?";
    private static final String DELETE_ARTISTA_QUERY = "delete from artista WHERE id = ?";
    private static final String GETALL_ARTISTA_QUERY = "select * from artista";

    // Mensaje de error
    private static final String ACCESO_DATOS_MENSAJE = "Ocurrió un error al acceder a los datos";

    // Activar el logger para emitir mensajes a fichero de log de formato estándar
    private static final Logger logger = LogManager.getLogger(ArtistaJDBC.class);

    /**
     * Obtiene un <code>Artista</code> a partir de un <code>id</code>
     *
     * @param id identificador de <code>Artista</code>
     * @return artista Objeto de la clase <code>Artista</code>
     * @throws AccesoDatosException Excepción de capa de persistencia
     */
    public Artista read(Integer id) throws AccesoDatosException {
        // El objeto conexión
        Connection conn = null;
        // Sentencia sql
        PreparedStatement stmt = null;
        // Conjunto de Resultados a obtener de la sentencia sql
        ResultSet rs = null;
        // Objeto artista que se va a devolver
        Artista artista = null;
        try {
            // Obtener el objeto conexión
            conn = JDBCUtil.getConnection();
            // Crear sentencia sql
            stmt = conn.prepareStatement(SELECT_ARTISTA_QUERY);
            // Pasar parámetros
            stmt.setInt(1, id);
            // Ejecución de la consulta y obtención de resultados en un ResultSet
            rs = stmt.executeQuery();
            // Recuperación de los datos del ResultSet
            if (rs.next()) {
                artista=new Artista();
                artista.setId(rs.getInt("id"));
                artista.setDniPas(rs.getString("dni_pas"));
                artista.setNombrelegal(rs.getString("nombrelegal"));
                artista.setNombreartistico(rs.getString("nombreartistico"));
                artista.setFechanac(rs.getObject("fechanac", LocalDate.class));
                artista.setCampoartistico(rs.getString("campoartistico"));
                artista.setGenero(rs.getString("genero"));
                artista.setTelefono(rs.getLong("telefono"));
                artista.setSueldo(rs.getBigDecimal("sueldo"));
            }
            logger.info("Recuperado artista {} ", id);
            return artista;
        } catch (SQLException sqle) {
            // En una aplicación real, escribo en el log y delego
            logger.error("Error al acceder a los datos.");
            JDBCUtil.printSQLException(sqle);
            throw new AccesoDatosException(ACCESO_DATOS_MENSAJE);
        } finally {
            JDBCUtil.liberar(conn, stmt, rs);
        }
    }

    /**
     * Inserta un <code>Artista</code>
     *
     * @param artista Objeto de la clase <code>Artista</code>
     * @throws AccesoDatosException Excepción de capa de persistencia
     */
    public void create(Artista artista) throws AccesoDatosException {
        // El objeto conexión
        Connection conn = null;
        // Sentencia sql
        PreparedStatement stmt = null;
        // Resultado de la operación
        int resultado;
        try {
            // Obtener el objeto conexión
            conn = JDBCUtil.getConnection();
            // Crear sentencia sql
            stmt = conn.prepareStatement(INSERT_ARTISTA_QUERY);
            // Pasar parámetros
            stmt.setLong(1, artista.getId());
            stmt.setString(2, artista.getDniPas());
            stmt.setString(3, artista.getNombrelegal());
            stmt.setString(4, artista.getNombreartistico());
            stmt.setObject(5, artista.getFechanac());
            stmt.setString(6, artista.getCampoartistico());
            stmt.setString(7, artista.getGenero());
            stmt.setLong(8, artista.getTelefono());
            stmt.setBigDecimal(9, artista.getSueldo());
            // Ejecución de la operación
            resultado = stmt.executeUpdate();
            if (resultado > 0) {
                logger.info("Insertado artista {}", artista.getId());
            }
        } catch (SQLException sqle) {
            // En una aplicación real, escribo en el log y delego
            JDBCUtil.printSQLException(sqle);
            throw new AccesoDatosException(ACCESO_DATOS_MENSAJE);
        } finally {
            JDBCUtil.liberar(conn, stmt);
        }
    }

    /**
     * Actualiza un <code>Artista</code>
     * Solo actualiza el atributo <code>nombre</code>
     *
     * @param artista Objeto de la clase <code>Artista</code>
     * @throws AccesoDatosException Excepción de capa de persistencia
     */
    public void update(Artista artista) throws AccesoDatosException {
        // El objeto conexión
        Connection conn = null;
        // Sentencia sql
        PreparedStatement stmt = null;
        // Resultado de la operación
        int resultado;
        try {
            // Obtener el objeto conexión
            conn = JDBCUtil.getConnection();
            // Crear sentencia sql
            stmt = conn.prepareStatement(UPDATE_ARTISTA_QUERY);
            // Pasar parámetros
            stmt.setString(1, artista.getNombrelegal());
            stmt.setInt(2, artista.getId());
            // Ejecución de la operación
            resultado = stmt.executeUpdate();
            if (resultado > 0) {
                logger.info("Actualizado artista {}", artista.getId());
            }
        } catch (SQLException sqle) {
            // En una aplicación real, escribo en el log y delego
            JDBCUtil.printSQLException(sqle);
            throw new AccesoDatosException(ACCESO_DATOS_MENSAJE);
        } finally {
            JDBCUtil.liberar(conn, stmt);
        }
    }

    /**
     * Elimina un <code>Artista</code> a partir de su <code>id</code>
     *
     * @param id identificador de <code>Artista</code>
     * @throws AccesoDatosException Excepción de capa de persistencia
     */
    public void delete(Integer id) throws AccesoDatosException {
        // El objeto conexión
        Connection conn = null;
        // Sentencia sql
        PreparedStatement stmt = null;
        // Resultado de la operación
        int resultado;
        try {
            // Obtener el objeto conexión
            conn = JDBCUtil.getConnection();
            // Crear sentencia sql
            stmt = conn.prepareStatement(DELETE_ARTISTA_QUERY);
            // Pasar parámetros
            stmt.setInt(1, id);
            // Ejecución de la operación
            resultado = stmt.executeUpdate();
            if (resultado > 0) {
                logger.info("Borrado artista {}", id);
            }

        } catch (SQLException sqle) {
            // En una aplicación real, escribo en el log y delego
            JDBCUtil.printSQLException(sqle);
            throw new AccesoDatosException(ACCESO_DATOS_MENSAJE);
        } finally {
            JDBCUtil.liberar(conn, stmt);
        }
    }

    /**
     * Obtiene una lista con todos los objetos <code>Artista</code>
     *
     * @return List<Artista> Lista de objetos de la clase <code>Artista</code>
     * @throws AccesoDatosException Excepción de capa de persistencia
     */
    public List<Artista> getAll() throws AccesoDatosException {
        // El objeto conexión
        Connection conn = null;
        // Sentencia sql
        PreparedStatement stmt = null;
        // Conjunto de Resultados a obtener de la sentencia sql
        ResultSet rs = null;
        // Objeto que se va a devolver
        List<Artista> artistas = new ArrayList<>();
        try {
            // Obtener el objeto conexión
            conn = JDBCUtil.getConnection();
            // Crear sentencia sql
            stmt = conn.prepareStatement(GETALL_ARTISTA_QUERY);
            // Ejecución de la consulta y obtención de resultados en un ResultSet
            rs = stmt.executeQuery();

            // Recuperación de los datos del ResultSet
            while (rs.next()) {
                Artista artista = new Artista();
                artista.setId(rs.getInt(1));
                artista.setDniPas(rs.getString(2));
                artista.setNombrelegal(rs.getString(3));
                artista.setNombreartistico(rs.getString(4));
                artista.setFechanac(rs.getObject(5, LocalDate.class));
                artista.setCampoartistico(rs.getString(6));
                artista.setGenero(rs.getString(7));
                artista.setTelefono(rs.getLong(8));
                artista.setSueldo(rs.getBigDecimal(9));
                artistas.add(artista);
            }
            //artistas.forEach(System.out::print);
            return artistas;
        } catch (SQLException sqle) {
            // En una aplicación real, escribo en el log y delego
            JDBCUtil.printSQLException(sqle);
            throw new AccesoDatosException(ACCESO_DATOS_MENSAJE);
        } finally {
            JDBCUtil.liberar(conn, stmt, rs);
        }
    }

}
