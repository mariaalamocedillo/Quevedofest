ESCENOGRAFÍA (id(PK), id_artista(PK)(FK), id_espacio(PK)(FK), cod_actuación(FK))
MATERIAL_ESCENOGRAFIA (id_escenografia(PK)(FK), id_material(PK)(FK))

ESPACIOS (id_espacio(PK), localización, empleado_encargado(((FK)))))
CAMERINO (id_espacio(PK), id_artista(PK)(FK))
BACKSTAGE (id_espacio(PK))
GRADAS (id_espacio(PK), capacidad)
ESCENARIO (id_espacio(PK))

MATERIAL (id(PK), tipo, precio, tiempo_disponible, proveedor(((FK))), cantidad, almacenaje, ubicación_uso, descripcion)
MATERIAL_ESPACIO (id_material(PK)(FK), id_espacio(PK)(FK))

CATERING (id(PK), num_puesto, lugar_asignado, empresa_encargada, propósito, servicio, servicio_gratuito, presupuesto)
CATERING_GRADAS (id_catering(PK)(FK), id_espacio(PK)(FK))
CATERING_CAMERINO (id_catering(PK)(FK), id_espacio(PK)(FK))


ARTISTA(id(PK), id_agenda(PK)(FK), nombre_artistico, nombre_legal, redes sociales, campo_artistico, telefono, fecha nacimiento, sueldo, DNI/pasporte)
CARTEL (id(PK), web, precio_entrada, patrocinadores, redes_sociales)
ARTISTAS_CARTEL (id_artista(PK)(FK), id_cartel(PK)(FK))
AGENDA (cod_actuacion(PK), espacio, teloneros)
AGENDA_CARTEL (id_cartel(PK)(FK), cod_actuacion(PK)(FK))
INVITACIONES (cod(PK), nombre, acompañantes, permisos)
INVITACIONES_ARTISTA (cod_invitacion(PK)(FK), id_artista(PK)(FK))






 







