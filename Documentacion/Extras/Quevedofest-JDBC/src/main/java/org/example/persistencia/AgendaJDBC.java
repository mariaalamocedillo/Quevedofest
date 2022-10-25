package org.example.persistencia;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.example.modelo.Agenda;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase que implementa los servicios CRUD de Agenda con tecnología JDBC
 * @author MariaAlamo
 * @since 16/05/2021
 * @version 1.0
 */
public class AgendaJDBC {

    // Operaciones a realizar en la BD
    private static final String SELECT_AGENDA_QUERY = "select * from agenda WHERE cod_actuacion = ?";
    private static final String INSERT_AGENDA_QUERY = "insert into agenda values (?,?,?,?)";
    private static final String UPDATE_AGENDA_QUERY = "update agenda set id_artista = ? where cod_actuacion = ?";
    private static final String DELETE_AGENDA_QUERY = "delete from agenda WHERE cod_actuacion = ?";
    private static final String GETALL_AGENDA_QUERY = "select * from agenda";
    private static final String GETNAME_ARTISTA_QUERY = "select nombreLegal from artista where id = ?";

    // Mensaje de error
    private static final String ACCESO_DATOS_MENSAJE = "Ocurrió un error al acceder a los datos";

    // Activar el logger para emitir mensajes a fichero de log de formato estándar
    private static final Logger logger = LogManager.getLogger(AgendaJDBC.class);

    /**
     * Obtiene un <code>Agenda</code> a partir de un <code>codActuacion</code>
     *
     * @param codActuacion identificador de <code>Agenda</code>
     * @return agenda Objeto de la clase <code>Agenda</code>
     * @throws AccesoDatosException Excepción de capa de persistencia
     */
    public Agenda read(Integer codActuacion) throws AccesoDatosException {
        // El objeto conexión
        Connection conn = null;
        // Sentencia sql
        PreparedStatement stmt = null;
        // Conjunto de Resultados a obtener de la sentencia sql
        ResultSet rs = null;
        // Objeto agenda que se va a devolver
        Agenda agenda = null;
        try {
            // Obtener el objeto conexión
            conn = JDBCUtil.getConnection();
            // Crear sentencia sql
            stmt = conn.prepareStatement(SELECT_AGENDA_QUERY);
            // Pasar parámetros
            stmt.setInt(1, codActuacion);
            // Ejecución de la consulta y obtención de resultados en un ResultSet
            rs = stmt.executeQuery();
            // Recuperación de los datos del ResultSet
            if (rs.next()) {
                agenda=new Agenda();
                agenda.setCodActuacion(rs.getInt("cod_actuacion"));
                agenda.setIdArtista(rs.getInt("id_artista"));
                agenda.setFecha(rs.getObject("fecha", LocalDate.class));
                agenda.setHorario(rs.getObject("horario", LocalTime.class));
            }
            logger.info("Recuperada agenda {} ", codActuacion);
            return agenda;
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
     * Inserta un <code>Agenda</code>
     *
     * @param agenda Objeto de la clase <code>Agenda</code>
     * @throws AccesoDatosException Excepción de capa de persistencia
     */
    public void create(Agenda agenda) throws AccesoDatosException {
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
            stmt = conn.prepareStatement(INSERT_AGENDA_QUERY);
            // Pasar parámetros
            stmt.setInt(1, agenda.getCodActuacion());
            stmt.setInt(2, agenda.getIdArtista());
            stmt.setObject(3, agenda.getFecha());
            stmt.setObject(4, agenda.getHorario());
            // Ejecución de la operación
            resultado = stmt.executeUpdate();
            if (resultado > 0) {
                logger.info("Insertada agenda {}", agenda.getCodActuacion());
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
     * Actualiza un <code>Agenda</code>
     * Solo actualiza el atributo <code>nombre</code>
     *
     * @param agenda Objeto de la clase <code>Agenda</code>
     * @throws AccesoDatosException Excepción de capa de persistencia
     */
    public void update(Agenda agenda) throws AccesoDatosException {
        // El objeto conexión
        Connection conn = null;
        // Sentencia sql
        PreparedStatement stmt = null;
        PreparedStatement stmtArt = null;   //para buscar al nombre del artista
        // Resultado de la operación
        int resultado;
        ResultSet rsArt;    //almacenará el nombre resultado de buscar al artista
        try {
            // Obtener el objeto conexión
            conn = JDBCUtil.getConnection();
            // Crear sentencia sql
            stmt = conn.prepareStatement(UPDATE_AGENDA_QUERY);
            // Pasar parámetros
            stmt.setInt(1, agenda.getCodActuacion());
            stmt.setInt(2, agenda.getIdArtista());
            // Ejecución de la operación
            resultado = stmt.executeUpdate();
            //para obtener el nombre del artista al que se cambió de actuación
            stmtArt = conn.prepareStatement(GETNAME_ARTISTA_QUERY);
            stmt.setInt(1, agenda.getIdArtista());
            rsArt = stmtArt.executeQuery();
            if (resultado > 0) {
                logger.info("Actualizada agenda {} con artista {}", agenda.getCodActuacion(), rsArt.getString(1));
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
     * Elimina un <code>Agenda</code> a partir de su <code>codActuacion</code>
     *
     * @param codActuacion identificador de <code>Agenda</code>
     * @throws AccesoDatosException Excepción de capa de persistencia
     */
    public void delete(Integer codActuacion) throws AccesoDatosException {
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
            stmt = conn.prepareStatement(DELETE_AGENDA_QUERY);
            // Pasar parámetros
            stmt.setInt(1, codActuacion);
            // Ejecución de la operación
            resultado = stmt.executeUpdate();
            if (resultado > 0) {
                logger.info("Borrada agenda {}", codActuacion);
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
     * Obtiene una lista con todos los objetos <code>Agenda</code>
     *
     * @return List<Agenda> Lista de objetos de la clase <code>Agenda</code>
     * @throws AccesoDatosException Excepción de capa de persistencia
     */
    public List<Agenda> getAll() throws AccesoDatosException {
        // El objeto conexión
        Connection conn = null;
        // Sentencia sql
        PreparedStatement stmt = null;
        // Conjunto de Resultados a obtener de la sentencia sql
        ResultSet rs = null;
        // Objeto que se va a devolver
        List<Agenda> agendas = new ArrayList<>();
        try {
            // Obtener el objeto conexión
            conn = JDBCUtil.getConnection();
            // Crear sentencia sql
            stmt = conn.prepareStatement(GETALL_AGENDA_QUERY);
            // Ejecución de la consulta y obtención de resultados en un ResultSet
            rs = stmt.executeQuery();

            // Recuperación de los datos del ResultSet
            while (rs.next()) {
                Agenda agenda = new Agenda();
                agenda.setCodActuacion(rs.getInt(1));
                agenda.setIdArtista(rs.getInt(2));
                agenda.setFecha(rs.getObject(3, LocalDate.class));
                agenda.setHorario(rs.getObject(4, LocalTime.class));
                agendas.add(agenda);
            }
            //agendas.forEach(System.out::print);
            return agendas;
        } catch (SQLException sqle) {
            // En una aplicación real, escribo en el log y delego
            JDBCUtil.printSQLException(sqle);
            throw new AccesoDatosException(ACCESO_DATOS_MENSAJE);
        } finally {
            JDBCUtil.liberar(conn, stmt, rs);
        }
    }

}
