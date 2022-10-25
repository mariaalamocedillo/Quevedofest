package org.example.modelo;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Objects;

/**
 * Clase encargada de representar objetos Artista del modelo
 * @author MariaAlamo
 * @since 16/05/2021
 * @version 1.0
 */
public class Artista {

  private int id;
  private String dniPas;
  private String nombrelegal;
  private String nombreartistico;
  private LocalDate fechanac;
  private String campoartistico;
  private String genero;
  private long telefono;
  private BigDecimal sueldo;


  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }


  public String getDniPas() {
    return dniPas;
  }

  public void setDniPas(String dniPas) {
    this.dniPas = dniPas;
  }


  public String getNombrelegal() {
    return nombrelegal;
  }

  public void setNombrelegal(String nombrelegal) {
    this.nombrelegal = nombrelegal;
  }


  public String getNombreartistico() {
    return nombreartistico;
  }

  public void setNombreartistico(String nombreartistico) {
    this.nombreartistico = nombreartistico;
  }


  public LocalDate getFechanac() {
    return fechanac;
  }

  public void setFechanac(LocalDate fechanac) {
    this.fechanac = fechanac;
  }


  public String getCampoartistico() {
    return campoartistico;
  }

  public void setCampoartistico(String campoartistico) {
    this.campoartistico = campoartistico;
  }


  public String getGenero() {
    return genero;
  }

  public void setGenero(String genero) {
    this.genero = genero;
  }


  public long getTelefono() {
    return telefono;
  }

  public void setTelefono(long telefono) {
    this.telefono = telefono;
  }


  public BigDecimal getSueldo() {
    return sueldo;
  }

  public void setSueldo(BigDecimal sueldo) {
    this.sueldo = sueldo;
  }

  @Override
  public String toString() {
    return "Artista{" +
            "id=" + id +
            ", dniPas='" + dniPas + '\'' +
            ", nombrelegal='" + nombrelegal + '\'' +
            ", nombreartistico='" + nombreartistico + '\'' +
            ", fechanac=" + fechanac +
            ", campoartistico='" + campoartistico + '\'' +
            ", genero='" + genero + '\'' +
            ", telefono=" + telefono +
            ", sueldo=" + sueldo +
            '}';
  }
  @Override
  public int hashCode() {
    return Objects.hash(id, dniPas, nombrelegal, nombreartistico, fechanac, campoartistico, genero, telefono, sueldo);
  }
}
