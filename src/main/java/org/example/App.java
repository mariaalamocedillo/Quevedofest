package org.example;

import org.example.modelo.Artista;
import org.example.modelo.Agenda;
import org.example.persistencia.AccesoDatosException;
import org.example.persistencia.ArtistaJDBC;
import org.example.persistencia.AgendaJDBC;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

/**
 * Hello world!
 *
 */
public class App
{
    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
        //Ejemplo creación de artista
        Artista artista = new Artista();
            artista.setId(22);
            artista.setDniPas("73848939M");
            artista.setNombrelegal("Sukaina El-Fhili");
            artista.setNombreartistico("Suke");
            artista.setFechanac(LocalDate.of(2000,7,7));
            artista.setCampoartistico("telonero");
            artista.setGenero("Jass");
            artista.setTelefono(666767983);
            artista.setSueldo(BigDecimal.valueOf(2000));
        //Ejemplo de creación de agenda
        Agenda agenda = new Agenda();
            agenda.setCodActuacion(21);
            agenda.setIdArtista(22);
            agenda.setFecha(LocalDate.of(2021,5,21));
            agenda.setHorario(LocalTime.of(20, 0, 0));
      try {
        //creación de artista
        ArtistaJDBC artJdbc = new ArtistaJDBC();
        //artJdbc.create(artista);
        //Búsqueda de artista
        Artista art = artJdbc.read(2);
        System.out.println(art);

        //creación de agenda
        AgendaJDBC agJdbc = new AgendaJDBC();
        //agJdbc.create(agenda);
        //Búsqueda de agenda
        Agenda ag = agJdbc.read(21);
        System.out.println(ag);

        //Listado de artistas
        System.out.println("*********Artistas***********");
        List<Artista> artistas = artJdbc.getAll();
        //artistas.forEach(System.out::println);

        //Listado de agendas
        System.out.println("*********Agendas***********");
        List<Agenda> agendas = agJdbc.getAll();
        //agendas.forEach(System.out::println);

        //obtener las actuaciones de la agenda de un artista (obtenido antes)
        for (Agenda UnaAgenda : agendas) {
              if (agenda.getIdArtista() == art.getId()) {
                  System.out.println(UnaAgenda + "\tArtista: " + art.getNombreartistico());
              }
        }

      } catch (AccesoDatosException e) {
        System.out.println("Lo sentimos ocurrió un error en la aplicación: "
          + e.getMessage());
      }
    }
}
