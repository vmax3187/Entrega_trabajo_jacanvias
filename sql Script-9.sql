CREATE TABLE viaje (
Cod varchar(20) NOT NULL,
estado_convoy varchar(40), 
min_demora int(5),
CONSTRAINT PK_viaje PRIMARY KEY (cod)
);

CREATE TABLE billete(
cod varchar(20)NOT NULL,
cod_viaje varchar(20)NOT NULL,
metodo_pago varchar(40),
precio int(4),
asiento varchar(15),
CONSTRAINT PK_billete PRIMARY KEY (cod,cod_viaje),
CONSTRAINT FK1_billete FOREIGN KEY  (cod_viaje) REFERENCES viaje (cod)
);

CREATE TABLE pasajero (
dni varchar(20)NOT NULL,
cod_billete varchar(20) NOT NULL,
cod_viaje varchar(20)NOT NULL,
sexo varchar(15),
nombre varchar(40),
edad int(3),
indicador_asistencia varchar(2),

CONSTRAINT PK_pasajero PRIMARY KEY (dni),
CONSTRAINT FK_pasajero FOREIGN KEY (cod_viaje,cod_billete) REFERENCES billete (cod_viaje,cod)
);

CREATE TABLE avala(
dni_avala varchar(20)NOT NULL,
dni_avalado varchar(20)NOT NULL,
CONSTRAINT PK_avala PRIMARY KEY (dni_avala),
CONSTRAINT FK1_avala FOREIGN KEY (dni_avala) REFERENCES pasajero (dni),
CONSTRAINT FK2_avala FOREIGN KEY (dni_avalado) REFERENCES pasajero (dni)
);

CREATE TABLE codigo_postal(
cod_post varchar(20) NOT NULL,
ciudad varchar(20),
CONSTRAINT PK_codigo_postal PRIMARY KEY (cod_post)
);

CREATE TABLE estacion (
cod varchar(20) NOT NULL,
nombre varchar(20),
num_vias int(15),
cod_post varchar(20) NOT NULL,
CONSTRAINT PK_estacion PRIMARY  KEY (cod),
CONSTRAINT FK_estacion FOREIGN KEY (cod_post) references codigo_postal (cod_post)
);

CREATE TABLE estacion_categoria(
cod_estacion varchar(20) NOT NULL,
categoria varchar(20),
CONSTRAINT PK_estacion_categoria PRIMARY KEY (cod_estacion),
CONSTRAINT FK_estacion_categoria FOREIGN KEY (cod_estacion) REFERENCES estacion (cod)
);
CREATE TABLE realizan (
cod_estacion varchar(20)NOT NULL,
cod_viaje varchar(20)NOT NULL,
CONSTRAINT PK_realizan PRIMARY KEY (cod_estacion,cod_viaje)
);
CREATE TABLE personal(
dni varchar(15) NOT NULL,
NSS varchar(20),
nombre varchar(40),
apellidos varchar(20),
antiguedad int(3),
salario_base int(6),
cod_estacion varchar(20) NOT NULL,
CONSTRAINT PK_personal PRIMARY KEY (dni),
CONSTRAINT FK_personal FOREIGN KEY (cod_estacion) REFERENCES estacion(cod)
);

CREATE TABLE conductor(
dni varchar(15) NOT NULL,
licencia varchar(40),
experiencia int(3),
CONSTRAINT PK_conductor PRIMARY KEY (dni),
CONSTRAINT FK_conductor FOREIGN KEY (dni) REFERENCES personal(dni)
);
CREATE TABLE vigilante (
dni varchar(15)NOT NULL,
empresa_externa varchar(50),
num_placa varchar(5),
CONSTRAINT PK_vigilante PRIMARY KEY (dni),
CONSTRAINT FK_vigilante FOREIGN KEY (dni) REFERENCES personal(dni)
);
CREATE TABLE atencion_al_cliente (
dni varchar(15) NOT NULL,
puesto varchar(40) NOT NULL,
CONSTRAINT PK_atencion_al_cliente PRIMARY KEY (dni),
CONSTRAINT FK_atencion_al_cliente FOREIGN KEY (dni) REFERENCES personal(dni)
);
CREATE TABLE atencion_al_caliente_idiomas(
dni varchar(15)NOT NULL,
idioma_adicional varchar(40),
CONSTRAINT PK_atencion_al_cliente_idiomas PRIMARY KEY (dni),
CONSTRAINT FK_atencion_al_cliente_idomasi FOREIGN KEY (dni) REFERENCES atencion_al_cliente(dni)
);
CREATE TABLE ruta(
cod varchar(20),
distancia_total varchar(20),
velocidad_maxima varchar(8),
cod_viaje varchar(20) NOT NULL,
CONSTRAINT PK_ruta PRIMARY KEY (cod),
CONSTRAINT FK_ruta FOREIGN KEY (cod_viaje) references viaje (cod)
);
CREATE TABLE parada(
cod_ruta varchar(20) NOT NULL,
cod varchar(20) NOT NULL,
via_llegada int(2),
tiempo_que_pertenece int(5),
CONSTRAINT PK_parada PRIMARY KEY (cod,cod_ruta),
CONSTRAINT FK_parada FOREIGN KEY (cod_ruta) REFERENCES ruta(cod)
);
CREATE TABLE tren (
matricula varchar(8) NOT NULL,
modelo varchar(40),
fecha_fab DATE,
CONSTRAINT PK_tren PRIMARY KEY (matricula)
);
CREATE TABLE hacen (
matricula varchar(8) NOT NULL,
cod_parada varchar(20)NOT NULL,
cod_ruta varchar(20)NOT NULL,
dia_semana varchar(10),
hora_salida int(10),
CONSTRAINT PK_hacen PRIMARY KEY (matricula,cod_parada,cod_ruta),
CONSTRAINT FK1_hacen FOREIGN KEY (matricula) REFERENCES tren(matricula),
CONSTRAINT FK2_hacen FOREIGN KEY (cod_ruta,cod_parada) REFERENCES parada(cod_ruta,cod)
);
CREATE TABLE revision (
cod_revision varchar(20)NOT null,
fecha DATE,
coste int(10),
matricula varchar(8) NOT NULL,
tipo_reparacion varchar(40),
CONSTRAINT PK_revision PRIMARY KEY (cod_revision),
CONSTRAINT FK1_revision FOREIGN KEY (matricula) REFERENCES tren (matricula)
);
CREATE TABLE vagones (
matricula_tren varchar(8) NOT NULL,
numero_bastidor int(10) NOT NULL,
capacidad int(10),
CONSTRAINT PK_vagones PRIMARY KEY (matricula_tren,numero_bastidor),
CONSTRAINT FK_vagones FOREIGN KEY (matricula_tren) REFERENCES tren(matricula)
);
CREATE TABLE vagones_servicios(
matricula_tren varchar(8) NOT NULL,
numero_bastidor int(10) NOT NULL,
servicio varchar(40),
CONSTRAINT PK_vagones_servicios PRIMARY KEY (matricula_tren,numero_bastidor),
CONSTRAINT FK_vagones_servicios FOREIGN KEY (matricula_tren) REFERENCES tren(matricula),
CONSTRAINT FK2_vagones_servicios FOREIGN KEY (matricula_tren,numero_bastidor) references vagones (matricula_tren,numero_bastidor)
);