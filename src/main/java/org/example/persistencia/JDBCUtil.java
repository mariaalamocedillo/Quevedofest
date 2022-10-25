package org.example.persistencia;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.IOException;
import java.sql.*;
import java.util.Properties;

/**
 *
 *  Clase que establece una conexión a BD utilizando la clase DriverManager.
 *  Lee los datos de un archivo de propiedades.
 *
 */
public class JDBCUtil {

    private static String url = null;
    private static String user = null;
    private static String password = null;

    private static final String PROPERTIES_FILE="db-properties.xml";

    // Activar el logger para emitir mensajes a fichero de log de formato estándar
    private static final Logger logger = LogManager.getLogger(JDBCUtil.class);

    /*
     * Constructor privado para una clase de utilidades. Recomendado por SonarLint
     */
    private JDBCUtil() {
        throw new IllegalStateException("Utility class");
    }

    /*
     * Carga fichero de propiedades en atributos de clase usando un
     * bloque de código estático para que se ejecute solo la primera vez
     * que se invoca la clase JDBCUtil
     */
    static {
        try {
            Properties prop = new Properties();
            prop.loadFromXML(JDBCUtil.class.getClassLoader().getResourceAsStream(PROPERTIES_FILE));

            url = prop.getProperty("url");
            user = prop.getProperty("user");
            password = prop.getProperty("password");
        } catch (IOException e) {
            logger.error("Error al leer el fichero de properties");
            e.printStackTrace();
        }
    }

    /**
     * Conexión a Base de Datos
     *
     * @return Connection objeto <code>Connection</code>
     * @throws SQLException Excepción producida al intentar conectarse a la BD
     */
    public static Connection getConnection() throws SQLException {

        /* Solicitar a DriverManager una conexión con la base de datos
        * Para identificar el controlador a usar se le proporciona una
        * URL, si no lo encuentra lanza SQLException
        *
        * formato de URL: jdbc:[host][:port]/[database]
        */
        Connection conn = DriverManager.getConnection(url, user, password);
        //System.out.println("Conectado a BD");
        return conn;
    }

    /**
     * Liberar recursos abiertos
     *
     * @param conn objeto <code>Connection</code>
     * @param stmt objeto <code>Statement</code>
     * @param rs objeto <code>ResultSet</code>
     */

    public static void liberar(Connection conn, Statement stmt, ResultSet rs) {
        // Liberando recursos abiertos
        closeRs(rs);
        closeStmt(stmt);
        closeConn(conn);
    }

    /**
     * Liberar recursos abiertos
     *
     * @param conn objeto <code>Connection</code>
     * @param stmt objeto <code>Statement</code>
     */
    public static void liberar(Connection conn, Statement stmt) {
        // Liberando recursos abiertos
        closeStmt(stmt);
        closeConn(conn);
    }

    private static void closeRs(ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            rs = null;
        }
    }
    private static void closeStmt(Statement stmt) {
        try {
            if (stmt != null) {
                stmt.close();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            stmt = null;
        }
    }
    private static void closeConn(Connection conn) {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            conn = null;
        }
    }

    /**
     * Método para imprimir la información de una Excepción SQL y poder depurar errores fácilmente
     * @param e Excepción SQLException
     */
    public static void printSQLException(SQLException e) {

        while (e != null) {
            if (e instanceof SQLException) {
                //Estado ANSI
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + e.getSQLState());
                //Código de error propio de cada gestor de BD
                System.err.println("Error Code: " + e.getErrorCode());
                //Mensaje textual
                System.err.println("Message: " + e.getMessage());
                //Objetos desencadenantes de la excepción
                Throwable t = e.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
                //Cualquier otra excepción encadenada
                e = e.getNextException();

            }
        }
    }


}
