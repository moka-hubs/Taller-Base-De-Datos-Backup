
CREATE TABLE AGENDA 
    ( 
     id_agendar                 NUMBER (7)  NOT NULL , 
     fecha_agendar              DATE  NOT NULL , 
     hora_agendar               INTERVAL DAY (9) TO SECOND (0)  NOT NULL , 
     estado_agendar             VARCHAR2 (15)  NOT NULL , 
     PREPARADOR_FISICO_rut_prep VARCHAR2 (13)  NOT NULL , 
     CLIENTE_rut_cliente        VARCHAR2 (13)  NOT NULL 
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
     fecha_ter              DATE 
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




