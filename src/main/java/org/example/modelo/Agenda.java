package org.example.modelo;


import java.time.LocalDate;
import java.time.LocalTime;

public class Agenda {

  private int codActuacion;
  private int idArtista;
  private LocalDate fecha;
  private LocalTime horario;


  public int getCodActuacion() {
    return codActuacion;
  }

  public void setCodActuacion(int codActuacion) {
    this.codActuacion = codActuacion;
  }


  public int getIdArtista() {
    return idArtista;
  }

  public void setIdArtista(int idArtista) {
    this.idArtista = idArtista;
  }


  public LocalDate getFecha() {
    return fecha;
  }

  public void setFecha(LocalDate fecha) {
    this.fecha = fecha;
  }


  public LocalTime getHorario() {
    return horario;
  }

  public void setHorario(LocalTime horario) {
    this.horario = horario;
  }

  @Override
  public String toString() {
    return "Agenda{" +
            "codActuacion=" + codActuacion +
            ", idArtista=" + idArtista +
            ", fecha=" + fecha +
            ", horario=" + horario +
            '}';
  }


}
