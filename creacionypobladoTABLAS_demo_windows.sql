-- Script unico: creacion y poblacion de tablas - Gimnasio (Taller Base de Datos)
-- Generado desde TABLAS.sql (modelo relacional actualizado) + datos coherentes
-- Geografia completa: 1 pais (Chile), 16 regiones, 56 ciudades, 346 comunas.
-- 200 registros en cada tabla de negocio; RUTs chilenos validos (digito verificador).
-- ============================================================
-- 1) REINICIO: elimina las tablas y sus datos para recargar todo
-- ============================================================
DROP TABLE AGENDA CASCADE CONSTRAINTS PURGE;
DROP TABLE BLOQUE_HORARIO CASCADE CONSTRAINTS PURGE;
DROP TABLE CAT_PATOLOGIA CASCADE CONSTRAINTS PURGE;
DROP TABLE CENTRO_DEP CASCADE CONSTRAINTS PURGE;
DROP TABLE CIUDAD CASCADE CONSTRAINTS PURGE;
DROP TABLE CLIENTE CASCADE CONSTRAINTS PURGE;
DROP TABLE COMUNA CASCADE CONSTRAINTS PURGE;
DROP TABLE CONTENER CASCADE CONSTRAINTS PURGE;
DROP TABLE CONTRATO_CLI CASCADE CONSTRAINTS PURGE;
DROP TABLE DEFINIR CASCADE CONSTRAINTS PURGE;
DROP TABLE DISENAR CASCADE CONSTRAINTS PURGE;
DROP TABLE EJERCICIO CASCADE CONSTRAINTS PURGE;
DROP TABLE EMPLEA CASCADE CONSTRAINTS PURGE;
DROP TABLE FACTURA CASCADE CONSTRAINTS PURGE;
DROP TABLE FICHA_CLIENTE CASCADE CONSTRAINTS PURGE;
DROP TABLE METODO_PAGO_CLI CASCADE CONSTRAINTS PURGE;
DROP TABLE METRICAS_CLIENTE CASCADE CONSTRAINTS PURGE;
DROP TABLE OFRECER CASCADE CONSTRAINTS PURGE;
DROP TABLE PAGO CASCADE CONSTRAINTS PURGE;
DROP TABLE PAIS CASCADE CONSTRAINTS PURGE;
DROP TABLE PATOLOGIAS CASCADE CONSTRAINTS PURGE;
DROP TABLE PLAN CASCADE CONSTRAINTS PURGE;
DROP TABLE PREPARADOR_FISICO CASCADE CONSTRAINTS PURGE;
DROP TABLE PROGRE_CLI CASCADE CONSTRAINTS PURGE;
DROP TABLE REGION CASCADE CONSTRAINTS PURGE;
DROP TABLE REGISTRAR CASCADE CONSTRAINTS PURGE;
DROP TABLE RUTINA CASCADE CONSTRAINTS PURGE;
DROP TABLE SESION_ENTRENAMIENTO CASCADE CONSTRAINTS PURGE;
DROP TABLE TENER CASCADE CONSTRAINTS PURGE;

-- ============================================================
-- 2) CREACION DE LAS TABLAS
-- ============================================================


CREATE TABLE AGENDA 
    ( 
     id_agendar                 NUMBER (7)  NOT NULL , 
     fecha_agendar              DATE  NOT NULL , 
     hora_agendar               INTERVAL DAY (9) TO SECOND (0)  NOT NULL , 
     estado_agendar             VARCHAR2 (15)  NOT NULL , 
     PREPARADOR_FISICO_rut_prep VARCHAR2 (13)  NOT NULL , 
     CLIENTE_rut_cliente        VARCHAR2 (13)  NOT NULL , 
     CONTRATO_CLI_id_contrato   NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE AGENDA 
    ADD CONSTRAINT AGENDA_PK PRIMARY KEY ( id_agendar, fecha_agendar ) ;

CREATE TABLE BLOQUE_HORARIO 
    ( 
     id_bloque            NUMBER (7)  NOT NULL , 
     dia_bloque           VARCHAR2 (20)  NOT NULL , 
     hora_bloque          INTERVAL DAY (9) TO SECOND (0)  NOT NULL , 
     AGENDA_id_agendar    NUMBER (7) , 
     AGENDA_fecha_agendar DATE 
    ) 
;

ALTER TABLE BLOQUE_HORARIO 
    ADD CONSTRAINT BLOQUE_HORARIO_PK PRIMARY KEY ( id_bloque ) ;

CREATE TABLE CAT_PATOLOGIA 
    ( 
     id_cat           NUMBER (4)  NOT NULL , 
     nombre_categoria VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE CAT_PATOLOGIA 
    ADD CONSTRAINT CAT_PATOLOGIA_PK PRIMARY KEY ( id_cat ) ;

CREATE TABLE CENTRO_DEP 
    ( 
     id_centro        NUMBER (6)  NOT NULL , 
     nombre_centro    VARCHAR2 (100)  NOT NULL , 
     rut_centro       VARCHAR2 (13)  NOT NULL , 
     COMUNA_id_comuna NUMBER (3) , 
     dir_centro       VARCHAR2 (150)  NOT NULL 
    ) 
;

ALTER TABLE CENTRO_DEP 
    ADD CONSTRAINT CENTRO_DEPORTIVO_PK PRIMARY KEY ( id_centro ) ;

CREATE TABLE CIUDAD 
    ( 
     id_ciudad        NUMBER (3)  NOT NULL , 
     nombre_ciudad    VARCHAR2 (50)  NOT NULL , 
     REGION_id_region NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE CIUDAD 
    ADD CONSTRAINT CIUDAD_PK PRIMARY KEY ( id_ciudad ) ;

CREATE TABLE CLIENTE 
    ( 
     rut_cliente          VARCHAR2 (13)  NOT NULL , 
     pnombre_cliente      VARCHAR2 (150)  NOT NULL , 
     snombre_cliente      VARCHAR2 (150) , 
     papellido_cliente    VARCHAR2 (150)  NOT NULL , 
     sapellido_cliente    VARCHAR2 (150) , 
     fecha_nac_cliente    DATE  NOT NULL , 
     nacionalidad_cliente VARCHAR2 (150) , 
     PLAN_id_plan         NUMBER (7)  NOT NULL , 
     COMUNA_id_comuna     NUMBER (3) , 
     telefono_cliente     VARCHAR2 (9)  NOT NULL , 
     correo_cliente       VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE CLIENTE 
    ADD CONSTRAINT CLIENTE_PK PRIMARY KEY ( rut_cliente ) ;

CREATE TABLE COMUNA 
    ( 
     id_comuna        NUMBER (3)  NOT NULL , 
     nombre_comuna    VARCHAR2 (50)  NOT NULL , 
     CIUDAD_id_ciudad NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_PK PRIMARY KEY ( id_comuna ) ;

CREATE TABLE CONTENER 
    ( 
     RUTINA_id_rutina       NUMBER (7)  NOT NULL , 
     EJERCICIO_id_ejercicio NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE CONTENER 
    ADD CONSTRAINT CONTENER_PK PRIMARY KEY ( RUTINA_id_rutina, EJERCICIO_id_ejercicio ) ;

CREATE TABLE CONTRATO_CLI 
    ( 
     id_contrato            NUMBER (7)  NOT NULL , 
     fecha_inicio_contrato  DATE  NOT NULL , 
     fecha_termino_contrato DATE  NOT NULL , 
     estado_contrato        VARCHAR2 (30)  NOT NULL , 
     PLAN_id_plan           NUMBER (7)  NOT NULL , 
     fecha_ini              DATE , 
     fecha_ter              DATE ,
     CLIENTE_rut_cliente    VARCHAR2 (13)  NOT NULL
    ) 
;

ALTER TABLE CONTRATO_CLI 
    ADD CONSTRAINT CONTRATO_CLI_PK PRIMARY KEY ( id_contrato ) ;

CREATE TABLE DEFINIR 
    ( 
     PREPARADOR_FISICO_rut_prep VARCHAR2 (13)  NOT NULL , 
     BLOQUE_HORARIO_id_bloque   NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE DEFINIR 
    ADD CONSTRAINT DEFINIR_PK PRIMARY KEY ( PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque ) ;

CREATE TABLE DISENAR 
    ( 
     PREPARADOR_FISICO_rut_prep VARCHAR2 (13)  NOT NULL , 
     RUTINA_id_rutina           NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE DISENAR 
    ADD CONSTRAINT DISENAR_PK PRIMARY KEY ( PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina ) ;

CREATE TABLE EJERCICIO 
    ( 
     id_ejercicio           NUMBER (7)  NOT NULL , 
     nombre_ejercicio       VARCHAR2 (30)  NOT NULL , 
     descripcion_ejercicio  VARCHAR2 (200)  NOT NULL , 
     repeticiones_ejercicio NUMBER (2)  NOT NULL , 
     peso_ejercicio         NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE EJERCICIO 
    ADD CONSTRAINT EJERCICIO_PK PRIMARY KEY ( id_ejercicio ) ;

CREATE TABLE EMPLEA 
    ( 
     PREPARADOR_FISICO_rut_prep VARCHAR2 (13)  NOT NULL , 
     CENTRO_DEPORTIVO_id_centro NUMBER (6)  NOT NULL 
    ) 
;

ALTER TABLE EMPLEA 
    ADD CONSTRAINT EMPLEA_PK PRIMARY KEY ( PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro ) ;

CREATE TABLE FACTURA 
    ( 
     id_factura    NUMBER (7)  NOT NULL , 
     fecha_emision DATE  NOT NULL , 
     total_factura NUMBER (6)  NOT NULL , 
     PAGO_id_pago  NUMBER (7)  NOT NULL 
    ) 
;
CREATE UNIQUE INDEX FACTURA__IDX ON FACTURA 
    ( 
     PAGO_id_pago ASC 
    ) 
;

ALTER TABLE FACTURA 
    ADD CONSTRAINT FACTURA_PK PRIMARY KEY ( id_factura ) ;

CREATE TABLE FICHA_CLIENTE 
    ( 
     id_ficha          NUMBER (7)  NOT NULL , 
     fecha_creacion    DATE  NOT NULL , 
     observaciones     VARCHAR2 (200) , 
     fecha_observacion DATE  NOT NULL 
    ) 
;

ALTER TABLE FICHA_CLIENTE 
    ADD CONSTRAINT FICHA_CLIENTE_PK PRIMARY KEY ( id_ficha ) ;

CREATE TABLE METODO_PAGO_CLI 
    ( 
     id_metodo_pago          NUMBER (7)  NOT NULL , 
     nombre_metodo_pago      VARCHAR2 (50)  NOT NULL , 
     descripcion_metodo_pago VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE METODO_PAGO_CLI 
    ADD CONSTRAINT METODO_PAGO_CLI_PK PRIMARY KEY ( id_metodo_pago ) ;

CREATE TABLE METRICAS_CLIENTE 
    ( 
     id_metrica                  NUMBER (3)  NOT NULL , 
     peso_cliente                NUMBER (5,2)  NOT NULL , 
     estatura_cliente            NUMBER (5,2)  NOT NULL , 
     medida_pecho_cliente        NUMBER (5,2)  NOT NULL , 
     medida_cintura_cliente      NUMBER (5,2)  NOT NULL , 
     medida_cadera_cliente       NUMBER (5,2)  NOT NULL , 
     medida_hombros_cliente      NUMBER (5,2)  NOT NULL , 
     medida_brazos_cliente       NUMBER (5,2)  NOT NULL , 
     medida_muslos_cliente       NUMBER (5,2)  NOT NULL , 
     medidas_pantorillas_cliente NUMBER (5,2)  NOT NULL , 
     fecha_medicion_cliente      DATE  NOT NULL 
    ) 
;

ALTER TABLE METRICAS_CLIENTE 
    ADD CONSTRAINT METRICAS_CLIENTE_PK PRIMARY KEY ( id_metrica ) ;

CREATE TABLE OFRECER 
    ( 
     PREPARADOR_FISICO_rut_prep VARCHAR2 (13)  NOT NULL , 
     PLAN_id_plan               NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE OFRECER 
    ADD CONSTRAINT OFRECER_PK PRIMARY KEY ( PREPARADOR_FISICO_rut_prep, PLAN_id_plan ) ;

CREATE TABLE PAGO 
    ( 
     id_pago                        NUMBER (7)  NOT NULL , 
     monto_pago                     NUMBER (6)  NOT NULL , 
     fecha_pago                     DATE  NOT NULL , 
     estado_pago                    VARCHAR2 (30)  NOT NULL , 
     CONTRATO_CLI_id_contrato       NUMBER (7)  NOT NULL , 
     METODO_PAGO_CLI_id_metodo_pago NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE PAGO 
    ADD CONSTRAINT PAGO_PK PRIMARY KEY ( id_pago ) ;

CREATE TABLE PAIS 
    ( 
     id_pais     NUMBER (3)  NOT NULL , 
     nombre_pais VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE PAIS 
    ADD CONSTRAINT PAIS_PK PRIMARY KEY ( id_pais ) ;

CREATE TABLE PATOLOGIAS 
    ( 
     id_patologia           NUMBER (3)  NOT NULL , 
     nombre_patologia       VARCHAR2 (150)  NOT NULL , 
     tipo_patologia         VARCHAR2 (150)  NOT NULL , 
     grado_patologia        VARCHAR2 (150)  NOT NULL , 
     duracion_patologia     VARCHAR2 (150)  NOT NULL , 
     FICHA_CLIENTE_id_ficha NUMBER (7) , 
     CAT_PATOLOGIA_id_cat   NUMBER (4)  NOT NULL 
    ) 
;

ALTER TABLE PATOLOGIAS 
    ADD CONSTRAINT PATOLOGIAS_PK PRIMARY KEY ( id_patologia ) ;

CREATE TABLE PLAN 
    ( 
     id_plan          NUMBER (7)  NOT NULL , 
     nombre_plan      VARCHAR2 (50)  NOT NULL , 
     precio_plan      NUMBER (5)  NOT NULL , 
     duracion_plan    VARCHAR2 (50)  NOT NULL , 
     descripcion_plan VARCHAR2 (200)  NOT NULL 
    ) 
;

ALTER TABLE PLAN 
    ADD CONSTRAINT PLAN_PK PRIMARY KEY ( id_plan ) ;

CREATE TABLE PREPARADOR_FISICO 
    ( 
     rut_prep                VARCHAR2 (13)  NOT NULL , 
     pnombre_preparador      VARCHAR2 (150)  NOT NULL , 
     snombre_preparador      VARCHAR2 (150) , 
     papellido_preparador    VARCHAR2 (150)  NOT NULL , 
     sapellido_preparador    VARCHAR2 (150) , 
     fecha_nac_preparador    DATE  NOT NULL , 
     especialidad_preparador VARCHAR2 (150)  NOT NULL , 
     COMUNA_id_comuna        NUMBER (3) , 
     correo_preparador       VARCHAR2 (100)  NOT NULL , 
     telefono_preparador     VARCHAR2 (9)  NOT NULL 
    ) 
;

ALTER TABLE PREPARADOR_FISICO 
    ADD CONSTRAINT PREPARADOR_FISICO_PK PRIMARY KEY ( rut_prep ) ;

CREATE TABLE PROGRE_CLI 
    ( 
     id_progreso            NUMBER (7)  NOT NULL , 
     descripcion_progreso   VARCHAR2 (200)  NOT NULL , 
     fecha_progreso         DATE  NOT NULL , 
     FICHA_CLIENTE_id_ficha NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE PROGRE_CLI 
    ADD CONSTRAINT PROGRE_CLI_PK PRIMARY KEY ( id_progreso ) ;

CREATE TABLE REGION 
    ( 
     id_region     NUMBER (3)  NOT NULL , 
     nombre_region VARCHAR2 (50)  NOT NULL , 
     PAIS_id_pais  NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE REGION 
    ADD CONSTRAINT REGION_PK PRIMARY KEY ( id_region ) ;

CREATE TABLE REGISTRAR 
    ( 
     METRICAS_CLIENTE_id_metrica NUMBER (3)  NOT NULL , 
     FICHA_CLIENTE_id_ficha      NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE REGISTRAR 
    ADD CONSTRAINT REGISTRAR_PK PRIMARY KEY ( METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha ) ;

CREATE TABLE RUTINA 
    ( 
     id_rutina           NUMBER (7)  NOT NULL , 
     nombre_rutina       VARCHAR2 (50)  NOT NULL , 
     CLIENTE_rut_cliente VARCHAR2 (13) 
    ) 
;

ALTER TABLE RUTINA 
    ADD CONSTRAINT RUTINA_PK PRIMARY KEY ( id_rutina ) ;

CREATE TABLE SESION_ENTRENAMIENTO 
    ( 
     id_sesion            NUMBER (7)  NOT NULL , 
     fecha_sesion         DATE  NOT NULL , 
     duracion_sesion      INTERVAL DAY (9) TO SECOND (0)  NOT NULL , 
     RUTINA_id_rutina     NUMBER (7) , 
     AGENDA_id_agendar    NUMBER (7) , 
     AGENDA_fecha_agendar DATE 
    ) 
;

ALTER TABLE SESION_ENTRENAMIENTO 
    ADD CONSTRAINT SESION_ENTRENAMIENTO_PK PRIMARY KEY ( id_sesion ) ;

CREATE TABLE TENER 
    ( 
     CLIENTE_rut_cliente    VARCHAR2 (13)  NOT NULL , 
     FICHA_CLIENTE_id_ficha NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE TENER 
    ADD CONSTRAINT TENER_PK PRIMARY KEY ( CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha ) ;

ALTER TABLE AGENDA 
    ADD CONSTRAINT AGENDA_CLIENTE_FK FOREIGN KEY 
    ( 
     CLIENTE_rut_cliente
    ) 
    REFERENCES CLIENTE 
    ( 
     rut_cliente
    ) 
;

ALTER TABLE AGENDA 
    ADD CONSTRAINT AGENDA_PREPARADOR_FISICO_FK FOREIGN KEY 
    ( 
     PREPARADOR_FISICO_rut_prep
    ) 
    REFERENCES PREPARADOR_FISICO 
    ( 
     rut_prep
    ) 
;

ALTER TABLE AGENDA 
    ADD CONSTRAINT AGENDA_CONTRATO_CLI_FK FOREIGN KEY 
    ( 
     CONTRATO_CLI_id_contrato
    ) 
    REFERENCES CONTRATO_CLI 
    ( 
     id_contrato
    ) 
;

ALTER TABLE BLOQUE_HORARIO 
    ADD CONSTRAINT BLOQUE_HORARIO_AGENDA_FK FOREIGN KEY 
    ( 
     AGENDA_id_agendar,
     AGENDA_fecha_agendar
    ) 
    REFERENCES AGENDA 
    ( 
     id_agendar,
     fecha_agendar
    ) 
;

ALTER TABLE CENTRO_DEP 
    ADD CONSTRAINT CENTRO_DEP_COMUNA_FK FOREIGN KEY 
    ( 
     COMUNA_id_comuna
    ) 
    REFERENCES COMUNA 
    ( 
     id_comuna
    ) 
;

ALTER TABLE CIUDAD 
    ADD CONSTRAINT CIUDAD_REGION_FK FOREIGN KEY 
    ( 
     REGION_id_region
    ) 
    REFERENCES REGION 
    ( 
     id_region
    ) 
;

ALTER TABLE CLIENTE 
    ADD CONSTRAINT CLIENTE_COMUNA_FK FOREIGN KEY 
    ( 
     COMUNA_id_comuna
    ) 
    REFERENCES COMUNA 
    ( 
     id_comuna
    ) 
;

ALTER TABLE CLIENTE 
    ADD CONSTRAINT CLIENTE_PLAN_FK FOREIGN KEY 
    ( 
     PLAN_id_plan
    ) 
    REFERENCES PLAN 
    ( 
     id_plan
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_CIUDAD_FK FOREIGN KEY 
    ( 
     CIUDAD_id_ciudad
    ) 
    REFERENCES CIUDAD 
    ( 
     id_ciudad
    ) 
;

ALTER TABLE CONTENER 
    ADD CONSTRAINT CONTENER_EJERCICIO_FK FOREIGN KEY 
    ( 
     EJERCICIO_id_ejercicio
    ) 
    REFERENCES EJERCICIO 
    ( 
     id_ejercicio
    ) 
;

ALTER TABLE CONTENER 
    ADD CONSTRAINT CONTENER_RUTINA_FK FOREIGN KEY 
    ( 
     RUTINA_id_rutina
    ) 
    REFERENCES RUTINA 
    ( 
     id_rutina
    ) 
;

ALTER TABLE CONTRATO_CLI 
    ADD CONSTRAINT CONTRATO_CLI_PLAN_FK FOREIGN KEY 
    ( 
     PLAN_id_plan
    ) 
    REFERENCES PLAN 
    ( 
     id_plan
    ) 
;

ALTER TABLE CONTRATO_CLI
    ADD CONSTRAINT CONTRATO_CLI_CLIENTE_FK FOREIGN KEY
    (
     CLIENTE_rut_cliente
    )
    REFERENCES CLIENTE
    (
     rut_cliente
    )
;

ALTER TABLE DEFINIR 
    ADD CONSTRAINT DEFINIR_BLOQUE_HORARIO_FK FOREIGN KEY 
    ( 
     BLOQUE_HORARIO_id_bloque
    ) 
    REFERENCES BLOQUE_HORARIO 
    ( 
     id_bloque
    ) 
;

ALTER TABLE DEFINIR 
    ADD CONSTRAINT DEFINIR_PREPARADOR_FISICO_FK FOREIGN KEY 
    ( 
     PREPARADOR_FISICO_rut_prep
    ) 
    REFERENCES PREPARADOR_FISICO 
    ( 
     rut_prep
    ) 
;

ALTER TABLE DISENAR 
    ADD CONSTRAINT DISENAR_PREPARADOR_FISICO_FK FOREIGN KEY 
    ( 
     PREPARADOR_FISICO_rut_prep
    ) 
    REFERENCES PREPARADOR_FISICO 
    ( 
     rut_prep
    ) 
;

ALTER TABLE DISENAR 
    ADD CONSTRAINT DISENAR_RUTINA_FK FOREIGN KEY 
    ( 
     RUTINA_id_rutina
    ) 
    REFERENCES RUTINA 
    ( 
     id_rutina
    ) 
;

ALTER TABLE EMPLEA 
    ADD CONSTRAINT EMPLEA_CENTRO_DEPORTIVO_FK FOREIGN KEY 
    ( 
     CENTRO_DEPORTIVO_id_centro
    ) 
    REFERENCES CENTRO_DEP 
    ( 
     id_centro
    ) 
;

ALTER TABLE EMPLEA 
    ADD CONSTRAINT EMPLEA_PREPARADOR_FISICO_FK FOREIGN KEY 
    ( 
     PREPARADOR_FISICO_rut_prep
    ) 
    REFERENCES PREPARADOR_FISICO 
    ( 
     rut_prep
    ) 
;

ALTER TABLE FACTURA 
    ADD CONSTRAINT FACTURA_PAGO_FK FOREIGN KEY 
    ( 
     PAGO_id_pago
    ) 
    REFERENCES PAGO 
    ( 
     id_pago
    ) 
;

ALTER TABLE OFRECER 
    ADD CONSTRAINT OFRECER_PLAN_FK FOREIGN KEY 
    ( 
     PLAN_id_plan
    ) 
    REFERENCES PLAN 
    ( 
     id_plan
    ) 
;

ALTER TABLE OFRECER 
    ADD CONSTRAINT OFRECER_PREPARADOR_FISICO_FK FOREIGN KEY 
    ( 
     PREPARADOR_FISICO_rut_prep
    ) 
    REFERENCES PREPARADOR_FISICO 
    ( 
     rut_prep
    ) 
;

ALTER TABLE PAGO 
    ADD CONSTRAINT PAGO_CONTRATO_CLI_FK FOREIGN KEY 
    ( 
     CONTRATO_CLI_id_contrato
    ) 
    REFERENCES CONTRATO_CLI 
    ( 
     id_contrato
    ) 
;

ALTER TABLE PAGO 
    ADD CONSTRAINT PAGO_METODO_PAGO_CLI_FK FOREIGN KEY 
    ( 
     METODO_PAGO_CLI_id_metodo_pago
    ) 
    REFERENCES METODO_PAGO_CLI 
    ( 
     id_metodo_pago
    ) 
;

ALTER TABLE PATOLOGIAS 
    ADD CONSTRAINT PATOLOGIAS_CAT_PATOLOGIA_FK FOREIGN KEY 
    ( 
     CAT_PATOLOGIA_id_cat
    ) 
    REFERENCES CAT_PATOLOGIA 
    ( 
     id_cat
    ) 
;

ALTER TABLE PATOLOGIAS 
    ADD CONSTRAINT PATOLOGIAS_FICHA_CLIENTE_FK FOREIGN KEY 
    ( 
     FICHA_CLIENTE_id_ficha
    ) 
    REFERENCES FICHA_CLIENTE 
    ( 
     id_ficha
    ) 
;

ALTER TABLE PREPARADOR_FISICO 
    ADD CONSTRAINT PREPARADOR_FISICO_COMUNA_FK FOREIGN KEY 
    ( 
     COMUNA_id_comuna
    ) 
    REFERENCES COMUNA 
    ( 
     id_comuna
    ) 
;

ALTER TABLE PROGRE_CLI 
    ADD CONSTRAINT PROGRE_CLI_FICHA_CLIENTE_FK FOREIGN KEY 
    ( 
     FICHA_CLIENTE_id_ficha
    ) 
    REFERENCES FICHA_CLIENTE 
    ( 
     id_ficha
    ) 
;

ALTER TABLE REGION 
    ADD CONSTRAINT REGION_PAIS_FK FOREIGN KEY 
    ( 
     PAIS_id_pais
    ) 
    REFERENCES PAIS 
    ( 
     id_pais
    ) 
;

ALTER TABLE REGISTRAR 
    ADD CONSTRAINT REGISTRAR_FICHA_CLIENTE_FK FOREIGN KEY 
    ( 
     FICHA_CLIENTE_id_ficha
    ) 
    REFERENCES FICHA_CLIENTE 
    ( 
     id_ficha
    ) 
;

ALTER TABLE REGISTRAR 
    ADD CONSTRAINT REGISTRAR_METRICAS_CLIENTE_FK FOREIGN KEY 
    ( 
     METRICAS_CLIENTE_id_metrica
    ) 
    REFERENCES METRICAS_CLIENTE 
    ( 
     id_metrica
    ) 
;

ALTER TABLE RUTINA 
    ADD CONSTRAINT RUTINA_CLIENTE_FK FOREIGN KEY 
    ( 
     CLIENTE_rut_cliente
    ) 
    REFERENCES CLIENTE 
    ( 
     rut_cliente
    ) 
;

ALTER TABLE SESION_ENTRENAMIENTO 
    ADD CONSTRAINT SESION_ENTRENAMIENTO_AGENDA_FK FOREIGN KEY 
    ( 
     AGENDA_id_agendar,
     AGENDA_fecha_agendar
    ) 
    REFERENCES AGENDA 
    ( 
     id_agendar,
     fecha_agendar
    ) 
;

ALTER TABLE SESION_ENTRENAMIENTO 
    ADD CONSTRAINT SESION_ENTRENAMIENTO_RUTINA_FK FOREIGN KEY 
    ( 
     RUTINA_id_rutina
    ) 
    REFERENCES RUTINA 
    ( 
     id_rutina
    ) 
;

ALTER TABLE TENER 
    ADD CONSTRAINT TENER_CLIENTE_FK FOREIGN KEY 
    ( 
     CLIENTE_rut_cliente
    ) 
    REFERENCES CLIENTE 
    ( 
     rut_cliente
    ) 
;

ALTER TABLE TENER 
    ADD CONSTRAINT TENER_FICHA_CLIENTE_FK FOREIGN KEY 
    ( 
     FICHA_CLIENTE_id_ficha
    ) 
    REFERENCES FICHA_CLIENTE 
    ( 
     id_ficha
    ) 
;

-- ============================================================
-- 3) POBLADO DE LAS TABLAS
-- ============================================================

-- PAIS: 1 registros
INSERT INTO PAIS (id_pais, nombre_pais) VALUES (1, 'Chile');

-- REGION: 16 registros
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (15, 'Arica y Parinacota', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (1, 'Tarapacá', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (2, 'Antofagasta', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (3, 'Atacama', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (4, 'Coquimbo', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (5, 'Valparaíso', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (13, 'Metropolitana de Santiago', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (6, 'Libertador General Bernardo O''Higgins', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (7, 'Maule', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (16, 'Ñuble', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (8, 'Biobío', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (9, 'La Araucanía', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (14, 'Los Ríos', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (10, 'Los Lagos', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (11, 'Aysén del General Carlos Ibáñez del Campo', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (12, 'Magallanes y de la Antártica Chilena', 1);

-- CIUDAD: 56 registros
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (1, 'Arica', 15);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (2, 'Putre', 15);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (3, 'Iquique', 1);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (4, 'Pozo Almonte', 1);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (5, 'Antofagasta', 2);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (6, 'Calama', 2);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (7, 'Tocopilla', 2);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (8, 'Copiapó', 3);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (9, 'Chañaral', 3);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (10, 'Vallenar', 3);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (11, 'La Serena', 4);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (12, 'Illapel', 4);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (13, 'Ovalle', 4);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (14, 'Valparaíso', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (15, 'Hanga Roa', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (16, 'Los Andes', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (17, 'La Ligua', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (18, 'Quillota', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (19, 'San Antonio', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (20, 'San Felipe', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (21, 'Quilpué', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (22, 'Santiago', 13);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (23, 'Puente Alto', 13);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (24, 'Colina', 13);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (25, 'San Bernardo', 13);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (26, 'Melipilla', 13);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (27, 'Talagante', 13);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (28, 'Rancagua', 6);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (29, 'Pichilemu', 6);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (30, 'San Fernando', 6);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (31, 'Curicó', 7);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (32, 'Talca', 7);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (33, 'Linares', 7);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (34, 'Cauquenes', 7);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (35, 'Chillán', 16);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (36, 'Quirihue', 16);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (37, 'San Carlos', 16);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (38, 'Concepción', 8);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (39, 'Lebu', 8);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (40, 'Los Ángeles', 8);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (41, 'Temuco', 9);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (42, 'Angol', 9);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (43, 'Valdivia', 14);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (44, 'La Unión', 14);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (45, 'Puerto Montt', 10);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (46, 'Osorno', 10);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (47, 'Castro', 10);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (48, 'Chaitén', 10);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (49, 'Coyhaique', 11);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (50, 'Puerto Aysén', 11);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (51, 'Cochrane', 11);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (52, 'Chile Chico', 11);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (53, 'Punta Arenas', 12);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (54, 'Puerto Natales', 12);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (55, 'Porvenir', 12);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (56, 'Puerto Williams', 12);

-- COMUNA: 346 registros
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (1, 'Arica', 1);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (2, 'Camarones', 1);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (3, 'General Lagos', 2);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (4, 'Putre', 2);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (5, 'Alto Hospicio', 3);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (6, 'Iquique', 3);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (7, 'Camiña', 4);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (8, 'Colchane', 4);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (9, 'Huara', 4);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (10, 'Pica', 4);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (11, 'Pozo Almonte', 4);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (12, 'Antofagasta', 5);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (13, 'Mejillones', 5);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (14, 'Sierra Gorda', 5);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (15, 'Taltal', 5);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (16, 'Calama', 6);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (17, 'Ollagüe', 6);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (18, 'San Pedro de Atacama', 6);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (19, 'María Elena', 7);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (20, 'Tocopilla', 7);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (21, 'Caldera', 8);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (22, 'Copiapó', 8);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (23, 'Tierra Amarilla', 8);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (24, 'Chañaral', 9);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (25, 'Diego de Almagro', 9);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (26, 'Alto del Carmen', 10);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (27, 'Freirina', 10);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (28, 'Huasco', 10);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (29, 'Vallenar', 10);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (30, 'Andacollo', 11);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (31, 'Coquimbo', 11);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (32, 'La Higuera', 11);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (33, 'La Serena', 11);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (34, 'Paiguano', 11);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (35, 'Vicuña', 11);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (36, 'Canela', 12);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (37, 'Illapel', 12);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (38, 'Los Vilos', 12);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (39, 'Salamanca', 12);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (40, 'Combarbalá', 13);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (41, 'Monte Patria', 13);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (42, 'Ovalle', 13);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (43, 'Punitaqui', 13);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (44, 'Río Hurtado', 13);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (45, 'Casablanca', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (46, 'Concón', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (47, 'Juan Fernández', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (48, 'Puchuncaví', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (49, 'Quintero', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (50, 'Valparaíso', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (51, 'Viña del Mar', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (52, 'Isla de Pascua', 15);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (53, 'Calle Larga', 16);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (54, 'Los Andes', 16);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (55, 'Rinconada', 16);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (56, 'San Esteban', 16);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (57, 'Cabildo', 17);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (58, 'La Ligua', 17);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (59, 'Papudo', 17);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (60, 'Petorca', 17);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (61, 'Zapallar', 17);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (62, 'Calera', 18);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (63, 'Hijuelas', 18);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (64, 'La Cruz', 18);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (65, 'Nogales', 18);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (66, 'Quillota', 18);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (67, 'Algarrobo', 19);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (68, 'Cartagena', 19);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (69, 'El Quisco', 19);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (70, 'El Tabo', 19);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (71, 'San Antonio', 19);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (72, 'Santo Domingo', 19);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (73, 'Catemu', 20);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (74, 'Llaillay', 20);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (75, 'Panquehue', 20);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (76, 'Putaendo', 20);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (77, 'San Felipe', 20);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (78, 'Santa María', 20);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (79, 'Limache', 21);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (80, 'Olmué', 21);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (81, 'Quilpué', 21);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (82, 'Villa Alemana', 21);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (83, 'Cerrillos', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (84, 'Cerro Navia', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (85, 'Conchalí', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (86, 'El Bosque', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (87, 'Estación Central', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (88, 'Huechuraba', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (89, 'Independencia', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (90, 'La Cisterna', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (91, 'La Florida', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (92, 'La Granja', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (93, 'La Pintana', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (94, 'La Reina', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (95, 'Las Condes', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (96, 'Lo Barnechea', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (97, 'Lo Espejo', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (98, 'Lo Prado', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (99, 'Macul', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (100, 'Maipú', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (101, 'Ñuñoa', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (102, 'Pedro Aguirre Cerda', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (103, 'Peñalolén', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (104, 'Providencia', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (105, 'Pudahuel', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (106, 'Quilicura', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (107, 'Quinta Normal', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (108, 'Recoleta', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (109, 'Renca', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (110, 'San Joaquín', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (111, 'San Miguel', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (112, 'San Ramón', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (113, 'Santiago', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (114, 'Vitacura', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (115, 'Pirque', 23);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (116, 'Puente Alto', 23);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (117, 'San José de Maipo', 23);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (118, 'Colina', 24);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (119, 'Lampa', 24);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (120, 'Tiltil', 24);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (121, 'Buin', 25);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (122, 'Calera de Tango', 25);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (123, 'Paine', 25);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (124, 'San Bernardo', 25);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (125, 'Alhué', 26);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (126, 'Curacaví', 26);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (127, 'María Pinto', 26);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (128, 'Melipilla', 26);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (129, 'San Pedro', 26);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (130, 'El Monte', 27);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (131, 'Isla de Maipo', 27);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (132, 'Padre Hurtado', 27);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (133, 'Peñaflor', 27);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (134, 'Talagante', 27);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (135, 'Codegua', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (136, 'Coínco', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (137, 'Coltauco', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (138, 'Doñihue', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (139, 'Graneros', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (140, 'Las Cabras', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (141, 'Machalí', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (142, 'Malloa', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (143, 'Mostazal', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (144, 'Olivar', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (145, 'Peumo', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (146, 'Pichidegua', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (147, 'Quinta de Tilcoco', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (148, 'Rancagua', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (149, 'Rengo', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (150, 'Requínoa', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (151, 'San Vicente', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (152, 'La Estrella', 29);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (153, 'Litueche', 29);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (154, 'Marchihue', 29);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (155, 'Navidad', 29);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (156, 'Paredones', 29);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (157, 'Pichilemu', 29);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (158, 'Chépica', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (159, 'Chimbarongo', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (160, 'Lolol', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (161, 'Nancagua', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (162, 'Palmilla', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (163, 'Peralillo', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (164, 'Placilla', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (165, 'Pumanque', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (166, 'San Fernando', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (167, 'Santa Cruz', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (168, 'Curicó', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (169, 'Hualañé', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (170, 'Licantén', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (171, 'Molina', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (172, 'Rauco', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (173, 'Romeral', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (174, 'Sagrada Familia', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (175, 'Teno', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (176, 'Vichuquén', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (177, 'Constitución', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (178, 'Curepto', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (179, 'Empedrado', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (180, 'Maule', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (181, 'Pelarco', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (182, 'Pencahue', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (183, 'Río Claro', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (184, 'San Clemente', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (185, 'San Rafael', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (186, 'Talca', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (187, 'Colbún', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (188, 'Linares', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (189, 'Longaví', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (190, 'Parral', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (191, 'Retiro', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (192, 'San Javier', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (193, 'Villa Alegre', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (194, 'Yerbas Buenas', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (195, 'Cauquenes', 34);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (196, 'Chanco', 34);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (197, 'Pelluhue', 34);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (198, 'Bulnes', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (199, 'Chillán', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (200, 'Chillán Viejo', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (201, 'El Carmen', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (202, 'Pemuco', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (203, 'Pinto', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (204, 'Quillón', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (205, 'San Ignacio', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (206, 'Yungay', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (207, 'Cobquecura', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (208, 'Coelemu', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (209, 'Ninhue', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (210, 'Portezuelo', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (211, 'Quirihue', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (212, 'Ránquil', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (213, 'Treguaco', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (214, 'Coihueco', 37);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (215, 'Ñiquén', 37);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (216, 'San Carlos', 37);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (217, 'San Fabián', 37);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (218, 'San Nicolás', 37);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (219, 'Chiguayante', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (220, 'Concepción', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (221, 'Coronel', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (222, 'Florida', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (223, 'Hualpén', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (224, 'Hualqui', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (225, 'Lota', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (226, 'Penco', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (227, 'San Pedro de la Paz', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (228, 'Santa Juana', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (229, 'Talcahuano', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (230, 'Tomé', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (231, 'Arauco', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (232, 'Cañete', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (233, 'Contulmo', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (234, 'Curanilahue', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (235, 'Lebu', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (236, 'Los Álamos', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (237, 'Tirúa', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (238, 'Alto Biobío', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (239, 'Antuco', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (240, 'Cabrero', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (241, 'Laja', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (242, 'Los Ángeles', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (243, 'Mulchén', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (244, 'Nacimiento', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (245, 'Negrete', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (246, 'Quilaco', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (247, 'Quilleco', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (248, 'San Rosendo', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (249, 'Santa Bárbara', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (250, 'Tucapel', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (251, 'Yumbel', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (252, 'Carahue', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (253, 'Cholchol', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (254, 'Cunco', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (255, 'Curarrehue', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (256, 'Freire', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (257, 'Galvarino', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (258, 'Gorbea', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (259, 'Lautaro', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (260, 'Loncoche', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (261, 'Melipeuco', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (262, 'Nueva Imperial', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (263, 'Padre Las Casas', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (264, 'Perquenco', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (265, 'Pitrufquén', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (266, 'Pucón', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (267, 'Saavedra', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (268, 'Temuco', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (269, 'Teodoro Schmidt', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (270, 'Toltén', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (271, 'Vilcún', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (272, 'Villarrica', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (273, 'Angol', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (274, 'Collipulli', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (275, 'Curacautín', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (276, 'Ercilla', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (277, 'Lonquimay', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (278, 'Los Sauces', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (279, 'Lumaco', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (280, 'Purén', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (281, 'Renaico', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (282, 'Traiguén', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (283, 'Victoria', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (284, 'Corral', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (285, 'Lanco', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (286, 'Los Lagos', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (287, 'Máfil', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (288, 'Mariquina', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (289, 'Paillaco', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (290, 'Panguipulli', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (291, 'Valdivia', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (292, 'Futrono', 44);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (293, 'La Unión', 44);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (294, 'Lago Ranco', 44);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (295, 'Río Bueno', 44);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (296, 'Calbuco', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (297, 'Cochamó', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (298, 'Fresia', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (299, 'Frutillar', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (300, 'Llanquihue', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (301, 'Los Muermos', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (302, 'Maullín', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (303, 'Puerto Montt', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (304, 'Puerto Octay', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (305, 'Puerto Varas', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (306, 'Osorno', 46);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (307, 'Puyehue', 46);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (308, 'Río Negro', 46);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (309, 'San Juan de la Costa', 46);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (310, 'San Pablo', 46);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (311, 'Purranque', 46);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (312, 'Ancud', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (313, 'Castro', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (314, 'Chonchi', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (315, 'Curaco de Vélez', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (316, 'Dalcahue', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (317, 'Puqueldón', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (318, 'Queilén', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (319, 'Quellón', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (320, 'Quemchi', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (321, 'Quinchao', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (322, 'Chaitén', 48);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (323, 'Futaleufú', 48);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (324, 'Hualaihué', 48);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (325, 'Palena', 48);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (326, 'Coyhaique', 49);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (327, 'Lago Verde', 49);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (328, 'Aysén', 50);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (329, 'Cisnes', 50);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (330, 'Guaitecas', 50);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (331, 'Cochrane', 51);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (332, 'O''Higgins', 51);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (333, 'Tortel', 51);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (334, 'Chile Chico', 52);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (335, 'Río Ibáñez', 52);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (336, 'Laguna Blanca', 53);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (337, 'Punta Arenas', 53);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (338, 'Río Verde', 53);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (339, 'San Gregorio', 53);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (340, 'Natales', 54);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (341, 'Torres del Paine', 54);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (342, 'Porvenir', 55);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (343, 'Primavera', 55);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (344, 'Timaukel', 55);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (345, 'Antártica', 56);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (346, 'Cabo de Hornos', 56);

-- PREPARADOR_FISICO: 200 registros
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('23.507.938-0', 'Ignacio', 'José', 'López', 'Morales', TO_DATE('1981-03-16','YYYY-MM-DD'), 'Musculación y Fuerza', 14, 'ignacio.lopez501@gmail.com', '994290960');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('16.314.012-8', 'Camila', 'Alejandra', 'Salazar', 'Álvarez', TO_DATE('1988-03-03','YYYY-MM-DD'), 'Entrenamiento Funcional', 27, 'camila.salazar502@gmail.com', '915034008');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('22.515.298-5', 'Vicente', 'Alejandro', 'Cortés', 'Araya', TO_DATE('1990-12-04','YYYY-MM-DD'), 'CrossFit', 40, 'vicente.cortes503@gmail.com', '928516756');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('18.616.569-1', 'Camila', 'Antonia', 'Carrasco', 'Valenzuela', TO_DATE('1969-07-13','YYYY-MM-DD'), 'Nutrición Deportiva', 53, 'camila.carrasco504@gmail.com', '986857008');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('20.699.123-2', 'Pedro', 'Andrés', 'Vega', 'Contreras', TO_DATE('1972-12-13','YYYY-MM-DD'), 'Fisioterapia Deportiva', 66, 'pedro.vega505@gmail.com', '921480544');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('11.280.435-8', 'Constanza', 'Paz', 'Valenzuela', 'Rojas', TO_DATE('1989-04-06','YYYY-MM-DD'), 'Yoga y Movilidad', 79, 'constanza.valenzuela506@gmail.com', '989553785');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('22.131.805-6', 'Iván', 'José', 'Espinoza', 'Cortés', TO_DATE('1979-03-13','YYYY-MM-DD'), 'Cardio y Resistencia', 92, 'ivan.espinoza507@gmail.com', '948329736');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('15.710.873-5', 'Trinidad', NULL, 'Miranda', 'Fernández', TO_DATE('1979-09-06','YYYY-MM-DD'), 'Hipertrofia', 105, 'trinidad.miranda508@gmail.com', '966727512');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('11.504.328-5', 'Javier', NULL, 'Rodríguez', 'Castillo', TO_DATE('1972-03-01','YYYY-MM-DD'), 'Acondicionamiento Físico', 118, 'javier.rodriguez509@gmail.com', '982356296');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('19.352.468-0', 'Martina', NULL, 'Gutiérrez', 'Pérez', TO_DATE('1977-04-18','YYYY-MM-DD'), 'Rehabilitación', 131, 'martina.gutierrez510@gmail.com', '959391658');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('19.027.228-1', 'Nicolás', 'Antonio', 'Martínez', 'Contreras', TO_DATE('1983-02-28','YYYY-MM-DD'), 'Musculación y Fuerza', 144, 'nicolas.martinez511@gmail.com', '953794068');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('14.900.991-4', 'Claudia', 'Ignacia', 'Castro', 'Araya', TO_DATE('1977-11-04','YYYY-MM-DD'), 'Entrenamiento Funcional', 157, 'claudia.castro512@gmail.com', '992806254');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('14.825.159-2', 'Benjamín', 'Luis', 'Ortiz', 'Silva', TO_DATE('1984-04-27','YYYY-MM-DD'), 'CrossFit', 170, 'benjamin.ortiz513@gmail.com', '984570424');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('17.674.700-5', 'Javiera', 'Constanza', 'Carrasco', 'Reyes', TO_DATE('1970-02-26','YYYY-MM-DD'), 'Nutrición Deportiva', 183, 'javiera.carrasco514@gmail.com', '921079602');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('12.363.714-3', 'Ignacio', 'José', 'Araya', 'Hernández', TO_DATE('1978-07-17','YYYY-MM-DD'), 'Fisioterapia Deportiva', 196, 'ignacio.araya515@gmail.com', '932594416');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.704.807-3', 'Paz', 'Alejandra', 'Castillo', 'Ortiz', TO_DATE('1978-03-07','YYYY-MM-DD'), 'Yoga y Movilidad', 209, 'paz.castillo516@gmail.com', '964099053');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('20.817.865-2', 'Arturo', 'Luis', 'Hernández', 'Reyes', TO_DATE('1981-10-13','YYYY-MM-DD'), 'Cardio y Resistencia', 222, 'arturo.hernandez517@gmail.com', '956990221');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('21.810.749-4', 'Trinidad', 'Andrea', 'Tapia', 'Navarro', TO_DATE('1991-03-14','YYYY-MM-DD'), 'Hipertrofia', 235, 'trinidad.tapia518@gmail.com', '998159747');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('22.019.455-8', 'Joaquín', 'Alejandro', 'Silva', 'Castillo', TO_DATE('1994-08-09','YYYY-MM-DD'), 'Acondicionamiento Físico', 248, 'joaquin.silva519@gmail.com', '945763098');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('19.687.556-5', 'Josefa', 'Paz', 'Hernández', 'Ramírez', TO_DATE('1985-02-09','YYYY-MM-DD'), 'Rehabilitación', 261, 'josefa.hernandez520@gmail.com', '929255527');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('15.184.138-4', 'Vicente', 'Luis', 'Valdés', 'González', TO_DATE('1990-06-22','YYYY-MM-DD'), 'Musculación y Fuerza', 274, 'vicente.valdes521@gmail.com', '983784068');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('10.415.056-K', 'Rocío', 'Alejandra', 'Contreras', 'Ortiz', TO_DATE('1994-11-25','YYYY-MM-DD'), 'Entrenamiento Funcional', 287, 'rocio.contreras522@gmail.com', '994957985');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.223.627-0', 'Pedro', 'Antonio', 'Vásquez', 'Reyes', TO_DATE('1978-01-13','YYYY-MM-DD'), 'CrossFit', 300, 'pedro.vasquez523@gmail.com', '997003335');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('21.926.290-6', 'Claudia', 'Andrea', 'Muñoz', 'Flores', TO_DATE('1990-05-05','YYYY-MM-DD'), 'Nutrición Deportiva', 313, 'claudia.munoz524@gmail.com', '985017167');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('16.188.185-6', 'Martín', 'Esteban', 'Fernández', 'Ramírez', TO_DATE('1969-04-21','YYYY-MM-DD'), 'Fisioterapia Deportiva', 326, 'martin.fernandez525@gmail.com', '911577597');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('16.099.226-3', 'Martina', 'Paz', 'Castillo', 'González', TO_DATE('1993-08-17','YYYY-MM-DD'), 'Yoga y Movilidad', 339, 'martina.castillo526@gmail.com', '938081599');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('17.735.513-5', 'Joaquín', 'Alejandro', 'Soto', 'Riquelme', TO_DATE('1985-01-04','YYYY-MM-DD'), 'Cardio y Resistencia', 6, 'joaquin.soto527@gmail.com', '935186307');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('17.083.634-0', 'Josefa', 'Alejandra', 'Hernández', 'Herrera', TO_DATE('1987-11-06','YYYY-MM-DD'), 'Hipertrofia', 19, 'josefa.hernandez528@gmail.com', '937698636');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('11.521.428-4', 'Camilo', 'José', 'Soto', 'Navarro', TO_DATE('1990-09-22','YYYY-MM-DD'), 'Acondicionamiento Físico', 32, 'camilo.soto529@gmail.com', '965974034');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('16.690.306-8', 'Amanda', 'Andrea', 'Contreras', 'González', TO_DATE('1981-01-06','YYYY-MM-DD'), 'Rehabilitación', 45, 'amanda.contreras530@gmail.com', '946356183');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.947.974-8', 'Pedro', 'Antonio', 'Fernández', 'Ramírez', TO_DATE('1979-06-20','YYYY-MM-DD'), 'Musculación y Fuerza', 58, 'pedro.fernandez531@gmail.com', '956111589');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('19.826.714-7', 'Daniela', 'Paz', 'Ortiz', 'Castillo', TO_DATE('1969-11-16','YYYY-MM-DD'), 'Entrenamiento Funcional', 71, 'daniela.ortiz532@gmail.com', '943568149');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('19.302.111-5', 'Nicolás', NULL, 'Fernández', 'Gutiérrez', TO_DATE('1994-08-07','YYYY-MM-DD'), 'CrossFit', 84, 'nicolas.fernandez533@gmail.com', '944071544');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('18.362.688-4', 'Javiera', 'Paz', 'Vega', 'Vargas', TO_DATE('1974-10-02','YYYY-MM-DD'), 'Nutrición Deportiva', 97, 'javiera.vega534@gmail.com', '950811259');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.549.625-7', 'Raúl', 'Esteban', 'Pérez', 'Vega', TO_DATE('1992-05-16','YYYY-MM-DD'), 'Fisioterapia Deportiva', 110, 'raul.perez535@gmail.com', '981440325');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('11.953.672-3', 'Renata', 'Ignacia', 'Vega', 'Salazar', TO_DATE('1978-08-11','YYYY-MM-DD'), 'Yoga y Movilidad', 123, 'renata.vega536@gmail.com', '989971027');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('17.137.754-4', 'Emilio', 'Alejandro', 'Gutiérrez', 'Rodríguez', TO_DATE('1985-03-25','YYYY-MM-DD'), 'Cardio y Resistencia', 136, 'emilio.gutierrez537@gmail.com', '920478103');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('18.495.290-4', 'Catalina', 'Estefanía', 'Contreras', 'Miranda', TO_DATE('1968-08-08','YYYY-MM-DD'), 'Hipertrofia', 149, 'catalina.contreras538@gmail.com', '938835830');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('23.464.542-0', 'Cristóbal', 'Esteban', 'Vega', 'Salazar', TO_DATE('1984-04-26','YYYY-MM-DD'), 'Acondicionamiento Físico', 162, 'cristobal.vega539@gmail.com', '926976604');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('22.585.374-6', 'Catalina', 'Constanza', 'Martínez', 'Riquelme', TO_DATE('1979-11-13','YYYY-MM-DD'), 'Rehabilitación', 175, 'catalina.martinez540@gmail.com', '953722847');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.541.731-4', 'Pedro', 'Antonio', 'Sepúlveda', 'Miranda', TO_DATE('1990-03-24','YYYY-MM-DD'), 'Musculación y Fuerza', 188, 'pedro.sepulveda541@gmail.com', '983995414');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('20.069.101-6', 'Josefa', 'Andrea', 'Navarro', 'Díaz', TO_DATE('1995-01-09','YYYY-MM-DD'), 'Entrenamiento Funcional', 201, 'josefa.navarro542@gmail.com', '999475391');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.687.336-4', 'Arturo', 'José', 'Rodríguez', 'Martínez', TO_DATE('1985-12-12','YYYY-MM-DD'), 'CrossFit', 214, 'arturo.rodriguez543@gmail.com', '945911099');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('18.238.128-4', 'Josefa', 'Constanza', 'Morales', 'Rodríguez', TO_DATE('1992-03-22','YYYY-MM-DD'), 'Nutrición Deportiva', 227, 'josefa.morales544@gmail.com', '917199812');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('16.679.821-3', 'Nicolás', 'Esteban', 'García', 'Ortiz', TO_DATE('1968-05-08','YYYY-MM-DD'), 'Fisioterapia Deportiva', 240, 'nicolas.garcia545@gmail.com', '983292329');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('25.380.590-0', 'Paula', 'Alejandra', 'Cortés', 'Soto', TO_DATE('1989-12-14','YYYY-MM-DD'), 'Yoga y Movilidad', 253, 'paula.cortes546@gmail.com', '972497122');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('18.802.211-1', 'Nicolás', 'Alejandro', 'Sepúlveda', 'Vega', TO_DATE('1983-01-02','YYYY-MM-DD'), 'Cardio y Resistencia', 266, 'nicolas.sepulveda547@gmail.com', '915405350');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('14.339.316-K', 'Martina', 'Alejandra', 'Carrasco', 'Araya', TO_DATE('1992-01-06','YYYY-MM-DD'), 'Hipertrofia', 279, 'martina.carrasco548@gmail.com', '954126987');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.167.984-5', 'Gabriel', 'Antonio', 'Soto', 'Vásquez', TO_DATE('1981-04-27','YYYY-MM-DD'), 'Acondicionamiento Físico', 292, 'gabriel.soto549@gmail.com', '999039934');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('17.045.862-1', 'Florencia', 'Antonia', 'Hernández', 'Ortiz', TO_DATE('1979-03-18','YYYY-MM-DD'), 'Rehabilitación', 305, 'florencia.hernandez550@gmail.com', '938549945');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.000.969-7', 'Amanda', 'Constanza', 'Miranda', 'Ortiz', TO_DATE('1992-10-22','YYYY-MM-DD'), 'Musculación y Fuerza', 12, 'amanda.miranda551@gmail.com', '985007599');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.000.988-3', 'Alonso', 'Paz', 'Vega', 'Álvarez', TO_DATE('1993-10-28','YYYY-MM-DD'), 'Entrenamiento Funcional', 19, 'alonso.vega552@gmail.com', '985007748');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.007-5', 'Sebastián', 'Estefanía', 'Vega', 'Torres', TO_DATE('1994-11-03','YYYY-MM-DD'), 'CrossFit', 26, 'sebastian.vega553@gmail.com', '985007897');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.026-1', 'Valentina', 'José', 'Araya', 'Castillo', TO_DATE('1995-11-09','YYYY-MM-DD'), 'Nutrición Deportiva', 33, 'valentina.araya554@gmail.com', '985008046');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.045-8', 'Valentina', 'Camila', 'Reyes', 'Salazar', TO_DATE('1996-11-14','YYYY-MM-DD'), 'Fisioterapia Deportiva', 40, 'valentina.reyes555@gmail.com', '985008195');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.064-4', 'Matías', 'Luis', 'Tapia', 'Rojas', TO_DATE('1997-11-20','YYYY-MM-DD'), 'Yoga y Movilidad', 47, 'matias.tapia556@gmail.com', '985008344');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.083-0', 'Laura', 'Antonio', 'Vega', 'Rodríguez', TO_DATE('1998-11-26','YYYY-MM-DD'), 'Cardio y Resistencia', 54, 'laura.vega557@gmail.com', '985008493');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.102-0', 'Camilo', 'Alejandra', 'Carrasco', 'Flores', TO_DATE('1970-12-03','YYYY-MM-DD'), 'Hipertrofia', 61, 'camilo.carrasco558@gmail.com', '985008642');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.121-7', 'Valentina', 'Andrés', 'García', 'Fernández', TO_DATE('1971-12-09','YYYY-MM-DD'), 'Acondicionamiento Físico', 68, 'valentina.garcia559@gmail.com', '985008791');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.140-3', 'Rodrigo', 'Esteban', 'Vargas', 'Gutiérrez', TO_DATE('1972-12-14','YYYY-MM-DD'), 'Rehabilitación', 75, 'rodrigo.vargas560@gmail.com', '985008940');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.159-4', 'Camilo', NULL, 'Martínez', 'Riquelme', TO_DATE('1973-12-20','YYYY-MM-DD'), 'Musculación y Fuerza', 82, 'camilo.martinez561@gmail.com', '985009089');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.178-0', 'Florencia', 'Andrea', 'Reyes', 'Cortés', TO_DATE('1974-12-26','YYYY-MM-DD'), 'Entrenamiento Funcional', 89, 'florencia.reyes562@gmail.com', '985009238');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.197-7', 'Mauricio', 'Ignacia', 'García', 'López', TO_DATE('1976-01-01','YYYY-MM-DD'), 'CrossFit', 96, 'mauricio.garcia563@gmail.com', '985009387');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.216-7', 'Valentina', 'Alejandro', 'Ortiz', 'Ramírez', TO_DATE('1977-01-06','YYYY-MM-DD'), 'Nutrición Deportiva', 103, 'valentina.ortiz564@gmail.com', '985009536');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.235-3', 'Franco', 'Antonia', 'Silva', 'Vásquez', TO_DATE('1978-01-12','YYYY-MM-DD'), 'Fisioterapia Deportiva', 110, 'franco.silva565@gmail.com', '985009685');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.254-K', 'Tomás', 'Fernanda', 'Pizarro', 'Sepúlveda', TO_DATE('1979-01-18','YYYY-MM-DD'), 'Yoga y Movilidad', 117, 'tomas.pizarro566@gmail.com', '985009834');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.273-6', 'Florencia', 'Constanza', 'Espinoza', 'Navarro', TO_DATE('1980-01-24','YYYY-MM-DD'), 'Cardio y Resistencia', 124, 'florencia.espinoza567@gmail.com', '985009983');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.292-2', 'Sebastián', 'Paz', 'Sepúlveda', 'Herrera', TO_DATE('1981-01-29','YYYY-MM-DD'), 'Hipertrofia', 131, 'sebastian.sepulveda568@gmail.com', '985010132');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.311-2', 'Rocío', 'Estefanía', 'Ortiz', 'Muñoz', TO_DATE('1982-02-04','YYYY-MM-DD'), 'Acondicionamiento Físico', 138, 'rocio.ortiz569@gmail.com', '985010281');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.330-9', 'Sergio', 'José', 'Espinoza', 'Díaz', TO_DATE('1983-02-10','YYYY-MM-DD'), 'Rehabilitación', 145, 'sergio.espinoza570@gmail.com', '985010430');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.349-K', 'Rocío', 'Camila', 'Valenzuela', 'Ortiz', TO_DATE('1984-02-16','YYYY-MM-DD'), 'Musculación y Fuerza', 152, 'rocio.valenzuela571@gmail.com', '985010579');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.368-6', 'Daniela', 'Luis', 'Herrera', 'Álvarez', TO_DATE('1985-02-21','YYYY-MM-DD'), 'Entrenamiento Funcional', 159, 'daniela.herrera572@gmail.com', '985010728');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.387-2', 'Antonia', 'Antonio', 'Valenzuela', 'Torres', TO_DATE('1986-02-27','YYYY-MM-DD'), 'CrossFit', 166, 'antonia.valenzuela573@gmail.com', '985010877');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.406-2', 'Vicente', 'Alejandra', 'Vega', 'Castillo', TO_DATE('1987-03-05','YYYY-MM-DD'), 'Nutrición Deportiva', 173, 'vicente.vega574@gmail.com', '985011026');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.425-9', 'Franco', 'Andrés', 'Soto', 'Salazar', TO_DATE('1988-03-10','YYYY-MM-DD'), 'Fisioterapia Deportiva', 180, 'franco.soto575@gmail.com', '985011175');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.444-5', 'Matías', 'Esteban', 'Sepúlveda', 'Rojas', TO_DATE('1989-03-16','YYYY-MM-DD'), 'Yoga y Movilidad', 187, 'matias.sepulveda576@gmail.com', '985011324');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.463-1', 'Sergio', NULL, 'Pizarro', 'Rodríguez', TO_DATE('1990-03-22','YYYY-MM-DD'), 'Cardio y Resistencia', 194, 'sergio.pizarro577@gmail.com', '985011473');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.482-8', 'Ignacio', 'Andrea', 'Espinoza', 'Flores', TO_DATE('1991-03-28','YYYY-MM-DD'), 'Hipertrofia', 201, 'ignacio.espinoza578@gmail.com', '985011622');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.501-8', 'Laura', 'Ignacia', 'González', 'Fernández', TO_DATE('1992-04-02','YYYY-MM-DD'), 'Acondicionamiento Físico', 208, 'laura.gonzalez579@gmail.com', '985011771');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.520-4', 'Matías', 'Alejandro', 'Pérez', 'Gutiérrez', TO_DATE('1993-04-08','YYYY-MM-DD'), 'Rehabilitación', 215, 'matias.perez580@gmail.com', '985011920');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.539-5', 'Valentina', 'Antonia', 'Tapia', 'Riquelme', TO_DATE('1994-04-14','YYYY-MM-DD'), 'Musculación y Fuerza', 222, 'valentina.tapia581@gmail.com', '985012069');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.558-1', 'Javiera', 'Fernanda', 'Fuentes', 'Cortés', TO_DATE('1995-04-20','YYYY-MM-DD'), 'Entrenamiento Funcional', 229, 'javiera.fuentes582@gmail.com', '985012218');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.577-8', 'Carla', 'Constanza', 'Pérez', 'López', TO_DATE('1996-04-25','YYYY-MM-DD'), 'CrossFit', 236, 'carla.perez583@gmail.com', '985012367');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.596-4', 'Florencia', 'Paz', 'Valenzuela', 'Ramírez', TO_DATE('1997-05-01','YYYY-MM-DD'), 'Nutrición Deportiva', 243, 'florencia.valenzuela584@gmail.com', '985012516');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.615-4', 'Sebastián', 'Estefanía', 'Fuentes', 'Vásquez', TO_DATE('1998-05-07','YYYY-MM-DD'), 'Fisioterapia Deportiva', 250, 'sebastian.fuentes585@gmail.com', '985012665');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.634-0', 'Diego', 'José', 'Araya', 'Sepúlveda', TO_DATE('1970-05-14','YYYY-MM-DD'), 'Yoga y Movilidad', 257, 'diego.araya586@gmail.com', '985012814');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.653-7', 'Rodrigo', 'Camila', 'Martínez', 'Navarro', TO_DATE('1971-05-20','YYYY-MM-DD'), 'Cardio y Resistencia', 264, 'rodrigo.martinez587@gmail.com', '985012963');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.672-3', 'Rocío', 'Luis', 'Carrasco', 'Herrera', TO_DATE('1972-05-25','YYYY-MM-DD'), 'Hipertrofia', 271, 'rocio.carrasco588@gmail.com', '985013112');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.691-K', 'Vicente', 'Antonio', 'Ortiz', 'Muñoz', TO_DATE('1973-05-31','YYYY-MM-DD'), 'Acondicionamiento Físico', 278, 'vicente.ortiz589@gmail.com', '985013261');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.710-K', 'Laura', 'Alejandra', 'Carrasco', 'Díaz', TO_DATE('1974-06-06','YYYY-MM-DD'), 'Rehabilitación', 285, 'laura.carrasco590@gmail.com', '985013410');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.729-0', 'Diego', 'Andrés', 'Espinoza', 'Ortiz', TO_DATE('1975-06-12','YYYY-MM-DD'), 'Musculación y Fuerza', 292, 'diego.espinoza591@gmail.com', '985013559');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.748-7', 'Paz', 'Esteban', 'Sepúlveda', 'Álvarez', TO_DATE('1976-06-17','YYYY-MM-DD'), 'Entrenamiento Funcional', 299, 'paz.sepulveda592@gmail.com', '985013708');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.767-3', 'Alonso', NULL, 'Martínez', 'Torres', TO_DATE('1977-06-23','YYYY-MM-DD'), 'CrossFit', 306, 'alonso.martinez593@gmail.com', '985013857');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.786-K', 'Vicente', 'Andrea', 'Martínez', 'Castillo', TO_DATE('1978-06-29','YYYY-MM-DD'), 'Nutrición Deportiva', 313, 'vicente.martinez594@gmail.com', '985014006');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.805-K', 'Daniela', 'Ignacia', 'Valenzuela', 'Salazar', TO_DATE('1979-07-05','YYYY-MM-DD'), 'Fisioterapia Deportiva', 320, 'daniela.valenzuela595@gmail.com', '985014155');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.824-6', 'Mauricio', 'Alejandro', 'Vargas', 'Rojas', TO_DATE('1980-07-10','YYYY-MM-DD'), 'Yoga y Movilidad', 327, 'mauricio.vargas596@gmail.com', '985014304');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.843-2', 'Sebastián', 'Antonia', 'Martínez', 'Rodríguez', TO_DATE('1981-07-16','YYYY-MM-DD'), 'Cardio y Resistencia', 334, 'sebastian.martinez597@gmail.com', '985014453');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.862-9', 'Valentina', 'Fernanda', 'Herrera', 'Flores', TO_DATE('1982-07-22','YYYY-MM-DD'), 'Hipertrofia', 341, 'valentina.herrera598@gmail.com', '985014602');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.881-5', 'Matías', 'Constanza', 'Carrasco', 'Fernández', TO_DATE('1983-07-28','YYYY-MM-DD'), 'Acondicionamiento Físico', 2, 'matias.carrasco599@gmail.com', '985014751');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.900-5', 'Rodrigo', 'Paz', 'Carrasco', 'Gutiérrez', TO_DATE('1984-08-02','YYYY-MM-DD'), 'Rehabilitación', 9, 'rodrigo.carrasco600@gmail.com', '985014900');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.919-6', 'Matías', 'Estefanía', 'Araya', 'Riquelme', TO_DATE('1985-08-08','YYYY-MM-DD'), 'Musculación y Fuerza', 16, 'matias.araya601@gmail.com', '985015049');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.938-2', 'Diego', 'José', 'Tapia', 'Cortés', TO_DATE('1986-08-14','YYYY-MM-DD'), 'Entrenamiento Funcional', 23, 'diego.tapia602@gmail.com', '985015198');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.957-9', 'Amanda', 'Camila', 'González', 'López', TO_DATE('1987-08-20','YYYY-MM-DD'), 'CrossFit', 30, 'amanda.gonzalez603@gmail.com', '985015347');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.976-5', 'Vicente', 'Luis', 'Araya', 'Ramírez', TO_DATE('1988-08-25','YYYY-MM-DD'), 'Nutrición Deportiva', 37, 'vicente.araya604@gmail.com', '985015496');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.001.995-1', 'Laura', 'Antonio', 'Araya', 'Vásquez', TO_DATE('1989-08-31','YYYY-MM-DD'), 'Fisioterapia Deportiva', 44, 'laura.araya605@gmail.com', '985015645');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.014-3', 'Daniela', 'Alejandra', 'Soto', 'Sepúlveda', TO_DATE('1990-09-06','YYYY-MM-DD'), 'Yoga y Movilidad', 51, 'daniela.soto606@gmail.com', '985015794');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.033-K', 'Diego', 'Andrés', 'Herrera', 'Navarro', TO_DATE('1991-09-12','YYYY-MM-DD'), 'Cardio y Resistencia', 58, 'diego.herrera607@gmail.com', '985015943');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.052-6', 'Andrés', 'Esteban', 'Ortiz', 'Herrera', TO_DATE('1992-09-17','YYYY-MM-DD'), 'Hipertrofia', 65, 'andres.ortiz608@gmail.com', '985016092');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.071-2', 'Camilo', NULL, 'Fuentes', 'Muñoz', TO_DATE('1993-09-23','YYYY-MM-DD'), 'Acondicionamiento Físico', 72, 'camilo.fuentes609@gmail.com', '985016241');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.090-9', 'Carla', 'Andrea', 'Miranda', 'Díaz', TO_DATE('1994-09-29','YYYY-MM-DD'), 'Rehabilitación', 79, 'carla.miranda610@gmail.com', '985016390');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.109-3', 'Carla', 'Ignacia', 'Soto', 'Ortiz', TO_DATE('1995-10-05','YYYY-MM-DD'), 'Musculación y Fuerza', 86, 'carla.soto611@gmail.com', '985016539');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.128-K', 'Matías', 'Alejandro', 'Silva', 'Álvarez', TO_DATE('1996-10-10','YYYY-MM-DD'), 'Entrenamiento Funcional', 93, 'matias.silva612@gmail.com', '985016688');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.147-6', 'Daniela', 'Antonia', 'Fernández', 'Torres', TO_DATE('1997-10-16','YYYY-MM-DD'), 'CrossFit', 100, 'daniela.fernandez613@gmail.com', '985016837');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.166-2', 'Javiera', 'Fernanda', 'Miranda', 'Castillo', TO_DATE('1998-10-22','YYYY-MM-DD'), 'Nutrición Deportiva', 107, 'javiera.miranda614@gmail.com', '985016986');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.185-9', 'Rocío', 'Constanza', 'González', 'Salazar', TO_DATE('1970-10-29','YYYY-MM-DD'), 'Fisioterapia Deportiva', 114, 'rocio.gonzalez615@gmail.com', '985017135');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.204-9', 'Franco', 'Paz', 'Vargas', 'Rojas', TO_DATE('1971-11-04','YYYY-MM-DD'), 'Yoga y Movilidad', 121, 'franco.vargas616@gmail.com', '985017284');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.223-5', 'Valentina', 'Estefanía', 'Sepúlveda', 'Rodríguez', TO_DATE('1972-11-09','YYYY-MM-DD'), 'Cardio y Resistencia', 128, 'valentina.sepulveda617@gmail.com', '985017433');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.242-1', 'Florencia', 'José', 'Fernández', 'Flores', TO_DATE('1973-11-15','YYYY-MM-DD'), 'Hipertrofia', 135, 'florencia.fernandez618@gmail.com', '985017582');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.261-8', 'Tomás', 'Camila', 'Silva', 'Fernández', TO_DATE('1974-11-21','YYYY-MM-DD'), 'Acondicionamiento Físico', 142, 'tomas.silva619@gmail.com', '985017731');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.280-4', 'Javiera', 'Luis', 'García', 'Gutiérrez', TO_DATE('1975-11-27','YYYY-MM-DD'), 'Rehabilitación', 149, 'javiera.garcia620@gmail.com', '985017880');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.299-5', 'Diego', 'Antonio', 'Sepúlveda', 'Riquelme', TO_DATE('1976-12-02','YYYY-MM-DD'), 'Musculación y Fuerza', 156, 'diego.sepulveda621@gmail.com', '985018029');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.318-5', 'Franco', 'Alejandra', 'Carrasco', 'Cortés', TO_DATE('1977-12-08','YYYY-MM-DD'), 'Entrenamiento Funcional', 163, 'franco.carrasco622@gmail.com', '985018178');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.337-1', 'Paz', 'Andrés', 'Pérez', 'López', TO_DATE('1978-12-14','YYYY-MM-DD'), 'CrossFit', 170, 'paz.perez623@gmail.com', '985018327');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.356-8', 'Sebastián', 'Esteban', 'Araya', 'Ramírez', TO_DATE('1979-12-20','YYYY-MM-DD'), 'Nutrición Deportiva', 177, 'sebastian.araya624@gmail.com', '985018476');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.375-4', 'Amanda', NULL, 'Ortiz', 'Vásquez', TO_DATE('1980-12-25','YYYY-MM-DD'), 'Fisioterapia Deportiva', 184, 'amanda.ortiz625@gmail.com', '985018625');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.394-0', 'Diego', 'Andrea', 'Castro', 'Sepúlveda', TO_DATE('1981-12-31','YYYY-MM-DD'), 'Yoga y Movilidad', 191, 'diego.castro626@gmail.com', '985018774');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.413-0', 'Amanda', 'Ignacia', 'Vargas', 'Navarro', TO_DATE('1983-01-06','YYYY-MM-DD'), 'Cardio y Resistencia', 198, 'amanda.vargas627@gmail.com', '985018923');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.432-7', 'Camilo', 'Alejandro', 'Pizarro', 'Herrera', TO_DATE('1984-01-12','YYYY-MM-DD'), 'Hipertrofia', 205, 'camilo.pizarro628@gmail.com', '985019072');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.451-3', 'Franco', 'Antonia', 'Pérez', 'Muñoz', TO_DATE('1985-01-17','YYYY-MM-DD'), 'Acondicionamiento Físico', 212, 'franco.perez629@gmail.com', '985019221');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.470-K', 'Sebastián', 'Fernanda', 'Pérez', 'Díaz', TO_DATE('1986-01-23','YYYY-MM-DD'), 'Rehabilitación', 219, 'sebastian.perez630@gmail.com', '985019370');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.489-0', 'Diego', 'Constanza', 'González', 'Ortiz', TO_DATE('1987-01-29','YYYY-MM-DD'), 'Musculación y Fuerza', 226, 'diego.gonzalez631@gmail.com', '985019519');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.508-0', 'Laura', 'Paz', 'Silva', 'Álvarez', TO_DATE('1988-02-04','YYYY-MM-DD'), 'Entrenamiento Funcional', 233, 'laura.silva632@gmail.com', '985019668');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.527-7', 'Carla', 'Estefanía', 'Reyes', 'Torres', TO_DATE('1989-02-09','YYYY-MM-DD'), 'CrossFit', 240, 'carla.reyes633@gmail.com', '985019817');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.546-3', 'Vicente', 'José', 'Tapia', 'Castillo', TO_DATE('1990-02-15','YYYY-MM-DD'), 'Nutrición Deportiva', 247, 'vicente.tapia634@gmail.com', '985019966');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.565-K', 'Florencia', 'Camila', 'Miranda', 'Salazar', TO_DATE('1991-02-21','YYYY-MM-DD'), 'Fisioterapia Deportiva', 254, 'florencia.miranda635@gmail.com', '985020115');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.584-6', 'Tomás', 'Luis', 'Valenzuela', 'Rojas', TO_DATE('1992-02-27','YYYY-MM-DD'), 'Yoga y Movilidad', 261, 'tomas.valenzuela636@gmail.com', '985020264');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.603-6', 'Antonia', 'Antonio', 'Reyes', 'Rodríguez', TO_DATE('1993-03-04','YYYY-MM-DD'), 'Cardio y Resistencia', 268, 'antonia.reyes637@gmail.com', '985020413');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.622-2', 'Daniela', 'Alejandra', 'Carrasco', 'Flores', TO_DATE('1994-03-10','YYYY-MM-DD'), 'Hipertrofia', 275, 'daniela.carrasco638@gmail.com', '985020562');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.641-9', 'Carla', 'Andrés', 'Espinoza', 'Fernández', TO_DATE('1995-03-16','YYYY-MM-DD'), 'Acondicionamiento Físico', 282, 'carla.espinoza639@gmail.com', '985020711');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.660-5', 'Paz', 'Esteban', 'Tapia', 'Gutiérrez', TO_DATE('1996-03-21','YYYY-MM-DD'), 'Rehabilitación', 289, 'paz.tapia640@gmail.com', '985020860');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.679-6', 'Rocío', NULL, 'Soto', 'Riquelme', TO_DATE('1997-03-27','YYYY-MM-DD'), 'Musculación y Fuerza', 296, 'rocio.soto641@gmail.com', '985021009');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.698-2', 'Rocío', 'Andrea', 'Araya', 'Cortés', TO_DATE('1998-04-02','YYYY-MM-DD'), 'Entrenamiento Funcional', 303, 'rocio.araya642@gmail.com', '985021158');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.717-2', 'Andrés', 'Ignacia', 'Castro', 'López', TO_DATE('1970-04-09','YYYY-MM-DD'), 'CrossFit', 310, 'andres.castro643@gmail.com', '985021307');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.736-9', 'Amanda', 'Alejandro', 'Pizarro', 'Ramírez', TO_DATE('1971-04-15','YYYY-MM-DD'), 'Nutrición Deportiva', 317, 'amanda.pizarro644@gmail.com', '985021456');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.755-5', 'Andrés', 'Antonia', 'Fuentes', 'Vásquez', TO_DATE('1972-04-20','YYYY-MM-DD'), 'Fisioterapia Deportiva', 324, 'andres.fuentes645@gmail.com', '985021605');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.774-1', 'Laura', 'Fernanda', 'Reyes', 'Sepúlveda', TO_DATE('1973-04-26','YYYY-MM-DD'), 'Yoga y Movilidad', 331, 'laura.reyes646@gmail.com', '985021754');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.793-8', 'Mauricio', 'Constanza', 'Tapia', 'Navarro', TO_DATE('1974-05-02','YYYY-MM-DD'), 'Cardio y Resistencia', 338, 'mauricio.tapia647@gmail.com', '985021903');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.812-8', 'Valentina', 'Paz', 'Martínez', 'Herrera', TO_DATE('1975-05-08','YYYY-MM-DD'), 'Hipertrofia', 345, 'valentina.martinez648@gmail.com', '985022052');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.831-4', 'Rodrigo', 'Estefanía', 'Vega', 'Muñoz', TO_DATE('1976-05-13','YYYY-MM-DD'), 'Acondicionamiento Físico', 6, 'rodrigo.vega649@gmail.com', '985022201');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.850-0', 'Daniela', 'José', 'Reyes', 'Díaz', TO_DATE('1977-05-19','YYYY-MM-DD'), 'Rehabilitación', 13, 'daniela.reyes650@gmail.com', '985022350');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.869-1', 'Camilo', 'Camila', 'Sepúlveda', 'Ortiz', TO_DATE('1978-05-25','YYYY-MM-DD'), 'Musculación y Fuerza', 20, 'camilo.sepulveda651@gmail.com', '985022499');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.888-8', 'Arturo', 'Luis', 'Pizarro', 'Álvarez', TO_DATE('1979-05-31','YYYY-MM-DD'), 'Entrenamiento Funcional', 27, 'arturo.pizarro652@gmail.com', '985022648');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.907-8', 'Isabel', 'Antonio', 'Fernández', 'Torres', TO_DATE('1980-06-05','YYYY-MM-DD'), 'CrossFit', 34, 'isabel.fernandez653@gmail.com', '985022797');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.926-4', 'Sergio', 'Alejandra', 'Fuentes', 'Castillo', TO_DATE('1981-06-11','YYYY-MM-DD'), 'Nutrición Deportiva', 41, 'sergio.fuentes654@gmail.com', '985022946');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.945-0', 'Mauricio', 'Andrés', 'Fuentes', 'Salazar', TO_DATE('1982-06-17','YYYY-MM-DD'), 'Fisioterapia Deportiva', 48, 'mauricio.fuentes655@gmail.com', '985023095');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.964-7', 'Rocío', 'Esteban', 'Pérez', 'Rojas', TO_DATE('1983-06-23','YYYY-MM-DD'), 'Yoga y Movilidad', 55, 'rocio.perez656@gmail.com', '985023244');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.002.983-3', 'Vicente', NULL, 'Pizarro', 'Rodríguez', TO_DATE('1984-06-28','YYYY-MM-DD'), 'Cardio y Resistencia', 62, 'vicente.pizarro657@gmail.com', '985023393');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.002-5', 'Paz', 'Andrea', 'Pizarro', 'Flores', TO_DATE('1985-07-04','YYYY-MM-DD'), 'Hipertrofia', 69, 'paz.pizarro658@gmail.com', '985023542');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.021-1', 'Sergio', 'Ignacia', 'Pérez', 'Fernández', TO_DATE('1986-07-10','YYYY-MM-DD'), 'Acondicionamiento Físico', 76, 'sergio.perez659@gmail.com', '985023691');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.040-8', 'Camilo', 'Alejandro', 'Castro', 'Gutiérrez', TO_DATE('1987-07-16','YYYY-MM-DD'), 'Rehabilitación', 83, 'camilo.castro660@gmail.com', '985023840');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.059-9', 'Ignacio', 'Antonia', 'Valenzuela', 'Riquelme', TO_DATE('1988-07-21','YYYY-MM-DD'), 'Musculación y Fuerza', 90, 'ignacio.valenzuela661@gmail.com', '985023989');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.078-5', 'Mauricio', 'Fernanda', 'Carrasco', 'Cortés', TO_DATE('1989-07-27','YYYY-MM-DD'), 'Entrenamiento Funcional', 97, 'mauricio.carrasco662@gmail.com', '985024138');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.097-1', 'Paz', 'Constanza', 'Martínez', 'López', TO_DATE('1990-08-02','YYYY-MM-DD'), 'CrossFit', 104, 'paz.martinez663@gmail.com', '985024287');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.116-1', 'Sebastián', 'Paz', 'Carrasco', 'Ramírez', TO_DATE('1991-08-08','YYYY-MM-DD'), 'Nutrición Deportiva', 111, 'sebastian.carrasco664@gmail.com', '985024436');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.135-8', 'Mauricio', 'Estefanía', 'Soto', 'Vásquez', TO_DATE('1992-08-13','YYYY-MM-DD'), 'Fisioterapia Deportiva', 118, 'mauricio.soto665@gmail.com', '985024585');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.154-4', 'Isabel', 'José', 'Carrasco', 'Sepúlveda', TO_DATE('1993-08-19','YYYY-MM-DD'), 'Yoga y Movilidad', 125, 'isabel.carrasco666@gmail.com', '985024734');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.173-0', 'Valentina', 'Camila', 'Valenzuela', 'Navarro', TO_DATE('1994-08-25','YYYY-MM-DD'), 'Cardio y Resistencia', 132, 'valentina.valenzuela667@gmail.com', '985024883');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.192-7', 'Alonso', 'Luis', 'Reyes', 'Herrera', TO_DATE('1995-08-31','YYYY-MM-DD'), 'Hipertrofia', 139, 'alonso.reyes668@gmail.com', '985025032');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.211-7', 'Sebastián', 'Antonio', 'Ortiz', 'Muñoz', TO_DATE('1996-09-05','YYYY-MM-DD'), 'Acondicionamiento Físico', 146, 'sebastian.ortiz669@gmail.com', '985025181');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.230-3', 'Paz', 'Alejandra', 'Vega', 'Díaz', TO_DATE('1997-09-11','YYYY-MM-DD'), 'Rehabilitación', 153, 'paz.vega670@gmail.com', '985025330');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.249-4', 'Alonso', 'Andrés', 'Ortiz', 'Ortiz', TO_DATE('1998-09-17','YYYY-MM-DD'), 'Musculación y Fuerza', 160, 'alonso.ortiz671@gmail.com', '985025479');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.268-0', 'Tomás', 'Esteban', 'Miranda', 'Álvarez', TO_DATE('1970-09-24','YYYY-MM-DD'), 'Entrenamiento Funcional', 167, 'tomas.miranda672@gmail.com', '985025628');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.287-7', 'Rodrigo', NULL, 'Araya', 'Torres', TO_DATE('1971-09-30','YYYY-MM-DD'), 'CrossFit', 174, 'rodrigo.araya673@gmail.com', '985025777');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.306-7', 'Carla', 'Andrea', 'Ortiz', 'Castillo', TO_DATE('1972-10-05','YYYY-MM-DD'), 'Nutrición Deportiva', 181, 'carla.ortiz674@gmail.com', '985025926');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.325-3', 'Rocío', 'Ignacia', 'Martínez', 'Salazar', TO_DATE('1973-10-11','YYYY-MM-DD'), 'Fisioterapia Deportiva', 188, 'rocio.martinez675@gmail.com', '985026075');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.344-K', 'Isabel', 'Alejandro', 'Araya', 'Rojas', TO_DATE('1974-10-17','YYYY-MM-DD'), 'Yoga y Movilidad', 195, 'isabel.araya676@gmail.com', '985026224');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.363-6', 'Andrés', 'Antonia', 'Soto', 'Rodríguez', TO_DATE('1975-10-23','YYYY-MM-DD'), 'Cardio y Resistencia', 202, 'andres.soto677@gmail.com', '985026373');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.382-2', 'Andrés', 'Fernanda', 'Miranda', 'Flores', TO_DATE('1976-10-28','YYYY-MM-DD'), 'Hipertrofia', 209, 'andres.miranda678@gmail.com', '985026522');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.401-2', 'Sebastián', 'Constanza', 'Herrera', 'Fernández', TO_DATE('1977-11-03','YYYY-MM-DD'), 'Acondicionamiento Físico', 216, 'sebastian.herrera679@gmail.com', '985026671');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.420-9', 'Sergio', 'Paz', 'García', 'Gutiérrez', TO_DATE('1978-11-09','YYYY-MM-DD'), 'Rehabilitación', 223, 'sergio.garcia680@gmail.com', '985026820');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.439-K', 'Arturo', 'Estefanía', 'Valenzuela', 'Riquelme', TO_DATE('1979-11-15','YYYY-MM-DD'), 'Musculación y Fuerza', 230, 'arturo.valenzuela681@gmail.com', '985026969');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.458-6', 'Daniela', 'José', 'González', 'Cortés', TO_DATE('1980-11-20','YYYY-MM-DD'), 'Entrenamiento Funcional', 237, 'daniela.gonzalez682@gmail.com', '985027118');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.477-2', 'Antonia', 'Camila', 'Tapia', 'López', TO_DATE('1981-11-26','YYYY-MM-DD'), 'CrossFit', 244, 'antonia.tapia683@gmail.com', '985027267');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.496-9', 'Antonia', 'Luis', 'Miranda', 'Ramírez', TO_DATE('1982-12-02','YYYY-MM-DD'), 'Nutrición Deportiva', 251, 'antonia.miranda684@gmail.com', '985027416');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.515-9', 'Arturo', 'Antonio', 'Pérez', 'Vásquez', TO_DATE('1983-12-08','YYYY-MM-DD'), 'Fisioterapia Deportiva', 258, 'arturo.perez685@gmail.com', '985027565');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.534-5', 'Laura', 'Alejandra', 'Fernández', 'Sepúlveda', TO_DATE('1984-12-13','YYYY-MM-DD'), 'Yoga y Movilidad', 265, 'laura.fernandez686@gmail.com', '985027714');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.553-1', 'Matías', 'Andrés', 'Vega', 'Navarro', TO_DATE('1985-12-19','YYYY-MM-DD'), 'Cardio y Resistencia', 272, 'matias.vega687@gmail.com', '985027863');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.572-8', 'Paz', 'Esteban', 'Espinoza', 'Herrera', TO_DATE('1986-12-25','YYYY-MM-DD'), 'Hipertrofia', 279, 'paz.espinoza688@gmail.com', '985028012');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.591-4', 'Valentina', NULL, 'Pizarro', 'Muñoz', TO_DATE('1987-12-31','YYYY-MM-DD'), 'Acondicionamiento Físico', 286, 'valentina.pizarro689@gmail.com', '985028161');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.610-4', 'Alonso', 'Andrea', 'Tapia', 'Díaz', TO_DATE('1989-01-05','YYYY-MM-DD'), 'Rehabilitación', 293, 'alonso.tapia690@gmail.com', '985028310');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.629-5', 'Alonso', 'Ignacia', 'Pérez', 'Ortiz', TO_DATE('1990-01-11','YYYY-MM-DD'), 'Musculación y Fuerza', 300, 'alonso.perez691@gmail.com', '985028459');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.648-1', 'Paz', 'Alejandro', 'Soto', 'Álvarez', TO_DATE('1991-01-17','YYYY-MM-DD'), 'Entrenamiento Funcional', 307, 'paz.soto692@gmail.com', '985028608');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.667-8', 'Florencia', 'Antonia', 'Tapia', 'Torres', TO_DATE('1992-01-23','YYYY-MM-DD'), 'CrossFit', 314, 'florencia.tapia693@gmail.com', '985028757');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.686-4', 'Sebastián', 'Fernanda', 'Reyes', 'Castillo', TO_DATE('1993-01-28','YYYY-MM-DD'), 'Nutrición Deportiva', 321, 'sebastian.reyes694@gmail.com', '985028906');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.705-4', 'Daniela', 'Constanza', 'García', 'Salazar', TO_DATE('1994-02-03','YYYY-MM-DD'), 'Fisioterapia Deportiva', 328, 'daniela.garcia695@gmail.com', '985029055');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.724-0', 'Amanda', 'Paz', 'Araya', 'Rojas', TO_DATE('1995-02-09','YYYY-MM-DD'), 'Yoga y Movilidad', 335, 'amanda.araya696@gmail.com', '985029204');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.743-7', 'Mauricio', 'Estefanía', 'Ortiz', 'Rodríguez', TO_DATE('1996-02-15','YYYY-MM-DD'), 'Cardio y Resistencia', 342, 'mauricio.ortiz697@gmail.com', '985029353');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.762-3', 'Laura', 'José', 'Tapia', 'Flores', TO_DATE('1997-02-20','YYYY-MM-DD'), 'Hipertrofia', 3, 'laura.tapia698@gmail.com', '985029502');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.781-K', 'Matías', 'Camila', 'Reyes', 'Fernández', TO_DATE('1998-02-26','YYYY-MM-DD'), 'Acondicionamiento Físico', 10, 'matias.reyes699@gmail.com', '985029651');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('27.003.800-K', 'Isabel', 'Luis', 'Sepúlveda', 'Gutiérrez', TO_DATE('1970-03-05','YYYY-MM-DD'), 'Rehabilitación', 17, 'isabel.sepulveda700@gmail.com', '985029800');

-- PLAN: 10 registros
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (1, 'Plan Inicial', 19990, '1 mes', 'Acceso completo en horario restringido (lunes a viernes hasta las 18:00 hrs).');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (2, 'Plan Básico', 24990, '1 mes', 'Acceso al gimnasio en horario completo y uso de máquinas de musculación.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (3, 'Plan Full', 29990, '1 mes', 'Acceso libre al gimnasio, clases grupales y evaluación física inicial.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (4, 'Plan Full +', 34990, '3 meses', 'Acceso libre, clases grupales y una rutina de entrenamiento personalizada.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (5, 'Plan Trimestral', 39990, '3 meses', 'Entrenamiento libre, clases dirigidas y seguimiento con preparador físico.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (6, 'Plan Semestral', 49990, '6 meses', 'Vigencia de 6 meses, incluye evaluación nutricional y control de métricas.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (7, 'Plan Anual', 59990, '12 meses', 'Vigencia de 12 meses con todos los beneficios del club y 2 evaluaciones anuales.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (8, 'Plan VIP', 79990, '12 meses', 'Entrenamiento personalizado dos veces por semana, plan nutricional y acceso prioritario.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (9, 'Plan Parejas', 44990, '3 meses', 'Acceso para 2 personas con un pago único mensual, incluye evaluación conjunta.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (10, 'Plan Estudiantes', 17990, '1 mes', 'Tarifa preferencial para estudiantes, presentando certificado vigente.');

-- CLIENTE: 200 registros
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('11.998.500-5', 'Franco', 'Luis', 'Sepúlveda', 'Fernández', TO_DATE('2002-02-21','YYYY-MM-DD'), 'Chilena', 2, 8, '940726097', 'franco.sepulveda1@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('15.360.060-0', 'Carla', 'Constanza', 'Fernández', 'Cortés', TO_DATE('1992-07-22','YYYY-MM-DD'), 'Chilena', 3, 15, '943689519', 'carla.fernandez2@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('18.430.815-0', 'Vicente', 'Luis', 'Vargas', 'Vásquez', TO_DATE('1984-05-01','YYYY-MM-DD'), 'Chilena', 4, 22, '937183296', 'vicente.vargas3@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('25.960.879-1', 'Valentina', 'Andrea', 'Miranda', 'Herrera', TO_DATE('2004-08-12','YYYY-MM-DD'), 'Chilena', 5, 29, '980180947', 'valentina.miranda4@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('18.586.960-1', 'Mauricio', 'Antonio', 'Araya', 'Ortiz', TO_DATE('1991-08-26','YYYY-MM-DD'), 'Chilena', 6, 36, '972633522', 'mauricio.araya5@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('20.858.183-K', 'Rocío', NULL, 'Espinoza', 'Castillo', TO_DATE('2004-02-15','YYYY-MM-DD'), 'Chilena', 7, 43, '971425491', 'rocio.espinoza6@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('24.428.415-9', 'Camilo', 'José', 'Tapia', 'Rodríguez', TO_DATE('2001-12-16','YYYY-MM-DD'), 'Chilena', 8, 50, '967146759', 'camilo.tapia7@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('25.987.858-6', 'Antonia', 'Paz', 'Ortiz', 'Gutiérrez', TO_DATE('1981-12-28','YYYY-MM-DD'), 'Chilena', 9, 57, '922973827', 'antonia.ortiz8@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('11.721.960-7', 'Franco', 'Andrés', 'Tapia', 'Muñoz', TO_DATE('1975-08-19','YYYY-MM-DD'), 'Chilena', 10, 64, '922370664', 'franco.tapia9@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('24.833.068-6', 'Paz', 'Ignacia', 'García', 'López', TO_DATE('1978-10-02','YYYY-MM-DD'), 'Chilena', 1, 71, '943264201', 'paz.garcia10@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('13.746.093-9', 'Sergio', 'José', 'Reyes', 'Sepúlveda', TO_DATE('1985-11-19','YYYY-MM-DD'), 'Chilena', 2, 78, '910688684', 'sergio.reyes11@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('25.012.372-8', 'Amanda', 'Constanza', 'Martínez', 'Cortés', TO_DATE('1990-10-05','YYYY-MM-DD'), 'Chilena', 3, 85, '939920845', 'amanda.martinez12@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('20.083.621-9', 'Alonso', 'José', 'Soto', 'Álvarez', TO_DATE('1980-03-26','YYYY-MM-DD'), 'Chilena', 4, 92, '999731916', 'alonso.soto13@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('20.426.773-1', 'Amanda', 'Paz', 'Vega', 'Álvarez', TO_DATE('2000-03-17','YYYY-MM-DD'), 'Chilena', 5, 99, '962399581', 'amanda.vega14@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('19.337.510-3', 'Arturo', 'Antonio', 'Castro', 'Muñoz', TO_DATE('1987-02-02','YYYY-MM-DD'), 'Chilena', 6, 106, '924245056', 'arturo.castro15@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('17.056.747-1', 'Javiera', 'Alejandra', 'González', 'Vega', TO_DATE('1985-11-10','YYYY-MM-DD'), 'Chilena', 7, 113, '973890916', 'javiera.gonzalez16@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('23.142.824-0', 'Rodrigo', 'Alejandro', 'Silva', 'Ortiz', TO_DATE('1993-10-26','YYYY-MM-DD'), 'Chilena', 8, 120, '972623684', 'rodrigo.silva17@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('19.606.110-K', 'Florencia', 'Andrea', 'Carrasco', 'Salazar', TO_DATE('1988-10-11','YYYY-MM-DD'), 'Chilena', 9, 127, '937781143', 'florencia.carrasco18@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('19.190.751-5', 'Rodrigo', 'Antonio', 'Pérez', 'Riquelme', TO_DATE('1976-04-21','YYYY-MM-DD'), 'Chilena', 10, 134, '963573955', 'rodrigo.perez19@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('24.133.155-5', 'Florencia', NULL, 'Cortés', 'Díaz', TO_DATE('2002-11-07','YYYY-MM-DD'), 'Chilena', 1, 141, '970642368', 'florencia.cortes20@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('22.256.410-7', 'Ignacio', NULL, 'Martínez', 'Salazar', TO_DATE('2000-09-05','YYYY-MM-DD'), 'Chilena', 2, 148, '939356575', 'ignacio.martinez21@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('23.028.725-2', 'Florencia', 'Andrea', 'Castro', 'Flores', TO_DATE('1992-07-28','YYYY-MM-DD'), 'Chilena', 3, 155, '967090084', 'florencia.castro22@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('22.886.836-1', 'Andrés', 'Esteban', 'Valenzuela', 'Rodríguez', TO_DATE('1980-05-15','YYYY-MM-DD'), 'Chilena', 4, 162, '956179753', 'andres.valenzuela23@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('18.236.009-0', 'Daniela', 'Estefanía', 'Espinoza', 'Herrera', TO_DATE('1985-09-16','YYYY-MM-DD'), 'Chilena', 5, 169, '933751475', 'daniela.espinoza24@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('22.600.124-7', 'Rodrigo', 'Ignacio', 'Salazar', 'Flores', TO_DATE('2002-04-08','YYYY-MM-DD'), 'Chilena', 6, 176, '922692439', 'rodrigo.salazar25@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('22.970.008-1', 'Camila', 'Ignacia', 'Herrera', 'Ramírez', TO_DATE('1992-11-06','YYYY-MM-DD'), 'Chilena', 7, 183, '964761163', 'camila.herrera26@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('19.840.186-2', 'Matías', 'Alejandro', 'Morales', 'Reyes', TO_DATE('1996-10-26','YYYY-MM-DD'), 'Chilena', 8, 190, '985430704', 'matias.morales27@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('17.400.346-7', 'Paz', 'Antonia', 'Silva', 'García', TO_DATE('1992-10-24','YYYY-MM-DD'), 'Chilena', 9, 197, '947644351', 'paz.silva28@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('14.025.425-8', 'Cristóbal', 'José', 'Navarro', 'Flores', TO_DATE('1992-03-04','YYYY-MM-DD'), 'Chilena', 10, 204, '999967131', 'cristobal.navarro29@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('10.042.527-0', 'Catalina', 'Ignacia', 'Vásquez', 'Morales', TO_DATE('1996-01-25','YYYY-MM-DD'), 'Chilena', 1, 211, '924231875', 'catalina.vasquez30@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('20.304.637-5', 'Benjamín', 'Andrés', 'Contreras', 'Vega', TO_DATE('1983-10-27','YYYY-MM-DD'), 'Chilena', 2, 218, '952084090', 'benjamin.contreras31@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('11.354.318-3', 'Antonia', 'Paz', 'Castillo', 'Morales', TO_DATE('1983-02-01','YYYY-MM-DD'), 'Chilena', 3, 225, '945011808', 'antonia.castillo32@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('11.857.850-3', 'Franco', 'José', 'Álvarez', 'Muñoz', TO_DATE('1978-04-01','YYYY-MM-DD'), 'Chilena', 4, 232, '917692234', 'franco.alvarez33@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('14.819.091-7', 'Fernanda', 'Ignacia', 'Contreras', 'Riquelme', TO_DATE('2004-06-11','YYYY-MM-DD'), 'Chilena', 5, 239, '987373976', 'fernanda.contreras34@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('23.702.981-K', 'Sergio', 'Luis', 'Miranda', 'García', TO_DATE('2004-07-11','YYYY-MM-DD'), 'Chilena', 6, 246, '915101730', 'sergio.miranda35@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('11.645.033-K', 'Renata', 'Antonia', 'Miranda', 'Herrera', TO_DATE('1996-02-22','YYYY-MM-DD'), 'Chilena', 7, 253, '967193390', 'renata.miranda36@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('17.543.956-0', 'Benjamín', 'José', 'Castro', 'Espinoza', TO_DATE('1976-12-23','YYYY-MM-DD'), 'Chilena', 8, 260, '957824180', 'benjamin.castro37@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('10.192.750-4', 'Rocío', NULL, 'Espinoza', 'Ramírez', TO_DATE('1998-02-10','YYYY-MM-DD'), 'Chilena', 9, 267, '948863507', 'rocio.espinoza38@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('23.669.449-6', 'Sergio', 'Esteban', 'Castillo', 'Carrasco', TO_DATE('1992-06-07','YYYY-MM-DD'), 'Chilena', 10, 274, '912720605', 'sergio.castillo39@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('24.947.890-3', 'Paz', NULL, 'Silva', 'Morales', TO_DATE('1978-02-02','YYYY-MM-DD'), 'Chilena', 1, 281, '993076786', 'paz.silva40@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('21.495.380-3', 'Nicolás', 'Alejandro', 'Miranda', 'Valenzuela', TO_DATE('1988-10-05','YYYY-MM-DD'), 'Chilena', 2, 288, '913864688', 'nicolas.miranda41@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('18.225.646-3', 'Javiera', 'Estefanía', 'Castro', 'Torres', TO_DATE('1996-04-25','YYYY-MM-DD'), 'Chilena', 3, 295, '966503709', 'javiera.castro42@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('21.398.255-9', 'Nicolás', 'Andrés', 'Cortés', 'González', TO_DATE('1997-09-22','YYYY-MM-DD'), 'Chilena', 4, 302, '998793440', 'nicolas.cortes43@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('15.271.957-4', 'Paz', 'Estefanía', 'Araya', 'Sepúlveda', TO_DATE('1975-01-09','YYYY-MM-DD'), 'Chilena', 5, 309, '940635974', 'paz.araya44@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('13.526.984-0', 'Pedro', 'Luis', 'Álvarez', 'Araya', TO_DATE('1979-11-19','YYYY-MM-DD'), 'Chilena', 6, 316, '952244317', 'pedro.alvarez45@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('16.664.202-7', 'Antonia', 'Andrea', 'Riquelme', 'Rojas', TO_DATE('2002-09-27','YYYY-MM-DD'), 'Chilena', 7, 323, '997270142', 'antonia.riquelme46@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('14.219.689-1', 'Joaquín', 'Alejandro', 'Salazar', 'Castillo', TO_DATE('1996-01-21','YYYY-MM-DD'), 'Chilena', 8, 330, '917550517', 'joaquin.salazar47@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('15.832.730-9', 'Isidora', 'Constanza', 'Díaz', 'Hernández', TO_DATE('2002-03-24','YYYY-MM-DD'), 'Chilena', 9, 337, '978265854', 'isidora.diaz48@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('25.591.357-3', 'Iván', 'Esteban', 'Gutiérrez', 'Hernández', TO_DATE('2001-05-11','YYYY-MM-DD'), 'Chilena', 10, 344, '985375365', 'ivan.gutierrez49@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('15.983.360-7', 'Trinidad', 'Alejandra', 'Reyes', 'Herrera', TO_DATE('1989-09-26','YYYY-MM-DD'), 'Chilena', 1, 5, '995498222', 'trinidad.reyes50@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.000.867-6', 'Mauricio', 'Luis', 'Valenzuela', 'Fernández', TO_DATE('1981-11-01','YYYY-MM-DD'), 'Chilena', 1, 256, '980006987', 'mauricio.valenzuela51@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.000.884-6', 'Vicente', 'Andrea', 'Herrera', 'Castillo', TO_DATE('1982-12-13','YYYY-MM-DD'), 'Chilena', 2, 261, '980007124', 'vicente.herrera52@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.000.901-K', 'Matías', 'Paz', 'García', 'Muñoz', TO_DATE('1984-01-24','YYYY-MM-DD'), 'Chilena', 3, 266, '980007261', 'matias.garcia53@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.000.918-4', 'Ignacio', 'Alejandra', 'Pérez', 'Ramírez', TO_DATE('1985-03-06','YYYY-MM-DD'), 'Chilena', 4, 271, '980007398', 'ignacio.perez54@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.000.935-4', 'Matías', 'Alejandro', 'Valenzuela', 'Fernández', TO_DATE('1986-04-17','YYYY-MM-DD'), 'Chilena', 5, 276, '980007535', 'matias.valenzuela55@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.000.952-4', 'Valentina', 'José', 'Castro', 'Castillo', TO_DATE('1987-05-29','YYYY-MM-DD'), 'Chilena', 6, 281, '980007672', 'valentina.castro56@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.000.969-9', 'Antonia', 'Esteban', 'Vargas', 'Muñoz', TO_DATE('1988-07-09','YYYY-MM-DD'), 'Chilena', 7, 286, '980007809', 'antonia.vargas57@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.000.986-9', 'Sergio', 'Fernanda', 'Tapia', 'Ramírez', TO_DATE('1989-08-20','YYYY-MM-DD'), 'Chilena', 8, 291, '980007946', 'sergio.tapia58@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.003-4', 'Tomás', 'Luis', 'Fernández', 'Fernández', TO_DATE('1990-10-01','YYYY-MM-DD'), 'Chilena', 9, 296, '980008083', 'tomas.fernandez59@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.020-4', 'Vicente', 'Andrea', 'García', 'Castillo', TO_DATE('1991-11-12','YYYY-MM-DD'), 'Chilena', 10, 301, '980008220', 'vicente.garcia60@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.037-9', 'Isabel', 'Paz', 'Vega', 'Muñoz', TO_DATE('1992-12-23','YYYY-MM-DD'), 'Chilena', 1, 306, '980008357', 'isabel.vega61@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.054-9', 'Sebastián', 'Alejandra', 'Valenzuela', 'Ramírez', TO_DATE('1994-02-03','YYYY-MM-DD'), 'Chilena', 2, 311, '980008494', 'sebastian.valenzuela62@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.071-9', 'Florencia', 'Alejandro', 'Herrera', 'Fernández', TO_DATE('1995-03-17','YYYY-MM-DD'), 'Chilena', 3, 316, '980008631', 'florencia.herrera63@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.088-3', 'Antonia', 'José', 'Castro', 'Castillo', TO_DATE('1996-04-27','YYYY-MM-DD'), 'Chilena', 4, 321, '980008768', 'antonia.castro64@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.105-7', 'Rodrigo', 'Esteban', 'Soto', 'Muñoz', TO_DATE('1997-06-08','YYYY-MM-DD'), 'Chilena', 5, 326, '980008905', 'rodrigo.soto65@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.122-7', 'Isabel', 'Fernanda', 'Castro', 'Ramírez', TO_DATE('1998-07-20','YYYY-MM-DD'), 'Chilena', 6, 331, '980009042', 'isabel.castro66@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.139-1', 'Carla', 'Luis', 'Herrera', 'Fernández', TO_DATE('1999-08-31','YYYY-MM-DD'), 'Chilena', 7, 336, '980009179', 'carla.herrera67@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.156-1', 'Matías', 'Andrea', 'Fernández', 'Castillo', TO_DATE('2000-10-11','YYYY-MM-DD'), 'Chilena', 8, 341, '980009316', 'matias.fernandez68@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.173-1', 'Daniela', 'Paz', 'Silva', 'Muñoz', TO_DATE('2001-11-22','YYYY-MM-DD'), 'Chilena', 9, 346, '980009453', 'daniela.silva69@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.190-1', 'Antonia', 'Alejandra', 'Sepúlveda', 'Ramírez', TO_DATE('2003-01-03','YYYY-MM-DD'), 'Chilena', 10, 5, '980009590', 'antonia.sepulveda70@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.207-K', 'Sergio', 'Alejandro', 'Silva', 'Fernández', TO_DATE('2004-02-14','YYYY-MM-DD'), 'Chilena', 1, 10, '980009727', 'sergio.silva71@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.224-K', 'Rodrigo', 'José', 'Sepúlveda', 'Castillo', TO_DATE('1965-03-28','YYYY-MM-DD'), 'Chilena', 2, 15, '980009864', 'rodrigo.sepulveda72@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.241-K', 'Vicente', 'Esteban', 'Sepúlveda', 'Muñoz', TO_DATE('1966-05-09','YYYY-MM-DD'), 'Chilena', 3, 20, '980010001', 'vicente.sepulveda73@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.258-4', 'Mauricio', 'Fernanda', 'Silva', 'Ramírez', TO_DATE('1967-06-20','YYYY-MM-DD'), 'Chilena', 4, 25, '980010138', 'mauricio.silva74@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.275-4', 'Amanda', 'Luis', 'Fernández', 'Fernández', TO_DATE('1968-07-31','YYYY-MM-DD'), 'Chilena', 5, 30, '980010275', 'amanda.fernandez75@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.292-4', 'Franco', 'Andrea', 'Valenzuela', 'Castillo', TO_DATE('1969-09-11','YYYY-MM-DD'), 'Chilena', 6, 35, '980010412', 'franco.valenzuela76@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.309-2', 'Paz', 'Paz', 'Valenzuela', 'Muñoz', TO_DATE('1970-10-23','YYYY-MM-DD'), 'Chilena', 7, 40, '980010549', 'paz.valenzuela77@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.326-2', 'Ignacio', 'Alejandra', 'Reyes', 'Ramírez', TO_DATE('1971-12-04','YYYY-MM-DD'), 'Chilena', 8, 45, '980010686', 'ignacio.reyes78@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.343-2', 'Isabel', 'Alejandro', 'Herrera', 'Fernández', TO_DATE('1973-01-14','YYYY-MM-DD'), 'Chilena', 9, 50, '980010823', 'isabel.herrera79@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.360-2', 'Isabel', 'José', 'García', 'Castillo', TO_DATE('1974-02-25','YYYY-MM-DD'), 'Chilena', 10, 55, '980010960', 'isabel.garcia80@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.377-7', 'Antonia', 'Esteban', 'García', 'Muñoz', TO_DATE('1975-04-08','YYYY-MM-DD'), 'Chilena', 1, 60, '980011097', 'antonia.garcia81@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.394-7', 'Mauricio', 'Fernanda', 'Pizarro', 'Ramírez', TO_DATE('1976-05-19','YYYY-MM-DD'), 'Chilena', 2, 65, '980011234', 'mauricio.pizarro82@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.411-0', 'Javiera', 'Luis', 'Herrera', 'Fernández', TO_DATE('1977-06-30','YYYY-MM-DD'), 'Chilena', 3, 70, '980011371', 'javiera.herrera83@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.428-5', 'Laura', 'Andrea', 'Fuentes', 'Castillo', TO_DATE('1978-08-11','YYYY-MM-DD'), 'Chilena', 4, 75, '980011508', 'laura.fuentes84@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.445-5', 'Laura', 'Paz', 'García', 'Muñoz', TO_DATE('1979-09-22','YYYY-MM-DD'), 'Chilena', 5, 80, '980011645', 'laura.garcia85@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.462-5', 'Camilo', 'Alejandra', 'Valenzuela', 'Ramírez', TO_DATE('1980-11-02','YYYY-MM-DD'), 'Chilena', 6, 85, '980011782', 'camilo.valenzuela86@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.479-K', 'Rocío', 'Alejandro', 'Miranda', 'Fernández', TO_DATE('1981-12-14','YYYY-MM-DD'), 'Chilena', 7, 90, '980011919', 'rocio.miranda87@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.496-K', 'Carla', 'José', 'Vargas', 'Castillo', TO_DATE('1983-01-25','YYYY-MM-DD'), 'Chilena', 8, 95, '980012056', 'carla.vargas88@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.513-3', 'Javiera', 'Esteban', 'Reyes', 'Muñoz', TO_DATE('1984-03-07','YYYY-MM-DD'), 'Chilena', 9, 100, '980012193', 'javiera.reyes89@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.530-3', 'Carla', 'Fernanda', 'Sepúlveda', 'Ramírez', TO_DATE('1985-04-18','YYYY-MM-DD'), 'Chilena', 10, 105, '980012330', 'carla.sepulveda90@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.547-8', 'Antonia', 'Luis', 'Pérez', 'Fernández', TO_DATE('1986-05-30','YYYY-MM-DD'), 'Chilena', 1, 110, '980012467', 'antonia.perez91@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.564-8', 'Ignacio', 'Andrea', 'Miranda', 'Castillo', TO_DATE('1987-07-11','YYYY-MM-DD'), 'Chilena', 2, 115, '980012604', 'ignacio.miranda92@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.581-8', 'Andrés', 'Paz', 'García', 'Muñoz', TO_DATE('1988-08-21','YYYY-MM-DD'), 'Chilena', 3, 120, '980012741', 'andres.garcia93@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.598-2', 'Rodrigo', 'Alejandra', 'Pizarro', 'Ramírez', TO_DATE('1989-10-02','YYYY-MM-DD'), 'Chilena', 4, 125, '980012878', 'rodrigo.pizarro94@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.615-6', 'Valentina', 'Alejandro', 'Espinoza', 'Fernández', TO_DATE('1990-11-13','YYYY-MM-DD'), 'Chilena', 5, 130, '980013015', 'valentina.espinoza95@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.632-6', 'Diego', 'José', 'Pérez', 'Castillo', TO_DATE('1991-12-25','YYYY-MM-DD'), 'Chilena', 6, 135, '980013152', 'diego.perez96@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.649-0', 'Sergio', 'Esteban', 'Soto', 'Muñoz', TO_DATE('1993-02-04','YYYY-MM-DD'), 'Chilena', 7, 140, '980013289', 'sergio.soto97@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.666-0', 'Arturo', 'Fernanda', 'Martínez', 'Ramírez', TO_DATE('1994-03-18','YYYY-MM-DD'), 'Chilena', 8, 145, '980013426', 'arturo.martinez98@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.683-0', 'Vicente', 'Luis', 'González', 'Fernández', TO_DATE('1995-04-29','YYYY-MM-DD'), 'Chilena', 9, 150, '980013563', 'vicente.gonzalez99@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.700-4', 'Amanda', 'Andrea', 'Silva', 'Castillo', TO_DATE('1996-06-09','YYYY-MM-DD'), 'Chilena', 10, 155, '980013700', 'amanda.silva100@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.717-9', 'Mauricio', 'Paz', 'Castro', 'Muñoz', TO_DATE('1997-07-21','YYYY-MM-DD'), 'Chilena', 1, 160, '980013837', 'mauricio.castro101@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.734-9', 'Amanda', 'Alejandra', 'Sepúlveda', 'Ramírez', TO_DATE('1998-09-01','YYYY-MM-DD'), 'Chilena', 2, 165, '980013974', 'amanda.sepulveda102@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.751-9', 'Florencia', 'Alejandro', 'Sepúlveda', 'Fernández', TO_DATE('1999-10-13','YYYY-MM-DD'), 'Chilena', 3, 170, '980014111', 'florencia.sepulveda103@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.768-3', 'Andrés', 'José', 'Vargas', 'Castillo', TO_DATE('2000-11-23','YYYY-MM-DD'), 'Chilena', 4, 175, '980014248', 'andres.vargas104@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.785-3', 'Mauricio', 'Esteban', 'Fernández', 'Muñoz', TO_DATE('2002-01-04','YYYY-MM-DD'), 'Chilena', 5, 180, '980014385', 'mauricio.fernandez105@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.802-7', 'Javiera', 'Fernanda', 'Martínez', 'Ramírez', TO_DATE('2003-02-15','YYYY-MM-DD'), 'Chilena', 6, 185, '980014522', 'javiera.martinez106@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.819-1', 'Matías', 'Luis', 'González', 'Fernández', TO_DATE('2004-03-28','YYYY-MM-DD'), 'Chilena', 7, 190, '980014659', 'matias.gonzalez107@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.836-1', 'Mauricio', 'Andrea', 'Sepúlveda', 'Castillo', TO_DATE('1965-05-10','YYYY-MM-DD'), 'Chilena', 8, 195, '980014796', 'mauricio.sepulveda108@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.853-1', 'Alonso', 'Paz', 'Espinoza', 'Muñoz', TO_DATE('1966-06-21','YYYY-MM-DD'), 'Chilena', 9, 200, '980014933', 'alonso.espinoza109@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.870-1', 'Javiera', 'Alejandra', 'Valenzuela', 'Ramírez', TO_DATE('1967-08-02','YYYY-MM-DD'), 'Chilena', 10, 205, '980015070', 'javiera.valenzuela110@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.887-6', 'Antonia', 'Alejandro', 'Herrera', 'Fernández', TO_DATE('1968-09-12','YYYY-MM-DD'), 'Chilena', 1, 210, '980015207', 'antonia.herrera111@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.904-K', 'Sebastián', 'José', 'González', 'Castillo', TO_DATE('1969-10-24','YYYY-MM-DD'), 'Chilena', 2, 215, '980015344', 'sebastian.gonzalez112@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.921-K', 'Valentina', 'Esteban', 'Fuentes', 'Muñoz', TO_DATE('1970-12-05','YYYY-MM-DD'), 'Chilena', 3, 220, '980015481', 'valentina.fuentes113@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.938-4', 'Tomás', 'Fernanda', 'Ortiz', 'Ramírez', TO_DATE('1972-01-16','YYYY-MM-DD'), 'Chilena', 4, 225, '980015618', 'tomas.ortiz114@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.955-4', 'Sebastián', 'Luis', 'Castro', 'Fernández', TO_DATE('1973-02-26','YYYY-MM-DD'), 'Chilena', 5, 230, '980015755', 'sebastian.castro115@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.972-4', 'Tomás', 'Andrea', 'García', 'Castillo', TO_DATE('1974-04-09','YYYY-MM-DD'), 'Chilena', 6, 235, '980015892', 'tomas.garcia116@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.001.989-9', 'Amanda', 'Paz', 'García', 'Muñoz', TO_DATE('1975-05-21','YYYY-MM-DD'), 'Chilena', 7, 240, '980016029', 'amanda.garcia117@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.006-4', 'Paz', 'Alejandra', 'Ortiz', 'Ramírez', TO_DATE('1976-07-01','YYYY-MM-DD'), 'Chilena', 8, 245, '980016166', 'paz.ortiz118@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.023-4', 'Ignacio', 'Alejandro', 'Herrera', 'Fernández', TO_DATE('1977-08-12','YYYY-MM-DD'), 'Chilena', 9, 250, '980016303', 'ignacio.herrera119@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.040-4', 'Isabel', 'José', 'González', 'Castillo', TO_DATE('1978-09-23','YYYY-MM-DD'), 'Chilena', 10, 255, '980016440', 'isabel.gonzalez120@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.057-9', 'Arturo', 'Esteban', 'Araya', 'Muñoz', TO_DATE('1979-11-04','YYYY-MM-DD'), 'Chilena', 1, 260, '980016577', 'arturo.araya121@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.074-9', 'Vicente', 'Fernanda', 'Fuentes', 'Ramírez', TO_DATE('1980-12-15','YYYY-MM-DD'), 'Chilena', 2, 265, '980016714', 'vicente.fuentes122@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.091-9', 'Tomás', 'Luis', 'Herrera', 'Fernández', TO_DATE('1982-01-26','YYYY-MM-DD'), 'Chilena', 3, 270, '980016851', 'tomas.herrera123@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.108-7', 'Sebastián', 'Andrea', 'Fernández', 'Castillo', TO_DATE('1983-03-09','YYYY-MM-DD'), 'Chilena', 4, 275, '980016988', 'sebastian.fernandez124@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.125-7', 'Vicente', 'Paz', 'Valenzuela', 'Muñoz', TO_DATE('1984-04-19','YYYY-MM-DD'), 'Chilena', 5, 280, '980017125', 'vicente.valenzuela125@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.142-7', 'Rodrigo', 'Alejandra', 'Valenzuela', 'Ramírez', TO_DATE('1985-05-31','YYYY-MM-DD'), 'Chilena', 6, 285, '980017262', 'rodrigo.valenzuela126@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.159-1', 'Sergio', 'Alejandro', 'Fernández', 'Fernández', TO_DATE('1986-07-12','YYYY-MM-DD'), 'Chilena', 7, 290, '980017399', 'sergio.fernandez127@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.176-1', 'Camilo', 'José', 'Vargas', 'Castillo', TO_DATE('1987-08-23','YYYY-MM-DD'), 'Chilena', 8, 295, '980017536', 'camilo.vargas128@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.193-1', 'Valentina', 'Esteban', 'Soto', 'Muñoz', TO_DATE('1988-10-03','YYYY-MM-DD'), 'Chilena', 9, 300, '980017673', 'valentina.soto129@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.210-5', 'Carla', 'Fernanda', 'Tapia', 'Ramírez', TO_DATE('1989-11-14','YYYY-MM-DD'), 'Chilena', 10, 305, '980017810', 'carla.tapia130@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.227-K', 'Tomás', 'Luis', 'Carrasco', 'Fernández', TO_DATE('1990-12-26','YYYY-MM-DD'), 'Chilena', 1, 310, '980017947', 'tomas.carrasco131@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.244-K', 'Camilo', 'Andrea', 'García', 'Castillo', TO_DATE('1992-02-06','YYYY-MM-DD'), 'Chilena', 2, 315, '980018084', 'camilo.garcia132@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.261-K', 'Alonso', 'Paz', 'Castro', 'Muñoz', TO_DATE('1993-03-19','YYYY-MM-DD'), 'Chilena', 3, 320, '980018221', 'alonso.castro133@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.278-4', 'Arturo', 'Alejandra', 'Soto', 'Ramírez', TO_DATE('1994-04-30','YYYY-MM-DD'), 'Chilena', 4, 325, '980018358', 'arturo.soto134@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.295-4', 'Alonso', 'Alejandro', 'Herrera', 'Fernández', TO_DATE('1995-06-11','YYYY-MM-DD'), 'Chilena', 5, 330, '980018495', 'alonso.herrera135@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.312-8', 'Paz', 'José', 'Fernández', 'Castillo', TO_DATE('1996-07-22','YYYY-MM-DD'), 'Chilena', 6, 335, '980018632', 'paz.fernandez136@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.329-2', 'Tomás', 'Esteban', 'Vega', 'Muñoz', TO_DATE('1997-09-02','YYYY-MM-DD'), 'Chilena', 7, 340, '980018769', 'tomas.vega137@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.346-2', 'Tomás', 'Fernanda', 'Sepúlveda', 'Ramírez', TO_DATE('1998-10-14','YYYY-MM-DD'), 'Chilena', 8, 345, '980018906', 'tomas.sepulveda138@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.363-2', 'Rocío', 'Luis', 'Fuentes', 'Fernández', TO_DATE('1999-11-25','YYYY-MM-DD'), 'Chilena', 9, 4, '980019043', 'rocio.fuentes139@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.380-2', 'Franco', 'Andrea', 'Araya', 'Castillo', TO_DATE('2001-01-05','YYYY-MM-DD'), 'Chilena', 10, 9, '980019180', 'franco.araya140@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.397-7', 'Tomás', 'Paz', 'Soto', 'Muñoz', TO_DATE('2002-02-16','YYYY-MM-DD'), 'Chilena', 1, 14, '980019317', 'tomas.soto141@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.414-0', 'Diego', 'Alejandra', 'Vargas', 'Ramírez', TO_DATE('2003-03-30','YYYY-MM-DD'), 'Chilena', 2, 19, '980019454', 'diego.vargas142@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.431-0', 'Sergio', 'Alejandro', 'Herrera', 'Fernández', TO_DATE('2004-05-10','YYYY-MM-DD'), 'Chilena', 3, 24, '980019591', 'sergio.herrera143@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.448-5', 'Vicente', 'José', 'Espinoza', 'Castillo', TO_DATE('1965-06-22','YYYY-MM-DD'), 'Chilena', 4, 29, '980019728', 'vicente.espinoza144@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.465-5', 'Rodrigo', 'Esteban', 'Espinoza', 'Muñoz', TO_DATE('1966-08-03','YYYY-MM-DD'), 'Chilena', 5, 34, '980019865', 'rodrigo.espinoza145@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.482-5', 'Diego', 'Fernanda', 'Miranda', 'Ramírez', TO_DATE('1967-09-14','YYYY-MM-DD'), 'Chilena', 6, 39, '980020002', 'diego.miranda146@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.499-K', 'Ignacio', 'Luis', 'González', 'Fernández', TO_DATE('1968-10-25','YYYY-MM-DD'), 'Chilena', 7, 44, '980020139', 'ignacio.gonzalez147@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.516-3', 'Laura', 'Andrea', 'Martínez', 'Castillo', TO_DATE('1969-12-06','YYYY-MM-DD'), 'Chilena', 8, 49, '980020276', 'laura.martinez148@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.533-3', 'Florencia', 'Paz', 'Soto', 'Muñoz', TO_DATE('1971-01-17','YYYY-MM-DD'), 'Chilena', 9, 54, '980020413', 'florencia.soto149@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.550-3', 'Tomás', 'Alejandra', 'Espinoza', 'Ramírez', TO_DATE('1972-02-28','YYYY-MM-DD'), 'Chilena', 10, 59, '980020550', 'tomas.espinoza150@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.567-8', 'Ignacio', 'Alejandro', 'Sepúlveda', 'Fernández', TO_DATE('1973-04-10','YYYY-MM-DD'), 'Chilena', 1, 64, '980020687', 'ignacio.sepulveda151@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.584-8', 'Franco', 'José', 'Miranda', 'Castillo', TO_DATE('1974-05-22','YYYY-MM-DD'), 'Chilena', 2, 69, '980020824', 'franco.miranda152@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.601-1', 'Valentina', 'Esteban', 'Silva', 'Muñoz', TO_DATE('1975-07-03','YYYY-MM-DD'), 'Chilena', 3, 74, '980020961', 'valentina.silva153@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.618-6', 'Andrés', 'Fernanda', 'Tapia', 'Ramírez', TO_DATE('1976-08-13','YYYY-MM-DD'), 'Chilena', 4, 79, '980021098', 'andres.tapia154@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.635-6', 'Diego', 'Luis', 'Fuentes', 'Fernández', TO_DATE('1977-09-24','YYYY-MM-DD'), 'Chilena', 5, 84, '980021235', 'diego.fuentes155@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.652-6', 'Paz', 'Andrea', 'González', 'Castillo', TO_DATE('1978-11-05','YYYY-MM-DD'), 'Chilena', 6, 89, '980021372', 'paz.gonzalez156@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.669-0', 'Tomás', 'Paz', 'González', 'Muñoz', TO_DATE('1979-12-17','YYYY-MM-DD'), 'Chilena', 7, 94, '980021509', 'tomas.gonzalez157@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.686-0', 'Rocío', 'Alejandra', 'Silva', 'Ramírez', TO_DATE('1981-01-27','YYYY-MM-DD'), 'Chilena', 8, 99, '980021646', 'rocio.silva158@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.703-4', 'Amanda', 'Alejandro', 'Valenzuela', 'Fernández', TO_DATE('1982-03-10','YYYY-MM-DD'), 'Chilena', 9, 104, '980021783', 'amanda.valenzuela159@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.720-4', 'Amanda', 'José', 'Espinoza', 'Castillo', TO_DATE('1983-04-21','YYYY-MM-DD'), 'Chilena', 10, 109, '980021920', 'amanda.espinoza160@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.737-9', 'Camilo', 'Esteban', 'Vega', 'Muñoz', TO_DATE('1984-06-01','YYYY-MM-DD'), 'Chilena', 1, 114, '980022057', 'camilo.vega161@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.754-9', 'Tomás', 'Fernanda', 'Tapia', 'Ramírez', TO_DATE('1985-07-13','YYYY-MM-DD'), 'Chilena', 2, 119, '980022194', 'tomas.tapia162@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.771-9', 'Sergio', 'Luis', 'Vega', 'Fernández', TO_DATE('1986-08-24','YYYY-MM-DD'), 'Chilena', 3, 124, '980022331', 'sergio.vega163@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.788-3', 'Alonso', 'Andrea', 'Miranda', 'Castillo', TO_DATE('1987-10-05','YYYY-MM-DD'), 'Chilena', 4, 129, '980022468', 'alonso.miranda164@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.805-7', 'Diego', 'Paz', 'García', 'Muñoz', TO_DATE('1988-11-15','YYYY-MM-DD'), 'Chilena', 5, 134, '980022605', 'diego.garcia165@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.822-7', 'Andrés', 'Alejandra', 'Pérez', 'Ramírez', TO_DATE('1989-12-27','YYYY-MM-DD'), 'Chilena', 6, 139, '980022742', 'andres.perez166@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.839-1', 'Arturo', 'Alejandro', 'Vega', 'Fernández', TO_DATE('1991-02-07','YYYY-MM-DD'), 'Chilena', 7, 144, '980022879', 'arturo.vega167@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.856-1', 'Rocío', 'José', 'Vargas', 'Castillo', TO_DATE('1992-03-20','YYYY-MM-DD'), 'Chilena', 8, 149, '980023016', 'rocio.vargas168@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.873-1', 'Sergio', 'Esteban', 'González', 'Muñoz', TO_DATE('1993-05-01','YYYY-MM-DD'), 'Chilena', 9, 154, '980023153', 'sergio.gonzalez169@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.890-1', 'Franco', 'Fernanda', 'Fernández', 'Ramírez', TO_DATE('1994-06-12','YYYY-MM-DD'), 'Chilena', 10, 159, '980023290', 'franco.fernandez170@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.907-K', 'Tomás', 'Luis', 'Vargas', 'Fernández', TO_DATE('1995-07-24','YYYY-MM-DD'), 'Chilena', 1, 164, '980023427', 'tomas.vargas171@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.924-K', 'Ignacio', 'Andrea', 'Fernández', 'Castillo', TO_DATE('1996-09-03','YYYY-MM-DD'), 'Chilena', 2, 169, '980023564', 'ignacio.fernandez172@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.941-K', 'Arturo', 'Paz', 'González', 'Muñoz', TO_DATE('1997-10-15','YYYY-MM-DD'), 'Chilena', 3, 174, '980023701', 'arturo.gonzalez173@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.958-4', 'Antonia', 'Alejandra', 'Carrasco', 'Ramírez', TO_DATE('1998-11-26','YYYY-MM-DD'), 'Chilena', 4, 179, '980023838', 'antonia.carrasco174@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.975-4', 'Vicente', 'Alejandro', 'Pérez', 'Fernández', TO_DATE('2000-01-07','YYYY-MM-DD'), 'Chilena', 5, 184, '980023975', 'vicente.perez175@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.002.992-4', 'Mauricio', 'José', 'Espinoza', 'Castillo', TO_DATE('2001-02-17','YYYY-MM-DD'), 'Chilena', 6, 189, '980024112', 'mauricio.espinoza176@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.009-4', 'Javiera', 'Esteban', 'Tapia', 'Muñoz', TO_DATE('2002-03-31','YYYY-MM-DD'), 'Chilena', 7, 194, '980024249', 'javiera.tapia177@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.026-4', 'Daniela', 'Fernanda', 'Vega', 'Ramírez', TO_DATE('2003-05-12','YYYY-MM-DD'), 'Chilena', 8, 199, '980024386', 'daniela.vega178@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.043-4', 'Ignacio', 'Luis', 'Silva', 'Fernández', TO_DATE('2004-06-22','YYYY-MM-DD'), 'Chilena', 9, 204, '980024523', 'ignacio.silva179@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.060-4', 'Rodrigo', 'Andrea', 'Reyes', 'Castillo', TO_DATE('1965-08-04','YYYY-MM-DD'), 'Chilena', 10, 209, '980024660', 'rodrigo.reyes180@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.077-9', 'Andrés', 'Paz', 'Silva', 'Muñoz', TO_DATE('1966-09-15','YYYY-MM-DD'), 'Chilena', 1, 214, '980024797', 'andres.silva181@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.094-9', 'Daniela', 'Alejandra', 'Fuentes', 'Ramírez', TO_DATE('1967-10-27','YYYY-MM-DD'), 'Chilena', 2, 219, '980024934', 'daniela.fuentes182@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.111-2', 'Javiera', 'Alejandro', 'Soto', 'Fernández', TO_DATE('1968-12-07','YYYY-MM-DD'), 'Chilena', 3, 224, '980025071', 'javiera.soto183@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.128-7', 'Franco', 'José', 'Castro', 'Castillo', TO_DATE('1970-01-18','YYYY-MM-DD'), 'Chilena', 4, 229, '980025208', 'franco.castro184@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.145-7', 'Diego', 'Esteban', 'Carrasco', 'Muñoz', TO_DATE('1971-03-01','YYYY-MM-DD'), 'Chilena', 5, 234, '980025345', 'diego.carrasco185@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.162-7', 'Valentina', 'Fernanda', 'Pérez', 'Ramírez', TO_DATE('1972-04-11','YYYY-MM-DD'), 'Chilena', 6, 239, '980025482', 'valentina.perez186@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.179-1', 'Rodrigo', 'Luis', 'García', 'Fernández', TO_DATE('1973-05-23','YYYY-MM-DD'), 'Chilena', 7, 244, '980025619', 'rodrigo.garcia187@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.196-1', 'Franco', 'Andrea', 'Ortiz', 'Castillo', TO_DATE('1974-07-04','YYYY-MM-DD'), 'Chilena', 8, 249, '980025756', 'franco.ortiz188@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.213-5', 'Amanda', 'Paz', 'Soto', 'Muñoz', TO_DATE('1975-08-15','YYYY-MM-DD'), 'Chilena', 9, 254, '980025893', 'amanda.soto189@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.230-5', 'Daniela', 'Alejandra', 'Tapia', 'Ramírez', TO_DATE('1976-09-25','YYYY-MM-DD'), 'Chilena', 10, 259, '980026030', 'daniela.tapia190@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.247-K', 'Isabel', 'Alejandro', 'Reyes', 'Fernández', TO_DATE('1977-11-06','YYYY-MM-DD'), 'Chilena', 1, 264, '980026167', 'isabel.reyes191@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.264-K', 'Daniela', 'José', 'Pérez', 'Castillo', TO_DATE('1978-12-18','YYYY-MM-DD'), 'Chilena', 2, 269, '980026304', 'daniela.perez192@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.281-K', 'Rodrigo', 'Esteban', 'González', 'Muñoz', TO_DATE('1980-01-29','YYYY-MM-DD'), 'Chilena', 3, 274, '980026441', 'rodrigo.gonzalez193@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.298-4', 'Arturo', 'Fernanda', 'Herrera', 'Ramírez', TO_DATE('1981-03-11','YYYY-MM-DD'), 'Chilena', 4, 279, '980026578', 'arturo.herrera194@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.315-8', 'Rodrigo', 'Luis', 'Castro', 'Fernández', TO_DATE('1982-04-22','YYYY-MM-DD'), 'Chilena', 5, 284, '980026715', 'rodrigo.castro195@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.332-8', 'Daniela', 'Andrea', 'Pizarro', 'Castillo', TO_DATE('1983-06-03','YYYY-MM-DD'), 'Chilena', 6, 289, '980026852', 'daniela.pizarro196@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.349-2', 'Daniela', 'Paz', 'Sepúlveda', 'Muñoz', TO_DATE('1984-07-14','YYYY-MM-DD'), 'Chilena', 7, 294, '980026989', 'daniela.sepulveda197@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.366-2', 'Alonso', 'Alejandra', 'González', 'Ramírez', TO_DATE('1985-08-25','YYYY-MM-DD'), 'Chilena', 8, 299, '980027126', 'alonso.gonzalez198@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.383-2', 'Diego', 'Alejandro', 'Vega', 'Fernández', TO_DATE('1986-10-06','YYYY-MM-DD'), 'Chilena', 9, 304, '980027263', 'diego.vega199@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('26.003.400-6', 'Andrés', 'José', 'Pizarro', 'Castillo', TO_DATE('1987-11-17','YYYY-MM-DD'), 'Chilena', 10, 309, '980027400', 'andres.pizarro200@gmail.com');

-- CONTRATO_CLI: 200 registros
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (1, TO_DATE('2026-08-28','YYYY-MM-DD'), TO_DATE('2026-09-28','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-08-28','YYYY-MM-DD'), TO_DATE('2026-09-28','YYYY-MM-DD'), '11.998.500-5');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (2, TO_DATE('2026-09-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-09-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'), '15.360.060-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (3, TO_DATE('2026-03-26','YYYY-MM-DD'), TO_DATE('2026-06-26','YYYY-MM-DD'), 'Caducado', 4, TO_DATE('2026-03-26','YYYY-MM-DD'), TO_DATE('2026-06-26','YYYY-MM-DD'), '18.430.815-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (4, TO_DATE('2026-07-22','YYYY-MM-DD'), TO_DATE('2026-10-22','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-07-22','YYYY-MM-DD'), TO_DATE('2026-10-22','YYYY-MM-DD'), '25.960.879-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (5, TO_DATE('2026-07-17','YYYY-MM-DD'), TO_DATE('2027-01-17','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-07-17','YYYY-MM-DD'), TO_DATE('2027-01-17','YYYY-MM-DD'), '18.586.960-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (6, TO_DATE('2024-11-03','YYYY-MM-DD'), TO_DATE('2025-11-03','YYYY-MM-DD'), 'Caducado', 7, TO_DATE('2024-11-03','YYYY-MM-DD'), TO_DATE('2025-11-03','YYYY-MM-DD'), '20.858.183-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (7, TO_DATE('2026-02-14','YYYY-MM-DD'), TO_DATE('2027-02-14','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2026-02-14','YYYY-MM-DD'), TO_DATE('2027-02-14','YYYY-MM-DD'), '24.428.415-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (8, TO_DATE('2026-08-22','YYYY-MM-DD'), TO_DATE('2026-11-22','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-08-22','YYYY-MM-DD'), TO_DATE('2026-11-22','YYYY-MM-DD'), '25.987.858-6');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (9, TO_DATE('2026-07-24','YYYY-MM-DD'), TO_DATE('2026-08-24','YYYY-MM-DD'), 'Caducado', 10, TO_DATE('2026-07-24','YYYY-MM-DD'), TO_DATE('2026-08-24','YYYY-MM-DD'), '11.721.960-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (10, TO_DATE('2026-09-02','YYYY-MM-DD'), TO_DATE('2026-10-02','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-09-02','YYYY-MM-DD'), TO_DATE('2026-10-02','YYYY-MM-DD'), '24.833.068-6');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (11, TO_DATE('2026-09-10','YYYY-MM-DD'), TO_DATE('2026-10-10','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-09-10','YYYY-MM-DD'), TO_DATE('2026-10-10','YYYY-MM-DD'), '13.746.093-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (12, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2026-08-26','YYYY-MM-DD'), 'Caducado', 3, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2026-08-26','YYYY-MM-DD'), '25.012.372-8');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (13, TO_DATE('2026-08-04','YYYY-MM-DD'), TO_DATE('2026-11-04','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-08-04','YYYY-MM-DD'), TO_DATE('2026-11-04','YYYY-MM-DD'), '20.083.621-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (14, TO_DATE('2026-08-31','YYYY-MM-DD'), TO_DATE('2026-11-30','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-08-31','YYYY-MM-DD'), TO_DATE('2026-11-30','YYYY-MM-DD'), '20.426.773-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (15, TO_DATE('2025-11-07','YYYY-MM-DD'), TO_DATE('2026-05-07','YYYY-MM-DD'), 'Caducado', 6, TO_DATE('2025-11-07','YYYY-MM-DD'), TO_DATE('2026-05-07','YYYY-MM-DD'), '19.337.510-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (16, TO_DATE('2026-04-09','YYYY-MM-DD'), TO_DATE('2027-04-09','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2026-04-09','YYYY-MM-DD'), TO_DATE('2027-04-09','YYYY-MM-DD'), '17.056.747-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (17, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2027-07-26','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2027-07-26','YYYY-MM-DD'), '23.142.824-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (18, TO_DATE('2026-04-18','YYYY-MM-DD'), TO_DATE('2026-07-18','YYYY-MM-DD'), 'Caducado', 9, TO_DATE('2026-04-18','YYYY-MM-DD'), TO_DATE('2026-07-18','YYYY-MM-DD'), '19.606.110-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (19, TO_DATE('2026-09-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-09-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'), '19.190.751-5');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (20, TO_DATE('2026-08-21','YYYY-MM-DD'), TO_DATE('2026-09-21','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-08-21','YYYY-MM-DD'), TO_DATE('2026-09-21','YYYY-MM-DD'), '24.133.155-5');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (21, TO_DATE('2026-07-30','YYYY-MM-DD'), TO_DATE('2026-08-30','YYYY-MM-DD'), 'Caducado', 2, TO_DATE('2026-07-30','YYYY-MM-DD'), TO_DATE('2026-08-30','YYYY-MM-DD'), '22.256.410-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (22, TO_DATE('2026-09-08','YYYY-MM-DD'), TO_DATE('2026-10-08','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-09-08','YYYY-MM-DD'), TO_DATE('2026-10-08','YYYY-MM-DD'), '23.028.725-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (23, TO_DATE('2026-06-29','YYYY-MM-DD'), TO_DATE('2026-09-29','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-06-29','YYYY-MM-DD'), TO_DATE('2026-09-29','YYYY-MM-DD'), '22.886.836-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (24, TO_DATE('2026-04-27','YYYY-MM-DD'), TO_DATE('2026-07-27','YYYY-MM-DD'), 'Caducado', 5, TO_DATE('2026-04-27','YYYY-MM-DD'), TO_DATE('2026-07-27','YYYY-MM-DD'), '18.236.009-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (25, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2027-01-26','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2027-01-26','YYYY-MM-DD'), '22.600.124-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (26, TO_DATE('2025-11-16','YYYY-MM-DD'), TO_DATE('2026-11-16','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2025-11-16','YYYY-MM-DD'), TO_DATE('2026-11-16','YYYY-MM-DD'), '22.970.008-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (27, TO_DATE('2025-03-09','YYYY-MM-DD'), TO_DATE('2026-03-09','YYYY-MM-DD'), 'Caducado', 8, TO_DATE('2025-03-09','YYYY-MM-DD'), TO_DATE('2026-03-09','YYYY-MM-DD'), '19.840.186-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (28, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-11-27','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-11-27','YYYY-MM-DD'), '17.400.346-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (29, TO_DATE('2026-08-25','YYYY-MM-DD'), TO_DATE('2026-09-25','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-08-25','YYYY-MM-DD'), TO_DATE('2026-09-25','YYYY-MM-DD'), '14.025.425-8');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (30, TO_DATE('2026-08-04','YYYY-MM-DD'), TO_DATE('2026-09-04','YYYY-MM-DD'), 'Caducado', 1, TO_DATE('2026-08-04','YYYY-MM-DD'), TO_DATE('2026-09-04','YYYY-MM-DD'), '10.042.527-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (31, TO_DATE('2026-09-12','YYYY-MM-DD'), TO_DATE('2026-10-12','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-09-12','YYYY-MM-DD'), TO_DATE('2026-10-12','YYYY-MM-DD'), '20.304.637-5');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (32, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-09-27','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-09-27','YYYY-MM-DD'), '11.354.318-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (33, TO_DATE('2026-05-11','YYYY-MM-DD'), TO_DATE('2026-08-11','YYYY-MM-DD'), 'Caducado', 4, TO_DATE('2026-05-11','YYYY-MM-DD'), TO_DATE('2026-08-11','YYYY-MM-DD'), '11.857.850-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (34, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-12-04','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-12-04','YYYY-MM-DD'), '14.819.091-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (35, TO_DATE('2026-05-15','YYYY-MM-DD'), TO_DATE('2026-11-15','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-05-15','YYYY-MM-DD'), TO_DATE('2026-11-15','YYYY-MM-DD'), '23.702.981-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (36, TO_DATE('2025-05-02','YYYY-MM-DD'), TO_DATE('2026-05-02','YYYY-MM-DD'), 'Caducado', 7, TO_DATE('2025-05-02','YYYY-MM-DD'), TO_DATE('2026-05-02','YYYY-MM-DD'), '11.645.033-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (37, TO_DATE('2025-10-11','YYYY-MM-DD'), TO_DATE('2026-10-11','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2025-10-11','YYYY-MM-DD'), TO_DATE('2026-10-11','YYYY-MM-DD'), '17.543.956-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (38, TO_DATE('2026-07-22','YYYY-MM-DD'), TO_DATE('2026-10-22','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-07-22','YYYY-MM-DD'), TO_DATE('2026-10-22','YYYY-MM-DD'), '10.192.750-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (39, TO_DATE('2026-08-09','YYYY-MM-DD'), TO_DATE('2026-09-09','YYYY-MM-DD'), 'Caducado', 10, TO_DATE('2026-08-09','YYYY-MM-DD'), TO_DATE('2026-09-09','YYYY-MM-DD'), '23.669.449-6');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (40, TO_DATE('2026-08-22','YYYY-MM-DD'), TO_DATE('2026-09-22','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-08-22','YYYY-MM-DD'), TO_DATE('2026-09-22','YYYY-MM-DD'), '24.947.890-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (41, TO_DATE('2026-08-31','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-08-31','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), '21.495.380-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (42, TO_DATE('2026-08-10','YYYY-MM-DD'), TO_DATE('2026-09-10','YYYY-MM-DD'), 'Caducado', 3, TO_DATE('2026-08-10','YYYY-MM-DD'), TO_DATE('2026-09-10','YYYY-MM-DD'), '18.225.646-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (43, TO_DATE('2026-07-04','YYYY-MM-DD'), TO_DATE('2026-10-04','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-07-04','YYYY-MM-DD'), TO_DATE('2026-10-04','YYYY-MM-DD'), '21.398.255-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (44, TO_DATE('2026-07-30','YYYY-MM-DD'), TO_DATE('2026-10-30','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-07-30','YYYY-MM-DD'), TO_DATE('2026-10-30','YYYY-MM-DD'), '15.271.957-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (45, TO_DATE('2026-02-05','YYYY-MM-DD'), TO_DATE('2026-08-05','YYYY-MM-DD'), 'Caducado', 6, TO_DATE('2026-02-05','YYYY-MM-DD'), TO_DATE('2026-08-05','YYYY-MM-DD'), '13.526.984-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (46, TO_DATE('2025-12-04','YYYY-MM-DD'), TO_DATE('2026-12-04','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2025-12-04','YYYY-MM-DD'), TO_DATE('2026-12-04','YYYY-MM-DD'), '16.664.202-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (47, TO_DATE('2026-03-22','YYYY-MM-DD'), TO_DATE('2027-03-22','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2026-03-22','YYYY-MM-DD'), TO_DATE('2027-03-22','YYYY-MM-DD'), '14.219.689-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (48, TO_DATE('2026-06-02','YYYY-MM-DD'), TO_DATE('2026-09-02','YYYY-MM-DD'), 'Caducado', 9, TO_DATE('2026-06-02','YYYY-MM-DD'), TO_DATE('2026-09-02','YYYY-MM-DD'), '15.832.730-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (49, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-09-27','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-09-27','YYYY-MM-DD'), '25.591.357-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (50, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-10-04','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-10-04','YYYY-MM-DD'), '15.983.360-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (51, TO_DATE('2026-08-30','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-08-30','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), '26.000.867-6');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (52, TO_DATE('2026-09-10','YYYY-MM-DD'), TO_DATE('2026-10-10','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-09-10','YYYY-MM-DD'), TO_DATE('2026-10-10','YYYY-MM-DD'), '26.000.884-6');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (53, TO_DATE('2026-08-28','YYYY-MM-DD'), TO_DATE('2026-09-28','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-08-28','YYYY-MM-DD'), TO_DATE('2026-09-28','YYYY-MM-DD'), '26.000.901-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (54, TO_DATE('2026-09-13','YYYY-MM-DD'), TO_DATE('2026-12-13','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-09-13','YYYY-MM-DD'), TO_DATE('2026-12-13','YYYY-MM-DD'), '26.000.918-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (55, TO_DATE('2026-07-01','YYYY-MM-DD'), TO_DATE('2026-10-01','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-07-01','YYYY-MM-DD'), TO_DATE('2026-10-01','YYYY-MM-DD'), '26.000.935-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (56, TO_DATE('2026-06-14','YYYY-MM-DD'), TO_DATE('2026-12-14','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-06-14','YYYY-MM-DD'), TO_DATE('2026-12-14','YYYY-MM-DD'), '26.000.952-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (57, TO_DATE('2026-06-17','YYYY-MM-DD'), TO_DATE('2027-06-17','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2026-06-17','YYYY-MM-DD'), TO_DATE('2027-06-17','YYYY-MM-DD'), '26.000.969-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (58, TO_DATE('2026-06-28','YYYY-MM-DD'), TO_DATE('2027-06-28','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2026-06-28','YYYY-MM-DD'), TO_DATE('2027-06-28','YYYY-MM-DD'), '26.000.986-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (59, TO_DATE('2026-08-14','YYYY-MM-DD'), TO_DATE('2026-11-14','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-08-14','YYYY-MM-DD'), TO_DATE('2026-11-14','YYYY-MM-DD'), '26.001.003-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (60, TO_DATE('2026-09-02','YYYY-MM-DD'), TO_DATE('2026-10-02','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-09-02','YYYY-MM-DD'), TO_DATE('2026-10-02','YYYY-MM-DD'), '26.001.020-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (61, TO_DATE('2026-09-13','YYYY-MM-DD'), TO_DATE('2026-10-13','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-09-13','YYYY-MM-DD'), TO_DATE('2026-10-13','YYYY-MM-DD'), '26.001.037-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (62, TO_DATE('2026-08-31','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-08-31','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), '26.001.054-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (63, TO_DATE('2026-09-11','YYYY-MM-DD'), TO_DATE('2026-10-11','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-09-11','YYYY-MM-DD'), TO_DATE('2026-10-11','YYYY-MM-DD'), '26.001.071-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (64, TO_DATE('2026-07-15','YYYY-MM-DD'), TO_DATE('2026-10-15','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-07-15','YYYY-MM-DD'), TO_DATE('2026-10-15','YYYY-MM-DD'), '26.001.088-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (65, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2026-10-26','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2026-10-26','YYYY-MM-DD'), '26.001.105-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (66, TO_DATE('2026-04-08','YYYY-MM-DD'), TO_DATE('2026-10-08','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-04-08','YYYY-MM-DD'), TO_DATE('2026-10-08','YYYY-MM-DD'), '26.001.122-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (67, TO_DATE('2025-10-12','YYYY-MM-DD'), TO_DATE('2026-10-12','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2025-10-12','YYYY-MM-DD'), TO_DATE('2026-10-12','YYYY-MM-DD'), '26.001.139-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (68, TO_DATE('2025-10-23','YYYY-MM-DD'), TO_DATE('2026-10-23','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2025-10-23','YYYY-MM-DD'), TO_DATE('2026-10-23','YYYY-MM-DD'), '26.001.156-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (69, TO_DATE('2026-09-08','YYYY-MM-DD'), TO_DATE('2026-12-08','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-09-08','YYYY-MM-DD'), TO_DATE('2026-12-08','YYYY-MM-DD'), '26.001.173-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (70, TO_DATE('2026-08-23','YYYY-MM-DD'), TO_DATE('2026-09-23','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-08-23','YYYY-MM-DD'), TO_DATE('2026-09-23','YYYY-MM-DD'), '26.001.190-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (71, TO_DATE('2026-09-03','YYYY-MM-DD'), TO_DATE('2026-10-03','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-09-03','YYYY-MM-DD'), TO_DATE('2026-10-03','YYYY-MM-DD'), '26.001.207-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (72, TO_DATE('2026-08-21','YYYY-MM-DD'), TO_DATE('2026-09-21','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-08-21','YYYY-MM-DD'), TO_DATE('2026-09-21','YYYY-MM-DD'), '26.001.224-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (73, TO_DATE('2026-09-01','YYYY-MM-DD'), TO_DATE('2026-10-01','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-09-01','YYYY-MM-DD'), TO_DATE('2026-10-01','YYYY-MM-DD'), '26.001.241-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (74, TO_DATE('2026-08-09','YYYY-MM-DD'), TO_DATE('2026-11-09','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-08-09','YYYY-MM-DD'), TO_DATE('2026-11-09','YYYY-MM-DD'), '26.001.258-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (75, TO_DATE('2026-08-20','YYYY-MM-DD'), TO_DATE('2026-11-20','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-08-20','YYYY-MM-DD'), TO_DATE('2026-11-20','YYYY-MM-DD'), '26.001.275-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (76, TO_DATE('2026-07-27','YYYY-MM-DD'), TO_DATE('2027-01-27','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-07-27','YYYY-MM-DD'), TO_DATE('2027-01-27','YYYY-MM-DD'), '26.001.292-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (77, TO_DATE('2026-01-30','YYYY-MM-DD'), TO_DATE('2027-01-30','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2026-01-30','YYYY-MM-DD'), TO_DATE('2027-01-30','YYYY-MM-DD'), '26.001.309-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (78, TO_DATE('2026-02-10','YYYY-MM-DD'), TO_DATE('2027-02-10','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2026-02-10','YYYY-MM-DD'), TO_DATE('2027-02-10','YYYY-MM-DD'), '26.001.326-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (79, TO_DATE('2026-07-10','YYYY-MM-DD'), TO_DATE('2026-10-10','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-07-10','YYYY-MM-DD'), TO_DATE('2026-10-10','YYYY-MM-DD'), '26.001.343-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (80, TO_DATE('2026-09-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-09-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'), '26.001.360-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (81, TO_DATE('2026-08-24','YYYY-MM-DD'), TO_DATE('2026-09-24','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-08-24','YYYY-MM-DD'), TO_DATE('2026-09-24','YYYY-MM-DD'), '26.001.377-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (82, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-10-04','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-10-04','YYYY-MM-DD'), '26.001.394-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (83, TO_DATE('2026-08-22','YYYY-MM-DD'), TO_DATE('2026-09-22','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-08-22','YYYY-MM-DD'), TO_DATE('2026-09-22','YYYY-MM-DD'), '26.001.411-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (84, TO_DATE('2026-09-03','YYYY-MM-DD'), TO_DATE('2026-12-03','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-09-03','YYYY-MM-DD'), TO_DATE('2026-12-03','YYYY-MM-DD'), '26.001.428-5');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (85, TO_DATE('2026-06-21','YYYY-MM-DD'), TO_DATE('2026-09-21','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-06-21','YYYY-MM-DD'), TO_DATE('2026-09-21','YYYY-MM-DD'), '26.001.445-5');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (86, TO_DATE('2026-05-21','YYYY-MM-DD'), TO_DATE('2026-11-21','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-05-21','YYYY-MM-DD'), TO_DATE('2026-11-21','YYYY-MM-DD'), '26.001.462-5');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (87, TO_DATE('2026-05-20','YYYY-MM-DD'), TO_DATE('2027-05-20','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2026-05-20','YYYY-MM-DD'), TO_DATE('2027-05-20','YYYY-MM-DD'), '26.001.479-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (88, TO_DATE('2026-05-31','YYYY-MM-DD'), TO_DATE('2027-05-31','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2026-05-31','YYYY-MM-DD'), TO_DATE('2027-05-31','YYYY-MM-DD'), '26.001.496-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (89, TO_DATE('2026-08-04','YYYY-MM-DD'), TO_DATE('2026-11-04','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-08-04','YYYY-MM-DD'), TO_DATE('2026-11-04','YYYY-MM-DD'), '26.001.513-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (90, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-09-27','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-09-27','YYYY-MM-DD'), '26.001.530-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (91, TO_DATE('2026-09-07','YYYY-MM-DD'), TO_DATE('2026-10-07','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-09-07','YYYY-MM-DD'), TO_DATE('2026-10-07','YYYY-MM-DD'), '26.001.547-8');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (92, TO_DATE('2026-08-25','YYYY-MM-DD'), TO_DATE('2026-09-25','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-08-25','YYYY-MM-DD'), TO_DATE('2026-09-25','YYYY-MM-DD'), '26.001.564-8');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (93, TO_DATE('2026-09-05','YYYY-MM-DD'), TO_DATE('2026-10-05','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-09-05','YYYY-MM-DD'), TO_DATE('2026-10-05','YYYY-MM-DD'), '26.001.581-8');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (94, TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-10-05','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-07-05','YYYY-MM-DD'), TO_DATE('2026-10-05','YYYY-MM-DD'), '26.001.598-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (95, TO_DATE('2026-07-16','YYYY-MM-DD'), TO_DATE('2026-10-16','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-07-16','YYYY-MM-DD'), TO_DATE('2026-10-16','YYYY-MM-DD'), '26.001.615-6');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (96, TO_DATE('2026-09-08','YYYY-MM-DD'), TO_DATE('2027-03-08','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-09-08','YYYY-MM-DD'), TO_DATE('2027-03-08','YYYY-MM-DD'), '26.001.632-6');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (97, TO_DATE('2026-09-07','YYYY-MM-DD'), TO_DATE('2027-09-07','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2026-09-07','YYYY-MM-DD'), TO_DATE('2027-09-07','YYYY-MM-DD'), '26.001.649-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (98, TO_DATE('2025-09-25','YYYY-MM-DD'), TO_DATE('2026-09-25','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2025-09-25','YYYY-MM-DD'), TO_DATE('2026-09-25','YYYY-MM-DD'), '26.001.666-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (99, TO_DATE('2026-08-29','YYYY-MM-DD'), TO_DATE('2026-11-29','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-08-29','YYYY-MM-DD'), TO_DATE('2026-11-29','YYYY-MM-DD'), '26.001.683-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (100, TO_DATE('2026-09-10','YYYY-MM-DD'), TO_DATE('2026-10-10','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-09-10','YYYY-MM-DD'), TO_DATE('2026-10-10','YYYY-MM-DD'), '26.001.700-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (101, TO_DATE('2026-08-28','YYYY-MM-DD'), TO_DATE('2026-09-28','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-08-28','YYYY-MM-DD'), TO_DATE('2026-09-28','YYYY-MM-DD'), '26.001.717-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (102, TO_DATE('2026-09-08','YYYY-MM-DD'), TO_DATE('2026-10-08','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-09-08','YYYY-MM-DD'), TO_DATE('2026-10-08','YYYY-MM-DD'), '26.001.734-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (103, TO_DATE('2026-08-26','YYYY-MM-DD'), TO_DATE('2026-09-26','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-08-26','YYYY-MM-DD'), TO_DATE('2026-09-26','YYYY-MM-DD'), '26.001.751-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (104, TO_DATE('2026-07-30','YYYY-MM-DD'), TO_DATE('2026-10-30','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-07-30','YYYY-MM-DD'), TO_DATE('2026-10-30','YYYY-MM-DD'), '26.001.768-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (105, TO_DATE('2026-08-10','YYYY-MM-DD'), TO_DATE('2026-11-10','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-08-10','YYYY-MM-DD'), TO_DATE('2026-11-10','YYYY-MM-DD'), '26.001.785-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (106, TO_DATE('2026-07-03','YYYY-MM-DD'), TO_DATE('2027-01-03','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-07-03','YYYY-MM-DD'), TO_DATE('2027-01-03','YYYY-MM-DD'), '26.001.802-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (107, TO_DATE('2026-01-02','YYYY-MM-DD'), TO_DATE('2027-01-02','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2026-01-02','YYYY-MM-DD'), TO_DATE('2027-01-02','YYYY-MM-DD'), '26.001.819-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (108, TO_DATE('2026-01-13','YYYY-MM-DD'), TO_DATE('2027-01-13','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2026-01-13','YYYY-MM-DD'), TO_DATE('2027-01-13','YYYY-MM-DD'), '26.001.836-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (109, TO_DATE('2026-06-30','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-06-30','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), '26.001.853-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (110, TO_DATE('2026-08-31','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-08-31','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), '26.001.870-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (111, TO_DATE('2026-09-11','YYYY-MM-DD'), TO_DATE('2026-10-11','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-09-11','YYYY-MM-DD'), TO_DATE('2026-10-11','YYYY-MM-DD'), '26.001.887-6');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (112, TO_DATE('2026-08-29','YYYY-MM-DD'), TO_DATE('2026-09-29','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-08-29','YYYY-MM-DD'), TO_DATE('2026-09-29','YYYY-MM-DD'), '26.001.904-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (113, TO_DATE('2026-09-09','YYYY-MM-DD'), TO_DATE('2026-10-09','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-09-09','YYYY-MM-DD'), TO_DATE('2026-10-09','YYYY-MM-DD'), '26.001.921-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (114, TO_DATE('2026-08-24','YYYY-MM-DD'), TO_DATE('2026-11-24','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-08-24','YYYY-MM-DD'), TO_DATE('2026-11-24','YYYY-MM-DD'), '26.001.938-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (115, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-12-04','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-12-04','YYYY-MM-DD'), '26.001.955-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (116, TO_DATE('2026-04-27','YYYY-MM-DD'), TO_DATE('2026-10-27','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-04-27','YYYY-MM-DD'), TO_DATE('2026-10-27','YYYY-MM-DD'), '26.001.972-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (117, TO_DATE('2026-04-22','YYYY-MM-DD'), TO_DATE('2027-04-22','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2026-04-22','YYYY-MM-DD'), TO_DATE('2027-04-22','YYYY-MM-DD'), '26.001.989-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (118, TO_DATE('2026-05-03','YYYY-MM-DD'), TO_DATE('2027-05-03','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2026-05-03','YYYY-MM-DD'), TO_DATE('2027-05-03','YYYY-MM-DD'), '26.002.006-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (119, TO_DATE('2026-07-25','YYYY-MM-DD'), TO_DATE('2026-10-25','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-07-25','YYYY-MM-DD'), TO_DATE('2026-10-25','YYYY-MM-DD'), '26.002.023-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (120, TO_DATE('2026-08-21','YYYY-MM-DD'), TO_DATE('2026-09-21','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-08-21','YYYY-MM-DD'), TO_DATE('2026-09-21','YYYY-MM-DD'), '26.002.040-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (121, TO_DATE('2026-09-01','YYYY-MM-DD'), TO_DATE('2026-10-01','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-09-01','YYYY-MM-DD'), TO_DATE('2026-10-01','YYYY-MM-DD'), '26.002.057-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (122, TO_DATE('2026-09-12','YYYY-MM-DD'), TO_DATE('2026-10-12','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-09-12','YYYY-MM-DD'), TO_DATE('2026-10-12','YYYY-MM-DD'), '26.002.074-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (123, TO_DATE('2026-08-30','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-08-30','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), '26.002.091-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (124, TO_DATE('2026-06-25','YYYY-MM-DD'), TO_DATE('2026-09-25','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-06-25','YYYY-MM-DD'), TO_DATE('2026-09-25','YYYY-MM-DD'), '26.002.108-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (125, TO_DATE('2026-07-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-07-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'), '26.002.125-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (126, TO_DATE('2026-08-15','YYYY-MM-DD'), TO_DATE('2027-02-15','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-08-15','YYYY-MM-DD'), TO_DATE('2027-02-15','YYYY-MM-DD'), '26.002.142-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (127, TO_DATE('2026-08-10','YYYY-MM-DD'), TO_DATE('2027-08-10','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2026-08-10','YYYY-MM-DD'), TO_DATE('2027-08-10','YYYY-MM-DD'), '26.002.159-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (128, TO_DATE('2026-08-21','YYYY-MM-DD'), TO_DATE('2027-08-21','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2026-08-21','YYYY-MM-DD'), TO_DATE('2027-08-21','YYYY-MM-DD'), '26.002.176-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (129, TO_DATE('2026-08-19','YYYY-MM-DD'), TO_DATE('2026-11-19','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-08-19','YYYY-MM-DD'), TO_DATE('2026-11-19','YYYY-MM-DD'), '26.002.193-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (130, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-10-04','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-10-04','YYYY-MM-DD'), '26.002.210-5');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (131, TO_DATE('2026-08-22','YYYY-MM-DD'), TO_DATE('2026-09-22','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-08-22','YYYY-MM-DD'), TO_DATE('2026-09-22','YYYY-MM-DD'), '26.002.227-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (132, TO_DATE('2026-09-02','YYYY-MM-DD'), TO_DATE('2026-10-02','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-09-02','YYYY-MM-DD'), TO_DATE('2026-10-02','YYYY-MM-DD'), '26.002.244-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (133, TO_DATE('2026-09-13','YYYY-MM-DD'), TO_DATE('2026-10-13','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-09-13','YYYY-MM-DD'), TO_DATE('2026-10-13','YYYY-MM-DD'), '26.002.261-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (134, TO_DATE('2026-07-20','YYYY-MM-DD'), TO_DATE('2026-10-20','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-07-20','YYYY-MM-DD'), TO_DATE('2026-10-20','YYYY-MM-DD'), '26.002.278-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (135, TO_DATE('2026-07-31','YYYY-MM-DD'), TO_DATE('2026-10-31','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-07-31','YYYY-MM-DD'), TO_DATE('2026-10-31','YYYY-MM-DD'), '26.002.295-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (136, TO_DATE('2026-06-09','YYYY-MM-DD'), TO_DATE('2026-12-09','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-06-09','YYYY-MM-DD'), TO_DATE('2026-12-09','YYYY-MM-DD'), '26.002.312-8');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (137, TO_DATE('2025-12-05','YYYY-MM-DD'), TO_DATE('2026-12-05','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2025-12-05','YYYY-MM-DD'), TO_DATE('2026-12-05','YYYY-MM-DD'), '26.002.329-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (138, TO_DATE('2025-12-16','YYYY-MM-DD'), TO_DATE('2026-12-16','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2025-12-16','YYYY-MM-DD'), TO_DATE('2026-12-16','YYYY-MM-DD'), '26.002.346-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (139, TO_DATE('2026-09-13','YYYY-MM-DD'), TO_DATE('2026-12-13','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-09-13','YYYY-MM-DD'), TO_DATE('2026-12-13','YYYY-MM-DD'), '26.002.363-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (140, TO_DATE('2026-08-25','YYYY-MM-DD'), TO_DATE('2026-09-25','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-08-25','YYYY-MM-DD'), TO_DATE('2026-09-25','YYYY-MM-DD'), '26.002.380-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (141, TO_DATE('2026-09-05','YYYY-MM-DD'), TO_DATE('2026-10-05','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-09-05','YYYY-MM-DD'), TO_DATE('2026-10-05','YYYY-MM-DD'), '26.002.397-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (142, TO_DATE('2026-08-23','YYYY-MM-DD'), TO_DATE('2026-09-23','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-08-23','YYYY-MM-DD'), TO_DATE('2026-09-23','YYYY-MM-DD'), '26.002.414-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (143, TO_DATE('2026-09-03','YYYY-MM-DD'), TO_DATE('2026-10-03','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-09-03','YYYY-MM-DD'), TO_DATE('2026-10-03','YYYY-MM-DD'), '26.002.431-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (144, TO_DATE('2026-08-14','YYYY-MM-DD'), TO_DATE('2026-11-14','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-08-14','YYYY-MM-DD'), TO_DATE('2026-11-14','YYYY-MM-DD'), '26.002.448-5');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (145, TO_DATE('2026-08-25','YYYY-MM-DD'), TO_DATE('2026-11-25','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-08-25','YYYY-MM-DD'), TO_DATE('2026-11-25','YYYY-MM-DD'), '26.002.465-5');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (146, TO_DATE('2026-04-03','YYYY-MM-DD'), TO_DATE('2026-10-03','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-04-03','YYYY-MM-DD'), TO_DATE('2026-10-03','YYYY-MM-DD'), '26.002.482-5');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (147, TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2027-03-25','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2026-03-25','YYYY-MM-DD'), TO_DATE('2027-03-25','YYYY-MM-DD'), '26.002.499-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (148, TO_DATE('2026-04-05','YYYY-MM-DD'), TO_DATE('2027-04-05','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2026-04-05','YYYY-MM-DD'), TO_DATE('2027-04-05','YYYY-MM-DD'), '26.002.516-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (149, TO_DATE('2026-07-15','YYYY-MM-DD'), TO_DATE('2026-10-15','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-07-15','YYYY-MM-DD'), TO_DATE('2026-10-15','YYYY-MM-DD'), '26.002.533-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (150, TO_DATE('2026-09-08','YYYY-MM-DD'), TO_DATE('2026-10-08','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-09-08','YYYY-MM-DD'), TO_DATE('2026-10-08','YYYY-MM-DD'), '26.002.550-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (151, TO_DATE('2026-08-26','YYYY-MM-DD'), TO_DATE('2026-09-26','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-08-26','YYYY-MM-DD'), TO_DATE('2026-09-26','YYYY-MM-DD'), '26.002.567-8');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (152, TO_DATE('2026-09-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-09-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'), '26.002.584-8');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (153, TO_DATE('2026-02-27','YYYY-MM-DD'), TO_DATE('2026-03-27','YYYY-MM-DD'), 'Caducado', 3, TO_DATE('2026-02-27','YYYY-MM-DD'), TO_DATE('2026-03-27','YYYY-MM-DD'), '26.002.601-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (154, TO_DATE('2026-01-08','YYYY-MM-DD'), TO_DATE('2026-04-08','YYYY-MM-DD'), 'Caducado', 4, TO_DATE('2026-01-08','YYYY-MM-DD'), TO_DATE('2026-04-08','YYYY-MM-DD'), '26.002.618-6');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (155, TO_DATE('2026-01-19','YYYY-MM-DD'), TO_DATE('2026-04-19','YYYY-MM-DD'), 'Caducado', 5, TO_DATE('2026-01-19','YYYY-MM-DD'), TO_DATE('2026-04-19','YYYY-MM-DD'), '26.002.635-6');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (156, TO_DATE('2025-10-30','YYYY-MM-DD'), TO_DATE('2026-04-30','YYYY-MM-DD'), 'Caducado', 6, TO_DATE('2025-10-30','YYYY-MM-DD'), TO_DATE('2026-04-30','YYYY-MM-DD'), '26.002.652-6');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (157, TO_DATE('2025-05-13','YYYY-MM-DD'), TO_DATE('2026-05-13','YYYY-MM-DD'), 'Caducado', 7, TO_DATE('2025-05-13','YYYY-MM-DD'), TO_DATE('2026-05-13','YYYY-MM-DD'), '26.002.669-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (158, TO_DATE('2025-05-24','YYYY-MM-DD'), TO_DATE('2026-05-24','YYYY-MM-DD'), 'Caducado', 8, TO_DATE('2025-05-24','YYYY-MM-DD'), TO_DATE('2026-05-24','YYYY-MM-DD'), '26.002.686-0');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (159, TO_DATE('2026-03-04','YYYY-MM-DD'), TO_DATE('2026-06-04','YYYY-MM-DD'), 'Caducado', 9, TO_DATE('2026-03-04','YYYY-MM-DD'), TO_DATE('2026-06-04','YYYY-MM-DD'), '26.002.703-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (160, TO_DATE('2026-05-15','YYYY-MM-DD'), TO_DATE('2026-06-15','YYYY-MM-DD'), 'Caducado', 10, TO_DATE('2026-05-15','YYYY-MM-DD'), TO_DATE('2026-06-15','YYYY-MM-DD'), '26.002.720-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (161, TO_DATE('2026-05-26','YYYY-MM-DD'), TO_DATE('2026-06-26','YYYY-MM-DD'), 'Caducado', 1, TO_DATE('2026-05-26','YYYY-MM-DD'), TO_DATE('2026-06-26','YYYY-MM-DD'), '26.002.737-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (162, TO_DATE('2026-06-06','YYYY-MM-DD'), TO_DATE('2026-07-06','YYYY-MM-DD'), 'Caducado', 2, TO_DATE('2026-06-06','YYYY-MM-DD'), TO_DATE('2026-07-06','YYYY-MM-DD'), '26.002.754-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (163, TO_DATE('2026-06-17','YYYY-MM-DD'), TO_DATE('2026-07-17','YYYY-MM-DD'), 'Caducado', 3, TO_DATE('2026-06-17','YYYY-MM-DD'), TO_DATE('2026-07-17','YYYY-MM-DD'), '26.002.771-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (164, TO_DATE('2026-04-28','YYYY-MM-DD'), TO_DATE('2026-07-28','YYYY-MM-DD'), 'Caducado', 4, TO_DATE('2026-04-28','YYYY-MM-DD'), TO_DATE('2026-07-28','YYYY-MM-DD'), '26.002.788-3');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (165, TO_DATE('2026-05-09','YYYY-MM-DD'), TO_DATE('2026-08-09','YYYY-MM-DD'), 'Caducado', 5, TO_DATE('2026-05-09','YYYY-MM-DD'), TO_DATE('2026-08-09','YYYY-MM-DD'), '26.002.805-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (166, TO_DATE('2026-02-17','YYYY-MM-DD'), TO_DATE('2026-08-17','YYYY-MM-DD'), 'Caducado', 6, TO_DATE('2026-02-17','YYYY-MM-DD'), TO_DATE('2026-08-17','YYYY-MM-DD'), '26.002.822-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (167, TO_DATE('2025-08-31','YYYY-MM-DD'), TO_DATE('2026-08-31','YYYY-MM-DD'), 'Caducado', 7, TO_DATE('2025-08-31','YYYY-MM-DD'), TO_DATE('2026-08-31','YYYY-MM-DD'), '26.002.839-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (168, TO_DATE('2025-01-23','YYYY-MM-DD'), TO_DATE('2026-01-23','YYYY-MM-DD'), 'Caducado', 8, TO_DATE('2025-01-23','YYYY-MM-DD'), TO_DATE('2026-01-23','YYYY-MM-DD'), '26.002.856-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (169, TO_DATE('2025-11-03','YYYY-MM-DD'), TO_DATE('2026-02-03','YYYY-MM-DD'), 'Caducado', 9, TO_DATE('2025-11-03','YYYY-MM-DD'), TO_DATE('2026-02-03','YYYY-MM-DD'), '26.002.873-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (170, TO_DATE('2026-01-14','YYYY-MM-DD'), TO_DATE('2026-02-14','YYYY-MM-DD'), 'Caducado', 10, TO_DATE('2026-01-14','YYYY-MM-DD'), TO_DATE('2026-02-14','YYYY-MM-DD'), '26.002.890-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (171, TO_DATE('2026-01-25','YYYY-MM-DD'), TO_DATE('2026-02-25','YYYY-MM-DD'), 'Caducado', 1, TO_DATE('2026-01-25','YYYY-MM-DD'), TO_DATE('2026-02-25','YYYY-MM-DD'), '26.002.907-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (172, TO_DATE('2026-02-05','YYYY-MM-DD'), TO_DATE('2026-03-05','YYYY-MM-DD'), 'Caducado', 2, TO_DATE('2026-02-05','YYYY-MM-DD'), TO_DATE('2026-03-05','YYYY-MM-DD'), '26.002.924-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (173, TO_DATE('2026-02-16','YYYY-MM-DD'), TO_DATE('2026-03-16','YYYY-MM-DD'), 'Caducado', 3, TO_DATE('2026-02-16','YYYY-MM-DD'), TO_DATE('2026-03-16','YYYY-MM-DD'), '26.002.941-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (174, TO_DATE('2025-12-28','YYYY-MM-DD'), TO_DATE('2026-03-28','YYYY-MM-DD'), 'Caducado', 4, TO_DATE('2025-12-28','YYYY-MM-DD'), TO_DATE('2026-03-28','YYYY-MM-DD'), '26.002.958-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (175, TO_DATE('2026-01-08','YYYY-MM-DD'), TO_DATE('2026-04-08','YYYY-MM-DD'), 'Caducado', 5, TO_DATE('2026-01-08','YYYY-MM-DD'), TO_DATE('2026-04-08','YYYY-MM-DD'), '26.002.975-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (176, TO_DATE('2025-10-19','YYYY-MM-DD'), TO_DATE('2026-04-19','YYYY-MM-DD'), 'Caducado', 6, TO_DATE('2025-10-19','YYYY-MM-DD'), TO_DATE('2026-04-19','YYYY-MM-DD'), '26.002.992-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (177, TO_DATE('2025-05-02','YYYY-MM-DD'), TO_DATE('2026-05-02','YYYY-MM-DD'), 'Caducado', 7, TO_DATE('2025-05-02','YYYY-MM-DD'), TO_DATE('2026-05-02','YYYY-MM-DD'), '26.003.009-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (178, TO_DATE('2025-05-13','YYYY-MM-DD'), TO_DATE('2026-05-13','YYYY-MM-DD'), 'Caducado', 8, TO_DATE('2025-05-13','YYYY-MM-DD'), TO_DATE('2026-05-13','YYYY-MM-DD'), '26.003.026-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (179, TO_DATE('2026-02-21','YYYY-MM-DD'), TO_DATE('2026-05-21','YYYY-MM-DD'), 'Caducado', 9, TO_DATE('2026-02-21','YYYY-MM-DD'), TO_DATE('2026-05-21','YYYY-MM-DD'), '26.003.043-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (180, TO_DATE('2026-05-04','YYYY-MM-DD'), TO_DATE('2026-06-04','YYYY-MM-DD'), 'Caducado', 10, TO_DATE('2026-05-04','YYYY-MM-DD'), TO_DATE('2026-06-04','YYYY-MM-DD'), '26.003.060-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (181, TO_DATE('2026-05-15','YYYY-MM-DD'), TO_DATE('2026-06-15','YYYY-MM-DD'), 'Caducado', 1, TO_DATE('2026-05-15','YYYY-MM-DD'), TO_DATE('2026-06-15','YYYY-MM-DD'), '26.003.077-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (182, TO_DATE('2026-05-26','YYYY-MM-DD'), TO_DATE('2026-06-26','YYYY-MM-DD'), 'Caducado', 2, TO_DATE('2026-05-26','YYYY-MM-DD'), TO_DATE('2026-06-26','YYYY-MM-DD'), '26.003.094-9');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (183, TO_DATE('2026-06-06','YYYY-MM-DD'), TO_DATE('2026-07-06','YYYY-MM-DD'), 'Caducado', 3, TO_DATE('2026-06-06','YYYY-MM-DD'), TO_DATE('2026-07-06','YYYY-MM-DD'), '26.003.111-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (184, TO_DATE('2026-04-17','YYYY-MM-DD'), TO_DATE('2026-07-17','YYYY-MM-DD'), 'Caducado', 4, TO_DATE('2026-04-17','YYYY-MM-DD'), TO_DATE('2026-07-17','YYYY-MM-DD'), '26.003.128-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (185, TO_DATE('2026-04-28','YYYY-MM-DD'), TO_DATE('2026-07-28','YYYY-MM-DD'), 'Caducado', 5, TO_DATE('2026-04-28','YYYY-MM-DD'), TO_DATE('2026-07-28','YYYY-MM-DD'), '26.003.145-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (186, TO_DATE('2026-02-06','YYYY-MM-DD'), TO_DATE('2026-08-06','YYYY-MM-DD'), 'Caducado', 6, TO_DATE('2026-02-06','YYYY-MM-DD'), TO_DATE('2026-08-06','YYYY-MM-DD'), '26.003.162-7');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (187, TO_DATE('2025-08-20','YYYY-MM-DD'), TO_DATE('2026-08-20','YYYY-MM-DD'), 'Caducado', 7, TO_DATE('2025-08-20','YYYY-MM-DD'), TO_DATE('2026-08-20','YYYY-MM-DD'), '26.003.179-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (188, TO_DATE('2025-08-31','YYYY-MM-DD'), TO_DATE('2026-08-31','YYYY-MM-DD'), 'Caducado', 8, TO_DATE('2025-08-31','YYYY-MM-DD'), TO_DATE('2026-08-31','YYYY-MM-DD'), '26.003.196-1');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (189, TO_DATE('2025-10-23','YYYY-MM-DD'), TO_DATE('2026-01-23','YYYY-MM-DD'), 'Caducado', 9, TO_DATE('2025-10-23','YYYY-MM-DD'), TO_DATE('2026-01-23','YYYY-MM-DD'), '26.003.213-5');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (190, TO_DATE('2026-01-03','YYYY-MM-DD'), TO_DATE('2026-02-03','YYYY-MM-DD'), 'Caducado', 10, TO_DATE('2026-01-03','YYYY-MM-DD'), TO_DATE('2026-02-03','YYYY-MM-DD'), '26.003.230-5');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (191, TO_DATE('2026-01-14','YYYY-MM-DD'), TO_DATE('2026-02-14','YYYY-MM-DD'), 'Caducado', 1, TO_DATE('2026-01-14','YYYY-MM-DD'), TO_DATE('2026-02-14','YYYY-MM-DD'), '26.003.247-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (192, TO_DATE('2026-01-25','YYYY-MM-DD'), TO_DATE('2026-02-25','YYYY-MM-DD'), 'Caducado', 2, TO_DATE('2026-01-25','YYYY-MM-DD'), TO_DATE('2026-02-25','YYYY-MM-DD'), '26.003.264-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (193, TO_DATE('2026-02-05','YYYY-MM-DD'), TO_DATE('2026-03-05','YYYY-MM-DD'), 'Caducado', 3, TO_DATE('2026-02-05','YYYY-MM-DD'), TO_DATE('2026-03-05','YYYY-MM-DD'), '26.003.281-K');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (194, TO_DATE('2025-12-17','YYYY-MM-DD'), TO_DATE('2026-03-17','YYYY-MM-DD'), 'Caducado', 4, TO_DATE('2025-12-17','YYYY-MM-DD'), TO_DATE('2026-03-17','YYYY-MM-DD'), '26.003.298-4');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (195, TO_DATE('2025-12-28','YYYY-MM-DD'), TO_DATE('2026-03-28','YYYY-MM-DD'), 'Caducado', 5, TO_DATE('2025-12-28','YYYY-MM-DD'), TO_DATE('2026-03-28','YYYY-MM-DD'), '26.003.315-8');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (196, TO_DATE('2025-10-08','YYYY-MM-DD'), TO_DATE('2026-04-08','YYYY-MM-DD'), 'Caducado', 6, TO_DATE('2025-10-08','YYYY-MM-DD'), TO_DATE('2026-04-08','YYYY-MM-DD'), '26.003.332-8');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (197, TO_DATE('2025-04-21','YYYY-MM-DD'), TO_DATE('2026-04-21','YYYY-MM-DD'), 'Caducado', 7, TO_DATE('2025-04-21','YYYY-MM-DD'), TO_DATE('2026-04-21','YYYY-MM-DD'), '26.003.349-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (198, TO_DATE('2025-05-02','YYYY-MM-DD'), TO_DATE('2026-05-02','YYYY-MM-DD'), 'Caducado', 8, TO_DATE('2025-05-02','YYYY-MM-DD'), TO_DATE('2026-05-02','YYYY-MM-DD'), '26.003.366-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (199, TO_DATE('2026-02-10','YYYY-MM-DD'), TO_DATE('2026-05-10','YYYY-MM-DD'), 'Caducado', 9, TO_DATE('2026-02-10','YYYY-MM-DD'), TO_DATE('2026-05-10','YYYY-MM-DD'), '26.003.383-2');
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter, CLIENTE_rut_cliente) VALUES (200, TO_DATE('2026-04-23','YYYY-MM-DD'), TO_DATE('2026-05-23','YYYY-MM-DD'), 'Caducado', 10, TO_DATE('2026-04-23','YYYY-MM-DD'), TO_DATE('2026-05-23','YYYY-MM-DD'), '26.003.400-6');

-- AGENDA: 200 registros
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (1, TO_DATE('2026-09-04','YYYY-MM-DD'), INTERVAL '0 16:45:00' DAY TO SECOND, 'Completada', '23.507.938-0', '11.998.500-5', 1);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (2, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 15:00:00' DAY TO SECOND, 'Agendada', '16.314.012-8', '15.360.060-0', 2);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (3, TO_DATE('2026-04-16','YYYY-MM-DD'), INTERVAL '0 09:30:00' DAY TO SECOND, 'Completada', '22.515.298-5', '18.430.815-0', 3);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (4, TO_DATE('2026-08-19','YYYY-MM-DD'), INTERVAL '0 17:15:00' DAY TO SECOND, 'Completada', '18.616.569-1', '25.960.879-1', 4);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (5, TO_DATE('2026-08-21','YYYY-MM-DD'), INTERVAL '0 13:30:00' DAY TO SECOND, 'Completada', '20.699.123-2', '18.586.960-1', 5);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (6, TO_DATE('2024-12-15','YYYY-MM-DD'), INTERVAL '0 10:45:00' DAY TO SECOND, 'Completada', '11.280.435-8', '20.858.183-K', 6);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (7, TO_DATE('2026-08-09','YYYY-MM-DD'), INTERVAL '0 09:15:00' DAY TO SECOND, 'Completada', '22.131.805-6', '24.428.415-9', 7);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (8, TO_DATE('2026-08-28','YYYY-MM-DD'), INTERVAL '0 16:00:00' DAY TO SECOND, 'Completada', '15.710.873-5', '25.987.858-6', 8);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (9, TO_DATE('2026-08-24','YYYY-MM-DD'), INTERVAL '0 17:15:00' DAY TO SECOND, 'Completada', '11.504.328-5', '11.721.960-7', 9);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (10, TO_DATE('2026-09-15','YYYY-MM-DD'), INTERVAL '0 07:15:00' DAY TO SECOND, 'Completada', '19.352.468-0', '24.833.068-6', 10);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (11, TO_DATE('2026-09-10','YYYY-MM-DD'), INTERVAL '0 11:15:00' DAY TO SECOND, 'Completada', '19.027.228-1', '13.746.093-9', 11);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (12, TO_DATE('2026-08-15','YYYY-MM-DD'), INTERVAL '0 17:15:00' DAY TO SECOND, 'Completada', '14.900.991-4', '25.012.372-8', 12);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (13, TO_DATE('2026-08-26','YYYY-MM-DD'), INTERVAL '0 11:15:00' DAY TO SECOND, 'Completada', '14.825.159-2', '20.083.621-9', 13);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (14, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 13:15:00' DAY TO SECOND, 'Completada', '17.674.700-5', '20.426.773-1', 14);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (15, TO_DATE('2026-02-20','YYYY-MM-DD'), INTERVAL '0 15:15:00' DAY TO SECOND, 'Completada', '12.363.714-3', '19.337.510-3', 15);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (16, TO_DATE('2026-07-30','YYYY-MM-DD'), INTERVAL '0 18:00:00' DAY TO SECOND, 'Completada', '24.704.807-3', '17.056.747-1', 16);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (17, TO_DATE('2026-08-27','YYYY-MM-DD'), INTERVAL '0 19:30:00' DAY TO SECOND, 'Completada', '20.817.865-2', '23.142.824-0', 17);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (18, TO_DATE('2026-05-22','YYYY-MM-DD'), INTERVAL '0 07:45:00' DAY TO SECOND, 'Completada', '21.810.749-4', '19.606.110-K', 18);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (19, TO_DATE('2026-09-19','YYYY-MM-DD'), INTERVAL '0 07:00:00' DAY TO SECOND, 'Agendada', '22.019.455-8', '19.190.751-5', 19);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (20, TO_DATE('2026-09-06','YYYY-MM-DD'), INTERVAL '0 15:45:00' DAY TO SECOND, 'Completada', '19.687.556-5', '24.133.155-5', 20);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (21, TO_DATE('2026-08-18','YYYY-MM-DD'), INTERVAL '0 08:30:00' DAY TO SECOND, 'Completada', '15.184.138-4', '22.256.410-7', 21);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (22, TO_DATE('2026-09-19','YYYY-MM-DD'), INTERVAL '0 08:45:00' DAY TO SECOND, 'Agendada', '10.415.056-K', '23.028.725-2', 22);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (23, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 15:00:00' DAY TO SECOND, 'Completada', '24.223.627-0', '22.886.836-1', 23);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (24, TO_DATE('2026-07-12','YYYY-MM-DD'), INTERVAL '0 20:00:00' DAY TO SECOND, 'Completada', '21.926.290-6', '18.236.009-0', 24);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (25, TO_DATE('2026-07-30','YYYY-MM-DD'), INTERVAL '0 10:15:00' DAY TO SECOND, 'Completada', '16.188.185-6', '22.600.124-7', 25);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (26, TO_DATE('2026-08-23','YYYY-MM-DD'), INTERVAL '0 18:15:00' DAY TO SECOND, 'Completada', '16.099.226-3', '22.970.008-1', 26);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (27, TO_DATE('2025-07-23','YYYY-MM-DD'), INTERVAL '0 12:15:00' DAY TO SECOND, 'Completada', '17.735.513-5', '19.840.186-2', 27);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (28, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 13:30:00' DAY TO SECOND, 'Completada', '17.083.634-0', '17.400.346-7', 28);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (29, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 18:45:00' DAY TO SECOND, 'Completada', '11.521.428-4', '14.025.425-8', 29);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (30, TO_DATE('2026-08-22','YYYY-MM-DD'), INTERVAL '0 18:15:00' DAY TO SECOND, 'Completada', '16.690.306-8', '10.042.527-0', 30);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (31, TO_DATE('2026-09-13','YYYY-MM-DD'), INTERVAL '0 14:15:00' DAY TO SECOND, 'Completada', '24.947.974-8', '20.304.637-5', 31);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (32, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 14:45:00' DAY TO SECOND, 'Agendada', '19.826.714-7', '11.354.318-3', 32);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (33, TO_DATE('2026-06-25','YYYY-MM-DD'), INTERVAL '0 18:00:00' DAY TO SECOND, 'Completada', '19.302.111-5', '11.857.850-3', 33);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (34, TO_DATE('2026-09-04','YYYY-MM-DD'), INTERVAL '0 17:15:00' DAY TO SECOND, 'Completada', '18.362.688-4', '14.819.091-7', 34);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (35, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 20:45:00' DAY TO SECOND, 'Completada', '24.549.625-7', '23.702.981-K', 35);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (36, TO_DATE('2026-03-13','YYYY-MM-DD'), INTERVAL '0 17:00:00' DAY TO SECOND, 'Completada', '11.953.672-3', '11.645.033-K', 36);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (37, TO_DATE('2026-06-27','YYYY-MM-DD'), INTERVAL '0 09:00:00' DAY TO SECOND, 'Completada', '17.137.754-4', '17.543.956-0', 37);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (38, TO_DATE('2026-08-04','YYYY-MM-DD'), INTERVAL '0 12:45:00' DAY TO SECOND, 'Completada', '18.495.290-4', '10.192.750-4', 38);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (39, TO_DATE('2026-08-26','YYYY-MM-DD'), INTERVAL '0 07:45:00' DAY TO SECOND, 'Completada', '23.464.542-0', '23.669.449-6', 39);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (40, TO_DATE('2026-09-01','YYYY-MM-DD'), INTERVAL '0 07:00:00' DAY TO SECOND, 'Completada', '22.585.374-6', '24.947.890-3', 40);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (41, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 10:45:00' DAY TO SECOND, 'Completada', '24.541.731-4', '21.495.380-3', 41);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (42, TO_DATE('2026-08-16','YYYY-MM-DD'), INTERVAL '0 19:45:00' DAY TO SECOND, 'Completada', '20.069.101-6', '18.225.646-3', 42);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (43, TO_DATE('2026-09-06','YYYY-MM-DD'), INTERVAL '0 12:15:00' DAY TO SECOND, 'Completada', '24.687.336-4', '21.398.255-9', 43);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (44, TO_DATE('2026-08-01','YYYY-MM-DD'), INTERVAL '0 11:15:00' DAY TO SECOND, 'Completada', '18.238.128-4', '15.271.957-4', 44);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (45, TO_DATE('2026-06-18','YYYY-MM-DD'), INTERVAL '0 09:45:00' DAY TO SECOND, 'Completada', '16.679.821-3', '13.526.984-0', 45);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (46, TO_DATE('2026-01-04','YYYY-MM-DD'), INTERVAL '0 11:45:00' DAY TO SECOND, 'Completada', '25.380.590-0', '16.664.202-7', 46);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (47, TO_DATE('2026-08-15','YYYY-MM-DD'), INTERVAL '0 20:30:00' DAY TO SECOND, 'Completada', '18.802.211-1', '14.219.689-1', 47);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (48, TO_DATE('2026-07-29','YYYY-MM-DD'), INTERVAL '0 07:00:00' DAY TO SECOND, 'Completada', '14.339.316-K', '15.832.730-9', 48);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (49, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 18:30:00' DAY TO SECOND, 'Completada', '24.167.984-5', '25.591.357-3', 49);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (50, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 18:00:00' DAY TO SECOND, 'Completada', '17.045.862-1', '15.983.360-7', 50);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (51, TO_DATE('2026-09-04','YYYY-MM-DD'), INTERVAL '0 16:15:00' DAY TO SECOND, 'Completada', '27.000.969-7', '26.000.867-6', 51);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (52, TO_DATE('2026-09-11','YYYY-MM-DD'), INTERVAL '0 20:00:00' DAY TO SECOND, 'Completada', '27.000.988-3', '26.000.884-6', 52);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (53, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 09:45:00' DAY TO SECOND, 'Completada', '27.001.007-5', '26.000.901-K', 53);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (54, TO_DATE('2026-09-15','YYYY-MM-DD'), INTERVAL '0 13:30:00' DAY TO SECOND, 'Completada', '27.001.026-1', '26.000.918-4', 54);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (55, TO_DATE('2026-08-27','YYYY-MM-DD'), INTERVAL '0 17:15:00' DAY TO SECOND, 'Completada', '27.001.045-8', '26.000.935-4', 55);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (56, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 07:00:00' DAY TO SECOND, 'Completada', '27.001.064-4', '26.000.952-4', 56);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (57, TO_DATE('2026-07-02','YYYY-MM-DD'), INTERVAL '0 10:45:00' DAY TO SECOND, 'Completada', '27.001.083-0', '26.000.969-9', 57);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (58, TO_DATE('2026-09-02','YYYY-MM-DD'), INTERVAL '0 14:30:00' DAY TO SECOND, 'Completada', '27.001.102-0', '26.000.986-9', 58);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (59, TO_DATE('2026-09-16','YYYY-MM-DD'), INTERVAL '0 18:15:00' DAY TO SECOND, 'Completada', '27.001.121-7', '26.001.003-4', 59);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (60, TO_DATE('2026-09-04','YYYY-MM-DD'), INTERVAL '0 08:00:00' DAY TO SECOND, 'Completada', '27.001.140-3', '26.001.020-4', 60);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (61, TO_DATE('2026-09-16','YYYY-MM-DD'), INTERVAL '0 11:45:00' DAY TO SECOND, 'Completada', '27.001.159-4', '26.001.037-9', 61);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (62, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 15:30:00' DAY TO SECOND, 'Completada', '27.001.178-0', '26.001.054-9', 62);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (63, TO_DATE('2026-09-12','YYYY-MM-DD'), INTERVAL '0 19:15:00' DAY TO SECOND, 'Completada', '27.001.197-7', '26.001.071-9', 63);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (64, TO_DATE('2026-08-24','YYYY-MM-DD'), INTERVAL '0 09:00:00' DAY TO SECOND, 'Completada', '27.001.216-7', '26.001.088-3', 64);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (65, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 12:45:00' DAY TO SECOND, 'Agendada', '27.001.235-3', '26.001.105-7', 65);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (66, TO_DATE('2026-08-16','YYYY-MM-DD'), INTERVAL '0 16:30:00' DAY TO SECOND, 'Completada', '27.001.254-K', '26.001.122-7', 66);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (67, TO_DATE('2026-02-14','YYYY-MM-DD'), INTERVAL '0 20:15:00' DAY TO SECOND, 'Completada', '27.001.273-6', '26.001.139-1', 67);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (68, TO_DATE('2026-03-15','YYYY-MM-DD'), INTERVAL '0 10:00:00' DAY TO SECOND, 'Completada', '27.001.292-2', '26.001.156-1', 68);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (69, TO_DATE('2026-09-10','YYYY-MM-DD'), INTERVAL '0 13:45:00' DAY TO SECOND, 'Completada', '27.001.311-2', '26.001.173-1', 69);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (70, TO_DATE('2026-09-18','YYYY-MM-DD'), INTERVAL '0 17:30:00' DAY TO SECOND, 'Agendada', '27.001.330-9', '26.001.190-1', 70);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (71, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 07:15:00' DAY TO SECOND, 'Completada', '27.001.349-K', '26.001.207-K', 71);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (72, TO_DATE('2026-08-29','YYYY-MM-DD'), INTERVAL '0 11:00:00' DAY TO SECOND, 'Completada', '27.001.368-6', '26.001.224-K', 72);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (73, TO_DATE('2026-09-12','YYYY-MM-DD'), INTERVAL '0 14:45:00' DAY TO SECOND, 'Completada', '27.001.387-2', '26.001.241-K', 73);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (74, TO_DATE('2026-08-11','YYYY-MM-DD'), INTERVAL '0 18:30:00' DAY TO SECOND, 'Completada', '27.001.406-2', '26.001.258-4', 74);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (75, TO_DATE('2026-09-02','YYYY-MM-DD'), INTERVAL '0 08:15:00' DAY TO SECOND, 'Completada', '27.001.425-9', '26.001.275-4', 75);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (76, TO_DATE('2026-08-24','YYYY-MM-DD'), INTERVAL '0 12:00:00' DAY TO SECOND, 'Completada', '27.001.444-5', '26.001.292-4', 76);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (77, TO_DATE('2026-04-11','YYYY-MM-DD'), INTERVAL '0 15:45:00' DAY TO SECOND, 'Completada', '27.001.463-1', '26.001.309-2', 77);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (78, TO_DATE('2026-05-21','YYYY-MM-DD'), INTERVAL '0 19:30:00' DAY TO SECOND, 'Completada', '27.001.482-8', '26.001.326-2', 78);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (79, TO_DATE('2026-08-21','YYYY-MM-DD'), INTERVAL '0 09:15:00' DAY TO SECOND, 'Completada', '27.001.501-8', '26.001.343-2', 79);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (80, TO_DATE('2026-09-11','YYYY-MM-DD'), INTERVAL '0 13:00:00' DAY TO SECOND, 'Completada', '27.001.520-4', '26.001.360-2', 80);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (81, TO_DATE('2026-08-31','YYYY-MM-DD'), INTERVAL '0 16:45:00' DAY TO SECOND, 'Completada', '27.001.539-5', '26.001.377-7', 81);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (82, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 20:30:00' DAY TO SECOND, 'Completada', '27.001.558-1', '26.001.394-7', 82);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (83, TO_DATE('2026-09-02','YYYY-MM-DD'), INTERVAL '0 10:15:00' DAY TO SECOND, 'Completada', '27.001.577-8', '26.001.411-0', 83);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (84, TO_DATE('2026-09-15','YYYY-MM-DD'), INTERVAL '0 14:00:00' DAY TO SECOND, 'Completada', '27.001.596-4', '26.001.428-5', 84);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (85, TO_DATE('2026-08-03','YYYY-MM-DD'), INTERVAL '0 17:45:00' DAY TO SECOND, 'Completada', '27.001.615-4', '26.001.445-5', 85);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (86, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 07:30:00' DAY TO SECOND, 'Completada', '27.001.634-0', '26.001.462-5', 86);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (87, TO_DATE('2026-09-10','YYYY-MM-DD'), INTERVAL '0 11:15:00' DAY TO SECOND, 'Completada', '27.001.653-7', '26.001.479-K', 87);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (88, TO_DATE('2026-07-21','YYYY-MM-DD'), INTERVAL '0 15:00:00' DAY TO SECOND, 'Completada', '27.001.672-3', '26.001.496-K', 88);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (89, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 18:45:00' DAY TO SECOND, 'Agendada', '27.001.691-K', '26.001.513-3', 89);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (90, TO_DATE('2026-09-01','YYYY-MM-DD'), INTERVAL '0 08:30:00' DAY TO SECOND, 'Completada', '27.001.710-K', '26.001.530-3', 90);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (91, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 12:15:00' DAY TO SECOND, 'Completada', '27.001.729-0', '26.001.547-8', 91);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (92, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 16:00:00' DAY TO SECOND, 'Completada', '27.001.748-7', '26.001.564-8', 92);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (93, TO_DATE('2026-09-16','YYYY-MM-DD'), INTERVAL '0 19:45:00' DAY TO SECOND, 'Completada', '27.001.767-3', '26.001.581-8', 93);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (94, TO_DATE('2026-08-08','YYYY-MM-DD'), INTERVAL '0 09:30:00' DAY TO SECOND, 'Completada', '27.001.786-K', '26.001.598-2', 94);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (95, TO_DATE('2026-09-16','YYYY-MM-DD'), INTERVAL '0 13:15:00' DAY TO SECOND, 'Completada', '27.001.805-K', '26.001.615-6', 95);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (96, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 17:00:00' DAY TO SECOND, 'Completada', '27.001.824-6', '26.001.632-6', 96);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (97, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 20:45:00' DAY TO SECOND, 'Completada', '27.001.843-2', '26.001.649-0', 97);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (98, TO_DATE('2026-08-16','YYYY-MM-DD'), INTERVAL '0 10:30:00' DAY TO SECOND, 'Completada', '27.001.862-9', '26.001.666-0', 98);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (99, TO_DATE('2026-09-01','YYYY-MM-DD'), INTERVAL '0 14:15:00' DAY TO SECOND, 'Completada', '27.001.881-5', '26.001.683-0', 99);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (100, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 18:00:00' DAY TO SECOND, 'Completada', '27.001.900-5', '26.001.700-4', 100);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (101, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 07:45:00' DAY TO SECOND, 'Completada', '27.001.919-6', '26.001.717-9', 101);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (102, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 11:30:00' DAY TO SECOND, 'Agendada', '27.001.938-2', '26.001.734-9', 102);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (103, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 15:15:00' DAY TO SECOND, 'Completada', '27.001.957-9', '26.001.751-9', 103);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (104, TO_DATE('2026-09-07','YYYY-MM-DD'), INTERVAL '0 19:00:00' DAY TO SECOND, 'Completada', '27.001.976-5', '26.001.768-3', 104);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (105, TO_DATE('2026-08-31','YYYY-MM-DD'), INTERVAL '0 08:45:00' DAY TO SECOND, 'Completada', '27.001.995-1', '26.001.785-3', 105);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (106, TO_DATE('2026-07-25','YYYY-MM-DD'), INTERVAL '0 12:30:00' DAY TO SECOND, 'Completada', '27.002.014-3', '26.001.802-7', 106);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (107, TO_DATE('2026-08-15','YYYY-MM-DD'), INTERVAL '0 16:15:00' DAY TO SECOND, 'Completada', '27.002.033-K', '26.001.819-1', 107);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (108, TO_DATE('2026-01-16','YYYY-MM-DD'), INTERVAL '0 20:00:00' DAY TO SECOND, 'Completada', '27.002.052-6', '26.001.836-1', 108);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (109, TO_DATE('2026-07-16','YYYY-MM-DD'), INTERVAL '0 09:45:00' DAY TO SECOND, 'Completada', '27.002.071-2', '26.001.853-1', 109);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (110, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 13:30:00' DAY TO SECOND, 'Completada', '27.002.090-9', '26.001.870-1', 110);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (111, TO_DATE('2026-09-18','YYYY-MM-DD'), INTERVAL '0 17:15:00' DAY TO SECOND, 'Agendada', '27.002.109-3', '26.001.887-6', 111);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (112, TO_DATE('2026-08-31','YYYY-MM-DD'), INTERVAL '0 07:00:00' DAY TO SECOND, 'Completada', '27.002.128-K', '26.001.904-K', 112);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (113, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 10:45:00' DAY TO SECOND, 'Agendada', '27.002.147-6', '26.001.921-K', 113);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (114, TO_DATE('2026-09-07','YYYY-MM-DD'), INTERVAL '0 14:30:00' DAY TO SECOND, 'Completada', '27.002.166-2', '26.001.938-4', 114);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (115, TO_DATE('2026-09-10','YYYY-MM-DD'), INTERVAL '0 18:15:00' DAY TO SECOND, 'Completada', '27.002.185-9', '26.001.955-4', 115);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (116, TO_DATE('2026-07-13','YYYY-MM-DD'), INTERVAL '0 08:00:00' DAY TO SECOND, 'Completada', '27.002.204-9', '26.001.972-4', 116);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (117, TO_DATE('2026-06-20','YYYY-MM-DD'), INTERVAL '0 11:45:00' DAY TO SECOND, 'Completada', '27.002.223-5', '26.001.989-9', 117);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (118, TO_DATE('2026-09-01','YYYY-MM-DD'), INTERVAL '0 15:30:00' DAY TO SECOND, 'Completada', '27.002.242-1', '26.002.006-4', 118);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (119, TO_DATE('2026-08-15','YYYY-MM-DD'), INTERVAL '0 19:15:00' DAY TO SECOND, 'Completada', '27.002.261-8', '26.002.023-4', 119);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (120, TO_DATE('2026-08-24','YYYY-MM-DD'), INTERVAL '0 09:00:00' DAY TO SECOND, 'Completada', '27.002.280-4', '26.002.040-4', 120);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (121, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 12:45:00' DAY TO SECOND, 'Completada', '27.002.299-5', '26.002.057-9', 121);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (122, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 16:30:00' DAY TO SECOND, 'Agendada', '27.002.318-5', '26.002.074-9', 122);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (123, TO_DATE('2026-09-02','YYYY-MM-DD'), INTERVAL '0 20:15:00' DAY TO SECOND, 'Completada', '27.002.337-1', '26.002.091-9', 123);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (124, TO_DATE('2026-09-09','YYYY-MM-DD'), INTERVAL '0 10:00:00' DAY TO SECOND, 'Completada', '27.002.356-8', '26.002.108-7', 124);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (125, TO_DATE('2026-08-03','YYYY-MM-DD'), INTERVAL '0 13:45:00' DAY TO SECOND, 'Completada', '27.002.375-4', '26.002.125-7', 125);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (126, TO_DATE('2026-09-15','YYYY-MM-DD'), INTERVAL '0 17:30:00' DAY TO SECOND, 'Completada', '27.002.394-0', '26.002.142-7', 126);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (127, TO_DATE('2026-08-17','YYYY-MM-DD'), INTERVAL '0 07:15:00' DAY TO SECOND, 'Completada', '27.002.413-0', '26.002.159-1', 127);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (128, TO_DATE('2026-09-18','YYYY-MM-DD'), INTERVAL '0 11:00:00' DAY TO SECOND, 'Agendada', '27.002.432-7', '26.002.176-1', 128);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (129, TO_DATE('2026-08-31','YYYY-MM-DD'), INTERVAL '0 14:45:00' DAY TO SECOND, 'Completada', '27.002.451-3', '26.002.193-1', 129);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (130, TO_DATE('2026-09-13','YYYY-MM-DD'), INTERVAL '0 18:30:00' DAY TO SECOND, 'Completada', '27.002.470-K', '26.002.210-5', 130);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (131, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 08:15:00' DAY TO SECOND, 'Completada', '27.002.489-0', '26.002.227-K', 131);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (132, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 12:00:00' DAY TO SECOND, 'Completada', '27.002.508-0', '26.002.244-K', 132);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (133, TO_DATE('2026-09-16','YYYY-MM-DD'), INTERVAL '0 15:45:00' DAY TO SECOND, 'Completada', '27.002.527-7', '26.002.261-K', 133);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (134, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 19:30:00' DAY TO SECOND, 'Completada', '27.002.546-3', '26.002.278-4', 134);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (135, TO_DATE('2026-08-09','YYYY-MM-DD'), INTERVAL '0 09:15:00' DAY TO SECOND, 'Completada', '27.002.565-K', '26.002.295-4', 135);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (136, TO_DATE('2026-06-25','YYYY-MM-DD'), INTERVAL '0 13:00:00' DAY TO SECOND, 'Completada', '27.002.584-6', '26.002.312-8', 136);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (137, TO_DATE('2026-03-04','YYYY-MM-DD'), INTERVAL '0 16:45:00' DAY TO SECOND, 'Completada', '27.002.603-6', '26.002.329-2', 137);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (138, TO_DATE('2026-04-24','YYYY-MM-DD'), INTERVAL '0 20:30:00' DAY TO SECOND, 'Completada', '27.002.622-2', '26.002.346-2', 138);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (139, TO_DATE('2026-09-18','YYYY-MM-DD'), INTERVAL '0 10:15:00' DAY TO SECOND, 'Agendada', '27.002.641-9', '26.002.363-2', 139);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (140, TO_DATE('2026-09-02','YYYY-MM-DD'), INTERVAL '0 14:00:00' DAY TO SECOND, 'Completada', '27.002.660-5', '26.002.380-2', 140);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (141, TO_DATE('2026-09-16','YYYY-MM-DD'), INTERVAL '0 17:45:00' DAY TO SECOND, 'Completada', '27.002.679-6', '26.002.397-7', 141);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (142, TO_DATE('2026-08-31','YYYY-MM-DD'), INTERVAL '0 07:30:00' DAY TO SECOND, 'Completada', '27.002.698-2', '26.002.414-0', 142);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (143, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 11:15:00' DAY TO SECOND, 'Completada', '27.002.717-2', '26.002.431-0', 143);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (144, TO_DATE('2026-09-03','YYYY-MM-DD'), INTERVAL '0 15:00:00' DAY TO SECOND, 'Completada', '27.002.736-9', '26.002.448-5', 144);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (145, TO_DATE('2026-09-10','YYYY-MM-DD'), INTERVAL '0 18:45:00' DAY TO SECOND, 'Completada', '27.002.755-5', '26.002.465-5', 145);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (146, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 08:30:00' DAY TO SECOND, 'Completada', '27.002.774-1', '26.002.482-5', 146);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (147, TO_DATE('2026-08-01','YYYY-MM-DD'), INTERVAL '0 12:15:00' DAY TO SECOND, 'Completada', '27.002.793-8', '26.002.499-K', 147);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (148, TO_DATE('2026-04-27','YYYY-MM-DD'), INTERVAL '0 16:00:00' DAY TO SECOND, 'Completada', '27.002.812-8', '26.002.516-3', 148);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (149, TO_DATE('2026-08-07','YYYY-MM-DD'), INTERVAL '0 19:45:00' DAY TO SECOND, 'Completada', '27.002.831-4', '26.002.533-3', 149);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (150, TO_DATE('2026-09-18','YYYY-MM-DD'), INTERVAL '0 09:30:00' DAY TO SECOND, 'Agendada', '27.002.850-0', '26.002.550-3', 150);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (151, TO_DATE('2026-09-12','YYYY-MM-DD'), INTERVAL '0 13:15:00' DAY TO SECOND, 'Completada', '27.002.869-1', '26.002.567-8', 151);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (152, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 17:00:00' DAY TO SECOND, 'Agendada', '27.002.888-8', '26.002.584-8', 152);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (153, TO_DATE('2026-03-26','YYYY-MM-DD'), INTERVAL '0 20:45:00' DAY TO SECOND, 'Completada', '27.002.907-8', '26.002.601-1', 153);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (154, TO_DATE('2026-03-26','YYYY-MM-DD'), INTERVAL '0 10:30:00' DAY TO SECOND, 'Completada', '27.002.926-4', '26.002.618-6', 154);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (155, TO_DATE('2026-04-13','YYYY-MM-DD'), INTERVAL '0 14:15:00' DAY TO SECOND, 'Completada', '27.002.945-0', '26.002.635-6', 155);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (156, TO_DATE('2026-04-25','YYYY-MM-DD'), INTERVAL '0 18:00:00' DAY TO SECOND, 'Completada', '27.002.964-7', '26.002.652-6', 156);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (157, TO_DATE('2025-05-14','YYYY-MM-DD'), INTERVAL '0 07:45:00' DAY TO SECOND, 'Completada', '27.002.983-3', '26.002.669-0', 157);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (158, TO_DATE('2025-06-01','YYYY-MM-DD'), INTERVAL '0 11:30:00' DAY TO SECOND, 'Completada', '27.003.002-5', '26.002.686-0', 158);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (159, TO_DATE('2026-06-02','YYYY-MM-DD'), INTERVAL '0 15:15:00' DAY TO SECOND, 'Completada', '27.003.021-1', '26.002.703-4', 159);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (160, TO_DATE('2026-05-15','YYYY-MM-DD'), INTERVAL '0 19:00:00' DAY TO SECOND, 'Completada', '27.003.040-8', '26.002.720-4', 160);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (161, TO_DATE('2026-06-02','YYYY-MM-DD'), INTERVAL '0 08:45:00' DAY TO SECOND, 'Completada', '27.003.059-9', '26.002.737-9', 161);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (162, TO_DATE('2026-06-24','YYYY-MM-DD'), INTERVAL '0 12:30:00' DAY TO SECOND, 'Completada', '27.003.078-5', '26.002.754-9', 162);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (163, TO_DATE('2026-07-12','YYYY-MM-DD'), INTERVAL '0 16:15:00' DAY TO SECOND, 'Completada', '27.003.097-1', '26.002.771-9', 163);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (164, TO_DATE('2026-06-11','YYYY-MM-DD'), INTERVAL '0 20:00:00' DAY TO SECOND, 'Completada', '27.003.116-1', '26.002.788-3', 164);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (165, TO_DATE('2026-06-17','YYYY-MM-DD'), INTERVAL '0 09:45:00' DAY TO SECOND, 'Completada', '27.003.135-8', '26.002.805-7', 165);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (166, TO_DATE('2026-04-28','YYYY-MM-DD'), INTERVAL '0 13:30:00' DAY TO SECOND, 'Completada', '27.003.154-4', '26.002.822-7', 166);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (167, TO_DATE('2025-11-10','YYYY-MM-DD'), INTERVAL '0 17:15:00' DAY TO SECOND, 'Completada', '27.003.173-0', '26.002.839-1', 167);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (168, TO_DATE('2025-04-11','YYYY-MM-DD'), INTERVAL '0 07:00:00' DAY TO SECOND, 'Completada', '27.003.192-7', '26.002.856-1', 168);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (169, TO_DATE('2026-01-09','YYYY-MM-DD'), INTERVAL '0 10:45:00' DAY TO SECOND, 'Completada', '27.003.211-7', '26.002.873-1', 169);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (170, TO_DATE('2026-01-20','YYYY-MM-DD'), INTERVAL '0 14:30:00' DAY TO SECOND, 'Completada', '27.003.230-3', '26.002.890-1', 170);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (171, TO_DATE('2026-02-07','YYYY-MM-DD'), INTERVAL '0 18:15:00' DAY TO SECOND, 'Completada', '27.003.249-4', '26.002.907-K', 171);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (172, TO_DATE('2026-02-20','YYYY-MM-DD'), INTERVAL '0 08:00:00' DAY TO SECOND, 'Completada', '27.003.268-0', '26.002.924-K', 172);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (173, TO_DATE('2026-03-10','YYYY-MM-DD'), INTERVAL '0 11:45:00' DAY TO SECOND, 'Completada', '27.003.287-7', '26.002.941-K', 173);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (174, TO_DATE('2026-02-01','YYYY-MM-DD'), INTERVAL '0 15:30:00' DAY TO SECOND, 'Completada', '27.003.306-7', '26.002.958-4', 174);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (175, TO_DATE('2026-02-19','YYYY-MM-DD'), INTERVAL '0 19:15:00' DAY TO SECOND, 'Completada', '27.003.325-3', '26.002.975-4', 175);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (176, TO_DATE('2026-03-02','YYYY-MM-DD'), INTERVAL '0 09:00:00' DAY TO SECOND, 'Completada', '27.003.344-K', '26.002.992-4', 176);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (177, TO_DATE('2025-09-20','YYYY-MM-DD'), INTERVAL '0 12:45:00' DAY TO SECOND, 'Completada', '27.003.363-6', '26.003.009-4', 177);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (178, TO_DATE('2025-10-08','YYYY-MM-DD'), INTERVAL '0 16:30:00' DAY TO SECOND, 'Completada', '27.003.382-2', '26.003.026-4', 178);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (179, TO_DATE('2026-05-15','YYYY-MM-DD'), INTERVAL '0 20:15:00' DAY TO SECOND, 'Completada', '27.003.401-2', '26.003.043-4', 179);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (180, TO_DATE('2026-05-16','YYYY-MM-DD'), INTERVAL '0 10:00:00' DAY TO SECOND, 'Completada', '27.003.420-9', '26.003.060-4', 180);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (181, TO_DATE('2026-06-03','YYYY-MM-DD'), INTERVAL '0 13:45:00' DAY TO SECOND, 'Completada', '27.003.439-K', '26.003.077-9', 181);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (182, TO_DATE('2026-06-21','YYYY-MM-DD'), INTERVAL '0 17:30:00' DAY TO SECOND, 'Completada', '27.003.458-6', '26.003.094-9', 182);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (183, TO_DATE('2026-06-16','YYYY-MM-DD'), INTERVAL '0 07:15:00' DAY TO SECOND, 'Completada', '27.003.477-2', '26.003.111-2', 183);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (184, TO_DATE('2026-04-17','YYYY-MM-DD'), INTERVAL '0 11:00:00' DAY TO SECOND, 'Completada', '27.003.496-9', '26.003.128-7', 184);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (185, TO_DATE('2026-05-05','YYYY-MM-DD'), INTERVAL '0 14:45:00' DAY TO SECOND, 'Completada', '27.003.515-9', '26.003.145-7', 185);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (186, TO_DATE('2026-03-06','YYYY-MM-DD'), INTERVAL '0 18:30:00' DAY TO SECOND, 'Completada', '27.003.534-5', '26.003.162-7', 186);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (187, TO_DATE('2026-03-19','YYYY-MM-DD'), INTERVAL '0 08:15:00' DAY TO SECOND, 'Completada', '27.003.553-1', '26.003.179-1', 187);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (188, TO_DATE('2026-04-06','YYYY-MM-DD'), INTERVAL '0 12:00:00' DAY TO SECOND, 'Completada', '27.003.572-8', '26.003.196-1', 188);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (189, TO_DATE('2025-11-13','YYYY-MM-DD'), INTERVAL '0 15:45:00' DAY TO SECOND, 'Completada', '27.003.591-4', '26.003.213-5', 189);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (190, TO_DATE('2026-01-21','YYYY-MM-DD'), INTERVAL '0 19:30:00' DAY TO SECOND, 'Completada', '27.003.610-4', '26.003.230-5', 190);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (191, TO_DATE('2026-02-08','YYYY-MM-DD'), INTERVAL '0 09:15:00' DAY TO SECOND, 'Completada', '27.003.629-5', '26.003.247-K', 191);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (192, TO_DATE('2026-01-25','YYYY-MM-DD'), INTERVAL '0 13:00:00' DAY TO SECOND, 'Completada', '27.003.648-1', '26.003.264-K', 192);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (193, TO_DATE('2026-02-22','YYYY-MM-DD'), INTERVAL '0 16:45:00' DAY TO SECOND, 'Completada', '27.003.667-8', '26.003.281-K', 193);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (194, TO_DATE('2026-03-11','YYYY-MM-DD'), INTERVAL '0 20:30:00' DAY TO SECOND, 'Completada', '27.003.686-4', '26.003.298-4', 194);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (195, TO_DATE('2025-12-28','YYYY-MM-DD'), INTERVAL '0 10:15:00' DAY TO SECOND, 'Completada', '27.003.705-4', '26.003.315-8', 195);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (196, TO_DATE('2026-01-07','YYYY-MM-DD'), INTERVAL '0 14:00:00' DAY TO SECOND, 'Completada', '27.003.724-0', '26.003.332-8', 196);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (197, TO_DATE('2026-01-27','YYYY-MM-DD'), INTERVAL '0 17:45:00' DAY TO SECOND, 'Completada', '27.003.743-7', '26.003.349-2', 197);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (198, TO_DATE('2026-02-14','YYYY-MM-DD'), INTERVAL '0 07:30:00' DAY TO SECOND, 'Completada', '27.003.762-3', '26.003.366-2', 198);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (199, TO_DATE('2026-03-25','YYYY-MM-DD'), INTERVAL '0 11:15:00' DAY TO SECOND, 'Completada', '27.003.781-K', '26.003.383-2', 199);
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente, CONTRATO_CLI_id_contrato) VALUES (200, TO_DATE('2026-04-28','YYYY-MM-DD'), INTERVAL '0 15:00:00' DAY TO SECOND, 'Completada', '27.003.800-K', '26.003.400-6', 200);

-- BLOQUE_HORARIO: 200 registros
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (1, 'Viernes', INTERVAL '0 16:45:00' DAY TO SECOND, 1, TO_DATE('2026-09-04','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (2, 'Domingo', INTERVAL '0 15:00:00' DAY TO SECOND, 2, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (3, 'Jueves', INTERVAL '0 09:30:00' DAY TO SECOND, 3, TO_DATE('2026-04-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (4, 'Miércoles', INTERVAL '0 17:15:00' DAY TO SECOND, 4, TO_DATE('2026-08-19','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (5, 'Viernes', INTERVAL '0 13:30:00' DAY TO SECOND, 5, TO_DATE('2026-08-21','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (6, 'Domingo', INTERVAL '0 10:45:00' DAY TO SECOND, 6, TO_DATE('2024-12-15','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (7, 'Domingo', INTERVAL '0 09:15:00' DAY TO SECOND, 7, TO_DATE('2026-08-09','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (8, 'Viernes', INTERVAL '0 16:00:00' DAY TO SECOND, 8, TO_DATE('2026-08-28','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (9, 'Lunes', INTERVAL '0 17:15:00' DAY TO SECOND, 9, TO_DATE('2026-08-24','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (10, 'Martes', INTERVAL '0 07:15:00' DAY TO SECOND, 10, TO_DATE('2026-09-15','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (11, 'Jueves', INTERVAL '0 11:15:00' DAY TO SECOND, 11, TO_DATE('2026-09-10','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (12, 'Sábado', INTERVAL '0 17:15:00' DAY TO SECOND, 12, TO_DATE('2026-08-15','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (13, 'Miércoles', INTERVAL '0 11:15:00' DAY TO SECOND, 13, TO_DATE('2026-08-26','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (14, 'Lunes', INTERVAL '0 13:15:00' DAY TO SECOND, 14, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (15, 'Viernes', INTERVAL '0 15:15:00' DAY TO SECOND, 15, TO_DATE('2026-02-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (16, 'Jueves', INTERVAL '0 18:00:00' DAY TO SECOND, 16, TO_DATE('2026-07-30','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (17, 'Jueves', INTERVAL '0 19:30:00' DAY TO SECOND, 17, TO_DATE('2026-08-27','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (18, 'Viernes', INTERVAL '0 07:45:00' DAY TO SECOND, 18, TO_DATE('2026-05-22','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (19, 'Sábado', INTERVAL '0 07:00:00' DAY TO SECOND, 19, TO_DATE('2026-09-19','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (20, 'Domingo', INTERVAL '0 15:45:00' DAY TO SECOND, 20, TO_DATE('2026-09-06','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (21, 'Martes', INTERVAL '0 08:30:00' DAY TO SECOND, 21, TO_DATE('2026-08-18','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (22, 'Sábado', INTERVAL '0 08:45:00' DAY TO SECOND, 22, TO_DATE('2026-09-19','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (23, 'Lunes', INTERVAL '0 15:00:00' DAY TO SECOND, 23, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (24, 'Domingo', INTERVAL '0 20:00:00' DAY TO SECOND, 24, TO_DATE('2026-07-12','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (25, 'Jueves', INTERVAL '0 10:15:00' DAY TO SECOND, 25, TO_DATE('2026-07-30','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (26, 'Domingo', INTERVAL '0 18:15:00' DAY TO SECOND, 26, TO_DATE('2026-08-23','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (27, 'Miércoles', INTERVAL '0 12:15:00' DAY TO SECOND, 27, TO_DATE('2025-07-23','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (28, 'Jueves', INTERVAL '0 13:30:00' DAY TO SECOND, 28, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (29, 'Martes', INTERVAL '0 18:45:00' DAY TO SECOND, 29, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (30, 'Sábado', INTERVAL '0 18:15:00' DAY TO SECOND, 30, TO_DATE('2026-08-22','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (31, 'Domingo', INTERVAL '0 14:15:00' DAY TO SECOND, 31, TO_DATE('2026-09-13','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (32, 'Domingo', INTERVAL '0 14:45:00' DAY TO SECOND, 32, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (33, 'Jueves', INTERVAL '0 18:00:00' DAY TO SECOND, 33, TO_DATE('2026-06-25','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (34, 'Viernes', INTERVAL '0 17:15:00' DAY TO SECOND, 34, TO_DATE('2026-09-04','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (35, 'Martes', INTERVAL '0 20:45:00' DAY TO SECOND, 35, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (36, 'Viernes', INTERVAL '0 17:00:00' DAY TO SECOND, 36, TO_DATE('2026-03-13','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (37, 'Sábado', INTERVAL '0 09:00:00' DAY TO SECOND, 37, TO_DATE('2026-06-27','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (38, 'Martes', INTERVAL '0 12:45:00' DAY TO SECOND, 38, TO_DATE('2026-08-04','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (39, 'Miércoles', INTERVAL '0 07:45:00' DAY TO SECOND, 39, TO_DATE('2026-08-26','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (40, 'Martes', INTERVAL '0 07:00:00' DAY TO SECOND, 40, TO_DATE('2026-09-01','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (41, 'Lunes', INTERVAL '0 10:45:00' DAY TO SECOND, 41, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (42, 'Domingo', INTERVAL '0 19:45:00' DAY TO SECOND, 42, TO_DATE('2026-08-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (43, 'Domingo', INTERVAL '0 12:15:00' DAY TO SECOND, 43, TO_DATE('2026-09-06','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (44, 'Sábado', INTERVAL '0 11:15:00' DAY TO SECOND, 44, TO_DATE('2026-08-01','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (45, 'Jueves', INTERVAL '0 09:45:00' DAY TO SECOND, 45, TO_DATE('2026-06-18','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (46, 'Domingo', INTERVAL '0 11:45:00' DAY TO SECOND, 46, TO_DATE('2026-01-04','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (47, 'Sábado', INTERVAL '0 20:30:00' DAY TO SECOND, 47, TO_DATE('2026-08-15','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (48, 'Miércoles', INTERVAL '0 07:00:00' DAY TO SECOND, 48, TO_DATE('2026-07-29','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (49, 'Lunes', INTERVAL '0 18:30:00' DAY TO SECOND, 49, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (50, 'Lunes', INTERVAL '0 18:00:00' DAY TO SECOND, 50, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (51, 'Viernes', INTERVAL '0 16:15:00' DAY TO SECOND, 51, TO_DATE('2026-09-04','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (52, 'Viernes', INTERVAL '0 20:00:00' DAY TO SECOND, 52, TO_DATE('2026-09-11','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (53, 'Martes', INTERVAL '0 09:45:00' DAY TO SECOND, 53, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (54, 'Martes', INTERVAL '0 13:30:00' DAY TO SECOND, 54, TO_DATE('2026-09-15','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (55, 'Jueves', INTERVAL '0 17:15:00' DAY TO SECOND, 55, TO_DATE('2026-08-27','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (56, 'Jueves', INTERVAL '0 07:00:00' DAY TO SECOND, 56, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (57, 'Jueves', INTERVAL '0 10:45:00' DAY TO SECOND, 57, TO_DATE('2026-07-02','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (58, 'Miércoles', INTERVAL '0 14:30:00' DAY TO SECOND, 58, TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (59, 'Miércoles', INTERVAL '0 18:15:00' DAY TO SECOND, 59, TO_DATE('2026-09-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (60, 'Viernes', INTERVAL '0 08:00:00' DAY TO SECOND, 60, TO_DATE('2026-09-04','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (61, 'Miércoles', INTERVAL '0 11:45:00' DAY TO SECOND, 61, TO_DATE('2026-09-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (62, 'Lunes', INTERVAL '0 15:30:00' DAY TO SECOND, 62, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (63, 'Sábado', INTERVAL '0 19:15:00' DAY TO SECOND, 63, TO_DATE('2026-09-12','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (64, 'Lunes', INTERVAL '0 09:00:00' DAY TO SECOND, 64, TO_DATE('2026-08-24','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (65, 'Domingo', INTERVAL '0 12:45:00' DAY TO SECOND, 65, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (66, 'Domingo', INTERVAL '0 16:30:00' DAY TO SECOND, 66, TO_DATE('2026-08-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (67, 'Sábado', INTERVAL '0 20:15:00' DAY TO SECOND, 67, TO_DATE('2026-02-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (68, 'Domingo', INTERVAL '0 10:00:00' DAY TO SECOND, 68, TO_DATE('2026-03-15','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (69, 'Jueves', INTERVAL '0 13:45:00' DAY TO SECOND, 69, TO_DATE('2026-09-10','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (70, 'Viernes', INTERVAL '0 17:30:00' DAY TO SECOND, 70, TO_DATE('2026-09-18','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (71, 'Lunes', INTERVAL '0 07:15:00' DAY TO SECOND, 71, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (72, 'Sábado', INTERVAL '0 11:00:00' DAY TO SECOND, 72, TO_DATE('2026-08-29','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (73, 'Sábado', INTERVAL '0 14:45:00' DAY TO SECOND, 73, TO_DATE('2026-09-12','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (74, 'Martes', INTERVAL '0 18:30:00' DAY TO SECOND, 74, TO_DATE('2026-08-11','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (75, 'Miércoles', INTERVAL '0 08:15:00' DAY TO SECOND, 75, TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (76, 'Lunes', INTERVAL '0 12:00:00' DAY TO SECOND, 76, TO_DATE('2026-08-24','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (77, 'Sábado', INTERVAL '0 15:45:00' DAY TO SECOND, 77, TO_DATE('2026-04-11','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (78, 'Jueves', INTERVAL '0 19:30:00' DAY TO SECOND, 78, TO_DATE('2026-05-21','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (79, 'Viernes', INTERVAL '0 09:15:00' DAY TO SECOND, 79, TO_DATE('2026-08-21','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (80, 'Viernes', INTERVAL '0 13:00:00' DAY TO SECOND, 80, TO_DATE('2026-09-11','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (81, 'Lunes', INTERVAL '0 16:45:00' DAY TO SECOND, 81, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (82, 'Jueves', INTERVAL '0 20:30:00' DAY TO SECOND, 82, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (83, 'Miércoles', INTERVAL '0 10:15:00' DAY TO SECOND, 83, TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (84, 'Martes', INTERVAL '0 14:00:00' DAY TO SECOND, 84, TO_DATE('2026-09-15','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (85, 'Lunes', INTERVAL '0 17:45:00' DAY TO SECOND, 85, TO_DATE('2026-08-03','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (86, 'Martes', INTERVAL '0 07:30:00' DAY TO SECOND, 86, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (87, 'Jueves', INTERVAL '0 11:15:00' DAY TO SECOND, 87, TO_DATE('2026-09-10','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (88, 'Martes', INTERVAL '0 15:00:00' DAY TO SECOND, 88, TO_DATE('2026-07-21','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (89, 'Domingo', INTERVAL '0 18:45:00' DAY TO SECOND, 89, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (90, 'Martes', INTERVAL '0 08:30:00' DAY TO SECOND, 90, TO_DATE('2026-09-01','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (91, 'Lunes', INTERVAL '0 12:15:00' DAY TO SECOND, 91, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (92, 'Jueves', INTERVAL '0 16:00:00' DAY TO SECOND, 92, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (93, 'Miércoles', INTERVAL '0 19:45:00' DAY TO SECOND, 93, TO_DATE('2026-09-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (94, 'Sábado', INTERVAL '0 09:30:00' DAY TO SECOND, 94, TO_DATE('2026-08-08','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (95, 'Miércoles', INTERVAL '0 13:15:00' DAY TO SECOND, 95, TO_DATE('2026-09-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (96, 'Jueves', INTERVAL '0 17:00:00' DAY TO SECOND, 96, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (97, 'Lunes', INTERVAL '0 20:45:00' DAY TO SECOND, 97, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (98, 'Domingo', INTERVAL '0 10:30:00' DAY TO SECOND, 98, TO_DATE('2026-08-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (99, 'Martes', INTERVAL '0 14:15:00' DAY TO SECOND, 99, TO_DATE('2026-09-01','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (100, 'Jueves', INTERVAL '0 18:00:00' DAY TO SECOND, 100, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (101, 'Martes', INTERVAL '0 07:45:00' DAY TO SECOND, 101, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (102, 'Domingo', INTERVAL '0 11:30:00' DAY TO SECOND, 102, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (103, 'Lunes', INTERVAL '0 15:15:00' DAY TO SECOND, 103, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (104, 'Lunes', INTERVAL '0 19:00:00' DAY TO SECOND, 104, TO_DATE('2026-09-07','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (105, 'Lunes', INTERVAL '0 08:45:00' DAY TO SECOND, 105, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (106, 'Sábado', INTERVAL '0 12:30:00' DAY TO SECOND, 106, TO_DATE('2026-07-25','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (107, 'Sábado', INTERVAL '0 16:15:00' DAY TO SECOND, 107, TO_DATE('2026-08-15','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (108, 'Viernes', INTERVAL '0 20:00:00' DAY TO SECOND, 108, TO_DATE('2026-01-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (109, 'Jueves', INTERVAL '0 09:45:00' DAY TO SECOND, 109, TO_DATE('2026-07-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (110, 'Lunes', INTERVAL '0 13:30:00' DAY TO SECOND, 110, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (111, 'Viernes', INTERVAL '0 17:15:00' DAY TO SECOND, 111, TO_DATE('2026-09-18','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (112, 'Lunes', INTERVAL '0 07:00:00' DAY TO SECOND, 112, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (113, 'Domingo', INTERVAL '0 10:45:00' DAY TO SECOND, 113, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (114, 'Lunes', INTERVAL '0 14:30:00' DAY TO SECOND, 114, TO_DATE('2026-09-07','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (115, 'Jueves', INTERVAL '0 18:15:00' DAY TO SECOND, 115, TO_DATE('2026-09-10','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (116, 'Lunes', INTERVAL '0 08:00:00' DAY TO SECOND, 116, TO_DATE('2026-07-13','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (117, 'Sábado', INTERVAL '0 11:45:00' DAY TO SECOND, 117, TO_DATE('2026-06-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (118, 'Martes', INTERVAL '0 15:30:00' DAY TO SECOND, 118, TO_DATE('2026-09-01','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (119, 'Sábado', INTERVAL '0 19:15:00' DAY TO SECOND, 119, TO_DATE('2026-08-15','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (120, 'Lunes', INTERVAL '0 09:00:00' DAY TO SECOND, 120, TO_DATE('2026-08-24','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (121, 'Martes', INTERVAL '0 12:45:00' DAY TO SECOND, 121, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (122, 'Domingo', INTERVAL '0 16:30:00' DAY TO SECOND, 122, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (123, 'Miércoles', INTERVAL '0 20:15:00' DAY TO SECOND, 123, TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (124, 'Miércoles', INTERVAL '0 10:00:00' DAY TO SECOND, 124, TO_DATE('2026-09-09','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (125, 'Lunes', INTERVAL '0 13:45:00' DAY TO SECOND, 125, TO_DATE('2026-08-03','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (126, 'Martes', INTERVAL '0 17:30:00' DAY TO SECOND, 126, TO_DATE('2026-09-15','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (127, 'Lunes', INTERVAL '0 07:15:00' DAY TO SECOND, 127, TO_DATE('2026-08-17','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (128, 'Viernes', INTERVAL '0 11:00:00' DAY TO SECOND, 128, TO_DATE('2026-09-18','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (129, 'Lunes', INTERVAL '0 14:45:00' DAY TO SECOND, 129, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (130, 'Domingo', INTERVAL '0 18:30:00' DAY TO SECOND, 130, TO_DATE('2026-09-13','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (131, 'Martes', INTERVAL '0 08:15:00' DAY TO SECOND, 131, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (132, 'Lunes', INTERVAL '0 12:00:00' DAY TO SECOND, 132, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (133, 'Miércoles', INTERVAL '0 15:45:00' DAY TO SECOND, 133, TO_DATE('2026-09-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (134, 'Lunes', INTERVAL '0 19:30:00' DAY TO SECOND, 134, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (135, 'Domingo', INTERVAL '0 09:15:00' DAY TO SECOND, 135, TO_DATE('2026-08-09','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (136, 'Jueves', INTERVAL '0 13:00:00' DAY TO SECOND, 136, TO_DATE('2026-06-25','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (137, 'Miércoles', INTERVAL '0 16:45:00' DAY TO SECOND, 137, TO_DATE('2026-03-04','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (138, 'Viernes', INTERVAL '0 20:30:00' DAY TO SECOND, 138, TO_DATE('2026-04-24','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (139, 'Viernes', INTERVAL '0 10:15:00' DAY TO SECOND, 139, TO_DATE('2026-09-18','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (140, 'Miércoles', INTERVAL '0 14:00:00' DAY TO SECOND, 140, TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (141, 'Miércoles', INTERVAL '0 17:45:00' DAY TO SECOND, 141, TO_DATE('2026-09-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (142, 'Lunes', INTERVAL '0 07:30:00' DAY TO SECOND, 142, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (143, 'Lunes', INTERVAL '0 11:15:00' DAY TO SECOND, 143, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (144, 'Jueves', INTERVAL '0 15:00:00' DAY TO SECOND, 144, TO_DATE('2026-09-03','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (145, 'Jueves', INTERVAL '0 18:45:00' DAY TO SECOND, 145, TO_DATE('2026-09-10','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (146, 'Jueves', INTERVAL '0 08:30:00' DAY TO SECOND, 146, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (147, 'Sábado', INTERVAL '0 12:15:00' DAY TO SECOND, 147, TO_DATE('2026-08-01','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (148, 'Lunes', INTERVAL '0 16:00:00' DAY TO SECOND, 148, TO_DATE('2026-04-27','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (149, 'Viernes', INTERVAL '0 19:45:00' DAY TO SECOND, 149, TO_DATE('2026-08-07','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (150, 'Viernes', INTERVAL '0 09:30:00' DAY TO SECOND, 150, TO_DATE('2026-09-18','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (151, 'Sábado', INTERVAL '0 13:15:00' DAY TO SECOND, 151, TO_DATE('2026-09-12','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (152, 'Domingo', INTERVAL '0 17:00:00' DAY TO SECOND, 152, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (153, 'Jueves', INTERVAL '0 20:45:00' DAY TO SECOND, 153, TO_DATE('2026-03-26','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (154, 'Jueves', INTERVAL '0 10:30:00' DAY TO SECOND, 154, TO_DATE('2026-03-26','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (155, 'Lunes', INTERVAL '0 14:15:00' DAY TO SECOND, 155, TO_DATE('2026-04-13','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (156, 'Sábado', INTERVAL '0 18:00:00' DAY TO SECOND, 156, TO_DATE('2026-04-25','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (157, 'Miércoles', INTERVAL '0 07:45:00' DAY TO SECOND, 157, TO_DATE('2025-05-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (158, 'Domingo', INTERVAL '0 11:30:00' DAY TO SECOND, 158, TO_DATE('2025-06-01','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (159, 'Martes', INTERVAL '0 15:15:00' DAY TO SECOND, 159, TO_DATE('2026-06-02','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (160, 'Viernes', INTERVAL '0 19:00:00' DAY TO SECOND, 160, TO_DATE('2026-05-15','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (161, 'Martes', INTERVAL '0 08:45:00' DAY TO SECOND, 161, TO_DATE('2026-06-02','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (162, 'Miércoles', INTERVAL '0 12:30:00' DAY TO SECOND, 162, TO_DATE('2026-06-24','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (163, 'Domingo', INTERVAL '0 16:15:00' DAY TO SECOND, 163, TO_DATE('2026-07-12','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (164, 'Jueves', INTERVAL '0 20:00:00' DAY TO SECOND, 164, TO_DATE('2026-06-11','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (165, 'Miércoles', INTERVAL '0 09:45:00' DAY TO SECOND, 165, TO_DATE('2026-06-17','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (166, 'Martes', INTERVAL '0 13:30:00' DAY TO SECOND, 166, TO_DATE('2026-04-28','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (167, 'Lunes', INTERVAL '0 17:15:00' DAY TO SECOND, 167, TO_DATE('2025-11-10','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (168, 'Viernes', INTERVAL '0 07:00:00' DAY TO SECOND, 168, TO_DATE('2025-04-11','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (169, 'Viernes', INTERVAL '0 10:45:00' DAY TO SECOND, 169, TO_DATE('2026-01-09','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (170, 'Martes', INTERVAL '0 14:30:00' DAY TO SECOND, 170, TO_DATE('2026-01-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (171, 'Sábado', INTERVAL '0 18:15:00' DAY TO SECOND, 171, TO_DATE('2026-02-07','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (172, 'Viernes', INTERVAL '0 08:00:00' DAY TO SECOND, 172, TO_DATE('2026-02-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (173, 'Martes', INTERVAL '0 11:45:00' DAY TO SECOND, 173, TO_DATE('2026-03-10','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (174, 'Domingo', INTERVAL '0 15:30:00' DAY TO SECOND, 174, TO_DATE('2026-02-01','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (175, 'Jueves', INTERVAL '0 19:15:00' DAY TO SECOND, 175, TO_DATE('2026-02-19','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (176, 'Lunes', INTERVAL '0 09:00:00' DAY TO SECOND, 176, TO_DATE('2026-03-02','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (177, 'Sábado', INTERVAL '0 12:45:00' DAY TO SECOND, 177, TO_DATE('2025-09-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (178, 'Miércoles', INTERVAL '0 16:30:00' DAY TO SECOND, 178, TO_DATE('2025-10-08','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (179, 'Viernes', INTERVAL '0 20:15:00' DAY TO SECOND, 179, TO_DATE('2026-05-15','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (180, 'Sábado', INTERVAL '0 10:00:00' DAY TO SECOND, 180, TO_DATE('2026-05-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (181, 'Miércoles', INTERVAL '0 13:45:00' DAY TO SECOND, 181, TO_DATE('2026-06-03','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (182, 'Domingo', INTERVAL '0 17:30:00' DAY TO SECOND, 182, TO_DATE('2026-06-21','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (183, 'Martes', INTERVAL '0 07:15:00' DAY TO SECOND, 183, TO_DATE('2026-06-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (184, 'Viernes', INTERVAL '0 11:00:00' DAY TO SECOND, 184, TO_DATE('2026-04-17','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (185, 'Martes', INTERVAL '0 14:45:00' DAY TO SECOND, 185, TO_DATE('2026-05-05','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (186, 'Viernes', INTERVAL '0 18:30:00' DAY TO SECOND, 186, TO_DATE('2026-03-06','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (187, 'Jueves', INTERVAL '0 08:15:00' DAY TO SECOND, 187, TO_DATE('2026-03-19','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (188, 'Lunes', INTERVAL '0 12:00:00' DAY TO SECOND, 188, TO_DATE('2026-04-06','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (189, 'Jueves', INTERVAL '0 15:45:00' DAY TO SECOND, 189, TO_DATE('2025-11-13','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (190, 'Miércoles', INTERVAL '0 19:30:00' DAY TO SECOND, 190, TO_DATE('2026-01-21','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (191, 'Domingo', INTERVAL '0 09:15:00' DAY TO SECOND, 191, TO_DATE('2026-02-08','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (192, 'Domingo', INTERVAL '0 13:00:00' DAY TO SECOND, 192, TO_DATE('2026-01-25','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (193, 'Domingo', INTERVAL '0 16:45:00' DAY TO SECOND, 193, TO_DATE('2026-02-22','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (194, 'Miércoles', INTERVAL '0 20:30:00' DAY TO SECOND, 194, TO_DATE('2026-03-11','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (195, 'Domingo', INTERVAL '0 10:15:00' DAY TO SECOND, 195, TO_DATE('2025-12-28','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (196, 'Miércoles', INTERVAL '0 14:00:00' DAY TO SECOND, 196, TO_DATE('2026-01-07','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (197, 'Martes', INTERVAL '0 17:45:00' DAY TO SECOND, 197, TO_DATE('2026-01-27','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (198, 'Sábado', INTERVAL '0 07:30:00' DAY TO SECOND, 198, TO_DATE('2026-02-14','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (199, 'Miércoles', INTERVAL '0 11:15:00' DAY TO SECOND, 199, TO_DATE('2026-03-25','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (200, 'Martes', INTERVAL '0 15:00:00' DAY TO SECOND, 200, TO_DATE('2026-04-28','YYYY-MM-DD'));

-- CAT_PATOLOGIA: 51 registros
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (1, 'Cardiovascular');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (2, 'Respiratoria');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (3, 'Metabólica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (4, 'Osteoarticular');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (5, 'Muscular');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (6, 'Neurológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (7, 'Digestiva');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (8, 'Autoinmune');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (9, 'Endocrina');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (10, 'Renal');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (11, 'Hematológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (12, 'Dermatológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (13, 'Oncológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (14, 'Infecciosa');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (15, 'Ortopédica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (16, 'Ósea');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (17, 'Articular');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (18, 'Traumatológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (19, 'Psicológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (20, 'Psiquiátrica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (21, 'Oftálmica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (22, 'Otorrinolaringológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (23, 'Auditiva');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (24, 'Visual');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (25, 'Dental');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (26, 'Nutricional');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (27, 'Genética');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (28, 'Congénita');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (29, 'Pediátrica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (30, 'Geriátrica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (31, 'Deportiva');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (32, 'Laboral');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (33, 'Alérgica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (34, 'Inflamatoria');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (35, 'Degenerativa');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (36, 'Fisiológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (37, 'Afectiva');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (38, 'Hepática');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (39, 'Tiroidea');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (40, 'Pulmonar');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (41, 'Cardíaca');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (42, 'Vascular');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (43, 'Coronaria');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (44, 'Renal crónica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (45, 'Digestiva crónica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (46, 'Ósea metabólica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (47, 'Del sueño');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (48, 'Sensorial');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (49, 'Motora');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (50, 'Cognitiva');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (51, 'Sin Patologías');

-- CENTRO_DEP: 200 registros
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (1, 'Centro Deportivo Central Santiago', '76.101.234-7', 113, 'Av. Libertador Bernardo O''Higgins 1234');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (2, 'Centro Deportivo Providencia Sport', '76.202.345-8', 104, 'Av. Providencia 2150');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (3, 'Centro Deportivo Las Condes Fitness', '76.303.456-9', 95, 'Av. Apoquindo 4500');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (4, 'Centro Deportivo Ñuñoa Activa', '76.404.567-K', 101, 'Av. Irarrázaval 3205');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (5, 'Centro Deportivo Maipú Fuerza', '76.505.678-0', 100, 'Av. Pajaritos 1890');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (6, 'Centro Deportivo La Florida Gym', '76.606.789-1', 91, 'Av. Vicuña Mackenna 7200');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (7, 'Centro Deportivo Viña Marina', '77.101.890-4', 51, 'Av. Libertad 850');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (8, 'Centro Deportivo Valparaíso Puerto', '77.202.901-2', 50, 'Calle Condell 1420');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (9, 'Centro Deportivo Antofagasta Costa', '77.303.012-K', 12, 'Av. Grecia 1650');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (10, 'Centro Deportivo La Serena Sol', '77.404.123-0', 33, 'Av. Francisco de Aguirre 420');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (11, 'Centro Deportivo Rancagua Salud', '77.505.234-1', 148, 'Paseo Independencia 630');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (12, 'Centro Deportivo Talca Centro', '77.606.345-2', 186, 'Calle 1 Sur 1120');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (13, 'Centro Deportivo Concepción Bío Bío', '78.101.456-7', 220, 'Calle Barros Arana 780');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (14, 'Centro Deportivo Temuco Araucanía', '78.202.567-8', 268, 'Av. Alemania 0825');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (15, 'Centro Deportivo Puerto Montt Sur', '78.303.678-9', 303, 'Av. Diego Portales 1500');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (16, 'Centro Deportivo Pozo Almonte Fit Club', '77.772.477-0', 7, 'Av. Pozo Almonte 1123');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (17, 'Centro Deportivo Tocopilla Power Gym', '77.706.003-1', 19, 'Av. Tocopilla 1246');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (18, 'Centro Deportivo Vallenar Athletic', '77.835.268-0', 26, 'Av. Vallenar 1369');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (19, 'Centro Deportivo Ovalle Elite Performance', '77.208.624-5', 40, 'Av. Ovalle 1492');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (20, 'Centro Deportivo Los Andes Box Training', '77.868.600-7', 53, 'Av. Los Andes 1615');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (21, 'Centro Deportivo San Antonio Zone Fitness', '77.316.367-7', 67, 'Av. San Antonio 1738');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (22, 'Centro Deportivo Santiago Sport Center', '77.207.659-2', 83, 'Av. Santiago 1861');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (23, 'Centro Deportivo San Bernardo Academy', '77.449.354-9', 121, 'Av. San Bernardo 1984');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (24, 'Centro Deportivo Rancagua Peak Training', '77.854.555-1', 135, 'Av. Rancagua 2107');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (25, 'Centro Deportivo Curicó Life Gym', '77.117.844-8', 168, 'Av. Curicó 2230');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (26, 'Centro Deportivo Cauquenes Energy Club', '77.992.087-9', 195, 'Av. Cauquenes 2353');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (27, 'Centro Deportivo San Carlos Core Fitness', '77.523.863-1', 214, 'Av. San Carlos 2476');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (28, 'Centro Deportivo Los Ángeles Strength House', '77.913.801-1', 238, 'Av. Los Ángeles 2599');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (29, 'Centro Deportivo Valdivia Movement Studio', '77.408.466-5', 284, 'Av. Valdivia 2722');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (30, 'Centro Deportivo Osorno Health Club', '77.237.147-0', 306, 'Av. Osorno 2845');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (31, 'Centro Deportivo Coyhaique Iron Gym', '77.686.514-1', 326, 'Av. Coyhaique 2968');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (32, 'Centro Deportivo Chile Chico Active Center', '77.569.846-2', 334, 'Av. Chile Chico 3091');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (33, 'Centro Deportivo Porvenir Total Fitness', '77.849.770-0', 342, 'Av. Porvenir 3214');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (34, 'Centro Deportivo Putre Body Studio', '77.267.058-3', 3, 'Av. Putre 3337');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (35, 'Centro Deportivo Antofagasta Oxygen Club', '77.141.967-4', 12, 'Av. Antofagasta 3460');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (36, 'Centro Deportivo Copiapó Training Lab', '77.165.367-7', 21, 'Av. Copiapó 3583');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (37, 'Centro Deportivo La Serena Iron House', '77.219.595-8', 30, 'Av. La Serena 3706');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (38, 'Centro Deportivo Valparaíso Fit House', '77.261.137-4', 45, 'Av. Valparaíso 3829');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (39, 'Centro Deportivo La Ligua Performance Club', '77.304.673-5', 57, 'Av. La Ligua 3952');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (40, 'Centro Deportivo San Felipe Gym Center', '77.363.478-5', 73, 'Av. San Felipe 4075');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (41, 'Centro Deportivo Puente Alto Fit Club', '77.780.814-1', 115, 'Av. Puente Alto 4198');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (42, 'Centro Deportivo Melipilla Power Gym', '77.113.316-9', 125, 'Av. Melipilla 4321');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (43, 'Centro Deportivo Pichilemu Athletic', '77.392.503-8', 152, 'Av. Pichilemu 4444');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (44, 'Centro Deportivo Talca Elite Performance', '77.866.419-4', 177, 'Av. Talca 4567');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (45, 'Centro Deportivo Chillán Box Training', '77.619.668-1', 198, 'Av. Chillán 4690');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (46, 'Centro Deportivo Concepción Zone Fitness', '77.578.915-8', 219, 'Av. Concepción 4813');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (47, 'Centro Deportivo Temuco Sport Center', '77.783.716-8', 252, 'Av. Temuco 4936');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (48, 'Centro Deportivo La Unión Academy', '77.855.994-3', 292, 'Av. La Unión 5059');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (49, 'Centro Deportivo Castro Peak Training', '77.272.819-0', 312, 'Av. Castro 5182');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (50, 'Centro Deportivo Puerto Aysén Life Gym', '77.614.375-8', 328, 'Av. Puerto Aysén 5305');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (51, 'Centro Deportivo Andes 51', '90.006.987-1', 154, 'Av. Los Deportes 1663, Marchihue');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (52, 'Centro Deportivo Pacífico 52', '90.007.124-8', 157, 'Av. El Sol 1676, Pichilemu');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (53, 'Centro Deportivo Cordillera 53', '90.007.261-9', 160, 'Av. del Mar 1689, Lolol');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (54, 'Centro Deportivo Valle 54', '90.007.398-4', 163, 'Av. Los Andes 1702, Peralillo');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (55, 'Centro Deportivo Costa 55', '90.007.535-9', 166, 'Av. Central 1715, San Fernando');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (56, 'Centro Deportivo Austral 56', '90.007.672-K', 169, 'Av. Libertad 1728, Hualañé');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (57, 'Centro Deportivo Norte 57', '90.007.809-9', 172, 'Av. Providencia 1741, Rauco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (58, 'Centro Deportivo Sur 58', '90.007.946-K', 175, 'Av. Independencia 1754, Teno');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (59, 'Centro Deportivo Central 59', '90.008.083-2', 178, 'Av. La Paz 1767, Curepto');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (60, 'Centro Deportivo Metropolitano 60', '90.008.220-7', 181, 'Av. Los Robles 1780, Pelarco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (61, 'Centro Deportivo Andes 61', '90.008.357-2', 184, 'Av. Los Deportes 1793, San Clemente');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (62, 'Centro Deportivo Pacífico 62', '90.008.494-3', 187, 'Av. El Sol 1806, Colbún');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (63, 'Centro Deportivo Cordillera 63', '90.008.631-8', 190, 'Av. del Mar 1819, Parral');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (64, 'Centro Deportivo Valle 64', '90.008.768-3', 193, 'Av. Los Andes 1832, Villa Alegre');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (65, 'Centro Deportivo Costa 65', '90.008.905-8', 196, 'Av. Central 1845, Chanco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (66, 'Centro Deportivo Austral 66', '90.009.042-0', 199, 'Av. Libertad 1858, Chillán');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (67, 'Centro Deportivo Norte 67', '90.009.179-6', 202, 'Av. Providencia 1871, Pemuco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (68, 'Centro Deportivo Sur 68', '90.009.316-0', 205, 'Av. Independencia 1884, San Ignacio');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (69, 'Centro Deportivo Central 69', '90.009.453-1', 208, 'Av. La Paz 1897, Coelemu');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (70, 'Centro Deportivo Metropolitano 70', '90.009.590-2', 211, 'Av. Los Robles 1910, Quirihue');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (71, 'Centro Deportivo Andes 71', '90.009.727-1', 214, 'Av. Los Deportes 1923, Coihueco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (72, 'Centro Deportivo Pacífico 72', '90.009.864-2', 217, 'Av. El Sol 1936, San Fabián');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (73, 'Centro Deportivo Cordillera 73', '90.010.001-9', 220, 'Av. del Mar 1949, Concepción');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (74, 'Centro Deportivo Valle 74', '90.010.138-4', 223, 'Av. Los Andes 1962, Hualpén');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (75, 'Centro Deportivo Costa 75', '90.010.275-5', 226, 'Av. Central 1975, Penco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (76, 'Centro Deportivo Austral 76', '90.010.412-K', 229, 'Av. Libertad 1988, Talcahuano');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (77, 'Centro Deportivo Norte 77', '90.010.549-5', 232, 'Av. Providencia 2001, Cañete');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (78, 'Centro Deportivo Sur 78', '90.010.686-6', 235, 'Av. Independencia 2014, Lebu');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (79, 'Centro Deportivo Central 79', '90.010.823-0', 238, 'Av. La Paz 2027, Alto Biobío');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (80, 'Centro Deportivo Metropolitano 80', '90.010.960-1', 241, 'Av. Los Robles 2040, Laja');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (81, 'Centro Deportivo Andes 81', '90.011.097-9', 244, 'Av. Los Deportes 2053, Nacimiento');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (82, 'Centro Deportivo Pacífico 82', '90.011.234-3', 247, 'Av. El Sol 2066, Quilleco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (83, 'Centro Deportivo Cordillera 83', '90.011.371-4', 250, 'Av. del Mar 2079, Tucapel');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (84, 'Centro Deportivo Valle 84', '90.011.508-3', 253, 'Av. Los Andes 2092, Cholchol');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (85, 'Centro Deportivo Costa 85', '90.011.645-4', 256, 'Av. Central 2105, Freire');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (86, 'Centro Deportivo Austral 86', '90.011.782-5', 259, 'Av. Libertad 2118, Lautaro');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (87, 'Centro Deportivo Norte 87', '90.011.919-4', 262, 'Av. Providencia 2131, Nueva Imperial');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (88, 'Centro Deportivo Sur 88', '90.012.056-7', 265, 'Av. Independencia 2144, Pitrufquén');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (89, 'Centro Deportivo Central 89', '90.012.193-8', 268, 'Av. La Paz 2157, Temuco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (90, 'Centro Deportivo Metropolitano 90', '90.012.330-2', 271, 'Av. Los Robles 2170, Vilcún');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (91, 'Centro Deportivo Andes 91', '90.012.467-8', 274, 'Av. Los Deportes 2183, Collipulli');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (92, 'Centro Deportivo Pacífico 92', '90.012.604-2', 277, 'Av. El Sol 2196, Lonquimay');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (93, 'Centro Deportivo Cordillera 93', '90.012.741-3', 280, 'Av. del Mar 2209, Purén');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (94, 'Centro Deportivo Valle 94', '90.012.878-9', 283, 'Av. Los Andes 2222, Victoria');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (95, 'Centro Deportivo Costa 95', '90.013.015-5', 286, 'Av. Central 2235, Los Lagos');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (96, 'Centro Deportivo Austral 96', '90.013.152-6', 289, 'Av. Libertad 2248, Paillaco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (97, 'Centro Deportivo Norte 97', '90.013.289-1', 292, 'Av. Providencia 2261, Futrono');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (98, 'Centro Deportivo Sur 98', '90.013.426-6', 295, 'Av. Independencia 2274, Río Bueno');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (99, 'Centro Deportivo Central 99', '90.013.563-7', 298, 'Av. La Paz 2287, Fresia');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (100, 'Centro Deportivo Metropolitano 100', '90.013.700-1', 301, 'Av. Los Robles 2300, Los Muermos');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (101, 'Centro Deportivo Andes 101', '90.013.837-7', 304, 'Av. Los Deportes 2313, Puerto Octay');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (102, 'Centro Deportivo Pacífico 102', '90.013.974-8', 307, 'Av. El Sol 2326, Puyehue');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (103, 'Centro Deportivo Cordillera 103', '90.014.111-4', 310, 'Av. del Mar 2339, San Pablo');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (104, 'Centro Deportivo Valle 104', '90.014.248-K', 313, 'Av. Los Andes 2352, Castro');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (105, 'Centro Deportivo Costa 105', '90.014.385-0', 316, 'Av. Central 2365, Dalcahue');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (106, 'Centro Deportivo Austral 106', '90.014.522-5', 319, 'Av. Libertad 2378, Quellón');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (107, 'Centro Deportivo Norte 107', '90.014.659-0', 322, 'Av. Providencia 2391, Chaitén');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (108, 'Centro Deportivo Sur 108', '90.014.796-1', 325, 'Av. Independencia 2404, Palena');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (109, 'Centro Deportivo Central 109', '90.014.933-6', 328, 'Av. La Paz 2417, Aysén');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (110, 'Centro Deportivo Metropolitano 110', '90.015.070-9', 331, 'Av. Los Robles 2430, Cochrane');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (111, 'Centro Deportivo Andes 111', '90.015.207-8', 334, 'Av. Los Deportes 2443, Chile Chico');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (112, 'Centro Deportivo Pacífico 112', '90.015.344-9', 337, 'Av. El Sol 2456, Punta Arenas');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (113, 'Centro Deportivo Cordillera 113', '90.015.481-K', 340, 'Av. del Mar 2469, Natales');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (114, 'Centro Deportivo Valle 114', '90.015.618-9', 343, 'Av. Los Andes 2482, Primavera');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (115, 'Centro Deportivo Costa 115', '90.015.755-K', 346, 'Av. Central 2495, Cabo de Hornos');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (116, 'Centro Deportivo Austral 116', '90.015.892-0', 3, 'Av. Libertad 2508, General Lagos');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (117, 'Centro Deportivo Norte 117', '90.016.029-1', 6, 'Av. Providencia 2521, Iquique');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (118, 'Centro Deportivo Sur 118', '90.016.166-2', 9, 'Av. Independencia 2534, Huara');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (119, 'Centro Deportivo Central 119', '90.016.303-7', 12, 'Av. La Paz 2547, Antofagasta');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (120, 'Centro Deportivo Metropolitano 120', '90.016.440-8', 15, 'Av. Los Robles 2560, Taltal');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (121, 'Centro Deportivo Andes 121', '90.016.577-3', 18, 'Av. Los Deportes 2573, San Pedro de Atacama');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (122, 'Centro Deportivo Pacífico 122', '90.016.714-8', 21, 'Av. El Sol 2586, Caldera');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (123, 'Centro Deportivo Cordillera 123', '90.016.851-9', 24, 'Av. del Mar 2599, Chañaral');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (124, 'Centro Deportivo Valle 124', '90.016.988-4', 27, 'Av. Los Andes 2612, Freirina');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (125, 'Centro Deportivo Costa 125', '90.017.125-0', 30, 'Av. Central 2625, Andacollo');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (126, 'Centro Deportivo Austral 126', '90.017.262-1', 33, 'Av. Libertad 2638, La Serena');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (127, 'Centro Deportivo Norte 127', '90.017.399-7', 36, 'Av. Providencia 2651, Canela');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (128, 'Centro Deportivo Sur 128', '90.017.536-1', 39, 'Av. Independencia 2664, Salamanca');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (129, 'Centro Deportivo Central 129', '90.017.673-2', 42, 'Av. La Paz 2677, Ovalle');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (130, 'Centro Deportivo Metropolitano 130', '90.017.810-7', 45, 'Av. Los Robles 2690, Casablanca');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (131, 'Centro Deportivo Andes 131', '90.017.947-2', 48, 'Av. Los Deportes 2703, Puchuncaví');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (132, 'Centro Deportivo Pacífico 132', '90.018.084-5', 51, 'Av. El Sol 2716, Viña del Mar');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (133, 'Centro Deportivo Cordillera 133', '90.018.221-K', 54, 'Av. del Mar 2729, Los Andes');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (134, 'Centro Deportivo Valle 134', '90.018.358-5', 57, 'Av. Los Andes 2742, Cabildo');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (135, 'Centro Deportivo Costa 135', '90.018.495-6', 60, 'Av. Central 2755, Petorca');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (136, 'Centro Deportivo Austral 136', '90.018.632-0', 63, 'Av. Libertad 2768, Hijuelas');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (137, 'Centro Deportivo Norte 137', '90.018.769-6', 66, 'Av. Providencia 2781, Quillota');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (138, 'Centro Deportivo Sur 138', '90.018.906-0', 69, 'Av. Independencia 2794, El Quisco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (139, 'Centro Deportivo Central 139', '90.019.043-3', 72, 'Av. La Paz 2807, Santo Domingo');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (140, 'Centro Deportivo Metropolitano 140', '90.019.180-4', 75, 'Av. Los Robles 2820, Panquehue');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (141, 'Centro Deportivo Andes 141', '90.019.317-3', 78, 'Av. Los Deportes 2833, Santa María');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (142, 'Centro Deportivo Pacífico 142', '90.019.454-4', 81, 'Av. El Sol 2846, Quilpué');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (143, 'Centro Deportivo Cordillera 143', '90.019.591-5', 84, 'Av. del Mar 2859, Cerro Navia');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (144, 'Centro Deportivo Valle 144', '90.019.728-4', 87, 'Av. Los Andes 2872, Estación Central');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (145, 'Centro Deportivo Costa 145', '90.019.865-5', 90, 'Av. Central 2885, La Cisterna');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (146, 'Centro Deportivo Austral 146', '90.020.002-1', 93, 'Av. Libertad 2898, La Pintana');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (147, 'Centro Deportivo Norte 147', '90.020.139-7', 96, 'Av. Providencia 2911, Lo Barnechea');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (148, 'Centro Deportivo Sur 148', '90.020.276-8', 99, 'Av. Independencia 2924, Macul');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (149, 'Centro Deportivo Central 149', '90.020.413-2', 102, 'Av. La Paz 2937, Pedro Aguirre Cerda');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (150, 'Centro Deportivo Metropolitano 150', '90.020.550-3', 105, 'Av. Los Robles 2950, Pudahuel');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (151, 'Centro Deportivo Andes 151', '90.020.687-9', 108, 'Av. Los Deportes 2963, Recoleta');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (152, 'Centro Deportivo Pacífico 152', '90.020.824-3', 111, 'Av. El Sol 2976, San Miguel');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (153, 'Centro Deportivo Cordillera 153', '90.020.961-4', 114, 'Av. del Mar 2989, Vitacura');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (154, 'Centro Deportivo Valle 154', '90.021.098-1', 117, 'Av. Los Andes 3002, San José de Maipo');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (155, 'Centro Deportivo Costa 155', '90.021.235-6', 120, 'Av. Central 3015, Tiltil');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (156, 'Centro Deportivo Austral 156', '90.021.372-7', 123, 'Av. Libertad 3028, Paine');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (157, 'Centro Deportivo Norte 157', '90.021.509-6', 126, 'Av. Providencia 3041, Curacaví');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (158, 'Centro Deportivo Sur 158', '90.021.646-7', 129, 'Av. Independencia 3054, San Pedro');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (159, 'Centro Deportivo Central 159', '90.021.783-8', 132, 'Av. La Paz 3067, Padre Hurtado');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (160, 'Centro Deportivo Metropolitano 160', '90.021.920-2', 135, 'Av. Los Robles 3080, Codegua');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (161, 'Centro Deportivo Andes 161', '90.022.057-K', 138, 'Av. Los Deportes 3093, Doñihue');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (162, 'Centro Deportivo Pacífico 162', '90.022.194-0', 141, 'Av. El Sol 3106, Machalí');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (163, 'Centro Deportivo Cordillera 163', '90.022.331-5', 144, 'Av. del Mar 3119, Olivar');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (164, 'Centro Deportivo Valle 164', '90.022.468-0', 147, 'Av. Los Andes 3132, Quinta de Tilcoco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (165, 'Centro Deportivo Costa 165', '90.022.605-5', 150, 'Av. Central 3145, Requínoa');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (166, 'Centro Deportivo Austral 166', '90.022.742-6', 153, 'Av. Libertad 3158, Litueche');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (167, 'Centro Deportivo Norte 167', '90.022.879-1', 156, 'Av. Providencia 3171, Paredones');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (168, 'Centro Deportivo Sur 168', '90.023.016-8', 159, 'Av. Independencia 3184, Chimbarongo');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (169, 'Centro Deportivo Central 169', '90.023.153-9', 162, 'Av. La Paz 3197, Palmilla');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (170, 'Centro Deportivo Metropolitano 170', '90.023.290-K', 165, 'Av. Los Robles 3210, Pumanque');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (171, 'Centro Deportivo Andes 171', '90.023.427-9', 168, 'Av. Los Deportes 3223, Curicó');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (172, 'Centro Deportivo Pacífico 172', '90.023.564-K', 171, 'Av. El Sol 3236, Molina');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (173, 'Centro Deportivo Cordillera 173', '90.023.701-4', 174, 'Av. del Mar 3249, Sagrada Familia');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (174, 'Centro Deportivo Valle 174', '90.023.838-K', 177, 'Av. Los Andes 3262, Constitución');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (175, 'Centro Deportivo Costa 175', '90.023.975-0', 180, 'Av. Central 3275, Maule');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (176, 'Centro Deportivo Austral 176', '90.024.112-7', 183, 'Av. Libertad 3288, Río Claro');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (177, 'Centro Deportivo Norte 177', '90.024.249-2', 186, 'Av. Providencia 3301, Talca');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (178, 'Centro Deportivo Sur 178', '90.024.386-3', 189, 'Av. Independencia 3314, Longaví');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (179, 'Centro Deportivo Central 179', '90.024.523-8', 192, 'Av. La Paz 3327, San Javier');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (180, 'Centro Deportivo Metropolitano 180', '90.024.660-9', 195, 'Av. Los Robles 3340, Cauquenes');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (181, 'Centro Deportivo Andes 181', '90.024.797-4', 198, 'Av. Los Deportes 3353, Bulnes');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (182, 'Centro Deportivo Pacífico 182', '90.024.934-9', 201, 'Av. El Sol 3366, El Carmen');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (183, 'Centro Deportivo Cordillera 183', '90.025.071-1', 204, 'Av. del Mar 3379, Quillón');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (184, 'Centro Deportivo Valle 184', '90.025.208-0', 207, 'Av. Los Andes 3392, Cobquecura');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (185, 'Centro Deportivo Costa 185', '90.025.345-1', 210, 'Av. Central 3405, Portezuelo');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (186, 'Centro Deportivo Austral 186', '90.025.482-2', 213, 'Av. Libertad 3418, Treguaco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (187, 'Centro Deportivo Norte 187', '90.025.619-1', 216, 'Av. Providencia 3431, San Carlos');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (188, 'Centro Deportivo Sur 188', '90.025.756-2', 219, 'Av. Independencia 3444, Chiguayante');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (189, 'Centro Deportivo Central 189', '90.025.893-3', 222, 'Av. La Paz 3457, Florida');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (190, 'Centro Deportivo Metropolitano 190', '90.026.030-K', 225, 'Av. Los Robles 3470, Lota');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (191, 'Centro Deportivo Andes 191', '90.026.167-5', 228, 'Av. Los Deportes 3483, Santa Juana');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (192, 'Centro Deportivo Pacífico 192', '90.026.304-K', 231, 'Av. El Sol 3496, Arauco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (193, 'Centro Deportivo Cordillera 193', '90.026.441-0', 234, 'Av. del Mar 3509, Curanilahue');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (194, 'Centro Deportivo Valle 194', '90.026.578-6', 237, 'Av. Los Andes 3522, Tirúa');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (195, 'Centro Deportivo Costa 195', '90.026.715-0', 240, 'Av. Central 3535, Cabrero');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (196, 'Centro Deportivo Austral 196', '90.026.852-1', 243, 'Av. Libertad 3548, Mulchén');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (197, 'Centro Deportivo Norte 197', '90.026.989-7', 246, 'Av. Providencia 3561, Quilaco');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (198, 'Centro Deportivo Sur 198', '90.027.126-3', 249, 'Av. Independencia 3574, Santa Bárbara');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (199, 'Centro Deportivo Central 199', '90.027.263-4', 252, 'Av. La Paz 3587, Carahue');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (200, 'Centro Deportivo Metropolitano 200', '90.027.400-9', 255, 'Av. Los Robles 3600, Curarrehue');

-- EJERCICIO: 200 registros
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (1, 'Sentadilla', 'Sentadilla con barra sobre la espalda, bajando hasta que los muslos queden paralelos al suelo.', 12, 40);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (2, 'Press de banca', 'Press de banca con barra, enfocado en el desarrollo del pectoral mayor.', 10, 50);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (3, 'Peso muerto', 'Levantamiento de barra desde el suelo con espalda recta, activando la cadena posterior.', 8, 80);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (4, 'Dominadas', 'Dominadas en barra con agarre prono, trabajando dorsal y bíceps.', 10, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (5, 'Fondos', 'Fondos en paralelas para tríceps y pectoral inferior.', 12, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (6, 'Remo con barra', 'Remo con barra inclinado, enfocado en la espalda media.', 10, 40);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (7, 'Press militar', 'Press militar con barra por encima de la cabeza para hombros.', 10, 30);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (8, 'Curl de bíceps', 'Curl de bíceps con barra recta, manteniendo los codos pegados al cuerpo.', 12, 15);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (9, 'Extensiones de tríceps', 'Extensiones de tríceps en polea alta.', 15, 20);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (10, 'Press francés', 'Press francés con barra Z para tríceps.', 12, 20);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (11, 'Sentadilla búlgara', 'Sentadilla búlgara con mancuernas, dividiendo el trabajo en cada pierna.', 12, 10);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (12, 'Zancadas', 'Zancadas alternadas con mancuernas, trabajando glúteos y cuádriceps.', 12, 12);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (13, 'Peso muerto rumano', 'Peso muerto rumano con barra para isquiotibiales y glúteos.', 10, 50);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (14, 'Hip thrust', 'Elevación de cadera con barra apoyada, enfocado en glúteos.', 12, 60);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (15, 'Puente de glúteos', 'Puente de glúteos con peso o banda elástica.', 15, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (16, 'Elevaciones laterales', 'Elevaciones laterales con mancuernas para hombros.', 15, 8);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (17, 'Elevaciones frontales', 'Elevaciones frontales con mancuernas para deltoides anterior.', 15, 8);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (18, 'Pájaros', 'Remo en pronación con mancuernas para deltoides posterior.', 15, 6);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (19, 'Remo en máquina', 'Remo en máquina sentado con agarre cerrado.', 12, 45);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (20, 'Jalón al pecho', 'Jalón al pecho en polea alta con agarre amplio.', 12, 40);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (21, 'Jalón al mentón', 'Remo alto al mentón con barra.', 12, 25);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (22, 'Aperturas en máquina', 'Aperturas de pecho en máquina.', 12, 30);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (23, 'Cruce de poleas', 'Cruce de poleas altas, enfocado en el pectoral.', 12, 15);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (24, 'Face pull', 'Face pull en polea alta con cuerda.', 15, 20);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (25, 'Encogimientos de hombros', 'Encogimientos con mancuernas para trapecios.', 15, 20);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (26, 'Abdominales en máquina', 'Crunch abdominal en máquina.', 20, 25);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (27, 'Plancha', 'Plancha abdominal isométrica manteniendo el cuerpo recto.', 60, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (28, 'Palof press', 'Rotación resistida con polea para core, de pie.', 15, 15);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (29, 'Russian twist', 'Giro ruso con disco o mancuerna.', 20, 10);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (30, 'Elevación de piernas colgado', 'Elevaciones de piernas en barra fija.', 12, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (31, 'Burpees', 'Burpees completos con salto final.', 15, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (32, 'Saltos al cajón', 'Saltos pliométricos sobre cajón.', 10, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (33, 'Sprints en cinta', 'Sprints en cinta a máxima intensidad.', 10, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (34, 'Skipping alto', 'Skipping con rodillas altas en el lugar.', 30, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (35, 'Escalador', 'Escalador de montaña, alternando rodillas al pecho.', 30, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (36, 'Mountain climbers', 'Escaladores en posición de plancha.', 40, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (37, 'Flexiones', 'Flexiones de pecho con apoyo de manos al piso.', 20, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (38, 'Flexiones diamante', 'Flexiones con manos juntas formando un diamante.', 12, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (39, 'Curl martillo', 'Curl de bíceps con agarre neutro.', 12, 12);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (40, 'Curl concentrado', 'Curl concentrado sentado con mancuerna.', 12, 10);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (41, 'Extensiones en polea', 'Extensiones de tríceps en polea baja.', 15, 20);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (42, 'Peso muerto sumo', 'Peso muerto con agarre ancho y postura sumo.', 8, 70);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (43, 'Sentadilla frontal', 'Sentadilla frontal con barra.', 10, 30);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (44, 'Prensa de piernas', 'Prensa inclinada de piernas en máquina.', 12, 120);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (45, 'Extensiones de cuádriceps', 'Extensión de piernas en máquina.', 15, 35);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (46, 'Curl femoral', 'Curl de pierna acostado en máquina.', 12, 30);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (47, 'Gemelos de pie', 'Elevación de talones de pie, trabajo de gemelos.', 20, 40);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (48, 'Gemelos sentado', 'Elevación de talones sentado con lastre.', 20, 30);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (49, 'Remo con mancuerna', 'Remo a una mano con mancuerna apoyado en una banca.', 12, 15);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (50, 'Band pull apart', 'Apertura de banda elástica frente al pecho.', 20, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (51, 'Sentadilla con barra', 'Variante de sentadilla realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 20, 115);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (52, 'Sentadilla con mancuerna', 'Variante de sentadilla realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 8, 1);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (53, 'Sentadilla con polea', 'Variante de sentadilla realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 9, 8);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (54, 'Sentadilla con máquina', 'Variante de sentadilla realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 10, 15);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (55, 'Sentadilla con banda', 'Variante de sentadilla realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 11, 22);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (56, 'Press banca con barra', 'Variante de press banca realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 12, 29);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (57, 'Press banca con mancuerna', 'Variante de press banca realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 13, 36);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (58, 'Press banca con polea', 'Variante de press banca realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 14, 43);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (59, 'Press banca con máquina', 'Variante de press banca realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 15, 50);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (60, 'Press banca con banda', 'Variante de press banca realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 16, 57);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (61, 'Peso muerto con barra', 'Variante de peso muerto realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 17, 64);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (62, 'Peso muerto con mancuerna', 'Variante de peso muerto realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 18, 71);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (63, 'Peso muerto con polea', 'Variante de peso muerto realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 19, 78);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (64, 'Peso muerto con máquina', 'Variante de peso muerto realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 20, 85);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (65, 'Peso muerto con banda', 'Variante de peso muerto realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 8, 92);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (66, 'Remo con polea', 'Variante de remo realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 9, 99);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (67, 'Remo con máquina', 'Variante de remo realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 10, 106);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (68, 'Remo con banda', 'Variante de remo realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 11, 113);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (69, 'Press militar con barra', 'Variante de press militar realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 12, 120);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (70, 'Press militar con mancuerna', 'Variante de press militar realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 13, 6);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (71, 'Press militar con polea', 'Variante de press militar realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 14, 13);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (72, 'Press militar con máquina', 'Variante de press militar realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 15, 20);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (73, 'Press militar con banda', 'Variante de press militar realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 16, 27);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (74, 'Curl bíceps con barra', 'Variante de curl bíceps realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 17, 34);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (75, 'Curl bíceps con mancuerna', 'Variante de curl bíceps realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 18, 41);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (76, 'Curl bíceps con polea', 'Variante de curl bíceps realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 19, 48);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (77, 'Curl bíceps con máquina', 'Variante de curl bíceps realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 20, 55);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (78, 'Curl bíceps con banda', 'Variante de curl bíceps realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 8, 62);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (79, 'Curl femoral con barra', 'Variante de curl femoral realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 9, 69);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (80, 'Curl femoral con mancuerna', 'Variante de curl femoral realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 10, 76);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (81, 'Curl femoral con polea', 'Variante de curl femoral realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 11, 83);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (82, 'Curl femoral con máquina', 'Variante de curl femoral realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 12, 90);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (83, 'Curl femoral con banda', 'Variante de curl femoral realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 13, 97);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (84, 'Jalón pecho con barra', 'Variante de jalón pecho realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 14, 104);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (85, 'Jalón pecho con mancuerna', 'Variante de jalón pecho realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 15, 111);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (86, 'Jalón pecho con polea', 'Variante de jalón pecho realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 16, 118);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (87, 'Jalón pecho con máquina', 'Variante de jalón pecho realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 17, 4);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (88, 'Jalón pecho con banda', 'Variante de jalón pecho realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 18, 11);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (89, 'Elev. lateral con barra', 'Variante de elev. lateral realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 19, 18);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (90, 'Elev. lateral con mancuerna', 'Variante de elev. lateral realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 20, 25);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (91, 'Elev. lateral con polea', 'Variante de elev. lateral realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 8, 32);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (92, 'Elev. lateral con máquina', 'Variante de elev. lateral realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 9, 39);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (93, 'Elev. lateral con banda', 'Variante de elev. lateral realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 10, 46);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (94, 'Apertura con barra', 'Variante de apertura realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 11, 53);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (95, 'Apertura con mancuerna', 'Variante de apertura realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 12, 60);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (96, 'Apertura con polea', 'Variante de apertura realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 13, 67);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (97, 'Apertura con máquina', 'Variante de apertura realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 14, 74);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (98, 'Apertura con banda', 'Variante de apertura realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 15, 81);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (99, 'Zancada con barra', 'Variante de zancada realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 16, 88);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (100, 'Zancada con mancuerna', 'Variante de zancada realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 17, 95);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (101, 'Zancada con polea', 'Variante de zancada realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 18, 102);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (102, 'Zancada con máquina', 'Variante de zancada realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 19, 109);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (103, 'Zancada con banda', 'Variante de zancada realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 20, 116);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (104, 'Hip thrust con barra', 'Variante de hip thrust realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 8, 2);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (105, 'Hip thrust con mancuerna', 'Variante de hip thrust realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 9, 9);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (106, 'Hip thrust con polea', 'Variante de hip thrust realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 10, 16);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (107, 'Hip thrust con máquina', 'Variante de hip thrust realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 11, 23);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (108, 'Hip thrust con banda', 'Variante de hip thrust realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 12, 30);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (109, 'Plancha con barra', 'Variante de plancha realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 13, 37);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (110, 'Plancha con mancuerna', 'Variante de plancha realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 14, 44);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (111, 'Plancha con polea', 'Variante de plancha realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 15, 51);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (112, 'Plancha con máquina', 'Variante de plancha realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 16, 58);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (113, 'Plancha con banda', 'Variante de plancha realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 17, 65);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (114, 'Abdominal con barra', 'Variante de abdominal realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 18, 72);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (115, 'Abdominal con mancuerna', 'Variante de abdominal realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 19, 79);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (116, 'Abdominal con polea', 'Variante de abdominal realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 20, 86);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (117, 'Abdominal con máquina', 'Variante de abdominal realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 8, 93);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (118, 'Abdominal con banda', 'Variante de abdominal realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 9, 100);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (119, 'Gemelo con barra', 'Variante de gemelo realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 10, 107);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (120, 'Gemelo con mancuerna', 'Variante de gemelo realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 11, 114);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (121, 'Gemelo con polea', 'Variante de gemelo realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 12, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (122, 'Gemelo con máquina', 'Variante de gemelo realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 13, 7);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (123, 'Gemelo con banda', 'Variante de gemelo realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 14, 14);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (124, 'Fondos con barra', 'Variante de fondos realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 15, 21);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (125, 'Fondos con mancuerna', 'Variante de fondos realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 16, 28);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (126, 'Fondos con polea', 'Variante de fondos realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 17, 35);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (127, 'Fondos con máquina', 'Variante de fondos realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 18, 42);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (128, 'Fondos con banda', 'Variante de fondos realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 19, 49);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (129, 'Dominada con barra', 'Variante de dominada realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 20, 56);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (130, 'Dominada con mancuerna', 'Variante de dominada realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 8, 63);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (131, 'Dominada con polea', 'Variante de dominada realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 9, 70);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (132, 'Dominada con máquina', 'Variante de dominada realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 10, 77);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (133, 'Dominada con banda', 'Variante de dominada realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 11, 84);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (134, 'Burpee con barra', 'Variante de burpee realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 12, 91);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (135, 'Burpee con mancuerna', 'Variante de burpee realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 13, 98);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (136, 'Burpee con polea', 'Variante de burpee realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 14, 105);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (137, 'Burpee con máquina', 'Variante de burpee realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 15, 112);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (138, 'Burpee con banda', 'Variante de burpee realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 16, 119);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (139, 'Salto con barra', 'Variante de salto realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 17, 5);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (140, 'Salto con mancuerna', 'Variante de salto realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 18, 12);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (141, 'Salto con polea', 'Variante de salto realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 19, 19);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (142, 'Salto con máquina', 'Variante de salto realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 20, 26);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (143, 'Salto con banda', 'Variante de salto realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 8, 33);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (144, 'Sprint con barra', 'Variante de sprint realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 9, 40);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (145, 'Sprint con mancuerna', 'Variante de sprint realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 10, 47);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (146, 'Sprint con polea', 'Variante de sprint realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 11, 54);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (147, 'Sprint con máquina', 'Variante de sprint realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 12, 61);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (148, 'Sprint con banda', 'Variante de sprint realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 13, 68);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (149, 'Flexión con barra', 'Variante de flexión realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 14, 75);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (150, 'Flexión con mancuerna', 'Variante de flexión realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 15, 82);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (151, 'Flexión con polea', 'Variante de flexión realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 16, 89);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (152, 'Flexión con máquina', 'Variante de flexión realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 17, 96);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (153, 'Flexión con banda', 'Variante de flexión realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 18, 103);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (154, 'Face pull con barra', 'Variante de face pull realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 19, 110);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (155, 'Face pull con mancuerna', 'Variante de face pull realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 20, 117);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (156, 'Face pull con polea', 'Variante de face pull realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 8, 3);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (157, 'Face pull con máquina', 'Variante de face pull realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 9, 10);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (158, 'Face pull con banda', 'Variante de face pull realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 10, 17);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (159, 'Encogimiento con barra', 'Variante de encogimiento realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 11, 24);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (160, 'Encogimiento con mancuerna', 'Variante de encogimiento realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 12, 31);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (161, 'Encogimiento con polea', 'Variante de encogimiento realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 13, 38);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (162, 'Encogimiento con máquina', 'Variante de encogimiento realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 14, 45);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (163, 'Encogimiento con banda', 'Variante de encogimiento realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 15, 52);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (164, 'Puente con barra', 'Variante de puente realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 16, 59);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (165, 'Puente con mancuerna', 'Variante de puente realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 17, 66);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (166, 'Puente con polea', 'Variante de puente realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 18, 73);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (167, 'Puente con máquina', 'Variante de puente realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 19, 80);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (168, 'Puente con banda', 'Variante de puente realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 20, 87);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (169, 'Prensa con barra', 'Variante de prensa realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 8, 94);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (170, 'Prensa con mancuerna', 'Variante de prensa realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 9, 101);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (171, 'Prensa con polea', 'Variante de prensa realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 10, 108);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (172, 'Prensa con máquina', 'Variante de prensa realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 11, 115);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (173, 'Prensa con banda', 'Variante de prensa realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 12, 1);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (174, 'Press incl. con barra', 'Variante de press incl. realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 13, 8);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (175, 'Press incl. con mancuerna', 'Variante de press incl. realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 14, 15);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (176, 'Press incl. con polea', 'Variante de press incl. realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 15, 22);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (177, 'Press incl. con máquina', 'Variante de press incl. realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 16, 29);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (178, 'Press incl. con banda', 'Variante de press incl. realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 17, 36);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (179, 'Remo unilat. con barra', 'Variante de remo unilat. realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 18, 43);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (180, 'Remo unilat. con mancuerna', 'Variante de remo unilat. realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 19, 50);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (181, 'Remo unilat. con polea', 'Variante de remo unilat. realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 20, 57);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (182, 'Remo unilat. con máquina', 'Variante de remo unilat. realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 8, 64);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (183, 'Remo unilat. con banda', 'Variante de remo unilat. realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 9, 71);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (184, 'Press Arnold con barra', 'Variante de press arnold realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 10, 78);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (185, 'Press Arnold con mancuerna', 'Variante de press arnold realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 11, 85);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (186, 'Press Arnold con polea', 'Variante de press arnold realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 12, 92);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (187, 'Press Arnold con máquina', 'Variante de press arnold realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 13, 99);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (188, 'Press Arnold con banda', 'Variante de press arnold realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 14, 106);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (189, 'Goblet con barra', 'Variante de goblet realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 15, 113);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (190, 'Goblet con mancuerna', 'Variante de goblet realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 16, 120);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (191, 'Goblet con polea', 'Variante de goblet realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 17, 6);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (192, 'Goblet con máquina', 'Variante de goblet realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 18, 13);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (193, 'Goblet con banda', 'Variante de goblet realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 19, 20);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (194, 'PM sumo con barra', 'Variante de pm sumo realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 20, 27);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (195, 'PM sumo con mancuerna', 'Variante de pm sumo realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 8, 34);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (196, 'PM sumo con polea', 'Variante de pm sumo realizada con polea; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 9, 41);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (197, 'PM sumo con máquina', 'Variante de pm sumo realizada con máquina; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 10, 48);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (198, 'PM sumo con banda', 'Variante de pm sumo realizada con banda; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 11, 55);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (199, 'Remo invertido con barra', 'Variante de remo invertido realizada con barra; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 12, 62);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (200, 'Remo invertido con mancuerna', 'Variante de remo invertido realizada con mancuerna; se enfatiza la técnica, el control postural y la respiración durante todo el movimiento.', 13, 69);

-- RUTINA: 200 registros
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (1, 'Rutina de hipertrofia 1', '11.998.500-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (2, 'Rutina Full Body A 2', '15.360.060-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (3, 'Rutina Full Body B 3', '18.430.815-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (4, 'Rutina Push Day 4', '25.960.879-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (5, 'Rutina Pull Day 5', '18.586.960-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (6, 'Rutina de piernas 6', '20.858.183-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (7, 'Rutina de espalda 7', '24.428.415-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (8, 'Rutina de pecho 8', '25.987.858-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (9, 'Rutina de hombros 9', '11.721.960-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (10, 'Rutina de brazos 10', '24.833.068-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (11, 'Rutina funcional 11', '13.746.093-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (12, 'Rutina de fuerza 12', '25.012.372-8');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (13, 'Rutina cardio HIIT 13', '20.083.621-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (14, 'Rutina de definición 14', '20.426.773-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (15, 'Rutina de resistencia 15', '19.337.510-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (16, 'Rutina de inicio 16', '17.056.747-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (17, 'Rutina avanzada 17', '23.142.824-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (18, 'Rutina de glúteos 18', '19.606.110-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (19, 'Rutina de torso 19', '19.190.751-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (20, 'Rutina de abdomen 20', '24.133.155-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (21, 'Rutina de hipertrofia 21', '22.256.410-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (22, 'Rutina Full Body A 22', '23.028.725-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (23, 'Rutina Full Body B 23', '22.886.836-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (24, 'Rutina Push Day 24', '18.236.009-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (25, 'Rutina Pull Day 25', '22.600.124-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (26, 'Rutina de piernas 26', '22.970.008-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (27, 'Rutina de espalda 27', '19.840.186-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (28, 'Rutina de pecho 28', '17.400.346-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (29, 'Rutina de hombros 29', '14.025.425-8');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (30, 'Rutina de brazos 30', '10.042.527-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (31, 'Rutina funcional 31', '20.304.637-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (32, 'Rutina de fuerza 32', '11.354.318-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (33, 'Rutina cardio HIIT 33', '11.857.850-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (34, 'Rutina de definición 34', '14.819.091-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (35, 'Rutina de resistencia 35', '23.702.981-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (36, 'Rutina de inicio 36', '11.645.033-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (37, 'Rutina avanzada 37', '17.543.956-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (38, 'Rutina de glúteos 38', '10.192.750-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (39, 'Rutina de torso 39', '23.669.449-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (40, 'Rutina de abdomen 40', '24.947.890-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (41, 'Rutina de hipertrofia 41', '21.495.380-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (42, 'Rutina Full Body A 42', '18.225.646-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (43, 'Rutina Full Body B 43', '21.398.255-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (44, 'Rutina Push Day 44', '15.271.957-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (45, 'Rutina Pull Day 45', '13.526.984-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (46, 'Rutina de piernas 46', '16.664.202-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (47, 'Rutina de espalda 47', '14.219.689-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (48, 'Rutina de pecho 48', '15.832.730-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (49, 'Rutina de hombros 49', '25.591.357-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (50, 'Rutina de brazos 50', '15.983.360-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (51, 'Rutina de hipertrofia 51', '26.000.867-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (52, 'Rutina de fuerza 52', '26.000.884-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (53, 'Rutina de definición 53', '26.000.901-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (54, 'Rutina de resistencia 54', '26.000.918-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (55, 'Rutina de movilidad 55', '26.000.935-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (56, 'Rutina de glúteos 56', '26.000.952-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (57, 'Rutina de espalda 57', '26.000.969-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (58, 'Rutina de piernas 58', '26.000.986-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (59, 'Rutina de pecho 59', '26.001.003-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (60, 'Rutina de brazos 60', '26.001.020-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (61, 'Rutina de hipertrofia 61', '26.001.037-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (62, 'Rutina de fuerza 62', '26.001.054-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (63, 'Rutina de definición 63', '26.001.071-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (64, 'Rutina de resistencia 64', '26.001.088-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (65, 'Rutina de movilidad 65', '26.001.105-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (66, 'Rutina de glúteos 66', '26.001.122-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (67, 'Rutina de espalda 67', '26.001.139-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (68, 'Rutina de piernas 68', '26.001.156-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (69, 'Rutina de pecho 69', '26.001.173-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (70, 'Rutina de brazos 70', '26.001.190-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (71, 'Rutina de hipertrofia 71', '26.001.207-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (72, 'Rutina de fuerza 72', '26.001.224-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (73, 'Rutina de definición 73', '26.001.241-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (74, 'Rutina de resistencia 74', '26.001.258-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (75, 'Rutina de movilidad 75', '26.001.275-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (76, 'Rutina de glúteos 76', '26.001.292-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (77, 'Rutina de espalda 77', '26.001.309-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (78, 'Rutina de piernas 78', '26.001.326-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (79, 'Rutina de pecho 79', '26.001.343-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (80, 'Rutina de brazos 80', '26.001.360-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (81, 'Rutina de hipertrofia 81', '26.001.377-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (82, 'Rutina de fuerza 82', '26.001.394-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (83, 'Rutina de definición 83', '26.001.411-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (84, 'Rutina de resistencia 84', '26.001.428-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (85, 'Rutina de movilidad 85', '26.001.445-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (86, 'Rutina de glúteos 86', '26.001.462-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (87, 'Rutina de espalda 87', '26.001.479-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (88, 'Rutina de piernas 88', '26.001.496-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (89, 'Rutina de pecho 89', '26.001.513-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (90, 'Rutina de brazos 90', '26.001.530-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (91, 'Rutina de hipertrofia 91', '26.001.547-8');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (92, 'Rutina de fuerza 92', '26.001.564-8');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (93, 'Rutina de definición 93', '26.001.581-8');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (94, 'Rutina de resistencia 94', '26.001.598-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (95, 'Rutina de movilidad 95', '26.001.615-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (96, 'Rutina de glúteos 96', '26.001.632-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (97, 'Rutina de espalda 97', '26.001.649-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (98, 'Rutina de piernas 98', '26.001.666-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (99, 'Rutina de pecho 99', '26.001.683-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (100, 'Rutina de brazos 100', '26.001.700-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (101, 'Rutina de hipertrofia 101', '26.001.717-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (102, 'Rutina de fuerza 102', '26.001.734-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (103, 'Rutina de definición 103', '26.001.751-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (104, 'Rutina de resistencia 104', '26.001.768-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (105, 'Rutina de movilidad 105', '26.001.785-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (106, 'Rutina de glúteos 106', '26.001.802-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (107, 'Rutina de espalda 107', '26.001.819-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (108, 'Rutina de piernas 108', '26.001.836-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (109, 'Rutina de pecho 109', '26.001.853-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (110, 'Rutina de brazos 110', '26.001.870-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (111, 'Rutina de hipertrofia 111', '26.001.887-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (112, 'Rutina de fuerza 112', '26.001.904-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (113, 'Rutina de definición 113', '26.001.921-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (114, 'Rutina de resistencia 114', '26.001.938-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (115, 'Rutina de movilidad 115', '26.001.955-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (116, 'Rutina de glúteos 116', '26.001.972-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (117, 'Rutina de espalda 117', '26.001.989-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (118, 'Rutina de piernas 118', '26.002.006-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (119, 'Rutina de pecho 119', '26.002.023-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (120, 'Rutina de brazos 120', '26.002.040-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (121, 'Rutina de hipertrofia 121', '26.002.057-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (122, 'Rutina de fuerza 122', '26.002.074-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (123, 'Rutina de definición 123', '26.002.091-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (124, 'Rutina de resistencia 124', '26.002.108-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (125, 'Rutina de movilidad 125', '26.002.125-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (126, 'Rutina de glúteos 126', '26.002.142-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (127, 'Rutina de espalda 127', '26.002.159-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (128, 'Rutina de piernas 128', '26.002.176-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (129, 'Rutina de pecho 129', '26.002.193-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (130, 'Rutina de brazos 130', '26.002.210-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (131, 'Rutina de hipertrofia 131', '26.002.227-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (132, 'Rutina de fuerza 132', '26.002.244-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (133, 'Rutina de definición 133', '26.002.261-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (134, 'Rutina de resistencia 134', '26.002.278-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (135, 'Rutina de movilidad 135', '26.002.295-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (136, 'Rutina de glúteos 136', '26.002.312-8');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (137, 'Rutina de espalda 137', '26.002.329-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (138, 'Rutina de piernas 138', '26.002.346-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (139, 'Rutina de pecho 139', '26.002.363-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (140, 'Rutina de brazos 140', '26.002.380-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (141, 'Rutina de hipertrofia 141', '26.002.397-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (142, 'Rutina de fuerza 142', '26.002.414-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (143, 'Rutina de definición 143', '26.002.431-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (144, 'Rutina de resistencia 144', '26.002.448-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (145, 'Rutina de movilidad 145', '26.002.465-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (146, 'Rutina de glúteos 146', '26.002.482-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (147, 'Rutina de espalda 147', '26.002.499-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (148, 'Rutina de piernas 148', '26.002.516-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (149, 'Rutina de pecho 149', '26.002.533-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (150, 'Rutina de brazos 150', '26.002.550-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (151, 'Rutina de hipertrofia 151', '26.002.567-8');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (152, 'Rutina de fuerza 152', '26.002.584-8');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (153, 'Rutina de definición 153', '26.002.601-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (154, 'Rutina de resistencia 154', '26.002.618-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (155, 'Rutina de movilidad 155', '26.002.635-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (156, 'Rutina de glúteos 156', '26.002.652-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (157, 'Rutina de espalda 157', '26.002.669-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (158, 'Rutina de piernas 158', '26.002.686-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (159, 'Rutina de pecho 159', '26.002.703-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (160, 'Rutina de brazos 160', '26.002.720-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (161, 'Rutina de hipertrofia 161', '26.002.737-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (162, 'Rutina de fuerza 162', '26.002.754-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (163, 'Rutina de definición 163', '26.002.771-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (164, 'Rutina de resistencia 164', '26.002.788-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (165, 'Rutina de movilidad 165', '26.002.805-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (166, 'Rutina de glúteos 166', '26.002.822-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (167, 'Rutina de espalda 167', '26.002.839-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (168, 'Rutina de piernas 168', '26.002.856-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (169, 'Rutina de pecho 169', '26.002.873-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (170, 'Rutina de brazos 170', '26.002.890-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (171, 'Rutina de hipertrofia 171', '26.002.907-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (172, 'Rutina de fuerza 172', '26.002.924-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (173, 'Rutina de definición 173', '26.002.941-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (174, 'Rutina de resistencia 174', '26.002.958-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (175, 'Rutina de movilidad 175', '26.002.975-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (176, 'Rutina de glúteos 176', '26.002.992-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (177, 'Rutina de espalda 177', '26.003.009-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (178, 'Rutina de piernas 178', '26.003.026-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (179, 'Rutina de pecho 179', '26.003.043-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (180, 'Rutina de brazos 180', '26.003.060-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (181, 'Rutina de hipertrofia 181', '26.003.077-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (182, 'Rutina de fuerza 182', '26.003.094-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (183, 'Rutina de definición 183', '26.003.111-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (184, 'Rutina de resistencia 184', '26.003.128-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (185, 'Rutina de movilidad 185', '26.003.145-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (186, 'Rutina de glúteos 186', '26.003.162-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (187, 'Rutina de espalda 187', '26.003.179-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (188, 'Rutina de piernas 188', '26.003.196-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (189, 'Rutina de pecho 189', '26.003.213-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (190, 'Rutina de brazos 190', '26.003.230-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (191, 'Rutina de hipertrofia 191', '26.003.247-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (192, 'Rutina de fuerza 192', '26.003.264-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (193, 'Rutina de definición 193', '26.003.281-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (194, 'Rutina de resistencia 194', '26.003.298-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (195, 'Rutina de movilidad 195', '26.003.315-8');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (196, 'Rutina de glúteos 196', '26.003.332-8');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (197, 'Rutina de espalda 197', '26.003.349-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (198, 'Rutina de piernas 198', '26.003.366-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (199, 'Rutina de pecho 199', '26.003.383-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (200, 'Rutina de brazos 200', '26.003.400-6');

-- CONTENER: 200 registros
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (1, 2);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (2, 4);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (3, 6);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (4, 8);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (5, 10);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (6, 12);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (7, 14);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (8, 16);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (9, 18);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (10, 20);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (11, 22);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (12, 24);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (13, 26);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (14, 28);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (15, 30);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (16, 32);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (17, 34);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (18, 36);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (19, 38);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (20, 40);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (21, 42);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (22, 44);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (23, 46);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (24, 48);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (25, 50);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (26, 2);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (27, 4);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (28, 6);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (29, 8);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (30, 10);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (31, 12);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (32, 14);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (33, 16);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (34, 18);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (35, 20);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (36, 22);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (37, 24);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (38, 26);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (39, 28);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (40, 30);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (41, 32);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (42, 34);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (43, 36);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (44, 38);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (45, 40);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (46, 42);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (47, 44);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (48, 46);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (49, 48);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (50, 50);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (51, 51);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (52, 52);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (53, 53);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (54, 54);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (55, 55);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (56, 56);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (57, 57);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (58, 58);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (59, 59);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (60, 60);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (61, 61);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (62, 62);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (63, 63);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (64, 64);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (65, 65);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (66, 66);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (67, 67);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (68, 68);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (69, 69);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (70, 70);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (71, 71);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (72, 72);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (73, 73);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (74, 74);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (75, 75);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (76, 76);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (77, 77);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (78, 78);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (79, 79);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (80, 80);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (81, 81);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (82, 82);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (83, 83);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (84, 84);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (85, 85);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (86, 86);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (87, 87);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (88, 88);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (89, 89);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (90, 90);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (91, 91);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (92, 92);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (93, 93);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (94, 94);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (95, 95);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (96, 96);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (97, 97);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (98, 98);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (99, 99);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (100, 100);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (101, 101);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (102, 102);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (103, 103);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (104, 104);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (105, 105);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (106, 106);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (107, 107);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (108, 108);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (109, 109);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (110, 110);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (111, 111);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (112, 112);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (113, 113);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (114, 114);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (115, 115);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (116, 116);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (117, 117);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (118, 118);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (119, 119);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (120, 120);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (121, 121);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (122, 122);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (123, 123);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (124, 124);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (125, 125);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (126, 126);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (127, 127);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (128, 128);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (129, 129);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (130, 130);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (131, 131);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (132, 132);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (133, 133);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (134, 134);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (135, 135);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (136, 136);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (137, 137);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (138, 138);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (139, 139);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (140, 140);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (141, 141);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (142, 142);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (143, 143);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (144, 144);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (145, 145);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (146, 146);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (147, 147);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (148, 148);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (149, 149);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (150, 150);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (151, 151);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (152, 152);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (153, 153);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (154, 154);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (155, 155);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (156, 156);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (157, 157);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (158, 158);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (159, 159);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (160, 160);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (161, 161);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (162, 162);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (163, 163);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (164, 164);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (165, 165);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (166, 166);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (167, 167);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (168, 168);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (169, 169);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (170, 170);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (171, 171);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (172, 172);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (173, 173);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (174, 174);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (175, 175);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (176, 176);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (177, 177);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (178, 178);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (179, 179);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (180, 180);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (181, 181);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (182, 182);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (183, 183);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (184, 184);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (185, 185);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (186, 186);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (187, 187);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (188, 188);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (189, 189);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (190, 190);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (191, 191);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (192, 192);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (193, 193);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (194, 194);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (195, 195);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (196, 196);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (197, 197);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (198, 198);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (199, 199);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (200, 200);

-- DEFINIR: 200 registros
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('23.507.938-0', 1);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('16.314.012-8', 2);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('22.515.298-5', 3);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('18.616.569-1', 4);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('20.699.123-2', 5);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('11.280.435-8', 6);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('22.131.805-6', 7);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('15.710.873-5', 8);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('11.504.328-5', 9);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('19.352.468-0', 10);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('19.027.228-1', 11);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('14.900.991-4', 12);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('14.825.159-2', 13);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('17.674.700-5', 14);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('12.363.714-3', 15);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.704.807-3', 16);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('20.817.865-2', 17);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('21.810.749-4', 18);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('22.019.455-8', 19);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('19.687.556-5', 20);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('15.184.138-4', 21);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('10.415.056-K', 22);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.223.627-0', 23);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('21.926.290-6', 24);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('16.188.185-6', 25);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('16.099.226-3', 26);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('17.735.513-5', 27);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('17.083.634-0', 28);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('11.521.428-4', 29);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('16.690.306-8', 30);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.947.974-8', 31);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('19.826.714-7', 32);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('19.302.111-5', 33);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('18.362.688-4', 34);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.549.625-7', 35);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('11.953.672-3', 36);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('17.137.754-4', 37);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('18.495.290-4', 38);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('23.464.542-0', 39);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('22.585.374-6', 40);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.541.731-4', 41);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('20.069.101-6', 42);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.687.336-4', 43);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('18.238.128-4', 44);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('16.679.821-3', 45);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('25.380.590-0', 46);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('18.802.211-1', 47);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('14.339.316-K', 48);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.167.984-5', 49);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('17.045.862-1', 50);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.000.969-7', 51);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.000.988-3', 52);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.007-5', 53);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.026-1', 54);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.045-8', 55);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.064-4', 56);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.083-0', 57);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.102-0', 58);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.121-7', 59);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.140-3', 60);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.159-4', 61);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.178-0', 62);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.197-7', 63);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.216-7', 64);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.235-3', 65);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.254-K', 66);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.273-6', 67);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.292-2', 68);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.311-2', 69);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.330-9', 70);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.349-K', 71);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.368-6', 72);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.387-2', 73);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.406-2', 74);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.425-9', 75);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.444-5', 76);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.463-1', 77);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.482-8', 78);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.501-8', 79);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.520-4', 80);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.539-5', 81);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.558-1', 82);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.577-8', 83);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.596-4', 84);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.615-4', 85);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.634-0', 86);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.653-7', 87);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.672-3', 88);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.691-K', 89);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.710-K', 90);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.729-0', 91);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.748-7', 92);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.767-3', 93);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.786-K', 94);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.805-K', 95);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.824-6', 96);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.843-2', 97);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.862-9', 98);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.881-5', 99);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.900-5', 100);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.919-6', 101);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.938-2', 102);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.957-9', 103);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.976-5', 104);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.001.995-1', 105);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.014-3', 106);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.033-K', 107);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.052-6', 108);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.071-2', 109);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.090-9', 110);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.109-3', 111);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.128-K', 112);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.147-6', 113);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.166-2', 114);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.185-9', 115);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.204-9', 116);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.223-5', 117);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.242-1', 118);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.261-8', 119);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.280-4', 120);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.299-5', 121);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.318-5', 122);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.337-1', 123);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.356-8', 124);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.375-4', 125);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.394-0', 126);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.413-0', 127);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.432-7', 128);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.451-3', 129);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.470-K', 130);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.489-0', 131);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.508-0', 132);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.527-7', 133);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.546-3', 134);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.565-K', 135);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.584-6', 136);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.603-6', 137);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.622-2', 138);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.641-9', 139);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.660-5', 140);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.679-6', 141);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.698-2', 142);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.717-2', 143);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.736-9', 144);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.755-5', 145);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.774-1', 146);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.793-8', 147);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.812-8', 148);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.831-4', 149);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.850-0', 150);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.869-1', 151);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.888-8', 152);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.907-8', 153);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.926-4', 154);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.945-0', 155);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.964-7', 156);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.002.983-3', 157);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.002-5', 158);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.021-1', 159);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.040-8', 160);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.059-9', 161);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.078-5', 162);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.097-1', 163);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.116-1', 164);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.135-8', 165);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.154-4', 166);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.173-0', 167);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.192-7', 168);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.211-7', 169);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.230-3', 170);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.249-4', 171);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.268-0', 172);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.287-7', 173);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.306-7', 174);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.325-3', 175);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.344-K', 176);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.363-6', 177);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.382-2', 178);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.401-2', 179);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.420-9', 180);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.439-K', 181);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.458-6', 182);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.477-2', 183);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.496-9', 184);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.515-9', 185);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.534-5', 186);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.553-1', 187);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.572-8', 188);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.591-4', 189);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.610-4', 190);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.629-5', 191);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.648-1', 192);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.667-8', 193);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.686-4', 194);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.705-4', 195);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.724-0', 196);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.743-7', 197);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.762-3', 198);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.781-K', 199);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('27.003.800-K', 200);

-- DISENAR: 200 registros
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('23.507.938-0', 1);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('16.314.012-8', 2);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('22.515.298-5', 3);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('18.616.569-1', 4);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('20.699.123-2', 5);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('11.280.435-8', 6);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('22.131.805-6', 7);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('15.710.873-5', 8);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('11.504.328-5', 9);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('19.352.468-0', 10);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('19.027.228-1', 11);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('14.900.991-4', 12);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('14.825.159-2', 13);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('17.674.700-5', 14);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('12.363.714-3', 15);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.704.807-3', 16);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('20.817.865-2', 17);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('21.810.749-4', 18);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('22.019.455-8', 19);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('19.687.556-5', 20);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('15.184.138-4', 21);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('10.415.056-K', 22);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.223.627-0', 23);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('21.926.290-6', 24);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('16.188.185-6', 25);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('16.099.226-3', 26);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('17.735.513-5', 27);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('17.083.634-0', 28);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('11.521.428-4', 29);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('16.690.306-8', 30);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.947.974-8', 31);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('19.826.714-7', 32);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('19.302.111-5', 33);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('18.362.688-4', 34);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.549.625-7', 35);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('11.953.672-3', 36);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('17.137.754-4', 37);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('18.495.290-4', 38);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('23.464.542-0', 39);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('22.585.374-6', 40);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.541.731-4', 41);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('20.069.101-6', 42);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.687.336-4', 43);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('18.238.128-4', 44);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('16.679.821-3', 45);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('25.380.590-0', 46);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('18.802.211-1', 47);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('14.339.316-K', 48);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.167.984-5', 49);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('17.045.862-1', 50);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.000.969-7', 51);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.000.988-3', 52);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.007-5', 53);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.026-1', 54);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.045-8', 55);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.064-4', 56);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.083-0', 57);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.102-0', 58);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.121-7', 59);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.140-3', 60);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.159-4', 61);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.178-0', 62);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.197-7', 63);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.216-7', 64);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.235-3', 65);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.254-K', 66);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.273-6', 67);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.292-2', 68);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.311-2', 69);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.330-9', 70);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.349-K', 71);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.368-6', 72);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.387-2', 73);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.406-2', 74);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.425-9', 75);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.444-5', 76);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.463-1', 77);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.482-8', 78);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.501-8', 79);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.520-4', 80);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.539-5', 81);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.558-1', 82);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.577-8', 83);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.596-4', 84);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.615-4', 85);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.634-0', 86);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.653-7', 87);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.672-3', 88);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.691-K', 89);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.710-K', 90);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.729-0', 91);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.748-7', 92);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.767-3', 93);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.786-K', 94);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.805-K', 95);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.824-6', 96);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.843-2', 97);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.862-9', 98);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.881-5', 99);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.900-5', 100);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.919-6', 101);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.938-2', 102);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.957-9', 103);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.976-5', 104);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.001.995-1', 105);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.014-3', 106);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.033-K', 107);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.052-6', 108);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.071-2', 109);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.090-9', 110);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.109-3', 111);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.128-K', 112);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.147-6', 113);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.166-2', 114);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.185-9', 115);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.204-9', 116);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.223-5', 117);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.242-1', 118);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.261-8', 119);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.280-4', 120);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.299-5', 121);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.318-5', 122);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.337-1', 123);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.356-8', 124);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.375-4', 125);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.394-0', 126);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.413-0', 127);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.432-7', 128);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.451-3', 129);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.470-K', 130);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.489-0', 131);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.508-0', 132);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.527-7', 133);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.546-3', 134);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.565-K', 135);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.584-6', 136);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.603-6', 137);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.622-2', 138);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.641-9', 139);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.660-5', 140);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.679-6', 141);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.698-2', 142);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.717-2', 143);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.736-9', 144);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.755-5', 145);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.774-1', 146);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.793-8', 147);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.812-8', 148);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.831-4', 149);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.850-0', 150);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.869-1', 151);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.888-8', 152);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.907-8', 153);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.926-4', 154);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.945-0', 155);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.964-7', 156);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.002.983-3', 157);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.002-5', 158);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.021-1', 159);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.040-8', 160);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.059-9', 161);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.078-5', 162);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.097-1', 163);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.116-1', 164);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.135-8', 165);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.154-4', 166);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.173-0', 167);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.192-7', 168);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.211-7', 169);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.230-3', 170);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.249-4', 171);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.268-0', 172);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.287-7', 173);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.306-7', 174);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.325-3', 175);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.344-K', 176);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.363-6', 177);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.382-2', 178);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.401-2', 179);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.420-9', 180);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.439-K', 181);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.458-6', 182);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.477-2', 183);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.496-9', 184);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.515-9', 185);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.534-5', 186);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.553-1', 187);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.572-8', 188);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.591-4', 189);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.610-4', 190);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.629-5', 191);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.648-1', 192);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.667-8', 193);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.686-4', 194);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.705-4', 195);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.724-0', 196);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.743-7', 197);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.762-3', 198);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.781-K', 199);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('27.003.800-K', 200);

-- EMPLEA: 200 registros
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('23.507.938-0', 4);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('16.314.012-8', 5);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('22.515.298-5', 6);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('18.616.569-1', 7);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('20.699.123-2', 8);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('11.280.435-8', 9);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('22.131.805-6', 10);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('15.710.873-5', 11);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('11.504.328-5', 12);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('19.352.468-0', 13);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('19.027.228-1', 14);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('14.900.991-4', 15);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('14.825.159-2', 16);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('17.674.700-5', 17);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('12.363.714-3', 18);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.704.807-3', 19);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('20.817.865-2', 20);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('21.810.749-4', 21);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('22.019.455-8', 22);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('19.687.556-5', 23);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('15.184.138-4', 24);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('10.415.056-K', 25);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.223.627-0', 26);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('21.926.290-6', 27);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('16.188.185-6', 28);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('16.099.226-3', 29);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('17.735.513-5', 30);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('17.083.634-0', 31);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('11.521.428-4', 32);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('16.690.306-8', 33);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.947.974-8', 34);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('19.826.714-7', 35);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('19.302.111-5', 36);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('18.362.688-4', 37);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.549.625-7', 38);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('11.953.672-3', 39);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('17.137.754-4', 40);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('18.495.290-4', 41);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('23.464.542-0', 42);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('22.585.374-6', 43);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.541.731-4', 44);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('20.069.101-6', 45);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.687.336-4', 46);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('18.238.128-4', 47);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('16.679.821-3', 48);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('25.380.590-0', 49);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('18.802.211-1', 50);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('14.339.316-K', 1);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.167.984-5', 2);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('17.045.862-1', 3);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.000.969-7', 51);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.000.988-3', 52);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.007-5', 53);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.026-1', 54);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.045-8', 55);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.064-4', 56);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.083-0', 57);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.102-0', 58);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.121-7', 59);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.140-3', 60);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.159-4', 61);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.178-0', 62);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.197-7', 63);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.216-7', 64);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.235-3', 65);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.254-K', 66);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.273-6', 67);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.292-2', 68);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.311-2', 69);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.330-9', 70);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.349-K', 71);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.368-6', 72);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.387-2', 73);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.406-2', 74);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.425-9', 75);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.444-5', 76);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.463-1', 77);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.482-8', 78);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.501-8', 79);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.520-4', 80);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.539-5', 81);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.558-1', 82);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.577-8', 83);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.596-4', 84);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.615-4', 85);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.634-0', 86);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.653-7', 87);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.672-3', 88);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.691-K', 89);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.710-K', 90);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.729-0', 91);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.748-7', 92);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.767-3', 93);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.786-K', 94);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.805-K', 95);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.824-6', 96);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.843-2', 97);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.862-9', 98);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.881-5', 99);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.900-5', 100);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.919-6', 101);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.938-2', 102);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.957-9', 103);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.976-5', 104);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.001.995-1', 105);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.014-3', 106);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.033-K', 107);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.052-6', 108);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.071-2', 109);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.090-9', 110);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.109-3', 111);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.128-K', 112);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.147-6', 113);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.166-2', 114);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.185-9', 115);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.204-9', 116);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.223-5', 117);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.242-1', 118);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.261-8', 119);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.280-4', 120);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.299-5', 121);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.318-5', 122);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.337-1', 123);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.356-8', 124);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.375-4', 125);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.394-0', 126);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.413-0', 127);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.432-7', 128);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.451-3', 129);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.470-K', 130);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.489-0', 131);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.508-0', 132);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.527-7', 133);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.546-3', 134);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.565-K', 135);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.584-6', 136);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.603-6', 137);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.622-2', 138);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.641-9', 139);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.660-5', 140);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.679-6', 141);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.698-2', 142);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.717-2', 143);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.736-9', 144);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.755-5', 145);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.774-1', 146);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.793-8', 147);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.812-8', 148);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.831-4', 149);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.850-0', 150);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.869-1', 151);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.888-8', 152);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.907-8', 153);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.926-4', 154);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.945-0', 155);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.964-7', 156);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.002.983-3', 157);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.002-5', 158);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.021-1', 159);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.040-8', 160);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.059-9', 161);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.078-5', 162);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.097-1', 163);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.116-1', 164);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.135-8', 165);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.154-4', 166);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.173-0', 167);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.192-7', 168);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.211-7', 169);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.230-3', 170);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.249-4', 171);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.268-0', 172);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.287-7', 173);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.306-7', 174);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.325-3', 175);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.344-K', 176);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.363-6', 177);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.382-2', 178);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.401-2', 179);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.420-9', 180);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.439-K', 181);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.458-6', 182);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.477-2', 183);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.496-9', 184);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.515-9', 185);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.534-5', 186);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.553-1', 187);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.572-8', 188);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.591-4', 189);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.610-4', 190);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.629-5', 191);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.648-1', 192);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.667-8', 193);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.686-4', 194);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.705-4', 195);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.724-0', 196);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.743-7', 197);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.762-3', 198);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.781-K', 199);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('27.003.800-K', 200);

-- METODO_PAGO_CLI: 5 registros
INSERT INTO METODO_PAGO_CLI (id_metodo_pago, nombre_metodo_pago, descripcion_metodo_pago) VALUES (1, 'Efectivo', 'Pago en caja del gimnasio.');
INSERT INTO METODO_PAGO_CLI (id_metodo_pago, nombre_metodo_pago, descripcion_metodo_pago) VALUES (2, 'Tarjeta de Débito', 'Pago con tarjeta de débito Redcompra.');
INSERT INTO METODO_PAGO_CLI (id_metodo_pago, nombre_metodo_pago, descripcion_metodo_pago) VALUES (3, 'Tarjeta de Crédito', 'Pago con tarjeta de crédito Visa, Mastercard o American Express.');
INSERT INTO METODO_PAGO_CLI (id_metodo_pago, nombre_metodo_pago, descripcion_metodo_pago) VALUES (4, 'Transferencia', 'Transferencia a la cuenta corriente del gimnasio.');
INSERT INTO METODO_PAGO_CLI (id_metodo_pago, nombre_metodo_pago, descripcion_metodo_pago) VALUES (5, 'Pago QR', 'Pago escaneando el código QR del gimnasio desde la app.');

-- PAGO: 200 registros
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (1, 24990, TO_DATE('2026-08-31','YYYY-MM-DD'), 'Pagado', 1, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (2, 29990, TO_DATE('2026-09-10','YYYY-MM-DD'), 'Pagado', 2, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (3, 34990, TO_DATE('2026-03-31','YYYY-MM-DD'), 'Pagado', 3, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (4, 39990, TO_DATE('2026-07-28','YYYY-MM-DD'), 'Pagado', 4, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (5, 49990, TO_DATE('2026-07-24','YYYY-MM-DD'), 'Pagado', 5, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (6, 59990, TO_DATE('2024-11-11','YYYY-MM-DD'), 'Pagado', 6, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (7, 79990, TO_DATE('2026-02-16','YYYY-MM-DD'), 'Pagado', 7, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (8, 44990, TO_DATE('2026-08-25','YYYY-MM-DD'), 'Pagado', 8, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (9, 17990, TO_DATE('2026-07-28','YYYY-MM-DD'), 'Pagado', 9, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (10, 19990, TO_DATE('2026-09-07','YYYY-MM-DD'), 'Pagado', 10, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (11, 24990, TO_DATE('2026-09-16','YYYY-MM-DD'), 'Pagado', 11, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (12, 29990, TO_DATE('2026-08-02','YYYY-MM-DD'), 'Pagado', 12, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (13, 34990, TO_DATE('2026-08-12','YYYY-MM-DD'), 'Pagado', 13, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (14, 39990, TO_DATE('2026-09-02','YYYY-MM-DD'), 'Pagado', 14, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (15, 49990, TO_DATE('2025-11-10','YYYY-MM-DD'), 'Pagado', 15, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (16, 59990, TO_DATE('2026-04-13','YYYY-MM-DD'), 'Pagado', 16, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (17, 79990, TO_DATE('2026-07-31','YYYY-MM-DD'), 'Pagado', 17, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (18, 44990, TO_DATE('2026-04-24','YYYY-MM-DD'), 'Pagado', 18, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (19, 17990, TO_DATE('2026-09-13','YYYY-MM-DD'), 'Pagado', 19, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (20, 19990, TO_DATE('2026-08-29','YYYY-MM-DD'), 'Pagado', 20, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (21, 24990, TO_DATE('2026-08-01','YYYY-MM-DD'), 'Pagado', 21, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (22, 29990, TO_DATE('2026-09-11','YYYY-MM-DD'), 'Pagado', 22, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (23, 34990, TO_DATE('2026-07-03','YYYY-MM-DD'), 'Pagado', 23, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (24, 39990, TO_DATE('2026-05-02','YYYY-MM-DD'), 'Pagado', 24, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (25, 49990, TO_DATE('2026-08-01','YYYY-MM-DD'), 'Pagado', 25, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (26, 59990, TO_DATE('2025-11-23','YYYY-MM-DD'), 'Pagado', 26, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (27, 79990, TO_DATE('2025-03-17','YYYY-MM-DD'), 'Pagado', 27, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (28, 44990, TO_DATE('2026-08-29','YYYY-MM-DD'), 'Pagado', 28, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (29, 17990, TO_DATE('2026-08-28','YYYY-MM-DD'), 'Pagado', 29, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (30, 19990, TO_DATE('2026-08-08','YYYY-MM-DD'), 'Pagado', 30, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (31, 24990, TO_DATE('2026-09-17','YYYY-MM-DD'), 'Pagado', 31, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (32, 29990, TO_DATE('2026-09-02','YYYY-MM-DD'), 'Pagado', 32, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (33, 34990, TO_DATE('2026-05-18','YYYY-MM-DD'), 'Pagado', 33, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (34, 39990, TO_DATE('2026-09-12','YYYY-MM-DD'), 'Pagado', 34, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (35, 49990, TO_DATE('2026-05-17','YYYY-MM-DD'), 'Pagado', 35, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (36, 59990, TO_DATE('2025-05-05','YYYY-MM-DD'), 'Pagado', 36, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (37, 79990, TO_DATE('2025-10-15','YYYY-MM-DD'), 'Pagado', 37, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (38, 44990, TO_DATE('2026-07-27','YYYY-MM-DD'), 'Pagado', 38, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (39, 17990, TO_DATE('2026-08-15','YYYY-MM-DD'), 'Pagado', 39, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (40, 19990, TO_DATE('2026-08-29','YYYY-MM-DD'), 'Pagado', 40, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (41, 24990, TO_DATE('2026-09-08','YYYY-MM-DD'), 'Pagado', 41, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (42, 29990, TO_DATE('2026-08-12','YYYY-MM-DD'), 'Pagado', 42, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (43, 34990, TO_DATE('2026-07-07','YYYY-MM-DD'), 'Pagado', 43, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (44, 39990, TO_DATE('2026-08-03','YYYY-MM-DD'), 'Pagado', 44, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (45, 49990, TO_DATE('2026-02-10','YYYY-MM-DD'), 'Pagado', 45, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (46, 59990, TO_DATE('2025-12-10','YYYY-MM-DD'), 'Pagado', 46, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (47, 79990, TO_DATE('2026-03-29','YYYY-MM-DD'), 'Pagado', 47, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (48, 44990, TO_DATE('2026-06-10','YYYY-MM-DD'), 'Pagado', 48, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (49, 17990, TO_DATE('2026-08-29','YYYY-MM-DD'), 'Pagado', 49, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (50, 19990, TO_DATE('2026-09-07','YYYY-MM-DD'), 'Pagado', 50, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (51, 19990, TO_DATE('2026-09-03','YYYY-MM-DD'), 'Pagado', 51, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (52, 24990, TO_DATE('2026-09-15','YYYY-MM-DD'), 'Pagado', 52, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (53, 29990, TO_DATE('2026-09-03','YYYY-MM-DD'), 'Pagado', 53, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (54, 34990, TO_DATE('2026-09-20','YYYY-MM-DD'), 'Pagado', 54, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (55, 39990, TO_DATE('2026-07-04','YYYY-MM-DD'), 'Pagado', 55, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (56, 49990, TO_DATE('2026-06-18','YYYY-MM-DD'), 'Pagado', 56, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (57, 59990, TO_DATE('2026-06-22','YYYY-MM-DD'), 'Pagado', 57, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (58, 79990, TO_DATE('2026-07-04','YYYY-MM-DD'), 'Pagado', 58, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (59, 44990, TO_DATE('2026-08-21','YYYY-MM-DD'), 'Pagado', 59, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (60, 17990, TO_DATE('2026-09-05','YYYY-MM-DD'), 'Pagado', 60, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (61, 19990, TO_DATE('2026-09-17','YYYY-MM-DD'), 'Pagado', 61, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (62, 24990, TO_DATE('2026-09-05','YYYY-MM-DD'), 'Pagado', 62, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (63, 29990, TO_DATE('2026-09-17','YYYY-MM-DD'), 'Pagado', 63, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (64, 34990, TO_DATE('2026-07-22','YYYY-MM-DD'), 'Pagado', 64, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (65, 39990, TO_DATE('2026-07-29','YYYY-MM-DD'), 'Pagado', 65, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (66, 49990, TO_DATE('2026-04-12','YYYY-MM-DD'), 'Pagado', 66, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (67, 59990, TO_DATE('2025-10-17','YYYY-MM-DD'), 'Pagado', 67, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (68, 79990, TO_DATE('2025-10-29','YYYY-MM-DD'), 'Pagado', 68, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (69, 44990, TO_DATE('2026-09-15','YYYY-MM-DD'), 'Pagado', 69, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (70, 17990, TO_DATE('2026-08-26','YYYY-MM-DD'), 'Pagado', 70, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (71, 19990, TO_DATE('2026-09-07','YYYY-MM-DD'), 'Pagado', 71, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (72, 24990, TO_DATE('2026-08-26','YYYY-MM-DD'), 'Pagado', 72, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (73, 29990, TO_DATE('2026-09-07','YYYY-MM-DD'), 'Pagado', 73, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (74, 34990, TO_DATE('2026-08-16','YYYY-MM-DD'), 'Pagado', 74, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (75, 39990, TO_DATE('2026-08-23','YYYY-MM-DD'), 'Pagado', 75, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (76, 49990, TO_DATE('2026-07-31','YYYY-MM-DD'), 'Pagado', 76, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (77, 59990, TO_DATE('2026-02-04','YYYY-MM-DD'), 'Pagado', 77, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (78, 79990, TO_DATE('2026-02-16','YYYY-MM-DD'), 'Pagado', 78, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (79, 44990, TO_DATE('2026-07-17','YYYY-MM-DD'), 'Pagado', 79, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (80, 17990, TO_DATE('2026-09-09','YYYY-MM-DD'), 'Pagado', 80, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (81, 19990, TO_DATE('2026-08-28','YYYY-MM-DD'), 'Pagado', 81, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (82, 24990, TO_DATE('2026-09-09','YYYY-MM-DD'), 'Pagado', 82, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (83, 29990, TO_DATE('2026-08-28','YYYY-MM-DD'), 'Pagado', 83, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (84, 34990, TO_DATE('2026-09-10','YYYY-MM-DD'), 'Pagado', 84, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (85, 39990, TO_DATE('2026-06-24','YYYY-MM-DD'), 'Pagado', 85, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (86, 49990, TO_DATE('2026-05-25','YYYY-MM-DD'), 'Pagado', 86, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (87, 59990, TO_DATE('2026-05-25','YYYY-MM-DD'), 'Pagado', 87, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (88, 79990, TO_DATE('2026-06-06','YYYY-MM-DD'), 'Pagado', 88, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (89, 44990, TO_DATE('2026-08-11','YYYY-MM-DD'), 'Pagado', 89, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (90, 17990, TO_DATE('2026-08-30','YYYY-MM-DD'), 'Pagado', 90, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (91, 19990, TO_DATE('2026-09-11','YYYY-MM-DD'), 'Pagado', 91, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (92, 24990, TO_DATE('2026-08-30','YYYY-MM-DD'), 'Pagado', 92, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (93, 29990, TO_DATE('2026-09-11','YYYY-MM-DD'), 'Pagado', 93, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (94, 34990, TO_DATE('2026-07-12','YYYY-MM-DD'), 'Pagado', 94, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (95, 39990, TO_DATE('2026-07-19','YYYY-MM-DD'), 'Pagado', 95, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (96, 49990, TO_DATE('2026-09-12','YYYY-MM-DD'), 'Pagado', 96, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (97, 59990, TO_DATE('2026-09-12','YYYY-MM-DD'), 'Pagado', 97, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (98, 79990, TO_DATE('2025-10-01','YYYY-MM-DD'), 'Pagado', 98, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (99, 44990, TO_DATE('2026-09-05','YYYY-MM-DD'), 'Pagado', 99, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (100, 17990, TO_DATE('2026-09-13','YYYY-MM-DD'), 'Pagado', 100, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (101, 19990, TO_DATE('2026-09-01','YYYY-MM-DD'), 'Pagado', 101, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (102, 24990, TO_DATE('2026-09-13','YYYY-MM-DD'), 'Pagado', 102, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (103, 29990, TO_DATE('2026-09-01','YYYY-MM-DD'), 'Pagado', 103, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (104, 34990, TO_DATE('2026-08-06','YYYY-MM-DD'), 'Pagado', 104, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (105, 39990, TO_DATE('2026-08-13','YYYY-MM-DD'), 'Pagado', 105, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (106, 49990, TO_DATE('2026-07-07','YYYY-MM-DD'), 'Pagado', 106, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (107, 59990, TO_DATE('2026-01-07','YYYY-MM-DD'), 'Pagado', 107, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (108, 79990, TO_DATE('2026-01-19','YYYY-MM-DD'), 'Pagado', 108, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (109, 44990, TO_DATE('2026-07-07','YYYY-MM-DD'), 'Pagado', 109, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (110, 17990, TO_DATE('2026-09-03','YYYY-MM-DD'), 'Pagado', 110, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (111, 19990, TO_DATE('2026-09-15','YYYY-MM-DD'), 'Pagado', 111, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (112, 24990, TO_DATE('2026-09-03','YYYY-MM-DD'), 'Pagado', 112, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (113, 29990, TO_DATE('2026-09-15','YYYY-MM-DD'), 'Pagado', 113, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (114, 34990, TO_DATE('2026-08-31','YYYY-MM-DD'), 'Pagado', 114, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (115, 39990, TO_DATE('2026-09-07','YYYY-MM-DD'), 'Pagado', 115, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (116, 49990, TO_DATE('2026-05-01','YYYY-MM-DD'), 'Pagado', 116, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (117, 59990, TO_DATE('2026-04-27','YYYY-MM-DD'), 'Pagado', 117, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (118, 79990, TO_DATE('2026-05-09','YYYY-MM-DD'), 'Pagado', 118, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (119, 44990, TO_DATE('2026-08-01','YYYY-MM-DD'), 'Pagado', 119, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (120, 17990, TO_DATE('2026-08-24','YYYY-MM-DD'), 'Pagado', 120, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (121, 19990, TO_DATE('2026-09-05','YYYY-MM-DD'), 'Pagado', 121, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (122, 24990, TO_DATE('2026-09-17','YYYY-MM-DD'), 'Pagado', 122, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (123, 29990, TO_DATE('2026-09-05','YYYY-MM-DD'), 'Pagado', 123, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (124, 34990, TO_DATE('2026-07-02','YYYY-MM-DD'), 'Pagado', 124, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (125, 39990, TO_DATE('2026-07-09','YYYY-MM-DD'), 'Pagado', 125, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (126, 49990, TO_DATE('2026-08-19','YYYY-MM-DD'), 'Pagado', 126, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (127, 59990, TO_DATE('2026-08-15','YYYY-MM-DD'), 'Pagado', 127, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (128, 79990, TO_DATE('2026-08-27','YYYY-MM-DD'), 'Pagado', 128, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (129, 44990, TO_DATE('2026-08-26','YYYY-MM-DD'), 'Pagado', 129, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (130, 17990, TO_DATE('2026-09-07','YYYY-MM-DD'), 'Pagado', 130, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (131, 19990, TO_DATE('2026-08-26','YYYY-MM-DD'), 'Pagado', 131, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (132, 24990, TO_DATE('2026-09-07','YYYY-MM-DD'), 'Pagado', 132, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (133, 29990, TO_DATE('2026-09-19','YYYY-MM-DD'), 'Pagado', 133, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (134, 34990, TO_DATE('2026-07-27','YYYY-MM-DD'), 'Pagado', 134, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (135, 39990, TO_DATE('2026-08-03','YYYY-MM-DD'), 'Pagado', 135, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (136, 49990, TO_DATE('2026-06-13','YYYY-MM-DD'), 'Pagado', 136, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (137, 59990, TO_DATE('2025-12-10','YYYY-MM-DD'), 'Pagado', 137, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (138, 79990, TO_DATE('2025-12-22','YYYY-MM-DD'), 'Pagado', 138, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (139, 44990, TO_DATE('2026-09-20','YYYY-MM-DD'), 'Pagado', 139, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (140, 17990, TO_DATE('2026-08-28','YYYY-MM-DD'), 'Pagado', 140, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (141, 19990, TO_DATE('2026-09-09','YYYY-MM-DD'), 'Pagado', 141, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (142, 24990, TO_DATE('2026-08-28','YYYY-MM-DD'), 'Pagado', 142, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (143, 29990, TO_DATE('2026-09-09','YYYY-MM-DD'), 'Pagado', 143, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (144, 34990, TO_DATE('2026-08-21','YYYY-MM-DD'), 'Pagado', 144, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (145, 39990, TO_DATE('2026-08-28','YYYY-MM-DD'), 'Pagado', 145, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (146, 49990, TO_DATE('2026-04-07','YYYY-MM-DD'), 'Pagado', 146, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (147, 59990, TO_DATE('2026-03-30','YYYY-MM-DD'), 'Pagado', 147, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (148, 79990, TO_DATE('2026-04-11','YYYY-MM-DD'), 'Pagado', 148, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (149, 44990, TO_DATE('2026-07-22','YYYY-MM-DD'), 'Pagado', 149, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (150, 17990, TO_DATE('2026-09-11','YYYY-MM-DD'), 'Pagado', 150, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (151, 19990, TO_DATE('2026-08-30','YYYY-MM-DD'), 'Pagado', 151, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (152, 24990, TO_DATE('2026-09-11','YYYY-MM-DD'), 'Pagado', 152, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (153, 29990, TO_DATE('2026-03-05','YYYY-MM-DD'), 'Pagado', 153, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (154, 34990, TO_DATE('2026-01-15','YYYY-MM-DD'), 'Pagado', 154, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (155, 39990, TO_DATE('2026-01-22','YYYY-MM-DD'), 'Pagado', 155, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (156, 49990, TO_DATE('2025-11-03','YYYY-MM-DD'), 'Pagado', 156, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (157, 59990, TO_DATE('2025-05-18','YYYY-MM-DD'), 'Pagado', 157, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (158, 79990, TO_DATE('2025-05-30','YYYY-MM-DD'), 'Pagado', 158, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (159, 44990, TO_DATE('2026-03-11','YYYY-MM-DD'), 'Pagado', 159, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (160, 17990, TO_DATE('2026-05-18','YYYY-MM-DD'), 'Pagado', 160, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (161, 19990, TO_DATE('2026-05-30','YYYY-MM-DD'), 'Pagado', 161, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (162, 24990, TO_DATE('2026-06-11','YYYY-MM-DD'), 'Pagado', 162, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (163, 29990, TO_DATE('2026-06-23','YYYY-MM-DD'), 'Pagado', 163, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (164, 34990, TO_DATE('2026-05-05','YYYY-MM-DD'), 'Pagado', 164, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (165, 39990, TO_DATE('2026-05-12','YYYY-MM-DD'), 'Pagado', 165, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (166, 49990, TO_DATE('2026-02-21','YYYY-MM-DD'), 'Pagado', 166, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (167, 59990, TO_DATE('2025-09-05','YYYY-MM-DD'), 'Pagado', 167, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (168, 79990, TO_DATE('2025-01-29','YYYY-MM-DD'), 'Pagado', 168, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (169, 44990, TO_DATE('2025-11-10','YYYY-MM-DD'), 'Pagado', 169, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (170, 17990, TO_DATE('2026-01-17','YYYY-MM-DD'), 'Pagado', 170, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (171, 19990, TO_DATE('2026-01-29','YYYY-MM-DD'), 'Pagado', 171, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (172, 24990, TO_DATE('2026-02-10','YYYY-MM-DD'), 'Pagado', 172, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (173, 29990, TO_DATE('2026-02-22','YYYY-MM-DD'), 'Pagado', 173, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (174, 34990, TO_DATE('2026-01-04','YYYY-MM-DD'), 'Pagado', 174, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (175, 39990, TO_DATE('2026-01-11','YYYY-MM-DD'), 'Pagado', 175, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (176, 49990, TO_DATE('2025-10-23','YYYY-MM-DD'), 'Pagado', 176, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (177, 59990, TO_DATE('2025-05-07','YYYY-MM-DD'), 'Pagado', 177, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (178, 79990, TO_DATE('2025-05-19','YYYY-MM-DD'), 'Pagado', 178, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (179, 44990, TO_DATE('2026-02-28','YYYY-MM-DD'), 'Pagado', 179, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (180, 17990, TO_DATE('2026-05-07','YYYY-MM-DD'), 'Pagado', 180, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (181, 19990, TO_DATE('2026-05-19','YYYY-MM-DD'), 'Pagado', 181, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (182, 24990, TO_DATE('2026-05-31','YYYY-MM-DD'), 'Pagado', 182, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (183, 29990, TO_DATE('2026-06-12','YYYY-MM-DD'), 'Pagado', 183, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (184, 34990, TO_DATE('2026-04-24','YYYY-MM-DD'), 'Pagado', 184, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (185, 39990, TO_DATE('2026-05-01','YYYY-MM-DD'), 'Pagado', 185, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (186, 49990, TO_DATE('2026-02-10','YYYY-MM-DD'), 'Pagado', 186, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (187, 59990, TO_DATE('2025-08-25','YYYY-MM-DD'), 'Pagado', 187, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (188, 79990, TO_DATE('2025-09-06','YYYY-MM-DD'), 'Pagado', 188, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (189, 44990, TO_DATE('2025-10-30','YYYY-MM-DD'), 'Pagado', 189, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (190, 17990, TO_DATE('2026-01-06','YYYY-MM-DD'), 'Pagado', 190, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (191, 19990, TO_DATE('2026-01-18','YYYY-MM-DD'), 'Pagado', 191, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (192, 24990, TO_DATE('2026-01-30','YYYY-MM-DD'), 'Pagado', 192, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (193, 29990, TO_DATE('2026-02-11','YYYY-MM-DD'), 'Pagado', 193, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (194, 34990, TO_DATE('2025-12-24','YYYY-MM-DD'), 'Pagado', 194, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (195, 39990, TO_DATE('2025-12-31','YYYY-MM-DD'), 'Pagado', 195, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (196, 49990, TO_DATE('2025-10-12','YYYY-MM-DD'), 'Pagado', 196, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (197, 59990, TO_DATE('2025-04-26','YYYY-MM-DD'), 'Pagado', 197, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (198, 79990, TO_DATE('2025-05-08','YYYY-MM-DD'), 'Pagado', 198, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (199, 44990, TO_DATE('2026-02-17','YYYY-MM-DD'), 'Pagado', 199, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (200, 17990, TO_DATE('2026-04-26','YYYY-MM-DD'), 'Pagado', 200, 5);

-- FACTURA: 200 registros
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (1, TO_DATE('2026-08-31','YYYY-MM-DD'), 24990, 1);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (2, TO_DATE('2026-09-10','YYYY-MM-DD'), 29990, 2);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (3, TO_DATE('2026-03-31','YYYY-MM-DD'), 34990, 3);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (4, TO_DATE('2026-07-28','YYYY-MM-DD'), 39990, 4);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (5, TO_DATE('2026-07-24','YYYY-MM-DD'), 49990, 5);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (6, TO_DATE('2024-11-11','YYYY-MM-DD'), 59990, 6);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (7, TO_DATE('2026-02-16','YYYY-MM-DD'), 79990, 7);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (8, TO_DATE('2026-08-25','YYYY-MM-DD'), 44990, 8);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (9, TO_DATE('2026-07-28','YYYY-MM-DD'), 17990, 9);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (10, TO_DATE('2026-09-07','YYYY-MM-DD'), 19990, 10);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (11, TO_DATE('2026-09-16','YYYY-MM-DD'), 24990, 11);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (12, TO_DATE('2026-08-02','YYYY-MM-DD'), 29990, 12);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (13, TO_DATE('2026-08-12','YYYY-MM-DD'), 34990, 13);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (14, TO_DATE('2026-09-02','YYYY-MM-DD'), 39990, 14);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (15, TO_DATE('2025-11-10','YYYY-MM-DD'), 49990, 15);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (16, TO_DATE('2026-04-13','YYYY-MM-DD'), 59990, 16);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (17, TO_DATE('2026-07-31','YYYY-MM-DD'), 79990, 17);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (18, TO_DATE('2026-04-24','YYYY-MM-DD'), 44990, 18);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (19, TO_DATE('2026-09-13','YYYY-MM-DD'), 17990, 19);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (20, TO_DATE('2026-08-29','YYYY-MM-DD'), 19990, 20);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (21, TO_DATE('2026-08-01','YYYY-MM-DD'), 24990, 21);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (22, TO_DATE('2026-09-11','YYYY-MM-DD'), 29990, 22);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (23, TO_DATE('2026-07-03','YYYY-MM-DD'), 34990, 23);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (24, TO_DATE('2026-05-02','YYYY-MM-DD'), 39990, 24);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (25, TO_DATE('2026-08-01','YYYY-MM-DD'), 49990, 25);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (26, TO_DATE('2025-11-23','YYYY-MM-DD'), 59990, 26);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (27, TO_DATE('2025-03-17','YYYY-MM-DD'), 79990, 27);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (28, TO_DATE('2026-08-29','YYYY-MM-DD'), 44990, 28);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (29, TO_DATE('2026-08-28','YYYY-MM-DD'), 17990, 29);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (30, TO_DATE('2026-08-08','YYYY-MM-DD'), 19990, 30);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (31, TO_DATE('2026-09-17','YYYY-MM-DD'), 24990, 31);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (32, TO_DATE('2026-09-02','YYYY-MM-DD'), 29990, 32);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (33, TO_DATE('2026-05-18','YYYY-MM-DD'), 34990, 33);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (34, TO_DATE('2026-09-12','YYYY-MM-DD'), 39990, 34);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (35, TO_DATE('2026-05-17','YYYY-MM-DD'), 49990, 35);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (36, TO_DATE('2025-05-05','YYYY-MM-DD'), 59990, 36);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (37, TO_DATE('2025-10-15','YYYY-MM-DD'), 79990, 37);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (38, TO_DATE('2026-07-27','YYYY-MM-DD'), 44990, 38);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (39, TO_DATE('2026-08-15','YYYY-MM-DD'), 17990, 39);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (40, TO_DATE('2026-08-29','YYYY-MM-DD'), 19990, 40);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (41, TO_DATE('2026-09-08','YYYY-MM-DD'), 24990, 41);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (42, TO_DATE('2026-08-12','YYYY-MM-DD'), 29990, 42);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (43, TO_DATE('2026-07-07','YYYY-MM-DD'), 34990, 43);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (44, TO_DATE('2026-08-03','YYYY-MM-DD'), 39990, 44);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (45, TO_DATE('2026-02-10','YYYY-MM-DD'), 49990, 45);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (46, TO_DATE('2025-12-10','YYYY-MM-DD'), 59990, 46);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (47, TO_DATE('2026-03-29','YYYY-MM-DD'), 79990, 47);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (48, TO_DATE('2026-06-10','YYYY-MM-DD'), 44990, 48);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (49, TO_DATE('2026-08-29','YYYY-MM-DD'), 17990, 49);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (50, TO_DATE('2026-09-07','YYYY-MM-DD'), 19990, 50);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (51, TO_DATE('2026-09-03','YYYY-MM-DD'), 19990, 51);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (52, TO_DATE('2026-09-15','YYYY-MM-DD'), 24990, 52);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (53, TO_DATE('2026-09-03','YYYY-MM-DD'), 29990, 53);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (54, TO_DATE('2026-09-20','YYYY-MM-DD'), 34990, 54);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (55, TO_DATE('2026-07-04','YYYY-MM-DD'), 39990, 55);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (56, TO_DATE('2026-06-18','YYYY-MM-DD'), 49990, 56);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (57, TO_DATE('2026-06-22','YYYY-MM-DD'), 59990, 57);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (58, TO_DATE('2026-07-04','YYYY-MM-DD'), 79990, 58);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (59, TO_DATE('2026-08-21','YYYY-MM-DD'), 44990, 59);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (60, TO_DATE('2026-09-05','YYYY-MM-DD'), 17990, 60);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (61, TO_DATE('2026-09-17','YYYY-MM-DD'), 19990, 61);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (62, TO_DATE('2026-09-05','YYYY-MM-DD'), 24990, 62);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (63, TO_DATE('2026-09-17','YYYY-MM-DD'), 29990, 63);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (64, TO_DATE('2026-07-22','YYYY-MM-DD'), 34990, 64);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (65, TO_DATE('2026-07-29','YYYY-MM-DD'), 39990, 65);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (66, TO_DATE('2026-04-12','YYYY-MM-DD'), 49990, 66);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (67, TO_DATE('2025-10-17','YYYY-MM-DD'), 59990, 67);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (68, TO_DATE('2025-10-29','YYYY-MM-DD'), 79990, 68);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (69, TO_DATE('2026-09-15','YYYY-MM-DD'), 44990, 69);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (70, TO_DATE('2026-08-26','YYYY-MM-DD'), 17990, 70);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (71, TO_DATE('2026-09-07','YYYY-MM-DD'), 19990, 71);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (72, TO_DATE('2026-08-26','YYYY-MM-DD'), 24990, 72);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (73, TO_DATE('2026-09-07','YYYY-MM-DD'), 29990, 73);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (74, TO_DATE('2026-08-16','YYYY-MM-DD'), 34990, 74);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (75, TO_DATE('2026-08-23','YYYY-MM-DD'), 39990, 75);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (76, TO_DATE('2026-07-31','YYYY-MM-DD'), 49990, 76);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (77, TO_DATE('2026-02-04','YYYY-MM-DD'), 59990, 77);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (78, TO_DATE('2026-02-16','YYYY-MM-DD'), 79990, 78);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (79, TO_DATE('2026-07-17','YYYY-MM-DD'), 44990, 79);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (80, TO_DATE('2026-09-09','YYYY-MM-DD'), 17990, 80);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (81, TO_DATE('2026-08-28','YYYY-MM-DD'), 19990, 81);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (82, TO_DATE('2026-09-09','YYYY-MM-DD'), 24990, 82);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (83, TO_DATE('2026-08-28','YYYY-MM-DD'), 29990, 83);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (84, TO_DATE('2026-09-10','YYYY-MM-DD'), 34990, 84);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (85, TO_DATE('2026-06-24','YYYY-MM-DD'), 39990, 85);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (86, TO_DATE('2026-05-25','YYYY-MM-DD'), 49990, 86);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (87, TO_DATE('2026-05-25','YYYY-MM-DD'), 59990, 87);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (88, TO_DATE('2026-06-06','YYYY-MM-DD'), 79990, 88);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (89, TO_DATE('2026-08-11','YYYY-MM-DD'), 44990, 89);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (90, TO_DATE('2026-08-30','YYYY-MM-DD'), 17990, 90);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (91, TO_DATE('2026-09-11','YYYY-MM-DD'), 19990, 91);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (92, TO_DATE('2026-08-30','YYYY-MM-DD'), 24990, 92);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (93, TO_DATE('2026-09-11','YYYY-MM-DD'), 29990, 93);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (94, TO_DATE('2026-07-12','YYYY-MM-DD'), 34990, 94);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (95, TO_DATE('2026-07-19','YYYY-MM-DD'), 39990, 95);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (96, TO_DATE('2026-09-12','YYYY-MM-DD'), 49990, 96);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (97, TO_DATE('2026-09-12','YYYY-MM-DD'), 59990, 97);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (98, TO_DATE('2025-10-01','YYYY-MM-DD'), 79990, 98);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (99, TO_DATE('2026-09-05','YYYY-MM-DD'), 44990, 99);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (100, TO_DATE('2026-09-13','YYYY-MM-DD'), 17990, 100);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (101, TO_DATE('2026-09-01','YYYY-MM-DD'), 19990, 101);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (102, TO_DATE('2026-09-13','YYYY-MM-DD'), 24990, 102);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (103, TO_DATE('2026-09-01','YYYY-MM-DD'), 29990, 103);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (104, TO_DATE('2026-08-06','YYYY-MM-DD'), 34990, 104);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (105, TO_DATE('2026-08-13','YYYY-MM-DD'), 39990, 105);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (106, TO_DATE('2026-07-07','YYYY-MM-DD'), 49990, 106);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (107, TO_DATE('2026-01-07','YYYY-MM-DD'), 59990, 107);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (108, TO_DATE('2026-01-19','YYYY-MM-DD'), 79990, 108);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (109, TO_DATE('2026-07-07','YYYY-MM-DD'), 44990, 109);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (110, TO_DATE('2026-09-03','YYYY-MM-DD'), 17990, 110);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (111, TO_DATE('2026-09-15','YYYY-MM-DD'), 19990, 111);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (112, TO_DATE('2026-09-03','YYYY-MM-DD'), 24990, 112);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (113, TO_DATE('2026-09-15','YYYY-MM-DD'), 29990, 113);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (114, TO_DATE('2026-08-31','YYYY-MM-DD'), 34990, 114);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (115, TO_DATE('2026-09-07','YYYY-MM-DD'), 39990, 115);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (116, TO_DATE('2026-05-01','YYYY-MM-DD'), 49990, 116);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (117, TO_DATE('2026-04-27','YYYY-MM-DD'), 59990, 117);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (118, TO_DATE('2026-05-09','YYYY-MM-DD'), 79990, 118);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (119, TO_DATE('2026-08-01','YYYY-MM-DD'), 44990, 119);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (120, TO_DATE('2026-08-24','YYYY-MM-DD'), 17990, 120);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (121, TO_DATE('2026-09-05','YYYY-MM-DD'), 19990, 121);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (122, TO_DATE('2026-09-17','YYYY-MM-DD'), 24990, 122);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (123, TO_DATE('2026-09-05','YYYY-MM-DD'), 29990, 123);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (124, TO_DATE('2026-07-02','YYYY-MM-DD'), 34990, 124);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (125, TO_DATE('2026-07-09','YYYY-MM-DD'), 39990, 125);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (126, TO_DATE('2026-08-19','YYYY-MM-DD'), 49990, 126);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (127, TO_DATE('2026-08-15','YYYY-MM-DD'), 59990, 127);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (128, TO_DATE('2026-08-27','YYYY-MM-DD'), 79990, 128);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (129, TO_DATE('2026-08-26','YYYY-MM-DD'), 44990, 129);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (130, TO_DATE('2026-09-07','YYYY-MM-DD'), 17990, 130);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (131, TO_DATE('2026-08-26','YYYY-MM-DD'), 19990, 131);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (132, TO_DATE('2026-09-07','YYYY-MM-DD'), 24990, 132);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (133, TO_DATE('2026-09-19','YYYY-MM-DD'), 29990, 133);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (134, TO_DATE('2026-07-27','YYYY-MM-DD'), 34990, 134);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (135, TO_DATE('2026-08-03','YYYY-MM-DD'), 39990, 135);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (136, TO_DATE('2026-06-13','YYYY-MM-DD'), 49990, 136);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (137, TO_DATE('2025-12-10','YYYY-MM-DD'), 59990, 137);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (138, TO_DATE('2025-12-22','YYYY-MM-DD'), 79990, 138);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (139, TO_DATE('2026-09-20','YYYY-MM-DD'), 44990, 139);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (140, TO_DATE('2026-08-28','YYYY-MM-DD'), 17990, 140);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (141, TO_DATE('2026-09-09','YYYY-MM-DD'), 19990, 141);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (142, TO_DATE('2026-08-28','YYYY-MM-DD'), 24990, 142);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (143, TO_DATE('2026-09-09','YYYY-MM-DD'), 29990, 143);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (144, TO_DATE('2026-08-21','YYYY-MM-DD'), 34990, 144);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (145, TO_DATE('2026-08-28','YYYY-MM-DD'), 39990, 145);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (146, TO_DATE('2026-04-07','YYYY-MM-DD'), 49990, 146);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (147, TO_DATE('2026-03-30','YYYY-MM-DD'), 59990, 147);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (148, TO_DATE('2026-04-11','YYYY-MM-DD'), 79990, 148);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (149, TO_DATE('2026-07-22','YYYY-MM-DD'), 44990, 149);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (150, TO_DATE('2026-09-11','YYYY-MM-DD'), 17990, 150);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (151, TO_DATE('2026-08-30','YYYY-MM-DD'), 19990, 151);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (152, TO_DATE('2026-09-11','YYYY-MM-DD'), 24990, 152);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (153, TO_DATE('2026-03-05','YYYY-MM-DD'), 29990, 153);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (154, TO_DATE('2026-01-15','YYYY-MM-DD'), 34990, 154);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (155, TO_DATE('2026-01-22','YYYY-MM-DD'), 39990, 155);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (156, TO_DATE('2025-11-03','YYYY-MM-DD'), 49990, 156);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (157, TO_DATE('2025-05-18','YYYY-MM-DD'), 59990, 157);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (158, TO_DATE('2025-05-30','YYYY-MM-DD'), 79990, 158);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (159, TO_DATE('2026-03-11','YYYY-MM-DD'), 44990, 159);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (160, TO_DATE('2026-05-18','YYYY-MM-DD'), 17990, 160);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (161, TO_DATE('2026-05-30','YYYY-MM-DD'), 19990, 161);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (162, TO_DATE('2026-06-11','YYYY-MM-DD'), 24990, 162);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (163, TO_DATE('2026-06-23','YYYY-MM-DD'), 29990, 163);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (164, TO_DATE('2026-05-05','YYYY-MM-DD'), 34990, 164);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (165, TO_DATE('2026-05-12','YYYY-MM-DD'), 39990, 165);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (166, TO_DATE('2026-02-21','YYYY-MM-DD'), 49990, 166);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (167, TO_DATE('2025-09-05','YYYY-MM-DD'), 59990, 167);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (168, TO_DATE('2025-01-29','YYYY-MM-DD'), 79990, 168);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (169, TO_DATE('2025-11-10','YYYY-MM-DD'), 44990, 169);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (170, TO_DATE('2026-01-17','YYYY-MM-DD'), 17990, 170);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (171, TO_DATE('2026-01-29','YYYY-MM-DD'), 19990, 171);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (172, TO_DATE('2026-02-10','YYYY-MM-DD'), 24990, 172);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (173, TO_DATE('2026-02-22','YYYY-MM-DD'), 29990, 173);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (174, TO_DATE('2026-01-04','YYYY-MM-DD'), 34990, 174);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (175, TO_DATE('2026-01-11','YYYY-MM-DD'), 39990, 175);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (176, TO_DATE('2025-10-23','YYYY-MM-DD'), 49990, 176);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (177, TO_DATE('2025-05-07','YYYY-MM-DD'), 59990, 177);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (178, TO_DATE('2025-05-19','YYYY-MM-DD'), 79990, 178);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (179, TO_DATE('2026-02-28','YYYY-MM-DD'), 44990, 179);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (180, TO_DATE('2026-05-07','YYYY-MM-DD'), 17990, 180);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (181, TO_DATE('2026-05-19','YYYY-MM-DD'), 19990, 181);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (182, TO_DATE('2026-05-31','YYYY-MM-DD'), 24990, 182);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (183, TO_DATE('2026-06-12','YYYY-MM-DD'), 29990, 183);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (184, TO_DATE('2026-04-24','YYYY-MM-DD'), 34990, 184);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (185, TO_DATE('2026-05-01','YYYY-MM-DD'), 39990, 185);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (186, TO_DATE('2026-02-10','YYYY-MM-DD'), 49990, 186);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (187, TO_DATE('2025-08-25','YYYY-MM-DD'), 59990, 187);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (188, TO_DATE('2025-09-06','YYYY-MM-DD'), 79990, 188);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (189, TO_DATE('2025-10-30','YYYY-MM-DD'), 44990, 189);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (190, TO_DATE('2026-01-06','YYYY-MM-DD'), 17990, 190);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (191, TO_DATE('2026-01-18','YYYY-MM-DD'), 19990, 191);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (192, TO_DATE('2026-01-30','YYYY-MM-DD'), 24990, 192);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (193, TO_DATE('2026-02-11','YYYY-MM-DD'), 29990, 193);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (194, TO_DATE('2025-12-24','YYYY-MM-DD'), 34990, 194);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (195, TO_DATE('2025-12-31','YYYY-MM-DD'), 39990, 195);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (196, TO_DATE('2025-10-12','YYYY-MM-DD'), 49990, 196);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (197, TO_DATE('2025-04-26','YYYY-MM-DD'), 59990, 197);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (198, TO_DATE('2025-05-08','YYYY-MM-DD'), 79990, 198);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (199, TO_DATE('2026-02-17','YYYY-MM-DD'), 44990, 199);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (200, TO_DATE('2026-04-26','YYYY-MM-DD'), 17990, 200);

-- FICHA_CLIENTE: 200 registros
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (1, TO_DATE('2025-07-24','YYYY-MM-DD'), 'Requiere control de presión arterial en reposo', TO_DATE('2025-07-24','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (2, TO_DATE('2025-04-24','YYYY-MM-DD'), 'Requiere seguimiento nutricional', TO_DATE('2025-04-24','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (3, TO_DATE('2025-07-01','YYYY-MM-DD'), 'Requiere trabajo de movilidad articular', TO_DATE('2025-07-01','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (4, TO_DATE('2025-06-16','YYYY-MM-DD'), 'Requiere fortalecimiento de core', TO_DATE('2025-06-16','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (5, TO_DATE('2025-05-22','YYYY-MM-DD'), 'Requiere progresión de cargas', TO_DATE('2025-05-22','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (6, TO_DATE('2025-02-17','YYYY-MM-DD'), 'Requiere control de frecuencia cardíaca', TO_DATE('2025-02-17','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (7, TO_DATE('2025-02-13','YYYY-MM-DD'), 'Requiere evaluación postural', TO_DATE('2025-02-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (8, TO_DATE('2025-06-23','YYYY-MM-DD'), 'Requiere hidratación durante el entrenamiento', TO_DATE('2025-06-23','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (9, TO_DATE('2025-08-08','YYYY-MM-DD'), 'Requiere descanso entre series', TO_DATE('2025-08-08','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (10, TO_DATE('2025-09-15','YYYY-MM-DD'), 'Requiere técnica de respiración', TO_DATE('2025-09-15','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (11, TO_DATE('2025-09-04','YYYY-MM-DD'), 'Se recomienda control de presión arterial en reposo', TO_DATE('2025-09-04','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (12, TO_DATE('2025-01-08','YYYY-MM-DD'), 'Se recomienda seguimiento nutricional', TO_DATE('2025-01-08','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (13, TO_DATE('2025-11-26','YYYY-MM-DD'), 'Se recomienda trabajo de movilidad articular', TO_DATE('2025-11-26','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (14, TO_DATE('2025-01-28','YYYY-MM-DD'), 'Se recomienda fortalecimiento de core', TO_DATE('2025-01-28','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (15, TO_DATE('2025-05-03','YYYY-MM-DD'), 'Se recomienda progresión de cargas', TO_DATE('2025-05-03','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (16, TO_DATE('2025-01-01','YYYY-MM-DD'), 'Se recomienda control de frecuencia cardíaca', TO_DATE('2025-01-01','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (17, TO_DATE('2025-11-21','YYYY-MM-DD'), 'Se recomienda evaluación postural', TO_DATE('2025-11-21','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (18, TO_DATE('2025-12-05','YYYY-MM-DD'), 'Se recomienda hidratación durante el entrenamiento', TO_DATE('2025-12-05','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (19, TO_DATE('2025-06-03','YYYY-MM-DD'), 'Se recomienda descanso entre series', TO_DATE('2025-06-03','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (20, TO_DATE('2025-12-18','YYYY-MM-DD'), 'Se recomienda técnica de respiración', TO_DATE('2025-12-18','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (21, TO_DATE('2025-09-22','YYYY-MM-DD'), 'Se sugiere control de presión arterial en reposo', TO_DATE('2025-09-22','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (22, TO_DATE('2025-11-21','YYYY-MM-DD'), 'Se sugiere seguimiento nutricional', TO_DATE('2025-11-21','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (23, TO_DATE('2025-05-09','YYYY-MM-DD'), 'Se sugiere trabajo de movilidad articular', TO_DATE('2025-05-09','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (24, TO_DATE('2025-12-25','YYYY-MM-DD'), 'Se sugiere fortalecimiento de core', TO_DATE('2025-12-25','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (25, TO_DATE('2025-09-10','YYYY-MM-DD'), 'Se sugiere progresión de cargas', TO_DATE('2025-09-10','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (26, TO_DATE('2025-05-06','YYYY-MM-DD'), 'Se sugiere control de frecuencia cardíaca', TO_DATE('2025-05-06','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (27, TO_DATE('2025-09-10','YYYY-MM-DD'), 'Se sugiere evaluación postural', TO_DATE('2025-09-10','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (28, TO_DATE('2025-06-27','YYYY-MM-DD'), 'Se sugiere hidratación durante el entrenamiento', TO_DATE('2025-06-27','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (29, TO_DATE('2025-10-13','YYYY-MM-DD'), 'Se sugiere descanso entre series', TO_DATE('2025-10-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (30, TO_DATE('2025-04-12','YYYY-MM-DD'), 'Se sugiere técnica de respiración', TO_DATE('2025-04-12','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (31, TO_DATE('2025-04-11','YYYY-MM-DD'), 'Necesita control de presión arterial en reposo', TO_DATE('2025-04-11','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (32, TO_DATE('2025-09-28','YYYY-MM-DD'), 'Necesita seguimiento nutricional', TO_DATE('2025-09-28','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (33, TO_DATE('2025-07-25','YYYY-MM-DD'), 'Necesita trabajo de movilidad articular', TO_DATE('2025-07-25','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (34, TO_DATE('2025-07-06','YYYY-MM-DD'), 'Necesita fortalecimiento de core', TO_DATE('2025-07-06','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (35, TO_DATE('2025-05-09','YYYY-MM-DD'), 'Necesita progresión de cargas', TO_DATE('2025-05-09','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (36, TO_DATE('2025-10-28','YYYY-MM-DD'), 'Necesita control de frecuencia cardíaca', TO_DATE('2025-10-28','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (37, TO_DATE('2025-12-28','YYYY-MM-DD'), 'Necesita evaluación postural', TO_DATE('2025-12-28','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (38, TO_DATE('2025-04-01','YYYY-MM-DD'), 'Necesita hidratación durante el entrenamiento', TO_DATE('2025-04-01','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (39, TO_DATE('2025-07-22','YYYY-MM-DD'), 'Necesita descanso entre series', TO_DATE('2025-07-22','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (40, TO_DATE('2025-12-12','YYYY-MM-DD'), 'Necesita técnica de respiración', TO_DATE('2025-12-12','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (41, TO_DATE('2025-06-14','YYYY-MM-DD'), 'Conviene control de presión arterial en reposo', TO_DATE('2025-06-14','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (42, TO_DATE('2025-10-18','YYYY-MM-DD'), 'Conviene seguimiento nutricional', TO_DATE('2025-10-18','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (43, TO_DATE('2025-02-26','YYYY-MM-DD'), 'Conviene trabajo de movilidad articular', TO_DATE('2025-02-26','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (44, TO_DATE('2025-07-12','YYYY-MM-DD'), 'Conviene fortalecimiento de core', TO_DATE('2025-07-12','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (45, TO_DATE('2025-12-02','YYYY-MM-DD'), 'Conviene progresión de cargas', TO_DATE('2025-12-02','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (46, TO_DATE('2025-07-07','YYYY-MM-DD'), 'Conviene control de frecuencia cardíaca', TO_DATE('2025-07-07','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (47, TO_DATE('2025-07-03','YYYY-MM-DD'), 'Conviene evaluación postural', TO_DATE('2025-07-03','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (48, TO_DATE('2025-09-18','YYYY-MM-DD'), 'Conviene hidratación durante el entrenamiento', TO_DATE('2025-09-18','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (49, TO_DATE('2025-02-13','YYYY-MM-DD'), 'Conviene descanso entre series', TO_DATE('2025-02-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (50, TO_DATE('2025-05-26','YYYY-MM-DD'), 'Conviene técnica de respiración', TO_DATE('2025-05-26','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (51, TO_DATE('2026-08-09','YYYY-MM-DD'), 'Se indica control de presión arterial en reposo', TO_DATE('2026-08-09','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (52, TO_DATE('2026-08-19','YYYY-MM-DD'), 'Se indica seguimiento nutricional', TO_DATE('2026-08-19','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (53, TO_DATE('2026-08-05','YYYY-MM-DD'), 'Se indica trabajo de movilidad articular', TO_DATE('2026-08-05','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (54, TO_DATE('2026-08-20','YYYY-MM-DD'), 'Se indica fortalecimiento de core', TO_DATE('2026-08-20','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (55, TO_DATE('2026-06-06','YYYY-MM-DD'), 'Se indica progresión de cargas', TO_DATE('2026-06-06','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (56, TO_DATE('2026-05-19','YYYY-MM-DD'), 'Se indica control de frecuencia cardíaca', TO_DATE('2026-05-19','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (57, TO_DATE('2026-05-21','YYYY-MM-DD'), 'Se indica evaluación postural', TO_DATE('2026-05-21','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (58, TO_DATE('2026-05-31','YYYY-MM-DD'), 'Se indica hidratación durante el entrenamiento', TO_DATE('2026-05-31','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (59, TO_DATE('2026-07-16','YYYY-MM-DD'), 'Se indica descanso entre series', TO_DATE('2026-07-16','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (60, TO_DATE('2026-09-02','YYYY-MM-DD'), 'Se indica técnica de respiración', TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (61, TO_DATE('2026-09-12','YYYY-MM-DD'), 'Se aconseja control de presión arterial en reposo', TO_DATE('2026-09-12','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (62, TO_DATE('2026-08-29','YYYY-MM-DD'), 'Se aconseja seguimiento nutricional', TO_DATE('2026-08-29','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (63, TO_DATE('2026-09-08','YYYY-MM-DD'), 'Se aconseja trabajo de movilidad articular', TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (64, TO_DATE('2026-07-11','YYYY-MM-DD'), 'Se aconseja fortalecimiento de core', TO_DATE('2026-07-11','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (65, TO_DATE('2026-07-21','YYYY-MM-DD'), 'Se aconseja progresión de cargas', TO_DATE('2026-07-21','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (66, TO_DATE('2026-04-02','YYYY-MM-DD'), 'Se aconseja control de frecuencia cardíaca', TO_DATE('2026-04-02','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (67, TO_DATE('2025-10-05','YYYY-MM-DD'), 'Se aconseja evaluación postural', TO_DATE('2025-10-05','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (68, TO_DATE('2025-10-15','YYYY-MM-DD'), 'Se aconseja hidratación durante el entrenamiento', TO_DATE('2025-10-15','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (69, TO_DATE('2026-08-30','YYYY-MM-DD'), 'Se aconseja descanso entre series', TO_DATE('2026-08-30','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (70, TO_DATE('2026-08-13','YYYY-MM-DD'), 'Se aconseja técnica de respiración', TO_DATE('2026-08-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (71, TO_DATE('2026-08-23','YYYY-MM-DD'), 'Mantiene control de presión arterial en reposo', TO_DATE('2026-08-23','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (72, TO_DATE('2026-08-09','YYYY-MM-DD'), 'Mantiene seguimiento nutricional', TO_DATE('2026-08-09','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (73, TO_DATE('2026-08-19','YYYY-MM-DD'), 'Mantiene trabajo de movilidad articular', TO_DATE('2026-08-19','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (74, TO_DATE('2026-07-26','YYYY-MM-DD'), 'Mantiene fortalecimiento de core', TO_DATE('2026-07-26','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (75, TO_DATE('2026-08-05','YYYY-MM-DD'), 'Mantiene progresión de cargas', TO_DATE('2026-08-05','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (76, TO_DATE('2026-07-11','YYYY-MM-DD'), 'Mantiene control de frecuencia cardíaca', TO_DATE('2026-07-11','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (77, TO_DATE('2026-01-13','YYYY-MM-DD'), 'Mantiene evaluación postural', TO_DATE('2026-01-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (78, TO_DATE('2026-01-23','YYYY-MM-DD'), 'Mantiene hidratación durante el entrenamiento', TO_DATE('2026-01-23','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (79, TO_DATE('2026-06-21','YYYY-MM-DD'), 'Mantiene descanso entre series', TO_DATE('2026-06-21','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (80, TO_DATE('2026-08-17','YYYY-MM-DD'), 'Mantiene técnica de respiración', TO_DATE('2026-08-17','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (81, TO_DATE('2026-08-03','YYYY-MM-DD'), 'Inicia control de presión arterial en reposo', TO_DATE('2026-08-03','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (82, TO_DATE('2026-08-13','YYYY-MM-DD'), 'Inicia seguimiento nutricional', TO_DATE('2026-08-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (83, TO_DATE('2026-07-30','YYYY-MM-DD'), 'Inicia trabajo de movilidad articular', TO_DATE('2026-07-30','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (84, TO_DATE('2026-08-10','YYYY-MM-DD'), 'Inicia fortalecimiento de core', TO_DATE('2026-08-10','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (85, TO_DATE('2026-05-27','YYYY-MM-DD'), 'Inicia progresión de cargas', TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (86, TO_DATE('2026-04-25','YYYY-MM-DD'), 'Inicia control de frecuencia cardíaca', TO_DATE('2026-04-25','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (87, TO_DATE('2026-04-23','YYYY-MM-DD'), 'Inicia evaluación postural', TO_DATE('2026-04-23','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (88, TO_DATE('2026-05-03','YYYY-MM-DD'), 'Inicia hidratación durante el entrenamiento', TO_DATE('2026-05-03','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (89, TO_DATE('2026-07-06','YYYY-MM-DD'), 'Inicia descanso entre series', TO_DATE('2026-07-06','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (90, TO_DATE('2026-08-27','YYYY-MM-DD'), 'Inicia técnica de respiración', TO_DATE('2026-08-27','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (91, TO_DATE('2026-09-06','YYYY-MM-DD'), 'Continúa con control de presión arterial en reposo', TO_DATE('2026-09-06','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (92, TO_DATE('2026-08-23','YYYY-MM-DD'), 'Continúa con seguimiento nutricional', TO_DATE('2026-08-23','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (93, TO_DATE('2026-09-02','YYYY-MM-DD'), 'Continúa con trabajo de movilidad articular', TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (94, TO_DATE('2026-07-01','YYYY-MM-DD'), 'Continúa con fortalecimiento de core', TO_DATE('2026-07-01','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (95, TO_DATE('2026-07-11','YYYY-MM-DD'), 'Continúa con progresión de cargas', TO_DATE('2026-07-11','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (96, TO_DATE('2026-09-02','YYYY-MM-DD'), 'Continúa con control de frecuencia cardíaca', TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (97, TO_DATE('2026-08-31','YYYY-MM-DD'), 'Continúa con evaluación postural', TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (98, TO_DATE('2025-09-17','YYYY-MM-DD'), 'Continúa con hidratación durante el entrenamiento', TO_DATE('2025-09-17','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (99, TO_DATE('2026-08-20','YYYY-MM-DD'), 'Continúa con descanso entre series', TO_DATE('2026-08-20','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (100, TO_DATE('2026-08-31','YYYY-MM-DD'), 'Continúa con técnica de respiración', TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (101, TO_DATE('2026-08-17','YYYY-MM-DD'), 'Se refuerza control de presión arterial en reposo', TO_DATE('2026-08-17','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (102, TO_DATE('2026-08-27','YYYY-MM-DD'), 'Se refuerza seguimiento nutricional', TO_DATE('2026-08-27','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (103, TO_DATE('2026-08-13','YYYY-MM-DD'), 'Se refuerza trabajo de movilidad articular', TO_DATE('2026-08-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (104, TO_DATE('2026-07-16','YYYY-MM-DD'), 'Se refuerza fortalecimiento de core', TO_DATE('2026-07-16','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (105, TO_DATE('2026-07-26','YYYY-MM-DD'), 'Se refuerza progresión de cargas', TO_DATE('2026-07-26','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (106, TO_DATE('2026-06-17','YYYY-MM-DD'), 'Se refuerza control de frecuencia cardíaca', TO_DATE('2026-06-17','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (107, TO_DATE('2025-12-16','YYYY-MM-DD'), 'Se refuerza evaluación postural', TO_DATE('2025-12-16','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (108, TO_DATE('2025-12-26','YYYY-MM-DD'), 'Se refuerza hidratación durante el entrenamiento', TO_DATE('2025-12-26','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (109, TO_DATE('2026-06-11','YYYY-MM-DD'), 'Se refuerza descanso entre series', TO_DATE('2026-06-11','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (110, TO_DATE('2026-08-11','YYYY-MM-DD'), 'Se refuerza técnica de respiración', TO_DATE('2026-08-11','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (111, TO_DATE('2026-08-21','YYYY-MM-DD'), 'Se controla control de presión arterial en reposo', TO_DATE('2026-08-21','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (112, TO_DATE('2026-08-07','YYYY-MM-DD'), 'Se controla seguimiento nutricional', TO_DATE('2026-08-07','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (113, TO_DATE('2026-08-17','YYYY-MM-DD'), 'Se controla trabajo de movilidad articular', TO_DATE('2026-08-17','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (114, TO_DATE('2026-07-31','YYYY-MM-DD'), 'Se controla fortalecimiento de core', TO_DATE('2026-07-31','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (115, TO_DATE('2026-08-10','YYYY-MM-DD'), 'Se controla progresión de cargas', TO_DATE('2026-08-10','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (116, TO_DATE('2026-04-01','YYYY-MM-DD'), 'Se controla control de frecuencia cardíaca', TO_DATE('2026-04-01','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (117, TO_DATE('2026-03-26','YYYY-MM-DD'), 'Se controla evaluación postural', TO_DATE('2026-03-26','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (118, TO_DATE('2026-04-05','YYYY-MM-DD'), 'Se controla hidratación durante el entrenamiento', TO_DATE('2026-04-05','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (119, TO_DATE('2026-06-26','YYYY-MM-DD'), 'Se controla descanso entre series', TO_DATE('2026-06-26','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (120, TO_DATE('2026-08-21','YYYY-MM-DD'), 'Se controla técnica de respiración', TO_DATE('2026-08-21','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (121, TO_DATE('2026-08-31','YYYY-MM-DD'), 'Se evalúa control de presión arterial en reposo', TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (122, TO_DATE('2026-09-10','YYYY-MM-DD'), 'Se evalúa seguimiento nutricional', TO_DATE('2026-09-10','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (123, TO_DATE('2026-08-27','YYYY-MM-DD'), 'Se evalúa trabajo de movilidad articular', TO_DATE('2026-08-27','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (124, TO_DATE('2026-06-21','YYYY-MM-DD'), 'Se evalúa fortalecimiento de core', TO_DATE('2026-06-21','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (125, TO_DATE('2026-07-01','YYYY-MM-DD'), 'Se evalúa progresión de cargas', TO_DATE('2026-07-01','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (126, TO_DATE('2026-08-09','YYYY-MM-DD'), 'Se evalúa control de frecuencia cardíaca', TO_DATE('2026-08-09','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (127, TO_DATE('2026-08-03','YYYY-MM-DD'), 'Se evalúa evaluación postural', TO_DATE('2026-08-03','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (128, TO_DATE('2026-08-13','YYYY-MM-DD'), 'Se evalúa hidratación durante el entrenamiento', TO_DATE('2026-08-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (129, TO_DATE('2026-08-10','YYYY-MM-DD'), 'Se evalúa descanso entre series', TO_DATE('2026-08-10','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (130, TO_DATE('2026-08-25','YYYY-MM-DD'), 'Se evalúa técnica de respiración', TO_DATE('2026-08-25','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (131, TO_DATE('2026-08-11','YYYY-MM-DD'), 'Se ajusta control de presión arterial en reposo', TO_DATE('2026-08-11','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (132, TO_DATE('2026-08-21','YYYY-MM-DD'), 'Se ajusta seguimiento nutricional', TO_DATE('2026-08-21','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (133, TO_DATE('2026-08-31','YYYY-MM-DD'), 'Se ajusta trabajo de movilidad articular', TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (134, TO_DATE('2026-07-06','YYYY-MM-DD'), 'Se ajusta fortalecimiento de core', TO_DATE('2026-07-06','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (135, TO_DATE('2026-07-16','YYYY-MM-DD'), 'Se ajusta progresión de cargas', TO_DATE('2026-07-16','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (136, TO_DATE('2026-05-24','YYYY-MM-DD'), 'Se ajusta control de frecuencia cardíaca', TO_DATE('2026-05-24','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (137, TO_DATE('2025-11-18','YYYY-MM-DD'), 'Se ajusta evaluación postural', TO_DATE('2025-11-18','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (138, TO_DATE('2025-11-28','YYYY-MM-DD'), 'Se ajusta hidratación durante el entrenamiento', TO_DATE('2025-11-28','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (139, TO_DATE('2026-08-25','YYYY-MM-DD'), 'Se ajusta descanso entre series', TO_DATE('2026-08-25','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (140, TO_DATE('2026-08-05','YYYY-MM-DD'), 'Se ajusta técnica de respiración', TO_DATE('2026-08-05','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (141, TO_DATE('2026-08-15','YYYY-MM-DD'), 'Se monitorea control de presión arterial en reposo', TO_DATE('2026-08-15','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (142, TO_DATE('2026-08-01','YYYY-MM-DD'), 'Se monitorea seguimiento nutricional', TO_DATE('2026-08-01','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (143, TO_DATE('2026-08-11','YYYY-MM-DD'), 'Se monitorea trabajo de movilidad articular', TO_DATE('2026-08-11','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (144, TO_DATE('2026-07-21','YYYY-MM-DD'), 'Se monitorea fortalecimiento de core', TO_DATE('2026-07-21','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (145, TO_DATE('2026-07-31','YYYY-MM-DD'), 'Se monitorea progresión de cargas', TO_DATE('2026-07-31','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (146, TO_DATE('2026-03-08','YYYY-MM-DD'), 'Se monitorea control de frecuencia cardíaca', TO_DATE('2026-03-08','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (147, TO_DATE('2026-02-26','YYYY-MM-DD'), 'Se monitorea evaluación postural', TO_DATE('2026-02-26','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (148, TO_DATE('2026-03-08','YYYY-MM-DD'), 'Se monitorea hidratación durante el entrenamiento', TO_DATE('2026-03-08','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (149, TO_DATE('2026-06-16','YYYY-MM-DD'), 'Se monitorea descanso entre series', TO_DATE('2026-06-16','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (150, TO_DATE('2026-09-08','YYYY-MM-DD'), 'Se monitorea técnica de respiración', TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (151, TO_DATE('2026-08-25','YYYY-MM-DD'), 'Prioriza control de presión arterial en reposo', TO_DATE('2026-08-25','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (152, TO_DATE('2026-09-04','YYYY-MM-DD'), 'Prioriza seguimiento nutricional', TO_DATE('2026-09-04','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (153, TO_DATE('2026-02-24','YYYY-MM-DD'), 'Prioriza trabajo de movilidad articular', TO_DATE('2026-02-24','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (154, TO_DATE('2026-01-04','YYYY-MM-DD'), 'Prioriza fortalecimiento de core', TO_DATE('2026-01-04','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (155, TO_DATE('2026-01-14','YYYY-MM-DD'), 'Prioriza progresión de cargas', TO_DATE('2026-01-14','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (156, TO_DATE('2025-10-24','YYYY-MM-DD'), 'Prioriza control de frecuencia cardíaca', TO_DATE('2025-10-24','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (157, TO_DATE('2025-05-06','YYYY-MM-DD'), 'Prioriza evaluación postural', TO_DATE('2025-05-06','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (158, TO_DATE('2025-05-16','YYYY-MM-DD'), 'Prioriza hidratación durante el entrenamiento', TO_DATE('2025-05-16','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (159, TO_DATE('2026-02-23','YYYY-MM-DD'), 'Prioriza descanso entre series', TO_DATE('2026-02-23','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (160, TO_DATE('2026-05-05','YYYY-MM-DD'), 'Prioriza técnica de respiración', TO_DATE('2026-05-05','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (161, TO_DATE('2026-05-15','YYYY-MM-DD'), 'Incluye control de presión arterial en reposo', TO_DATE('2026-05-15','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (162, TO_DATE('2026-05-25','YYYY-MM-DD'), 'Incluye seguimiento nutricional', TO_DATE('2026-05-25','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (163, TO_DATE('2026-06-04','YYYY-MM-DD'), 'Incluye trabajo de movilidad articular', TO_DATE('2026-06-04','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (164, TO_DATE('2026-04-14','YYYY-MM-DD'), 'Incluye fortalecimiento de core', TO_DATE('2026-04-14','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (165, TO_DATE('2026-04-24','YYYY-MM-DD'), 'Incluye progresión de cargas', TO_DATE('2026-04-24','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (166, TO_DATE('2026-02-01','YYYY-MM-DD'), 'Incluye control de frecuencia cardíaca', TO_DATE('2026-02-01','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (167, TO_DATE('2025-08-14','YYYY-MM-DD'), 'Incluye evaluación postural', TO_DATE('2025-08-14','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (168, TO_DATE('2025-01-05','YYYY-MM-DD'), 'Incluye hidratación durante el entrenamiento', TO_DATE('2025-01-05','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (169, TO_DATE('2025-10-15','YYYY-MM-DD'), 'Incluye descanso entre series', TO_DATE('2025-10-15','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (170, TO_DATE('2025-12-25','YYYY-MM-DD'), 'Incluye técnica de respiración', TO_DATE('2025-12-25','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (171, TO_DATE('2026-01-04','YYYY-MM-DD'), 'Refuerza control de presión arterial en reposo', TO_DATE('2026-01-04','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (172, TO_DATE('2026-01-14','YYYY-MM-DD'), 'Refuerza seguimiento nutricional', TO_DATE('2026-01-14','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (173, TO_DATE('2026-01-24','YYYY-MM-DD'), 'Refuerza trabajo de movilidad articular', TO_DATE('2026-01-24','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (174, TO_DATE('2025-12-04','YYYY-MM-DD'), 'Refuerza fortalecimiento de core', TO_DATE('2025-12-04','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (175, TO_DATE('2025-12-14','YYYY-MM-DD'), 'Refuerza progresión de cargas', TO_DATE('2025-12-14','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (176, TO_DATE('2025-09-23','YYYY-MM-DD'), 'Refuerza control de frecuencia cardíaca', TO_DATE('2025-09-23','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (177, TO_DATE('2025-04-05','YYYY-MM-DD'), 'Refuerza evaluación postural', TO_DATE('2025-04-05','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (178, TO_DATE('2025-04-15','YYYY-MM-DD'), 'Refuerza hidratación durante el entrenamiento', TO_DATE('2025-04-15','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (179, TO_DATE('2026-01-23','YYYY-MM-DD'), 'Refuerza descanso entre series', TO_DATE('2026-01-23','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (180, TO_DATE('2026-05-04','YYYY-MM-DD'), 'Refuerza técnica de respiración', TO_DATE('2026-05-04','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (181, TO_DATE('2026-05-14','YYYY-MM-DD'), 'Controla control de presión arterial en reposo', TO_DATE('2026-05-14','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (182, TO_DATE('2026-05-24','YYYY-MM-DD'), 'Controla seguimiento nutricional', TO_DATE('2026-05-24','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (183, TO_DATE('2026-06-03','YYYY-MM-DD'), 'Controla trabajo de movilidad articular', TO_DATE('2026-06-03','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (184, TO_DATE('2026-04-13','YYYY-MM-DD'), 'Controla fortalecimiento de core', TO_DATE('2026-04-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (185, TO_DATE('2026-04-23','YYYY-MM-DD'), 'Controla progresión de cargas', TO_DATE('2026-04-23','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (186, TO_DATE('2026-01-31','YYYY-MM-DD'), 'Controla control de frecuencia cardíaca', TO_DATE('2026-01-31','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (187, TO_DATE('2025-08-13','YYYY-MM-DD'), 'Controla evaluación postural', TO_DATE('2025-08-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (188, TO_DATE('2025-08-23','YYYY-MM-DD'), 'Controla hidratación durante el entrenamiento', TO_DATE('2025-08-23','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (189, TO_DATE('2025-10-14','YYYY-MM-DD'), 'Controla descanso entre series', TO_DATE('2025-10-14','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (190, TO_DATE('2025-12-24','YYYY-MM-DD'), 'Controla técnica de respiración', TO_DATE('2025-12-24','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (191, TO_DATE('2026-01-03','YYYY-MM-DD'), 'Monitorea control de presión arterial en reposo', TO_DATE('2026-01-03','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (192, TO_DATE('2026-01-13','YYYY-MM-DD'), 'Monitorea seguimiento nutricional', TO_DATE('2026-01-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (193, TO_DATE('2026-01-23','YYYY-MM-DD'), 'Monitorea trabajo de movilidad articular', TO_DATE('2026-01-23','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (194, TO_DATE('2025-12-03','YYYY-MM-DD'), 'Monitorea fortalecimiento de core', TO_DATE('2025-12-03','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (195, TO_DATE('2025-12-13','YYYY-MM-DD'), 'Monitorea progresión de cargas', TO_DATE('2025-12-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (196, TO_DATE('2025-09-22','YYYY-MM-DD'), 'Monitorea control de frecuencia cardíaca', TO_DATE('2025-09-22','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (197, TO_DATE('2025-04-04','YYYY-MM-DD'), 'Monitorea evaluación postural', TO_DATE('2025-04-04','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (198, TO_DATE('2025-04-14','YYYY-MM-DD'), 'Monitorea hidratación durante el entrenamiento', TO_DATE('2025-04-14','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (199, TO_DATE('2026-01-22','YYYY-MM-DD'), 'Monitorea descanso entre series', TO_DATE('2026-01-22','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (200, TO_DATE('2026-04-03','YYYY-MM-DD'), 'Monitorea técnica de respiración', TO_DATE('2026-04-03','YYYY-MM-DD'));

-- METRICAS_CLIENTE: 200 registros
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (1, 87.97, 176.00, 97.44, 82.03, 95.51, 121.72, 35.83, 56.67, 40.91, TO_DATE('2025-07-24','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (2, 54.05, 152.00, 99.16, 79.42, 86.80, 109.36, 36.98, 51.41, 41.53, TO_DATE('2025-04-24','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (3, 113.55, 187.00, 115.76, 94.53, 103.45, 127.06, 28.13, 57.38, 40.98, TO_DATE('2025-07-01','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (4, 53.76, 154.00, 87.34, 72.05, 83.11, 98.30, 28.68, 60.57, 38.04, TO_DATE('2025-06-16','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (5, 88.05, 175.00, 113.47, 87.66, 94.45, 116.73, 31.87, 48.67, 38.31, TO_DATE('2025-05-22','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (6, 69.75, 161.00, 97.49, 78.10, 87.93, 100.05, 28.31, 64.17, 34.21, TO_DATE('2025-02-17','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (7, 73.41, 195.00, 92.47, 75.20, 87.22, 127.30, 35.29, 61.18, 40.71, TO_DATE('2025-02-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (8, 60.75, 163.00, 89.73, 87.11, 96.31, 105.19, 35.20, 63.27, 36.77, TO_DATE('2025-06-23','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (9, 74.21, 169.00, 94.96, 86.38, 96.62, 113.16, 34.99, 51.93, 39.57, TO_DATE('2025-08-08','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (10, 60.31, 174.00, 89.53, 83.48, 94.12, 109.00, 32.95, 63.65, 34.50, TO_DATE('2025-09-15','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (11, 83.42, 170.00, 93.98, 78.42, 85.31, 113.73, 29.48, 65.82, 36.61, TO_DATE('2025-09-04','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (12, 51.79, 171.00, 86.06, 69.46, 77.50, 98.23, 41.11, 48.65, 39.36, TO_DATE('2025-01-08','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (13, 70.78, 179.00, 109.34, 83.25, 96.94, 125.18, 34.54, 65.09, 38.67, TO_DATE('2025-11-26','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (14, 72.77, 177.00, 83.13, 64.55, 72.78, 104.34, 28.10, 59.12, 33.39, TO_DATE('2025-01-28','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (15, 73.38, 186.00, 107.18, 80.19, 90.52, 123.69, 31.20, 55.07, 33.79, TO_DATE('2025-05-03','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (16, 63.50, 153.00, 98.20, 67.00, 77.47, 112.60, 35.07, 54.07, 35.51, TO_DATE('2025-01-01','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (17, 88.41, 163.00, 93.93, 93.57, 104.11, 127.54, 35.24, 52.38, 40.36, TO_DATE('2025-11-21','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (18, 56.15, 165.00, 85.33, 84.80, 96.38, 91.97, 36.81, 60.08, 36.05, TO_DATE('2025-12-05','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (19, 66.05, 172.00, 95.01, 94.01, 107.58, 126.64, 36.07, 65.89, 34.62, TO_DATE('2025-06-03','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (20, 84.04, 160.00, 99.67, 82.00, 89.94, 102.98, 34.60, 64.95, 38.47, TO_DATE('2025-12-18','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (21, 70.66, 167.00, 107.94, 82.09, 90.11, 113.79, 34.22, 53.32, 34.36, TO_DATE('2025-09-22','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (22, 65.54, 153.00, 87.46, 71.09, 83.86, 107.81, 41.35, 55.90, 37.00, TO_DATE('2025-11-21','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (23, 101.98, 178.00, 99.71, 82.14, 93.04, 108.04, 28.43, 51.84, 39.29, TO_DATE('2025-05-09','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (24, 57.87, 169.00, 89.81, 84.40, 91.43, 95.06, 32.69, 57.66, 34.87, TO_DATE('2025-12-25','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (25, 91.91, 176.00, 98.86, 96.51, 103.92, 114.85, 32.23, 61.23, 40.42, TO_DATE('2025-09-10','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (26, 73.45, 154.00, 105.68, 79.82, 90.71, 119.88, 38.33, 62.39, 37.62, TO_DATE('2025-05-06','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (27, 76.29, 188.00, 114.93, 96.93, 107.02, 126.74, 39.21, 62.96, 38.53, TO_DATE('2025-09-10','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (28, 76.29, 165.00, 82.32, 76.72, 89.86, 98.52, 33.10, 65.01, 35.20, TO_DATE('2025-06-27','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (29, 108.18, 195.00, 92.76, 80.14, 91.08, 108.20, 34.62, 62.65, 36.92, TO_DATE('2025-10-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (30, 69.09, 177.00, 84.81, 73.13, 81.91, 100.06, 35.22, 63.87, 33.89, TO_DATE('2025-04-12','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (31, 109.87, 166.00, 93.72, 82.89, 93.91, 107.62, 29.39, 49.90, 40.37, TO_DATE('2025-04-11','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (32, 61.93, 155.00, 84.08, 68.63, 82.23, 99.75, 40.82, 64.53, 37.96, TO_DATE('2025-09-28','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (33, 69.56, 188.00, 103.00, 99.78, 106.27, 114.60, 34.66, 61.45, 41.98, TO_DATE('2025-07-25','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (34, 72.41, 157.00, 95.08, 68.95, 82.56, 107.48, 28.15, 50.55, 38.46, TO_DATE('2025-07-06','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (35, 104.29, 188.00, 101.49, 93.56, 104.63, 113.85, 36.09, 59.12, 35.87, TO_DATE('2025-05-09','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (36, 60.88, 171.00, 96.52, 67.08, 73.35, 99.22, 36.53, 57.49, 35.61, TO_DATE('2025-10-28','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (37, 75.40, 197.00, 110.92, 85.49, 95.63, 112.59, 41.34, 53.60, 40.85, TO_DATE('2025-12-28','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (38, 71.03, 159.00, 89.64, 87.79, 99.08, 104.03, 33.68, 55.64, 37.16, TO_DATE('2025-04-01','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (39, 113.78, 195.00, 117.81, 93.65, 102.25, 135.11, 33.28, 48.26, 36.21, TO_DATE('2025-07-22','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (40, 77.38, 150.00, 91.92, 63.23, 74.90, 100.32, 35.57, 57.80, 33.49, TO_DATE('2025-12-12','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (41, 84.20, 197.00, 116.77, 80.69, 87.15, 126.27, 31.20, 48.90, 36.30, TO_DATE('2025-06-14','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (42, 53.61, 167.00, 94.39, 79.29, 86.15, 96.36, 33.86, 50.10, 41.98, TO_DATE('2025-10-18','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (43, 114.94, 195.00, 110.74, 74.96, 87.63, 114.58, 38.30, 61.62, 40.76, TO_DATE('2025-02-26','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (44, 73.67, 172.00, 86.56, 63.43, 71.57, 96.86, 41.03, 57.65, 38.46, TO_DATE('2025-07-12','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (45, 87.67, 184.00, 113.35, 85.47, 97.75, 119.26, 32.02, 62.06, 40.17, TO_DATE('2025-12-02','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (46, 83.72, 163.00, 96.91, 67.76, 80.17, 111.31, 32.13, 63.96, 34.74, TO_DATE('2025-07-07','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (47, 84.55, 165.00, 117.85, 83.54, 91.75, 120.08, 31.06, 54.12, 33.84, TO_DATE('2025-07-03','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (48, 78.84, 152.00, 87.40, 77.63, 90.59, 107.30, 30.39, 51.50, 35.27, TO_DATE('2025-09-18','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (49, 94.40, 180.00, 96.97, 93.76, 103.55, 126.51, 40.73, 58.71, 38.61, TO_DATE('2025-02-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (50, 51.72, 166.00, 102.34, 68.34, 79.42, 110.54, 28.48, 53.50, 35.41, TO_DATE('2025-05-26','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (51, 72.56, 159, 100.20, 72.10, 93.40, 109.50, 31.30, 56.30, 46.60, TO_DATE('2026-08-09','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (52, 77.16, 162, 105.30, 79.20, 91.20, 115.70, 34.00, 60.40, 35.70, TO_DATE('2026-08-19','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (53, 81.95, 165, 110.40, 86.30, 101.40, 121.90, 37.10, 64.50, 38.80, TO_DATE('2026-08-05','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (54, 86.93, 168, 115.50, 68.40, 86.60, 127.50, 40.20, 50.60, 41.00, TO_DATE('2026-08-20','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (55, 92.11, 171, 95.60, 75.00, 96.30, 108.70, 28.30, 54.70, 44.10, TO_DATE('2026-06-06','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (56, 58.13, 174, 100.00, 82.10, 94.10, 114.20, 31.00, 58.00, 33.20, TO_DATE('2026-05-19','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (57, 62.34, 177, 105.10, 89.20, 104.30, 120.40, 34.10, 62.10, 36.30, TO_DATE('2026-05-21','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (58, 66.74, 180, 110.20, 71.30, 89.50, 126.60, 37.20, 66.20, 39.40, TO_DATE('2026-05-31','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (59, 71.33, 183, 115.30, 78.40, 99.70, 132.80, 40.30, 52.30, 42.50, TO_DATE('2026-07-16','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (60, 76.11, 186, 95.40, 85.00, 97.00, 103.40, 28.00, 56.40, 45.60, TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (61, 81.09, 189, 100.50, 67.10, 82.20, 109.60, 31.10, 60.50, 34.70, TO_DATE('2026-09-12','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (62, 86.26, 192, 105.60, 74.20, 92.40, 115.80, 34.20, 64.60, 37.80, TO_DATE('2026-08-29','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (63, 91.64, 195, 110.00, 81.30, 102.60, 121.30, 37.30, 50.70, 40.00, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (64, 55.80, 150, 115.10, 88.40, 100.40, 127.50, 40.00, 54.00, 43.10, TO_DATE('2026-07-11','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (65, 59.69, 153, 95.20, 70.00, 85.10, 108.70, 28.10, 58.10, 46.20, TO_DATE('2026-07-21','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (66, 63.76, 156, 100.30, 77.10, 95.30, 114.30, 31.20, 62.20, 35.30, TO_DATE('2026-04-02','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (67, 68.01, 159, 105.40, 84.20, 105.50, 120.50, 34.30, 66.30, 38.40, TO_DATE('2025-10-05','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (68, 72.43, 162, 110.50, 66.30, 78.30, 126.70, 37.00, 52.40, 41.50, TO_DATE('2025-10-15','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (69, 77.05, 165, 115.60, 73.40, 88.50, 132.90, 40.10, 56.50, 44.60, TO_DATE('2026-08-30','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (70, 81.85, 168, 95.00, 80.00, 98.20, 103.40, 28.20, 60.60, 33.70, TO_DATE('2026-08-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (71, 86.85, 171, 100.10, 87.10, 108.40, 109.60, 31.30, 64.70, 36.80, TO_DATE('2026-08-23','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (72, 92.04, 174, 105.20, 69.20, 81.20, 115.20, 34.00, 50.00, 39.00, TO_DATE('2026-08-09','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (73, 97.43, 177, 110.30, 76.30, 91.40, 121.40, 37.10, 54.10, 42.10, TO_DATE('2026-08-19','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (74, 103.03, 180, 115.40, 83.40, 101.60, 127.60, 40.20, 58.20, 45.20, TO_DATE('2026-07-26','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (75, 65.30, 183, 95.50, 65.00, 86.30, 108.80, 28.30, 62.30, 34.30, TO_DATE('2026-08-05','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (76, 69.88, 186, 100.60, 72.10, 84.10, 115.00, 31.00, 66.40, 37.40, TO_DATE('2026-07-11','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (77, 74.66, 189, 105.00, 79.20, 94.30, 120.50, 34.10, 52.50, 40.50, TO_DATE('2026-01-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (78, 79.63, 192, 110.10, 86.30, 104.50, 126.10, 37.20, 56.60, 43.60, TO_DATE('2026-01-23','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (79, 84.80, 195, 115.20, 68.40, 89.70, 132.30, 40.30, 60.70, 46.70, TO_DATE('2026-06-21','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (80, 51.75, 150, 95.30, 75.00, 87.00, 103.50, 28.00, 64.00, 35.80, TO_DATE('2026-08-17','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (81, 55.48, 153, 100.40, 82.10, 97.20, 109.70, 31.10, 50.10, 38.00, TO_DATE('2026-08-03','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (82, 59.38, 156, 105.50, 89.20, 107.40, 115.90, 34.20, 54.20, 41.10, TO_DATE('2026-08-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (83, 63.46, 159, 110.60, 71.30, 92.60, 122.10, 37.30, 58.30, 44.20, TO_DATE('2026-07-30','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (84, 67.71, 162, 115.00, 78.40, 90.40, 127.00, 40.00, 62.40, 33.30, TO_DATE('2026-08-10','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (85, 72.15, 165, 95.10, 85.00, 100.10, 108.20, 28.10, 66.50, 36.40, TO_DATE('2026-05-27','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (86, 76.77, 168, 100.20, 67.10, 85.30, 114.40, 31.20, 52.60, 39.50, TO_DATE('2026-04-25','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (87, 81.58, 171, 105.30, 74.20, 95.50, 120.60, 34.30, 56.70, 42.60, TO_DATE('2026-04-23','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (88, 86.59, 174, 110.40, 81.30, 93.30, 126.80, 37.00, 60.00, 45.70, TO_DATE('2026-05-03','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (89, 91.79, 177, 115.50, 88.40, 103.50, 133.00, 40.10, 64.10, 34.80, TO_DATE('2026-07-06','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (90, 97.20, 180, 95.60, 70.00, 88.20, 103.60, 28.20, 50.20, 37.00, TO_DATE('2026-08-27','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (91, 102.81, 183, 100.00, 77.10, 98.40, 109.10, 31.30, 54.30, 40.10, TO_DATE('2026-09-06','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (92, 108.63, 186, 105.10, 84.20, 96.20, 115.30, 34.00, 58.40, 43.20, TO_DATE('2026-08-23','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (93, 68.23, 189, 110.20, 66.30, 81.40, 121.50, 37.10, 62.50, 46.30, TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (94, 72.99, 192, 115.30, 73.40, 91.60, 127.70, 40.20, 66.60, 35.40, TO_DATE('2026-07-01','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (95, 77.95, 195, 95.40, 80.00, 101.30, 108.90, 28.30, 52.70, 38.50, TO_DATE('2026-07-11','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (96, 47.70, 150, 100.50, 87.10, 99.10, 114.50, 31.00, 56.00, 41.60, TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (97, 51.27, 153, 105.60, 69.20, 84.30, 120.70, 34.10, 60.10, 44.70, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (98, 55.00, 156, 110.00, 76.30, 94.50, 126.20, 37.20, 64.20, 33.80, TO_DATE('2025-09-17','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (99, 58.90, 159, 115.10, 83.40, 104.70, 132.40, 40.30, 50.30, 36.00, TO_DATE('2026-08-20','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (100, 62.99, 162, 95.20, 65.00, 77.00, 103.60, 28.00, 54.40, 39.10, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (101, 67.25, 165, 100.30, 72.10, 87.20, 109.80, 31.10, 58.50, 42.20, TO_DATE('2026-08-17','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (102, 71.69, 168, 105.40, 79.20, 97.40, 115.40, 34.20, 62.60, 45.30, TO_DATE('2026-08-27','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (103, 76.32, 171, 110.50, 86.30, 107.60, 121.60, 37.30, 66.70, 34.40, TO_DATE('2026-08-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (104, 81.14, 174, 115.60, 68.40, 80.40, 127.80, 40.00, 52.00, 37.50, TO_DATE('2026-07-16','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (105, 86.15, 177, 95.00, 75.00, 90.10, 108.30, 28.10, 56.10, 40.60, TO_DATE('2026-07-26','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (106, 91.37, 180, 100.10, 82.10, 100.30, 114.50, 31.20, 60.20, 43.70, TO_DATE('2026-06-17','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (107, 96.78, 183, 105.20, 89.20, 110.50, 120.70, 34.30, 64.30, 46.80, TO_DATE('2025-12-16','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (108, 102.40, 186, 110.30, 71.30, 83.30, 126.30, 37.00, 50.40, 35.00, TO_DATE('2025-12-26','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (109, 108.23, 189, 115.40, 78.40, 93.50, 132.50, 40.10, 54.50, 38.10, TO_DATE('2026-06-11','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (110, 114.28, 192, 95.50, 85.00, 103.20, 103.70, 28.20, 58.60, 41.20, TO_DATE('2026-08-11','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (111, 120.54, 195, 100.60, 67.10, 88.40, 109.90, 31.30, 62.70, 44.30, TO_DATE('2026-08-21','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (112, 43.65, 150, 105.00, 74.20, 86.20, 115.40, 34.00, 66.00, 33.40, TO_DATE('2026-08-07','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (113, 47.05, 153, 110.10, 81.30, 96.40, 121.60, 37.10, 52.10, 36.50, TO_DATE('2026-08-17','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (114, 50.62, 156, 115.20, 88.40, 106.60, 127.20, 40.20, 56.20, 39.60, TO_DATE('2026-07-31','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (115, 54.35, 159, 95.30, 70.00, 91.30, 108.40, 28.30, 60.30, 42.70, TO_DATE('2026-08-10','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (116, 58.26, 162, 100.40, 77.10, 89.10, 114.60, 31.00, 64.40, 45.80, TO_DATE('2026-04-01','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (117, 62.35, 165, 105.50, 84.20, 99.30, 120.80, 34.10, 50.50, 34.00, TO_DATE('2026-03-26','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (118, 66.61, 168, 110.60, 66.30, 84.50, 127.00, 37.20, 54.60, 37.10, TO_DATE('2026-04-05','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (119, 71.06, 171, 115.00, 73.40, 94.70, 132.50, 40.30, 58.70, 40.20, TO_DATE('2026-06-26','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (120, 75.69, 174, 95.10, 80.00, 92.00, 103.10, 28.00, 62.00, 43.30, TO_DATE('2026-08-21','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (121, 80.52, 177, 100.20, 87.10, 102.20, 109.30, 31.10, 66.10, 46.40, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (122, 85.54, 180, 105.30, 69.20, 87.40, 115.50, 34.20, 52.20, 35.50, TO_DATE('2026-09-10','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (123, 90.76, 183, 110.40, 76.30, 97.60, 121.70, 37.30, 56.30, 38.60, TO_DATE('2026-08-27','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (124, 96.18, 186, 115.50, 83.40, 95.40, 127.90, 40.00, 60.40, 41.70, TO_DATE('2026-06-21','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (125, 101.80, 189, 95.60, 65.00, 80.10, 109.10, 28.10, 64.50, 44.80, TO_DATE('2026-07-01','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (126, 107.64, 192, 100.00, 72.10, 90.30, 114.00, 31.20, 50.60, 33.00, TO_DATE('2026-08-09','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (127, 113.69, 195, 105.10, 79.20, 100.50, 120.20, 34.30, 54.70, 36.10, TO_DATE('2026-08-03','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (128, 68.85, 150, 110.20, 86.30, 98.30, 126.40, 37.00, 58.00, 39.20, TO_DATE('2026-08-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (129, 73.27, 153, 115.30, 68.40, 83.50, 132.60, 40.10, 62.10, 42.30, TO_DATE('2026-08-10','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (130, 46.24, 156, 95.40, 75.00, 93.20, 103.80, 28.20, 66.20, 45.40, TO_DATE('2026-08-25','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (131, 49.80, 159, 100.50, 82.10, 103.40, 110.00, 31.30, 52.30, 34.50, TO_DATE('2026-08-11','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (132, 53.54, 162, 105.60, 89.20, 101.20, 115.60, 34.00, 56.40, 37.60, TO_DATE('2026-08-21','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (133, 57.44, 165, 110.00, 71.30, 86.40, 121.10, 37.10, 60.50, 40.70, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (134, 61.53, 168, 115.10, 78.40, 96.60, 127.30, 40.20, 64.60, 43.80, TO_DATE('2026-07-06','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (135, 65.79, 171, 95.20, 85.00, 106.30, 108.50, 28.30, 50.70, 46.00, TO_DATE('2026-07-16','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (136, 70.24, 174, 100.30, 67.10, 79.10, 114.70, 31.00, 54.00, 35.10, TO_DATE('2026-05-24','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (137, 74.88, 177, 105.40, 74.20, 89.30, 120.90, 34.10, 58.10, 38.20, TO_DATE('2025-11-18','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (138, 79.70, 180, 110.50, 81.30, 99.50, 126.50, 37.20, 62.20, 41.30, TO_DATE('2025-11-28','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (139, 84.73, 183, 115.60, 88.40, 109.70, 132.70, 40.30, 66.30, 44.40, TO_DATE('2026-08-25','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (140, 89.95, 186, 95.00, 70.00, 82.00, 103.20, 28.00, 52.40, 33.50, TO_DATE('2026-08-05','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (141, 95.38, 189, 100.10, 77.10, 92.20, 109.40, 31.10, 56.50, 36.60, TO_DATE('2026-08-15','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (142, 101.01, 192, 105.20, 84.20, 102.40, 115.60, 34.20, 60.60, 39.70, TO_DATE('2026-08-01','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (143, 106.85, 195, 110.30, 66.30, 87.60, 121.80, 37.30, 64.70, 42.80, TO_DATE('2026-08-11','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (144, 64.80, 150, 115.40, 73.40, 85.40, 127.40, 40.00, 50.00, 45.00, TO_DATE('2026-07-21','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (145, 69.06, 153, 95.50, 80.00, 95.10, 108.60, 28.10, 54.10, 34.10, TO_DATE('2026-07-31','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (146, 73.49, 156, 100.60, 87.10, 105.30, 114.80, 31.20, 58.20, 37.20, TO_DATE('2026-03-08','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (147, 78.12, 159, 105.00, 69.20, 90.50, 120.30, 34.30, 62.30, 40.30, TO_DATE('2026-02-26','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (148, 82.93, 162, 110.10, 76.30, 88.30, 126.50, 37.00, 66.40, 43.40, TO_DATE('2026-03-08','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (149, 52.54, 165, 115.20, 83.40, 98.50, 132.70, 40.10, 52.50, 46.50, TO_DATE('2026-06-16','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (150, 56.45, 168, 95.30, 65.00, 83.20, 103.30, 28.20, 56.60, 35.60, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (151, 60.53, 171, 100.40, 72.10, 93.40, 109.50, 31.30, 60.70, 38.70, TO_DATE('2026-08-25','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (152, 64.79, 174, 105.50, 79.20, 91.20, 115.70, 34.00, 64.00, 41.80, TO_DATE('2026-09-04','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (153, 69.24, 177, 110.60, 86.30, 101.40, 121.90, 37.10, 50.10, 44.00, TO_DATE('2026-02-24','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (154, 73.87, 180, 115.00, 68.40, 86.60, 127.40, 40.20, 54.20, 33.10, TO_DATE('2026-01-04','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (155, 78.70, 183, 95.10, 75.00, 96.30, 108.60, 28.30, 58.30, 36.20, TO_DATE('2026-01-14','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (156, 83.72, 186, 100.20, 82.10, 94.10, 114.20, 31.00, 62.40, 39.30, TO_DATE('2025-10-24','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (157, 88.95, 189, 105.30, 89.20, 104.30, 120.40, 34.10, 66.50, 42.40, TO_DATE('2025-05-06','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (158, 94.37, 192, 110.40, 71.30, 89.50, 126.60, 37.20, 52.60, 45.50, TO_DATE('2025-05-16','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (159, 100.01, 195, 115.50, 78.40, 99.70, 132.80, 40.30, 56.70, 34.60, TO_DATE('2026-02-23','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (160, 60.75, 150, 95.60, 85.00, 97.00, 104.00, 28.00, 60.00, 37.70, TO_DATE('2026-05-05','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (161, 64.84, 153, 100.00, 67.10, 82.20, 109.50, 31.10, 64.10, 40.80, TO_DATE('2026-05-15','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (162, 69.11, 156, 105.10, 74.20, 92.40, 115.10, 34.20, 50.20, 43.00, TO_DATE('2026-05-25','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (163, 73.57, 159, 110.20, 81.30, 102.60, 121.30, 37.30, 54.30, 46.10, TO_DATE('2026-06-04','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (164, 78.21, 162, 115.30, 88.40, 100.40, 127.50, 40.00, 58.40, 35.20, TO_DATE('2026-04-14','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (165, 83.04, 165, 95.40, 70.00, 85.10, 108.70, 28.10, 62.50, 38.30, TO_DATE('2026-04-24','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (166, 88.06, 168, 100.50, 77.10, 95.30, 114.90, 31.20, 66.60, 41.40, TO_DATE('2026-02-01','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (167, 93.28, 171, 105.60, 84.20, 105.50, 121.10, 34.30, 52.70, 44.50, TO_DATE('2025-08-14','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (168, 59.34, 174, 110.00, 66.30, 78.30, 126.00, 37.00, 56.00, 33.60, TO_DATE('2025-01-05','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (169, 63.60, 177, 115.10, 73.40, 88.50, 132.20, 40.10, 60.10, 36.70, TO_DATE('2025-10-15','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (170, 68.04, 180, 95.20, 80.00, 98.20, 103.40, 28.20, 64.20, 39.80, TO_DATE('2025-12-25','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (171, 72.67, 183, 100.30, 87.10, 108.40, 109.60, 31.30, 50.30, 42.00, TO_DATE('2026-01-04','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (172, 77.50, 186, 105.40, 69.20, 81.20, 115.80, 34.00, 54.40, 45.10, TO_DATE('2026-01-14','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (173, 82.52, 189, 110.50, 76.30, 91.40, 122.00, 37.10, 58.50, 34.20, TO_DATE('2026-01-24','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (174, 87.74, 192, 115.60, 83.40, 101.60, 127.60, 40.20, 62.60, 37.30, TO_DATE('2025-12-04','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (175, 93.16, 195, 95.00, 65.00, 86.30, 108.10, 28.30, 66.70, 40.40, TO_DATE('2025-12-14','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (176, 56.70, 150, 100.10, 72.10, 84.10, 114.30, 31.00, 52.00, 43.50, TO_DATE('2025-09-23','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (177, 60.63, 153, 105.20, 79.20, 94.30, 120.50, 34.10, 56.10, 46.60, TO_DATE('2025-04-05','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (178, 64.73, 156, 110.30, 86.30, 104.50, 126.70, 37.20, 60.20, 35.70, TO_DATE('2025-04-15','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (179, 69.02, 159, 115.40, 68.40, 89.70, 132.90, 40.30, 64.30, 38.80, TO_DATE('2026-01-23','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (180, 73.48, 162, 95.50, 75.00, 87.00, 103.50, 28.00, 50.40, 41.00, TO_DATE('2026-05-04','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (181, 78.14, 165, 100.60, 82.10, 97.20, 109.70, 31.10, 54.50, 44.10, TO_DATE('2026-05-14','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (182, 82.98, 168, 105.00, 89.20, 107.40, 115.20, 34.20, 58.60, 33.20, TO_DATE('2026-05-24','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (183, 88.02, 171, 110.10, 71.30, 92.60, 121.40, 37.30, 62.70, 36.30, TO_DATE('2026-06-03','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (184, 93.25, 174, 115.20, 78.40, 90.40, 127.60, 40.00, 66.00, 39.40, TO_DATE('2026-04-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (185, 98.69, 177, 95.30, 85.00, 100.10, 108.80, 28.10, 52.10, 42.50, TO_DATE('2026-04-23','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (186, 62.21, 180, 100.40, 67.10, 85.30, 114.40, 31.20, 56.20, 45.60, TO_DATE('2026-01-31','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (187, 66.64, 183, 105.50, 74.20, 95.50, 120.60, 34.30, 60.30, 34.70, TO_DATE('2025-08-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (188, 71.27, 186, 110.60, 81.30, 93.30, 126.80, 37.00, 64.40, 37.80, TO_DATE('2025-08-23','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (189, 76.09, 189, 115.00, 88.40, 103.50, 132.30, 40.10, 50.50, 40.00, TO_DATE('2025-10-14','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (190, 81.10, 192, 95.10, 70.00, 88.20, 103.50, 28.20, 54.60, 43.10, TO_DATE('2025-12-24','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (191, 86.32, 195, 100.20, 77.10, 98.40, 109.70, 31.30, 58.70, 46.20, TO_DATE('2026-01-03','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (192, 52.65, 150, 105.30, 84.20, 96.20, 115.30, 34.00, 62.00, 35.30, TO_DATE('2026-01-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (193, 56.42, 153, 110.40, 66.30, 81.40, 121.50, 37.10, 66.10, 38.40, TO_DATE('2026-01-23','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (194, 60.35, 156, 115.50, 73.40, 91.60, 127.70, 40.20, 52.20, 41.50, TO_DATE('2025-12-03','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (195, 64.47, 159, 95.60, 80.00, 101.30, 108.90, 28.30, 56.30, 44.60, TO_DATE('2025-12-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (196, 68.76, 162, 100.00, 87.10, 99.10, 114.40, 31.00, 60.40, 33.70, TO_DATE('2025-09-22','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (197, 73.24, 165, 105.10, 69.20, 84.30, 120.60, 34.10, 64.50, 36.80, TO_DATE('2025-04-04','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (198, 77.90, 168, 110.20, 76.30, 94.50, 126.20, 37.20, 50.60, 39.00, TO_DATE('2025-04-14','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (199, 82.75, 171, 115.30, 83.40, 104.70, 132.40, 40.30, 54.70, 42.10, TO_DATE('2026-01-22','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (200, 87.80, 174, 95.40, 65.00, 77.00, 103.60, 28.00, 58.00, 45.20, TO_DATE('2026-04-03','YYYY-MM-DD'));

-- OFRECER: 200 registros
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('23.507.938-0', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('16.314.012-8', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('22.515.298-5', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('18.616.569-1', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('20.699.123-2', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('11.280.435-8', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('22.131.805-6', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('15.710.873-5', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('11.504.328-5', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('19.352.468-0', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('19.027.228-1', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('14.900.991-4', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('14.825.159-2', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('17.674.700-5', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('12.363.714-3', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.704.807-3', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('20.817.865-2', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('21.810.749-4', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('22.019.455-8', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('19.687.556-5', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('15.184.138-4', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('10.415.056-K', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.223.627-0', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('21.926.290-6', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('16.188.185-6', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('16.099.226-3', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('17.735.513-5', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('17.083.634-0', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('11.521.428-4', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('16.690.306-8', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.947.974-8', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('19.826.714-7', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('19.302.111-5', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('18.362.688-4', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.549.625-7', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('11.953.672-3', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('17.137.754-4', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('18.495.290-4', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('23.464.542-0', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('22.585.374-6', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.541.731-4', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('20.069.101-6', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.687.336-4', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('18.238.128-4', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('16.679.821-3', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('25.380.590-0', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('18.802.211-1', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('14.339.316-K', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.167.984-5', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('17.045.862-1', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.000.969-7', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.000.988-3', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.007-5', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.026-1', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.045-8', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.064-4', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.083-0', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.102-0', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.121-7', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.140-3', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.159-4', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.178-0', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.197-7', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.216-7', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.235-3', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.254-K', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.273-6', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.292-2', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.311-2', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.330-9', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.349-K', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.368-6', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.387-2', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.406-2', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.425-9', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.444-5', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.463-1', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.482-8', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.501-8', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.520-4', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.539-5', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.558-1', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.577-8', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.596-4', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.615-4', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.634-0', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.653-7', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.672-3', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.691-K', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.710-K', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.729-0', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.748-7', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.767-3', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.786-K', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.805-K', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.824-6', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.843-2', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.862-9', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.881-5', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.900-5', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.919-6', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.938-2', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.957-9', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.976-5', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.001.995-1', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.014-3', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.033-K', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.052-6', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.071-2', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.090-9', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.109-3', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.128-K', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.147-6', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.166-2', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.185-9', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.204-9', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.223-5', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.242-1', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.261-8', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.280-4', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.299-5', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.318-5', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.337-1', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.356-8', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.375-4', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.394-0', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.413-0', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.432-7', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.451-3', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.470-K', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.489-0', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.508-0', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.527-7', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.546-3', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.565-K', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.584-6', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.603-6', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.622-2', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.641-9', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.660-5', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.679-6', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.698-2', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.717-2', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.736-9', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.755-5', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.774-1', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.793-8', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.812-8', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.831-4', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.850-0', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.869-1', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.888-8', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.907-8', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.926-4', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.945-0', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.964-7', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.002.983-3', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.002-5', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.021-1', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.040-8', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.059-9', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.078-5', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.097-1', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.116-1', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.135-8', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.154-4', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.173-0', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.192-7', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.211-7', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.230-3', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.249-4', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.268-0', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.287-7', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.306-7', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.325-3', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.344-K', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.363-6', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.382-2', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.401-2', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.420-9', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.439-K', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.458-6', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.477-2', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.496-9', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.515-9', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.534-5', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.553-1', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.572-8', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.591-4', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.610-4', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.629-5', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.648-1', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.667-8', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.686-4', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.705-4', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.724-0', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.743-7', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.762-3', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.781-K', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('27.003.800-K', 10);

-- PATOLOGIAS: 70 registros
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (1, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 1, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (2, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 2, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (3, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 3, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (4, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 4, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (5, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 5, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (6, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 6, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (7, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 7, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (8, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 8, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (9, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 9, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (10, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 10, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (11, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 11, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (12, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 12, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (13, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 13, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (14, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 14, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (15, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 15, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (16, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 16, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (17, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 17, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (18, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 18, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (19, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 19, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (20, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 20, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (21, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 21, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (22, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 22, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (23, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 23, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (24, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 24, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (25, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 25, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (26, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 26, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (27, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 27, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (28, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 28, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (29, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 29, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (30, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 30, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (31, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 1, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (32, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 2, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (33, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 3, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (34, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 4, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (35, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 5, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (36, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 6, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (37, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 7, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (38, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 8, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (39, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 9, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (40, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 10, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (41, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 11, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (42, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 12, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (43, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 13, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (44, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 14, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (45, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 15, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (46, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 16, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (47, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 17, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (48, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 18, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (49, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 19, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (50, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 20, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (51, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 31, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (52, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 32, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (53, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 33, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (54, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 34, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (55, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 35, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (56, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 36, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (57, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 37, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (58, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 38, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (59, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 39, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (60, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 40, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (61, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 41, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (62, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 42, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (63, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 43, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (64, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 44, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (65, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 45, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (66, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 46, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (67, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 47, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (68, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 48, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (69, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 49, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (70, 'Sin Patologías', 'Sin Patologías', 'Ninguno', 'N/A', 50, 51);

-- PROGRE_CLI: 200 registros
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (1, 'Mejora de 2 kg de peso tras 4 semanas', TO_DATE('2025-07-24','YYYY-MM-DD'), 1);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (2, 'Mejora de 2 kg de peso tras 6 semanas', TO_DATE('2025-04-24','YYYY-MM-DD'), 2);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (3, 'Mejora de 2 kg de peso tras 8 semanas', TO_DATE('2026-09-08','YYYY-MM-DD'), 3);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (4, 'Mejora de 2 kg de peso tras 10 semanas', TO_DATE('2025-07-13','YYYY-MM-DD'), 4);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (5, 'Mejora de 2 kg de peso tras 12 semanas', TO_DATE('2025-08-11','YYYY-MM-DD'), 5);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (6, 'Mejora de 2 kg de peso tras 3 meses', TO_DATE('2025-04-03','YYYY-MM-DD'), 6);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (7, 'Mejora de 2 kg de peso tras 4 meses', TO_DATE('2026-06-03','YYYY-MM-DD'), 7);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (8, 'Mejora de 2 kg de peso tras 5 meses', TO_DATE('2025-08-07','YYYY-MM-DD'), 8);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (9, 'Mejora de 2 kg de peso tras 6 meses', TO_DATE('2025-08-18','YYYY-MM-DD'), 9);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (10, 'Mejora de 2 kg de peso tras 7 meses', TO_DATE('2025-09-15','YYYY-MM-DD'), 10);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (11, 'Mejora de 2 kg de peso tras 8 meses', TO_DATE('2025-10-14','YYYY-MM-DD'), 11);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (12, 'Mejora de 2 kg de peso tras 9 meses', TO_DATE('2025-03-02','YYYY-MM-DD'), 12);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (13, 'Mejora de 2 kg de peso tras 10 meses', TO_DATE('2026-07-19','YYYY-MM-DD'), 13);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (14, 'Mejora de 2 kg de peso tras 11 meses', TO_DATE('2026-04-24','YYYY-MM-DD'), 14);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (15, 'Mejora de 2 kg de peso tras 12 meses', TO_DATE('2026-02-04','YYYY-MM-DD'), 15);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (16, 'Mejora de 2 kg de peso tras el primer mes', TO_DATE('2025-01-25','YYYY-MM-DD'), 16);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (17, 'Mejora de 2 kg de peso tras el segundo mes', TO_DATE('2026-07-22','YYYY-MM-DD'), 17);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (18, 'Mejora de 2 kg de peso tras el tercer mes', TO_DATE('2025-12-05','YYYY-MM-DD'), 18);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (19, 'Mejora de 2 kg de peso tras la primera etapa', TO_DATE('2025-06-03','YYYY-MM-DD'), 19);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (20, 'Mejora de 2 kg de peso tras la etapa final', TO_DATE('2025-12-18','YYYY-MM-DD'), 20);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (21, 'Mejora de masa muscular tras 4 semanas', TO_DATE('2025-11-26','YYYY-MM-DD'), 21);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (22, 'Mejora de masa muscular tras 6 semanas', TO_DATE('2026-01-05','YYYY-MM-DD'), 22);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (23, 'Mejora de masa muscular tras 8 semanas', TO_DATE('2026-05-06','YYYY-MM-DD'), 23);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (24, 'Mejora de masa muscular tras 10 semanas', TO_DATE('2026-09-05','YYYY-MM-DD'), 24);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (25, 'Mejora de masa muscular tras 12 semanas', TO_DATE('2025-12-13','YYYY-MM-DD'), 25);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (26, 'Mejora de masa muscular tras 3 meses', TO_DATE('2025-05-28','YYYY-MM-DD'), 26);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (27, 'Mejora de masa muscular tras 4 meses', TO_DATE('2026-04-03','YYYY-MM-DD'), 27);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (28, 'Mejora de masa muscular tras 5 meses', TO_DATE('2026-08-09','YYYY-MM-DD'), 28);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (29, 'Mejora de masa muscular tras 6 meses', TO_DATE('2026-07-09','YYYY-MM-DD'), 29);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (30, 'Mejora de masa muscular tras 7 meses', TO_DATE('2025-04-12','YYYY-MM-DD'), 30);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (31, 'Mejora de masa muscular tras 8 meses', TO_DATE('2025-04-11','YYYY-MM-DD'), 31);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (32, 'Mejora de masa muscular tras 9 meses', TO_DATE('2026-08-15','YYYY-MM-DD'), 32);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (33, 'Mejora de masa muscular tras 10 meses', TO_DATE('2025-07-25','YYYY-MM-DD'), 33);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (34, 'Mejora de masa muscular tras 11 meses', TO_DATE('2025-12-12','YYYY-MM-DD'), 34);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (35, 'Mejora de masa muscular tras 12 meses', TO_DATE('2025-05-10','YYYY-MM-DD'), 35);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (36, 'Mejora de masa muscular tras el primer mes', TO_DATE('2025-12-12','YYYY-MM-DD'), 36);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (37, 'Mejora de masa muscular tras el segundo mes', TO_DATE('2026-08-05','YYYY-MM-DD'), 37);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (38, 'Mejora de masa muscular tras el tercer mes', TO_DATE('2026-03-03','YYYY-MM-DD'), 38);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (39, 'Mejora de masa muscular tras la primera etapa', TO_DATE('2025-07-22','YYYY-MM-DD'), 39);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (40, 'Mejora de masa muscular tras la etapa final', TO_DATE('2025-12-12','YYYY-MM-DD'), 40);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (41, 'Mejora de resistencia cardiovascular tras 4 semanas', TO_DATE('2025-07-29','YYYY-MM-DD'), 41);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (42, 'Mejora de resistencia cardiovascular tras 6 semanas', TO_DATE('2025-12-02','YYYY-MM-DD'), 42);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (43, 'Mejora de resistencia cardiovascular tras 8 semanas', TO_DATE('2025-08-27','YYYY-MM-DD'), 43);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (44, 'Mejora de resistencia cardiovascular tras 10 semanas', TO_DATE('2025-07-12','YYYY-MM-DD'), 44);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (45, 'Mejora de resistencia cardiovascular tras 12 semanas', TO_DATE('2025-12-02','YYYY-MM-DD'), 45);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (46, 'Mejora de resistencia cardiovascular tras 3 meses', TO_DATE('2025-08-21','YYYY-MM-DD'), 46);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (47, 'Mejora de resistencia cardiovascular tras 4 meses', TO_DATE('2025-07-03','YYYY-MM-DD'), 47);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (48, 'Mejora de resistencia cardiovascular tras 5 meses', TO_DATE('2025-11-05','YYYY-MM-DD'), 48);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (49, 'Mejora de resistencia cardiovascular tras 6 meses', TO_DATE('2026-03-20','YYYY-MM-DD'), 49);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (50, 'Mejora de resistencia cardiovascular tras 7 meses', TO_DATE('2025-05-26','YYYY-MM-DD'), 50);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (51, 'Mejora de resistencia cardiovascular tras 8 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 51);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (52, 'Mejora de resistencia cardiovascular tras 9 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 52);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (53, 'Mejora de resistencia cardiovascular tras 10 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 53);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (54, 'Mejora de resistencia cardiovascular tras 11 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 54);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (55, 'Mejora de resistencia cardiovascular tras 12 meses', TO_DATE('2026-09-14','YYYY-MM-DD'), 55);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (56, 'Mejora de resistencia cardiovascular tras el primer mes', TO_DATE('2026-08-28','YYYY-MM-DD'), 56);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (57, 'Mejora de resistencia cardiovascular tras el segundo mes', TO_DATE('2026-08-31','YYYY-MM-DD'), 57);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (58, 'Mejora de resistencia cardiovascular tras el tercer mes', TO_DATE('2026-09-11','YYYY-MM-DD'), 58);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (59, 'Mejora de resistencia cardiovascular tras la primera etapa', TO_DATE('2026-09-20','YYYY-MM-DD'), 59);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (60, 'Mejora de resistencia cardiovascular tras la etapa final', TO_DATE('2026-09-20','YYYY-MM-DD'), 60);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (61, 'Mejora de fuerza en sentadilla tras 4 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 61);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (62, 'Mejora de fuerza en sentadilla tras 6 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 62);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (63, 'Mejora de fuerza en sentadilla tras 8 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 63);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (64, 'Mejora de fuerza en sentadilla tras 10 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 64);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (65, 'Mejora de fuerza en sentadilla tras 12 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 65);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (66, 'Mejora de fuerza en sentadilla tras 3 meses', TO_DATE('2026-07-22','YYYY-MM-DD'), 66);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (67, 'Mejora de fuerza en sentadilla tras 4 meses', TO_DATE('2026-01-25','YYYY-MM-DD'), 67);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (68, 'Mejora de fuerza en sentadilla tras 5 meses', TO_DATE('2026-02-05','YYYY-MM-DD'), 68);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (69, 'Mejora de fuerza en sentadilla tras 6 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 69);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (70, 'Mejora de fuerza en sentadilla tras 7 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 70);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (71, 'Mejora de fuerza en sentadilla tras 8 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 71);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (72, 'Mejora de fuerza en sentadilla tras 9 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 72);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (73, 'Mejora de fuerza en sentadilla tras 10 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 73);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (74, 'Mejora de fuerza en sentadilla tras 11 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 74);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (75, 'Mejora de fuerza en sentadilla tras 12 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 75);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (76, 'Mejora de fuerza en sentadilla tras el primer mes', TO_DATE('2026-09-20','YYYY-MM-DD'), 76);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (77, 'Mejora de fuerza en sentadilla tras el segundo mes', TO_DATE('2026-05-15','YYYY-MM-DD'), 77);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (78, 'Mejora de fuerza en sentadilla tras el tercer mes', TO_DATE('2026-05-26','YYYY-MM-DD'), 78);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (79, 'Mejora de fuerza en sentadilla tras la primera etapa', TO_DATE('2026-09-20','YYYY-MM-DD'), 79);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (80, 'Mejora de fuerza en sentadilla tras la etapa final', TO_DATE('2026-09-20','YYYY-MM-DD'), 80);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (81, 'Mejora de porcentaje de grasa corporal tras 4 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 81);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (82, 'Mejora de porcentaje de grasa corporal tras 6 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 82);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (83, 'Mejora de porcentaje de grasa corporal tras 8 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 83);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (84, 'Mejora de porcentaje de grasa corporal tras 10 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 84);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (85, 'Mejora de porcentaje de grasa corporal tras 12 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 85);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (86, 'Mejora de porcentaje de grasa corporal tras 3 meses', TO_DATE('2026-09-03','YYYY-MM-DD'), 86);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (87, 'Mejora de porcentaje de grasa corporal tras 4 meses', TO_DATE('2026-09-02','YYYY-MM-DD'), 87);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (88, 'Mejora de porcentaje de grasa corporal tras 5 meses', TO_DATE('2026-09-13','YYYY-MM-DD'), 88);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (89, 'Mejora de porcentaje de grasa corporal tras 6 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 89);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (90, 'Mejora de porcentaje de grasa corporal tras 7 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 90);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (91, 'Mejora de porcentaje de grasa corporal tras 8 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 91);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (92, 'Mejora de porcentaje de grasa corporal tras 9 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 92);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (93, 'Mejora de porcentaje de grasa corporal tras 10 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 93);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (94, 'Mejora de porcentaje de grasa corporal tras 11 meses', TO_DATE('2026-08-19','YYYY-MM-DD'), 94);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (95, 'Mejora de porcentaje de grasa corporal tras 12 meses', TO_DATE('2026-08-30','YYYY-MM-DD'), 95);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (96, 'Mejora de porcentaje de grasa corporal tras el primer mes', TO_DATE('2026-09-20','YYYY-MM-DD'), 96);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (97, 'Mejora de porcentaje de grasa corporal tras el segundo mes', TO_DATE('2026-09-20','YYYY-MM-DD'), 97);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (98, 'Mejora de porcentaje de grasa corporal tras el tercer mes', TO_DATE('2025-11-09','YYYY-MM-DD'), 98);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (99, 'Mejora de porcentaje de grasa corporal tras la primera etapa', TO_DATE('2026-09-20','YYYY-MM-DD'), 99);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (100, 'Mejora de porcentaje de grasa corporal tras la etapa final', TO_DATE('2026-09-20','YYYY-MM-DD'), 100);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (101, 'Mejora de técnica de peso muerto tras 4 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 101);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (102, 'Mejora de técnica de peso muerto tras 6 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 102);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (103, 'Mejora de técnica de peso muerto tras 8 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 103);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (104, 'Mejora de técnica de peso muerto tras 10 semanas', TO_DATE('2026-09-13','YYYY-MM-DD'), 104);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (105, 'Mejora de técnica de peso muerto tras 12 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 105);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (106, 'Mejora de técnica de peso muerto tras 3 meses', TO_DATE('2026-08-17','YYYY-MM-DD'), 106);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (107, 'Mejora de técnica de peso muerto tras 4 meses', TO_DATE('2026-02-16','YYYY-MM-DD'), 107);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (108, 'Mejora de técnica de peso muerto tras 5 meses', TO_DATE('2026-02-27','YYYY-MM-DD'), 108);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (109, 'Mejora de técnica de peso muerto tras 6 meses', TO_DATE('2026-08-14','YYYY-MM-DD'), 109);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (110, 'Mejora de técnica de peso muerto tras 7 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 110);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (111, 'Mejora de técnica de peso muerto tras 8 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 111);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (112, 'Mejora de técnica de peso muerto tras 9 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 112);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (113, 'Mejora de técnica de peso muerto tras 10 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 113);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (114, 'Mejora de técnica de peso muerto tras 11 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 114);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (115, 'Mejora de técnica de peso muerto tras 12 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 115);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (116, 'Mejora de técnica de peso muerto tras el primer mes', TO_DATE('2026-06-11','YYYY-MM-DD'), 116);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (117, 'Mejora de técnica de peso muerto tras el segundo mes', TO_DATE('2026-06-06','YYYY-MM-DD'), 117);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (118, 'Mejora de técnica de peso muerto tras el tercer mes', TO_DATE('2026-06-17','YYYY-MM-DD'), 118);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (119, 'Mejora de técnica de peso muerto tras la primera etapa', TO_DATE('2026-09-08','YYYY-MM-DD'), 119);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (120, 'Mejora de técnica de peso muerto tras la etapa final', TO_DATE('2026-09-20','YYYY-MM-DD'), 120);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (121, 'Mejora de movilidad de cadera tras 4 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 121);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (122, 'Mejora de movilidad de cadera tras 6 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 122);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (123, 'Mejora de movilidad de cadera tras 8 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 123);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (124, 'Mejora de movilidad de cadera tras 10 semanas', TO_DATE('2026-09-08','YYYY-MM-DD'), 124);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (125, 'Mejora de movilidad de cadera tras 12 semanas', TO_DATE('2026-09-19','YYYY-MM-DD'), 125);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (126, 'Mejora de movilidad de cadera tras 3 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 126);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (127, 'Mejora de movilidad de cadera tras 4 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 127);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (128, 'Mejora de movilidad de cadera tras 5 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 128);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (129, 'Mejora de movilidad de cadera tras 6 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 129);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (130, 'Mejora de movilidad de cadera tras 7 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 130);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (131, 'Mejora de movilidad de cadera tras 8 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 131);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (132, 'Mejora de movilidad de cadera tras 9 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 132);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (133, 'Mejora de movilidad de cadera tras 10 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 133);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (134, 'Mejora de movilidad de cadera tras 11 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 134);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (135, 'Mejora de movilidad de cadera tras 12 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 135);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (136, 'Mejora de movilidad de cadera tras el primer mes', TO_DATE('2026-08-23','YYYY-MM-DD'), 136);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (137, 'Mejora de movilidad de cadera tras el segundo mes', TO_DATE('2026-02-18','YYYY-MM-DD'), 137);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (138, 'Mejora de movilidad de cadera tras el tercer mes', TO_DATE('2026-03-01','YYYY-MM-DD'), 138);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (139, 'Mejora de movilidad de cadera tras la primera etapa', TO_DATE('2026-09-20','YYYY-MM-DD'), 139);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (140, 'Mejora de movilidad de cadera tras la etapa final', TO_DATE('2026-09-20','YYYY-MM-DD'), 140);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (141, 'Mejora de fuerza en press de banca tras 4 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 141);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (142, 'Mejora de fuerza en press de banca tras 6 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 142);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (143, 'Mejora de fuerza en press de banca tras 8 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 143);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (144, 'Mejora de fuerza en press de banca tras 10 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 144);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (145, 'Mejora de fuerza en press de banca tras 12 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 145);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (146, 'Mejora de fuerza en press de banca tras 3 meses', TO_DATE('2026-06-17','YYYY-MM-DD'), 146);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (147, 'Mejora de fuerza en press de banca tras 4 meses', TO_DATE('2026-06-08','YYYY-MM-DD'), 147);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (148, 'Mejora de fuerza en press de banca tras 5 meses', TO_DATE('2026-06-19','YYYY-MM-DD'), 148);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (149, 'Mejora de fuerza en press de banca tras 6 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 149);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (150, 'Mejora de fuerza en press de banca tras 7 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 150);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (151, 'Mejora de fuerza en press de banca tras 8 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 151);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (152, 'Mejora de fuerza en press de banca tras 9 meses', TO_DATE('2026-09-20','YYYY-MM-DD'), 152);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (153, 'Mejora de fuerza en press de banca tras 10 meses', TO_DATE('2026-06-12','YYYY-MM-DD'), 153);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (154, 'Mejora de fuerza en press de banca tras 11 meses', TO_DATE('2026-04-23','YYYY-MM-DD'), 154);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (155, 'Mejora de fuerza en press de banca tras 12 meses', TO_DATE('2026-05-04','YYYY-MM-DD'), 155);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (156, 'Mejora de fuerza en press de banca tras el primer mes', TO_DATE('2026-02-12','YYYY-MM-DD'), 156);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (157, 'Mejora de fuerza en press de banca tras el segundo mes', TO_DATE('2025-08-26','YYYY-MM-DD'), 157);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (158, 'Mejora de fuerza en press de banca tras el tercer mes', TO_DATE('2025-09-06','YYYY-MM-DD'), 158);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (159, 'Mejora de fuerza en press de banca tras la primera etapa', TO_DATE('2026-06-17','YYYY-MM-DD'), 159);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (160, 'Mejora de fuerza en press de banca tras la etapa final', TO_DATE('2026-08-28','YYYY-MM-DD'), 160);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (161, 'Mejora de adherencia al entrenamiento tras 4 semanas', TO_DATE('2026-09-08','YYYY-MM-DD'), 161);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (162, 'Mejora de adherencia al entrenamiento tras 6 semanas', TO_DATE('2026-09-19','YYYY-MM-DD'), 162);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (163, 'Mejora de adherencia al entrenamiento tras 8 semanas', TO_DATE('2026-09-20','YYYY-MM-DD'), 163);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (164, 'Mejora de adherencia al entrenamiento tras 10 semanas', TO_DATE('2026-08-11','YYYY-MM-DD'), 164);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (165, 'Mejora de adherencia al entrenamiento tras 12 semanas', TO_DATE('2026-08-22','YYYY-MM-DD'), 165);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (166, 'Mejora de adherencia al entrenamiento tras 3 meses', TO_DATE('2026-06-02','YYYY-MM-DD'), 166);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (167, 'Mejora de adherencia al entrenamiento tras 4 meses', TO_DATE('2025-12-14','YYYY-MM-DD'), 167);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (168, 'Mejora de adherencia al entrenamiento tras 5 meses', TO_DATE('2025-05-08','YYYY-MM-DD'), 168);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (169, 'Mejora de adherencia al entrenamiento tras 6 meses', TO_DATE('2026-02-16','YYYY-MM-DD'), 169);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (170, 'Mejora de adherencia al entrenamiento tras 7 meses', TO_DATE('2026-04-29','YYYY-MM-DD'), 170);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (171, 'Mejora de adherencia al entrenamiento tras 8 meses', TO_DATE('2026-05-10','YYYY-MM-DD'), 171);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (172, 'Mejora de adherencia al entrenamiento tras 9 meses', TO_DATE('2026-05-21','YYYY-MM-DD'), 172);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (173, 'Mejora de adherencia al entrenamiento tras 10 meses', TO_DATE('2026-06-01','YYYY-MM-DD'), 173);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (174, 'Mejora de adherencia al entrenamiento tras 11 meses', TO_DATE('2026-04-12','YYYY-MM-DD'), 174);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (175, 'Mejora de adherencia al entrenamiento tras 12 meses', TO_DATE('2026-04-23','YYYY-MM-DD'), 175);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (176, 'Mejora de adherencia al entrenamiento tras el primer mes', TO_DATE('2026-02-01','YYYY-MM-DD'), 176);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (177, 'Mejora de adherencia al entrenamiento tras el segundo mes', TO_DATE('2025-08-15','YYYY-MM-DD'), 177);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (178, 'Mejora de adherencia al entrenamiento tras el tercer mes', TO_DATE('2025-08-26','YYYY-MM-DD'), 178);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (179, 'Mejora de adherencia al entrenamiento tras la primera etapa', TO_DATE('2026-06-06','YYYY-MM-DD'), 179);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (180, 'Mejora de adherencia al entrenamiento tras la etapa final', TO_DATE('2026-06-18','YYYY-MM-DD'), 180);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (181, 'Mejora de capacidad aeróbica tras 4 semanas', TO_DATE('2026-06-29','YYYY-MM-DD'), 181);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (182, 'Mejora de capacidad aeróbica tras 6 semanas', TO_DATE('2026-07-10','YYYY-MM-DD'), 182);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (183, 'Mejora de capacidad aeróbica tras 8 semanas', TO_DATE('2026-07-21','YYYY-MM-DD'), 183);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (184, 'Mejora de capacidad aeróbica tras 10 semanas', TO_DATE('2026-06-01','YYYY-MM-DD'), 184);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (185, 'Mejora de capacidad aeróbica tras 12 semanas', TO_DATE('2026-06-12','YYYY-MM-DD'), 185);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (186, 'Mejora de capacidad aeróbica tras 3 meses', TO_DATE('2026-03-23','YYYY-MM-DD'), 186);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (187, 'Mejora de capacidad aeróbica tras 4 meses', TO_DATE('2025-10-04','YYYY-MM-DD'), 187);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (188, 'Mejora de capacidad aeróbica tras 5 meses', TO_DATE('2025-10-15','YYYY-MM-DD'), 188);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (189, 'Mejora de capacidad aeróbica tras 6 meses', TO_DATE('2025-12-07','YYYY-MM-DD'), 189);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (190, 'Mejora de capacidad aeróbica tras 7 meses', TO_DATE('2026-02-17','YYYY-MM-DD'), 190);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (191, 'Mejora de capacidad aeróbica tras 8 meses', TO_DATE('2026-02-28','YYYY-MM-DD'), 191);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (192, 'Mejora de capacidad aeróbica tras 9 meses', TO_DATE('2026-03-11','YYYY-MM-DD'), 192);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (193, 'Mejora de capacidad aeróbica tras 10 meses', TO_DATE('2026-03-22','YYYY-MM-DD'), 193);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (194, 'Mejora de capacidad aeróbica tras 11 meses', TO_DATE('2026-01-31','YYYY-MM-DD'), 194);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (195, 'Mejora de capacidad aeróbica tras 12 meses', TO_DATE('2026-02-11','YYYY-MM-DD'), 195);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (196, 'Mejora de capacidad aeróbica tras el primer mes', TO_DATE('2025-11-22','YYYY-MM-DD'), 196);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (197, 'Mejora de capacidad aeróbica tras el segundo mes', TO_DATE('2025-06-05','YYYY-MM-DD'), 197);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (198, 'Mejora de capacidad aeróbica tras el tercer mes', TO_DATE('2025-06-16','YYYY-MM-DD'), 198);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (199, 'Mejora de capacidad aeróbica tras la primera etapa', TO_DATE('2026-03-27','YYYY-MM-DD'), 199);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (200, 'Mejora de capacidad aeróbica tras la etapa final', TO_DATE('2026-06-07','YYYY-MM-DD'), 200);

-- REGISTRAR: 200 registros
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (1, 1);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (2, 2);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (3, 3);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (4, 4);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (5, 5);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (6, 6);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (7, 7);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (8, 8);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (9, 9);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (10, 10);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (11, 11);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (12, 12);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (13, 13);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (14, 14);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (15, 15);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (16, 16);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (17, 17);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (18, 18);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (19, 19);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (20, 20);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (21, 21);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (22, 22);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (23, 23);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (24, 24);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (25, 25);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (26, 26);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (27, 27);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (28, 28);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (29, 29);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (30, 30);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (31, 31);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (32, 32);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (33, 33);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (34, 34);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (35, 35);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (36, 36);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (37, 37);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (38, 38);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (39, 39);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (40, 40);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (41, 41);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (42, 42);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (43, 43);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (44, 44);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (45, 45);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (46, 46);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (47, 47);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (48, 48);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (49, 49);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (50, 50);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (51, 51);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (52, 52);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (53, 53);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (54, 54);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (55, 55);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (56, 56);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (57, 57);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (58, 58);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (59, 59);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (60, 60);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (61, 61);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (62, 62);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (63, 63);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (64, 64);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (65, 65);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (66, 66);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (67, 67);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (68, 68);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (69, 69);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (70, 70);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (71, 71);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (72, 72);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (73, 73);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (74, 74);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (75, 75);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (76, 76);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (77, 77);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (78, 78);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (79, 79);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (80, 80);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (81, 81);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (82, 82);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (83, 83);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (84, 84);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (85, 85);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (86, 86);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (87, 87);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (88, 88);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (89, 89);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (90, 90);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (91, 91);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (92, 92);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (93, 93);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (94, 94);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (95, 95);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (96, 96);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (97, 97);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (98, 98);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (99, 99);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (100, 100);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (101, 101);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (102, 102);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (103, 103);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (104, 104);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (105, 105);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (106, 106);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (107, 107);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (108, 108);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (109, 109);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (110, 110);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (111, 111);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (112, 112);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (113, 113);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (114, 114);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (115, 115);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (116, 116);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (117, 117);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (118, 118);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (119, 119);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (120, 120);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (121, 121);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (122, 122);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (123, 123);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (124, 124);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (125, 125);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (126, 126);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (127, 127);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (128, 128);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (129, 129);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (130, 130);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (131, 131);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (132, 132);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (133, 133);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (134, 134);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (135, 135);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (136, 136);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (137, 137);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (138, 138);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (139, 139);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (140, 140);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (141, 141);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (142, 142);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (143, 143);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (144, 144);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (145, 145);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (146, 146);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (147, 147);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (148, 148);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (149, 149);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (150, 150);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (151, 151);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (152, 152);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (153, 153);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (154, 154);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (155, 155);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (156, 156);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (157, 157);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (158, 158);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (159, 159);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (160, 160);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (161, 161);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (162, 162);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (163, 163);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (164, 164);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (165, 165);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (166, 166);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (167, 167);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (168, 168);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (169, 169);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (170, 170);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (171, 171);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (172, 172);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (173, 173);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (174, 174);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (175, 175);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (176, 176);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (177, 177);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (178, 178);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (179, 179);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (180, 180);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (181, 181);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (182, 182);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (183, 183);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (184, 184);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (185, 185);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (186, 186);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (187, 187);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (188, 188);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (189, 189);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (190, 190);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (191, 191);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (192, 192);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (193, 193);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (194, 194);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (195, 195);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (196, 196);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (197, 197);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (198, 198);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (199, 199);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (200, 200);

-- SESION_ENTRENAMIENTO: 200 registros
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (1, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 2, 2, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (2, TO_DATE('2026-08-19','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 4, 4, TO_DATE('2026-08-19','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (3, TO_DATE('2026-08-21','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 5, 5, TO_DATE('2026-08-21','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (4, TO_DATE('2026-08-09','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 7, 7, TO_DATE('2026-08-09','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (5, TO_DATE('2026-08-28','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 8, 8, TO_DATE('2026-08-28','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (6, TO_DATE('2026-08-24','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 9, 9, TO_DATE('2026-08-24','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (7, TO_DATE('2026-09-10','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 11, 11, TO_DATE('2026-09-10','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (8, TO_DATE('2026-08-26','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 13, 13, TO_DATE('2026-08-26','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (9, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 14, 14, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (10, TO_DATE('2026-07-30','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 16, 16, TO_DATE('2026-07-30','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (11, TO_DATE('2026-08-27','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 17, 17, TO_DATE('2026-08-27','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (12, TO_DATE('2026-05-22','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 18, 18, TO_DATE('2026-05-22','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (13, TO_DATE('2026-09-19','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 19, 19, TO_DATE('2026-09-19','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (14, TO_DATE('2026-08-18','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 21, 21, TO_DATE('2026-08-18','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (15, TO_DATE('2026-09-19','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 22, 22, TO_DATE('2026-09-19','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (16, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 23, 23, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (17, TO_DATE('2026-07-12','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 24, 24, TO_DATE('2026-07-12','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (18, TO_DATE('2026-07-30','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 25, 25, TO_DATE('2026-07-30','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (19, TO_DATE('2026-08-23','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 26, 26, TO_DATE('2026-08-23','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (20, TO_DATE('2025-07-23','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 27, 27, TO_DATE('2025-07-23','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (21, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 28, 28, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (22, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 29, 29, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (23, TO_DATE('2026-09-13','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 31, 31, TO_DATE('2026-09-13','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (24, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 32, 32, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (25, TO_DATE('2026-06-25','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 33, 33, TO_DATE('2026-06-25','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (26, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 35, 35, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (27, TO_DATE('2026-03-13','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 36, 36, TO_DATE('2026-03-13','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (28, TO_DATE('2026-08-04','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 38, 38, TO_DATE('2026-08-04','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (29, TO_DATE('2026-08-26','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 39, 39, TO_DATE('2026-08-26','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (30, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 41, 41, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (31, TO_DATE('2026-09-06','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 43, 43, TO_DATE('2026-09-06','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (32, TO_DATE('2026-08-01','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 44, 44, TO_DATE('2026-08-01','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (33, TO_DATE('2026-06-18','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 45, 45, TO_DATE('2026-06-18','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (34, TO_DATE('2026-08-15','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 47, 47, TO_DATE('2026-08-15','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (35, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 50, 50, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (36, TO_DATE('2026-09-04','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 1, 1, TO_DATE('2026-09-04','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (37, TO_DATE('2026-04-16','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 3, 3, TO_DATE('2026-04-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (38, TO_DATE('2024-12-15','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 6, 6, TO_DATE('2024-12-15','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (39, TO_DATE('2026-09-15','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 10, 10, TO_DATE('2026-09-15','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (40, TO_DATE('2026-08-15','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 12, 12, TO_DATE('2026-08-15','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (41, TO_DATE('2026-02-20','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 15, 15, TO_DATE('2026-02-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (42, TO_DATE('2026-09-06','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 20, 20, TO_DATE('2026-09-06','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (43, TO_DATE('2026-08-22','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 30, 30, TO_DATE('2026-08-22','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (44, TO_DATE('2026-09-04','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 34, 34, TO_DATE('2026-09-04','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (45, TO_DATE('2026-06-27','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 37, 37, TO_DATE('2026-06-27','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (46, TO_DATE('2026-09-01','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 40, 40, TO_DATE('2026-09-01','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (47, TO_DATE('2026-08-16','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 42, 42, TO_DATE('2026-08-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (48, TO_DATE('2026-01-04','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 46, 46, TO_DATE('2026-01-04','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (49, TO_DATE('2026-07-29','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 48, 48, TO_DATE('2026-07-29','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (50, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 49, 49, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (51, TO_DATE('2026-09-04','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 51, 51, TO_DATE('2026-09-04','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (52, TO_DATE('2026-09-11','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 52, 52, TO_DATE('2026-09-11','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (53, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 53, 53, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (54, TO_DATE('2026-09-15','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 54, 54, TO_DATE('2026-09-15','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (55, TO_DATE('2026-08-27','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 55, 55, TO_DATE('2026-08-27','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (56, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 56, 56, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (57, TO_DATE('2026-07-02','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 57, 57, TO_DATE('2026-07-02','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (58, TO_DATE('2026-09-02','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 58, 58, TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (59, TO_DATE('2026-09-16','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 59, 59, TO_DATE('2026-09-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (60, TO_DATE('2026-09-04','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 60, 60, TO_DATE('2026-09-04','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (61, TO_DATE('2026-09-16','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 61, 61, TO_DATE('2026-09-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (62, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 62, 62, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (63, TO_DATE('2026-09-12','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 63, 63, TO_DATE('2026-09-12','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (64, TO_DATE('2026-08-24','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 64, 64, TO_DATE('2026-08-24','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (65, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 65, 65, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (66, TO_DATE('2026-08-16','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 66, 66, TO_DATE('2026-08-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (67, TO_DATE('2026-02-14','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 67, 67, TO_DATE('2026-02-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (68, TO_DATE('2026-03-15','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 68, 68, TO_DATE('2026-03-15','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (69, TO_DATE('2026-09-10','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 69, 69, TO_DATE('2026-09-10','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (70, TO_DATE('2026-09-18','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 70, 70, TO_DATE('2026-09-18','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (71, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 71, 71, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (72, TO_DATE('2026-08-29','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 72, 72, TO_DATE('2026-08-29','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (73, TO_DATE('2026-09-12','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 73, 73, TO_DATE('2026-09-12','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (74, TO_DATE('2026-08-11','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 74, 74, TO_DATE('2026-08-11','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (75, TO_DATE('2026-09-02','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 75, 75, TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (76, TO_DATE('2026-08-24','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 76, 76, TO_DATE('2026-08-24','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (77, TO_DATE('2026-04-11','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 77, 77, TO_DATE('2026-04-11','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (78, TO_DATE('2026-05-21','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 78, 78, TO_DATE('2026-05-21','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (79, TO_DATE('2026-08-21','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 79, 79, TO_DATE('2026-08-21','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (80, TO_DATE('2026-09-11','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 80, 80, TO_DATE('2026-09-11','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (81, TO_DATE('2026-08-31','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 81, 81, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (82, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 82, 82, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (83, TO_DATE('2026-09-02','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 83, 83, TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (84, TO_DATE('2026-09-15','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 84, 84, TO_DATE('2026-09-15','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (85, TO_DATE('2026-08-03','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 85, 85, TO_DATE('2026-08-03','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (86, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 86, 86, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (87, TO_DATE('2026-09-10','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 87, 87, TO_DATE('2026-09-10','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (88, TO_DATE('2026-07-21','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 88, 88, TO_DATE('2026-07-21','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (89, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 89, 89, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (90, TO_DATE('2026-09-01','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 90, 90, TO_DATE('2026-09-01','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (91, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 91, 91, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (92, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 92, 92, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (93, TO_DATE('2026-09-16','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 93, 93, TO_DATE('2026-09-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (94, TO_DATE('2026-08-08','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 94, 94, TO_DATE('2026-08-08','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (95, TO_DATE('2026-09-16','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 95, 95, TO_DATE('2026-09-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (96, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 96, 96, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (97, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 97, 97, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (98, TO_DATE('2026-08-16','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 98, 98, TO_DATE('2026-08-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (99, TO_DATE('2026-09-01','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 99, 99, TO_DATE('2026-09-01','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (100, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 100, 100, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (101, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 101, 101, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (102, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 102, 102, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (103, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 103, 103, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (104, TO_DATE('2026-09-07','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 104, 104, TO_DATE('2026-09-07','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (105, TO_DATE('2026-08-31','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 105, 105, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (106, TO_DATE('2026-07-25','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 106, 106, TO_DATE('2026-07-25','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (107, TO_DATE('2026-08-15','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 107, 107, TO_DATE('2026-08-15','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (108, TO_DATE('2026-01-16','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 108, 108, TO_DATE('2026-01-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (109, TO_DATE('2026-07-16','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 109, 109, TO_DATE('2026-07-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (110, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 110, 110, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (111, TO_DATE('2026-09-18','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 111, 111, TO_DATE('2026-09-18','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (112, TO_DATE('2026-08-31','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 112, 112, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (113, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 113, 113, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (114, TO_DATE('2026-09-07','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 114, 114, TO_DATE('2026-09-07','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (115, TO_DATE('2026-09-10','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 115, 115, TO_DATE('2026-09-10','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (116, TO_DATE('2026-07-13','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 116, 116, TO_DATE('2026-07-13','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (117, TO_DATE('2026-06-20','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 117, 117, TO_DATE('2026-06-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (118, TO_DATE('2026-09-01','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 118, 118, TO_DATE('2026-09-01','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (119, TO_DATE('2026-08-15','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 119, 119, TO_DATE('2026-08-15','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (120, TO_DATE('2026-08-24','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 120, 120, TO_DATE('2026-08-24','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (121, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 121, 121, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (122, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 122, 122, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (123, TO_DATE('2026-09-02','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 123, 123, TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (124, TO_DATE('2026-09-09','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 124, 124, TO_DATE('2026-09-09','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (125, TO_DATE('2026-08-03','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 125, 125, TO_DATE('2026-08-03','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (126, TO_DATE('2026-09-15','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 126, 126, TO_DATE('2026-09-15','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (127, TO_DATE('2026-08-17','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 127, 127, TO_DATE('2026-08-17','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (128, TO_DATE('2026-09-18','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 128, 128, TO_DATE('2026-09-18','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (129, TO_DATE('2026-08-31','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 129, 129, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (130, TO_DATE('2026-09-13','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 130, 130, TO_DATE('2026-09-13','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (131, TO_DATE('2026-09-08','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 131, 131, TO_DATE('2026-09-08','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (132, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 132, 132, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (133, TO_DATE('2026-09-16','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 133, 133, TO_DATE('2026-09-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (134, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 134, 134, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (135, TO_DATE('2026-08-09','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 135, 135, TO_DATE('2026-08-09','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (136, TO_DATE('2026-06-25','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 136, 136, TO_DATE('2026-06-25','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (137, TO_DATE('2026-03-04','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 137, 137, TO_DATE('2026-03-04','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (138, TO_DATE('2026-04-24','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 138, 138, TO_DATE('2026-04-24','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (139, TO_DATE('2026-09-18','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 139, 139, TO_DATE('2026-09-18','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (140, TO_DATE('2026-09-02','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 140, 140, TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (141, TO_DATE('2026-09-16','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 141, 141, TO_DATE('2026-09-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (142, TO_DATE('2026-08-31','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 142, 142, TO_DATE('2026-08-31','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (143, TO_DATE('2026-09-14','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 143, 143, TO_DATE('2026-09-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (144, TO_DATE('2026-09-03','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 144, 144, TO_DATE('2026-09-03','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (145, TO_DATE('2026-09-10','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 145, 145, TO_DATE('2026-09-10','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (146, TO_DATE('2026-09-17','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 146, 146, TO_DATE('2026-09-17','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (147, TO_DATE('2026-08-01','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 147, 147, TO_DATE('2026-08-01','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (148, TO_DATE('2026-04-27','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 148, 148, TO_DATE('2026-04-27','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (149, TO_DATE('2026-08-07','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 149, 149, TO_DATE('2026-08-07','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (150, TO_DATE('2026-09-18','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 150, 150, TO_DATE('2026-09-18','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (151, TO_DATE('2026-09-12','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 151, 151, TO_DATE('2026-09-12','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (152, TO_DATE('2026-09-20','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 152, 152, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (153, TO_DATE('2026-03-26','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 153, 153, TO_DATE('2026-03-26','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (154, TO_DATE('2026-03-26','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 154, 154, TO_DATE('2026-03-26','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (155, TO_DATE('2026-04-13','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 155, 155, TO_DATE('2026-04-13','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (156, TO_DATE('2026-04-25','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 156, 156, TO_DATE('2026-04-25','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (157, TO_DATE('2025-05-14','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 157, 157, TO_DATE('2025-05-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (158, TO_DATE('2025-06-01','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 158, 158, TO_DATE('2025-06-01','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (159, TO_DATE('2026-06-02','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 159, 159, TO_DATE('2026-06-02','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (160, TO_DATE('2026-05-15','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 160, 160, TO_DATE('2026-05-15','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (161, TO_DATE('2026-06-02','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 161, 161, TO_DATE('2026-06-02','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (162, TO_DATE('2026-06-24','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 162, 162, TO_DATE('2026-06-24','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (163, TO_DATE('2026-07-12','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 163, 163, TO_DATE('2026-07-12','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (164, TO_DATE('2026-06-11','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 164, 164, TO_DATE('2026-06-11','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (165, TO_DATE('2026-06-17','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 165, 165, TO_DATE('2026-06-17','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (166, TO_DATE('2026-04-28','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 166, 166, TO_DATE('2026-04-28','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (167, TO_DATE('2025-11-10','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 167, 167, TO_DATE('2025-11-10','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (168, TO_DATE('2025-04-11','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 168, 168, TO_DATE('2025-04-11','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (169, TO_DATE('2026-01-09','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 169, 169, TO_DATE('2026-01-09','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (170, TO_DATE('2026-01-20','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 170, 170, TO_DATE('2026-01-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (171, TO_DATE('2026-02-07','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 171, 171, TO_DATE('2026-02-07','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (172, TO_DATE('2026-02-20','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 172, 172, TO_DATE('2026-02-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (173, TO_DATE('2026-03-10','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 173, 173, TO_DATE('2026-03-10','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (174, TO_DATE('2026-02-01','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 174, 174, TO_DATE('2026-02-01','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (175, TO_DATE('2026-02-19','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 175, 175, TO_DATE('2026-02-19','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (176, TO_DATE('2026-03-02','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 176, 176, TO_DATE('2026-03-02','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (177, TO_DATE('2025-09-20','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 177, 177, TO_DATE('2025-09-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (178, TO_DATE('2025-10-08','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 178, 178, TO_DATE('2025-10-08','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (179, TO_DATE('2026-05-15','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 179, 179, TO_DATE('2026-05-15','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (180, TO_DATE('2026-05-16','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 180, 180, TO_DATE('2026-05-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (181, TO_DATE('2026-06-03','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 181, 181, TO_DATE('2026-06-03','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (182, TO_DATE('2026-06-21','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 182, 182, TO_DATE('2026-06-21','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (183, TO_DATE('2026-06-16','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 183, 183, TO_DATE('2026-06-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (184, TO_DATE('2026-04-17','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 184, 184, TO_DATE('2026-04-17','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (185, TO_DATE('2026-05-05','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 185, 185, TO_DATE('2026-05-05','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (186, TO_DATE('2026-03-06','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 186, 186, TO_DATE('2026-03-06','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (187, TO_DATE('2026-03-19','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 187, 187, TO_DATE('2026-03-19','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (188, TO_DATE('2026-04-06','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 188, 188, TO_DATE('2026-04-06','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (189, TO_DATE('2025-11-13','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 189, 189, TO_DATE('2025-11-13','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (190, TO_DATE('2026-01-21','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 190, 190, TO_DATE('2026-01-21','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (191, TO_DATE('2026-02-08','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 191, 191, TO_DATE('2026-02-08','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (192, TO_DATE('2026-01-25','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 192, 192, TO_DATE('2026-01-25','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (193, TO_DATE('2026-02-22','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 193, 193, TO_DATE('2026-02-22','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (194, TO_DATE('2026-03-11','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 194, 194, TO_DATE('2026-03-11','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (195, TO_DATE('2025-12-28','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 195, 195, TO_DATE('2025-12-28','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (196, TO_DATE('2026-01-07','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 196, 196, TO_DATE('2026-01-07','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (197, TO_DATE('2026-01-27','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 197, 197, TO_DATE('2026-01-27','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (198, TO_DATE('2026-02-14','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 198, 198, TO_DATE('2026-02-14','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (199, TO_DATE('2026-03-25','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 199, 199, TO_DATE('2026-03-25','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (200, TO_DATE('2026-04-28','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 200, 200, TO_DATE('2026-04-28','YYYY-MM-DD'));

-- TENER: 200 registros
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('11.998.500-5', 1);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('15.360.060-0', 2);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('18.430.815-0', 3);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('25.960.879-1', 4);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('18.586.960-1', 5);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('20.858.183-K', 6);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('24.428.415-9', 7);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('25.987.858-6', 8);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('11.721.960-7', 9);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('24.833.068-6', 10);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('13.746.093-9', 11);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('25.012.372-8', 12);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('20.083.621-9', 13);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('20.426.773-1', 14);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('19.337.510-3', 15);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('17.056.747-1', 16);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('23.142.824-0', 17);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('19.606.110-K', 18);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('19.190.751-5', 19);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('24.133.155-5', 20);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('22.256.410-7', 21);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('23.028.725-2', 22);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('22.886.836-1', 23);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('18.236.009-0', 24);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('22.600.124-7', 25);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('22.970.008-1', 26);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('19.840.186-2', 27);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('17.400.346-7', 28);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('14.025.425-8', 29);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('10.042.527-0', 30);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('20.304.637-5', 31);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('11.354.318-3', 32);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('11.857.850-3', 33);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('14.819.091-7', 34);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('23.702.981-K', 35);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('11.645.033-K', 36);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('17.543.956-0', 37);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('10.192.750-4', 38);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('23.669.449-6', 39);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('24.947.890-3', 40);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('21.495.380-3', 41);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('18.225.646-3', 42);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('21.398.255-9', 43);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('15.271.957-4', 44);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('13.526.984-0', 45);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('16.664.202-7', 46);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('14.219.689-1', 47);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('15.832.730-9', 48);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('25.591.357-3', 49);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('15.983.360-7', 50);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.000.867-6', 51);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.000.884-6', 52);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.000.901-K', 53);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.000.918-4', 54);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.000.935-4', 55);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.000.952-4', 56);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.000.969-9', 57);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.000.986-9', 58);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.003-4', 59);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.020-4', 60);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.037-9', 61);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.054-9', 62);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.071-9', 63);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.088-3', 64);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.105-7', 65);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.122-7', 66);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.139-1', 67);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.156-1', 68);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.173-1', 69);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.190-1', 70);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.207-K', 71);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.224-K', 72);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.241-K', 73);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.258-4', 74);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.275-4', 75);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.292-4', 76);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.309-2', 77);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.326-2', 78);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.343-2', 79);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.360-2', 80);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.377-7', 81);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.394-7', 82);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.411-0', 83);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.428-5', 84);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.445-5', 85);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.462-5', 86);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.479-K', 87);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.496-K', 88);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.513-3', 89);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.530-3', 90);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.547-8', 91);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.564-8', 92);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.581-8', 93);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.598-2', 94);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.615-6', 95);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.632-6', 96);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.649-0', 97);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.666-0', 98);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.683-0', 99);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.700-4', 100);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.717-9', 101);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.734-9', 102);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.751-9', 103);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.768-3', 104);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.785-3', 105);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.802-7', 106);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.819-1', 107);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.836-1', 108);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.853-1', 109);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.870-1', 110);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.887-6', 111);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.904-K', 112);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.921-K', 113);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.938-4', 114);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.955-4', 115);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.972-4', 116);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.001.989-9', 117);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.006-4', 118);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.023-4', 119);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.040-4', 120);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.057-9', 121);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.074-9', 122);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.091-9', 123);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.108-7', 124);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.125-7', 125);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.142-7', 126);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.159-1', 127);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.176-1', 128);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.193-1', 129);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.210-5', 130);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.227-K', 131);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.244-K', 132);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.261-K', 133);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.278-4', 134);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.295-4', 135);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.312-8', 136);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.329-2', 137);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.346-2', 138);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.363-2', 139);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.380-2', 140);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.397-7', 141);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.414-0', 142);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.431-0', 143);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.448-5', 144);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.465-5', 145);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.482-5', 146);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.499-K', 147);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.516-3', 148);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.533-3', 149);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.550-3', 150);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.567-8', 151);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.584-8', 152);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.601-1', 153);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.618-6', 154);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.635-6', 155);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.652-6', 156);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.669-0', 157);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.686-0', 158);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.703-4', 159);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.720-4', 160);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.737-9', 161);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.754-9', 162);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.771-9', 163);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.788-3', 164);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.805-7', 165);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.822-7', 166);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.839-1', 167);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.856-1', 168);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.873-1', 169);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.890-1', 170);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.907-K', 171);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.924-K', 172);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.941-K', 173);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.958-4', 174);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.975-4', 175);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.002.992-4', 176);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.009-4', 177);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.026-4', 178);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.043-4', 179);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.060-4', 180);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.077-9', 181);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.094-9', 182);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.111-2', 183);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.128-7', 184);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.145-7', 185);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.162-7', 186);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.179-1', 187);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.196-1', 188);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.213-5', 189);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.230-5', 190);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.247-K', 191);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.264-K', 192);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.281-K', 193);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.298-4', 194);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.315-8', 195);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.332-8', 196);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.349-2', 197);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.366-2', 198);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.383-2', 199);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('26.003.400-6', 200);

COMMIT;
