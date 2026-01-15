CREATE TABLE viaje (
Cod varchar2(20) NOT NULL,
estado_convoy varchar2(40), 
min_demora NUMBER(5),
CONSTRAINT PK_viaje PRIMARY KEY (cod)
);

CREATE TABLE billete(
cod varchar2(20)NOT NULL,
cod_viaje varchar2(20)NOT NULL,
metodo_pago varchar2(40),
precio number(4),
asiento varchar2(15),
CONSTRAINT PK_billete PRIMARY KEY (cod,cod_viaje),
CONSTRAINT FK1_billete FOREIGN KEY  (cod_viaje) REFERENCES viaje (cod)
);

CREATE TABLE pasajero (
dni varchar2(20)NOT NULL,
cod_billete varchar2(20) NOT NULL,
cod_viaje varchar2(20)NOT NULL,
sexo varchar2(15),
nombre varchar2(40),
edad number(3),
indicador_asistencia varchar2(2),

CONSTRAINT PK_pasajero PRIMARY KEY (dni),
CONSTRAINT FK_pasajero FOREIGN KEY (cod_viaje,cod_billete) REFERENCES billete
);

CREATE TABLE avala(
dni_avala varchar2(20)NOT NULL,
dni_avalado varchar2(20)NOT NULL,
CONSTRAINT PK_avala PRIMARY KEY (dni_avala),
CONSTRAINT FK1_avala FOREIGN KEY (dni_avala) REFERENCES pasajero (dni),
CONSTRAINT FK2_avala FOREIGN KEY (dni_avalado) REFERENCES pasajero (dni)
);

CREATE TABLE codigo_postal(
cod_post varchar2(20) NOT NULL,
ciudad varchar2(20),
CONSTRAINT PK_codigo_postal PRIMARY KEY (cod_post)
);

CREATE TABLE estacion (
cod varchar2(20) NOT NULL,
nombre varchar2(20),
num_vias number(15),
cod_post varchar2(20) NOT NULL,
CONSTRAINT PK_estacion PRIMARY  KEY (cod),
CONSTRAINT FK_estacion FOREIGN KEY (cod_post) references codigo_postal (cod_post)
);

CREATE TABLE estacion_categoria(
cod_estacion varchar2(20) NOT NULL,
categoria varchar2(20),
CONSTRAINT PK_estacion_categoria PRIMARY KEY (cod_estacion),
CONSTRAINT FK_estacion_categoria FOREIGN KEY (cod_estacion) REFERENCES estacion (cod)
);
CREATE TABLE realizan (
cod_estacion varchar2(20)NOT NULL,
cod_viaje varchar2(20)NOT NULL,
CONSTRAINT PK_realizan PRIMARY KEY (cod_estacion,cod_viaje)
);
CREATE TABLE personal(
dni varchar2(15) NOT NULL,
NSS varchar2(20),
nombre varchar2(40),
apellidos varchar2(20),
antiguedad number(3),
salario_base Number(6),
cod_estacion varchar2(20) NOT NULL,
CONSTRAINT PK_personal PRIMARY KEY (dni),
CONSTRAINT FK_personal FOREIGN KEY (cod_estacion) REFERENCES estacion(cod)
);

CREATE TABLE conductor(
dni varchar2(15) NOT NULL,
licencia varchar2(40),
experiencia number(3),
CONSTRAINT PK_conductor PRIMARY KEY (dni),
CONSTRAINT FK_conductor FOREIGN KEY (dni) REFERENCES personal(dni)
);
CREATE TABLE vigilante (
dni varchar2(15)NOT NULL,
empresa_externa varchar2(50),
num_placa varchar2(5),
CONSTRAINT PK_vigilante PRIMARY KEY (dni),
CONSTRAINT FK_vigilante FOREIGN KEY (dni) REFERENCES personal(dni)
);
CREATE TABLE atencion_al_cliente (
dni varchar2(15) NOT NULL,
puesto varchar2(40) NOT NULL,
CONSTRAINT PK_atencion_al_cliente PRIMARY KEY (dni),
CONSTRAINT FK_atencion_al_cliente FOREIGN KEY (dni) REFERENCES personal(dni)
);
CREATE TABLE atencion_al_caliente_idiomas(
dni varchar2(15)NOT NULL,
idioma_adicional varchar2(40),
CONSTRAINT PK_atencion_al_cliente_idiomas PRIMARY KEY (dni),
CONSTRAINT FK_atencion_al_cliente_idomasi FOREIGN KEY (dni) REFERENCES atencion_al_cliente(dni)
);
CREATE TABLE ruta(
cod varchar2(20),
distancia_total varchar2(20),
velocidad_maxima varchar2(8),
cod_viaje varchar2(20) NOT NULL,
CONSTRAINT PK_ruta PRIMARY KEY (cod),
CONSTRAINT FK_ruta FOREIGN KEY (cod_viaje) references VIAJE (cod)
);
CREATE TABLE parada(
cod_ruta varchar2(20)NOT NULL,
cod varchar2(20) NOT NULL,
via_llegada number(2),
tiempo_que_pertenece number(5),
CONSTRAINT PK_parada PRIMARY KEY (cod,cod_ruta),
CONSTRAINT FK_paraa FOREIGN KEY (cod_ruta) REFERENCES ruta(cod)
);
CREATE TABLE tren (
matricula varchar2(8) NOT NULL,
modelo varchar2(40),
fecha_fab DATE,
CONSTRAINT PK_tren PRIMARY KEY (matricula)
);
CREATE TABLE hacen (
matricula varchar2(8) NOT NULL,
cod_parada varchar2(20)NOT NULL,
cod_ruta varchar2(20)NOT NULL,
dia_semana varchar2(10),
hora_salida number(10),
CONSTRAINT PK_hacen PRIMARY KEY (matricula,cod_parada,cod_ruta),
CONSTRAINT FK1_hacen FOREIGN KEY (matricula) REFERENCES tren(matricula),
CONSTRAINT FK2_hacen FOREIGN KEY (cod_ruta,cod_parada) REFERENCES parada(cod_ruta,cod)
);
CREATE TABLE revision (
cod_revision varchar2(20)NOT null,
fecha DATE,
coste number(10),
matricula varchar2(8) NOT NULL,
tipo_reparacion varchar2(40),
CONSTRAINT PK_revision PRIMARY KEY (cod_revision),
CONSTRAINT FK1_revision FOREIGN KEY (matricula) REFERENCES tren (matricula)
);
CREATE TABLE vagones (
matricula_tren varchar2(8) NOT NULL,
numero_bastidor number(10) NOT NULL,
capacidad number(10),
CONSTRAINT PK_vagones PRIMARY KEY (matricula_tren,numero_bastidor),
CONSTRAINT FK_vagones FOREIGN KEY (matricula_tren) REFERENCES tren(matricula)
);
CREATE TABLE vagones_servicios(
matricula_tren varchar2(8) NOT NULL,
numero_bastidor number(10) NOT NULL,
servicio varchar2(40),
CONSTRAINT PK_vagones_servicios PRIMARY KEY (matricula_tren,numero_bastidor),
CONSTRAINT FK_vagones_servicios FOREIGN KEY (matricula_tren) REFERENCES tren(matricula),
CONSTRAINT FK2_vagones_servicios FOREIGN KEY (matricula_tren,numero_bastidor) references vagones (matricula_tren,numero_bastidor)
);