@carteles
Feature: Gestión de carteles
    es la administración de los carteles del festival.
    
        Scenario: crear cartel que no existe para una fecha
            Given una fecha del festival
              And un carteles que no existe en el sistema
             When añado el cartel
             Then el cartel queda añadido

        Scenario: crear cartel que ya existe para una fecha
            Given una fecha del festival
              And un carteles que ya existe en el sistema
             When añado el cartel
             Then da error de que el cartel ya existe para esa fecha

        Scenario: añadir al cartel artista que existe
            Given un cartel existente en el sistema
              And un artista que existe en el sistema
             When añado el artista al cartel
             Then el cartel tiene el artista añadido

        Scenario: añadir al cartel artista que no existe
            Given un cartel existente en el sistema
              And un artista que no existe en el sistema
             When añado el artista al cartel
             Then da error de que el artista no existe

