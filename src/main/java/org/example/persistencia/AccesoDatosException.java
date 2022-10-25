package org.example.persistencia;

/**
 * Excepción de capa de persistencia. Lanzada cuando ocurre algun error en el acceso
 * a la capa persistente de datos(ficheros, base de datos...)
 *
 * Para desacoplar la aplicación (GUI) de las excepciones propias del origen de datos
 * es una buena práctica crear excepciones propias para nuestra aplicación
 * que encapsulen el tipo de origen de datos.
 *
 * @see Exception
 */
public class AccesoDatosException extends Exception{

    public AccesoDatosException(String message) {
        super(message);
    }

}