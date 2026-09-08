

CREATE TABLE agenda (
    id_agendar                 NUMBER(7) NOT NULL,
    fecha_agendar              DATE NOT NULL,
    hora_agendar               INTERVAL DAY(9) TO SECOND(0) NOT NULL,
    estado_agendar             CHAR(1) NOT NULL,
    preparador_fisico_rut_prep VARCHAR2(13) NOT NULL,
    cliente_rut_cliente        VARCHAR2(13) NOT NULL
);

ALTER TABLE agenda ADD CONSTRAINT agenda_pk PRIMARY KEY ( id_agendar,
                                                          fecha_agendar );

CREATE TABLE bloque_horario (
    id_bloque            NUMBER(7) NOT NULL,
    dia_bloque           VARCHAR2(20) NOT NULL,
    hora_bloque          INTERVAL DAY(9) TO SECOND(0) NOT NULL,
    agenda_id_agendar    NUMBER(7),
    agenda_fecha_agendar DATE
);

ALTER TABLE bloque_horario ADD CONSTRAINT bloque_horario_pk PRIMARY KEY ( id_bloque );

CREATE TABLE cat_patologia (
    id_cat           NUMBER(4) NOT NULL,
    nombre_categoria VARCHAR2(100) NOT NULL
);

ALTER TABLE cat_patologia ADD CONSTRAINT cat_patologia_pk PRIMARY KEY ( id_cat );

CREATE TABLE ciudad (
    id_ciudad        NUMBER(3) NOT NULL,
    nombre_ciudad    VARCHAR2(50),
    region_id_region NUMBER(3) NOT NULL
);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( id_ciudad );

CREATE TABLE cliente (
    rut_cliente          VARCHAR2(13) NOT NULL,
    pnombre_cliente      VARCHAR2(150) NOT NULL,
    snombre_cliente      VARCHAR2(150),
    papellido_cliente    VARCHAR2(150) NOT NULL,
    sapellido_cliente    VARCHAR2(150),
    fecha_nac_cliente    DATE NOT NULL,
    nacionalidad_cliente VARCHAR2(150),
    plan_id_plan         NUMBER(7) NOT NULL,
    comuna_id_comuna     NUMBER(3),
    telefono_cliente     VARCHAR2(9) NOT NULL,
    correo_cliente       VARCHAR2(100) NOT NULL
);

CREATE UNIQUE INDEX cliente__idx ON
    cliente (
        plan_id_plan
    ASC );

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( rut_cliente );

CREATE TABLE comuna (
    id_comuna        NUMBER(3) NOT NULL,
    nombre_comuna    VARCHAR2(50),
    ciudad_id_ciudad NUMBER(3) NOT NULL
);

ALTER TABLE comuna ADD CONSTRAINT comuna_pk PRIMARY KEY ( id_comuna );

CREATE TABLE contenerv2 (
    rutina_id_rutina       NUMBER(7) NOT NULL,
    ejercicio_id_ejercicio NUMBER(7) NOT NULL
);

ALTER TABLE contenerv2 ADD CONSTRAINT contenerv2_pk PRIMARY KEY ( rutina_id_rutina,
                                                                  ejercicio_id_ejercicio );

CREATE TABLE contrato (
    id_contrato            NUMBER(7) NOT NULL,
    fecha_inicio_contrato  DATE NOT NULL,
    fecha_termino_contrato DATE NOT NULL,
    estado_contrato        VARCHAR2(30) NOT NULL,
    plan_id_plan           NUMBER(7) NOT NULL,
    fecha_ini              DATE,
    fecha_ter              DATE
);

ALTER TABLE contrato ADD CONSTRAINT contrato_pk PRIMARY KEY ( id_contrato );

CREATE TABLE definir (
    preparador_fisico_rut_prep VARCHAR2(13) NOT NULL,
    bloque_horario_id_bloque   NUMBER(7) NOT NULL
);

ALTER TABLE definir ADD CONSTRAINT definir_pk PRIMARY KEY ( preparador_fisico_rut_prep,
                                                            bloque_horario_id_bloque );

CREATE TABLE diseñar (
    preparador_fisico_rut_prep VARCHAR2(13) NOT NULL,
    rutina_id_rutina           NUMBER(7) NOT NULL
);

ALTER TABLE diseñar ADD CONSTRAINT diseñar_pk PRIMARY KEY ( preparador_fisico_rut_prep,
                                                            rutina_id_rutina );

CREATE TABLE ejercicio (
    id_ejercicio           NUMBER(7) NOT NULL,
    nombre_ejercicio       VARCHAR2(30) NOT NULL,
    descripcion_ejercicio  VARCHAR2(200) NOT NULL,
    repeticiones_ejercicio NUMBER(2) NOT NULL,
    peso_ejercicio         NUMBER(3) NOT NULL
);

ALTER TABLE ejercicio ADD CONSTRAINT ejercicio_pk PRIMARY KEY ( id_ejercicio );

CREATE TABLE factura (
    id_factura    NUMBER(7) NOT NULL,
    fecha_emision DATE NOT NULL,
    total_factura NUMBER(6) NOT NULL,
    pago_id_pago  NUMBER(7) NOT NULL
);

CREATE UNIQUE INDEX factura__idx ON
    factura (
        pago_id_pago
    ASC );

ALTER TABLE factura ADD CONSTRAINT factura_pk PRIMARY KEY ( id_factura );

CREATE TABLE ficha_cliente (
    id_ficha          NUMBER(7) NOT NULL,
    fecha_creacion    DATE NOT NULL,
    observaciones     VARCHAR2(200),
    fecha_observacion DATE NOT NULL
);

ALTER TABLE ficha_cliente ADD CONSTRAINT ficha_cliente_pk PRIMARY KEY ( id_ficha );

CREATE TABLE metodo_pago (
    id_metodo_pago          NUMBER(7) NOT NULL,
    nombre_metodo_pago      VARCHAR2(50) NOT NULL,
    descripcion_metodo_pago VARCHAR2(100) NOT NULL
);

ALTER TABLE metodo_pago ADD CONSTRAINT metodo_pago_pk PRIMARY KEY ( id_metodo_pago );

CREATE TABLE metricas_cliente (
    id_metrica                  NUMBER(3) NOT NULL,
    peso_cliente                NUMBER(3, 2) NOT NULL,
    estatura_cliente            NUMBER(3, 2) NOT NULL,
    medida_pecho_cliente        NUMBER(3, 2) NOT NULL,
    medida_cintura_cliente      NUMBER(3, 2) NOT NULL,
    medida_cadera_cliente       NUMBER(3, 2) NOT NULL,
    medida_hombros_cliente      NUMBER(3, 2) NOT NULL,
    medida_brazos_cliente       NUMBER(3, 2) NOT NULL,
    medida_muslos_cliente       NUMBER(3, 2) NOT NULL,
    medidas_pantorillas_cliente NUMBER(3, 2) NOT NULL,
    fecha_medicion_cliente      DATE NOT NULL
);

ALTER TABLE metricas_cliente ADD CONSTRAINT metricas_cliente_pk PRIMARY KEY ( id_metrica );

CREATE TABLE ofrecer (
    preparador_fisico_rut_prep VARCHAR2(13) NOT NULL,
    plan_id_plan               NUMBER(7) NOT NULL
);

ALTER TABLE ofrecer ADD CONSTRAINT ofrecer_pk PRIMARY KEY ( preparador_fisico_rut_prep,
                                                            plan_id_plan );

CREATE TABLE pago (
    id_pago                    NUMBER(7) NOT NULL,
    monto_pago                 NUMBER(6) NOT NULL,
    fecha_pago                 DATE NOT NULL,
    estado_pago                VARCHAR2(30) NOT NULL,
    contrato_id_contrato       NUMBER(7) NOT NULL,
    factura_id_factura         NUMBER(7) NOT NULL,
    metodo_pago_id_metodo_pago NUMBER(7) NOT NULL
);

CREATE UNIQUE INDEX pago__idx ON
    pago (
        factura_id_factura
    ASC );

ALTER TABLE pago ADD CONSTRAINT pago_pk PRIMARY KEY ( id_pago );

CREATE TABLE pais (
    id_pais     NUMBER(3) NOT NULL,
    nombre_pais VARCHAR2(50)
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( id_pais );

CREATE TABLE patologias (
    id_patologia           NUMBER(3) NOT NULL,
    nombre_patologia       VARCHAR2(150) NOT NULL,
    tipo_patologia         VARCHAR2(150) NOT NULL,
    grado_patologia        VARCHAR2(150) NOT NULL,
    duracion_patologia     VARCHAR2(150) NOT NULL,
    ficha_cliente_id_ficha NUMBER(7),
    cat_patologia_id_cat   NUMBER(4) NOT NULL
);

ALTER TABLE patologias ADD CONSTRAINT patologias_pk PRIMARY KEY ( id_patologia );

CREATE TABLE plan (
    id_plan          NUMBER(7) NOT NULL,
    nombre_plan      VARCHAR2(50) NOT NULL,
    precio_plan      NUMBER(5) NOT NULL,
    duracion_plan    VARCHAR2(50) NOT NULL,
    descripcion_plan VARCHAR2(200) NOT NULL
);

ALTER TABLE plan ADD CONSTRAINT plan_pk PRIMARY KEY ( id_plan );

CREATE TABLE preparador_fisico (
    rut_prep                VARCHAR2(13) NOT NULL,
    pnombre_preparador      VARCHAR2(150) NOT NULL,
    snombre_preparador      VARCHAR2(150),
    papellido_preparador    VARCHAR2(150) NOT NULL,
    sapellido_preparador    VARCHAR2(150),
    fecha_nac_preparador    DATE NOT NULL,
    especialidad_preparador VARCHAR2(150) NOT NULL,
    comuna_id_comuna        NUMBER(3),
    correo_preparador       VARCHAR2(100) NOT NULL,
    telefono_preparador     VARCHAR2(9) NOT NULL
);

ALTER TABLE preparador_fisico ADD CONSTRAINT preparador_fisico_pk PRIMARY KEY ( rut_prep );

CREATE TABLE progre_cli (
    id_progreso            NUMBER(7) NOT NULL,
    descripcion_progreso   VARCHAR2(200) NOT NULL,
    fecha_progreso         DATE NOT NULL,
    ficha_cliente_id_ficha NUMBER(7) NOT NULL
);

ALTER TABLE progre_cli ADD CONSTRAINT progre_cli_pk PRIMARY KEY ( id_progreso );

CREATE TABLE region (
    id_region     NUMBER(3) NOT NULL,
    nombre_region VARCHAR2(50) NOT NULL,
    pais_id_pais  NUMBER(3) NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( id_region );

CREATE TABLE registrar (
    metricas_cliente_id_metrica NUMBER(3) NOT NULL,
    ficha_cliente_id_ficha      NUMBER(7) NOT NULL
);

ALTER TABLE registrar ADD CONSTRAINT registrar_pk PRIMARY KEY ( metricas_cliente_id_metrica,
                                                                ficha_cliente_id_ficha );

CREATE TABLE rutina (
    id_rutina           NUMBER(7) NOT NULL,
    nombre_rutina       VARCHAR2(50) NOT NULL,
    cliente_rut_cliente VARCHAR2(13)
);

ALTER TABLE rutina ADD CONSTRAINT rutina_pk PRIMARY KEY ( id_rutina );

CREATE TABLE sesion_entrenamiento (
    id_sesion            NUMBER(7) NOT NULL,
    fecha_sesion         DATE NOT NULL,
    duracion_sesion      INTERVAL DAY(9) TO SECOND(0) NOT NULL,
    rutina_id_rutina     NUMBER(7),
    agenda_id_agendar    NUMBER(7),
    agenda_fecha_agendar DATE
);

ALTER TABLE sesion_entrenamiento ADD CONSTRAINT sesion_entrenamiento_pk PRIMARY KEY ( id_sesion );

CREATE TABLE tener (
    cliente_rut_cliente    VARCHAR2(13) NOT NULL,
    ficha_cliente_id_ficha NUMBER(7) NOT NULL
);

ALTER TABLE tener ADD CONSTRAINT tener_pk PRIMARY KEY ( cliente_rut_cliente,
                                                        ficha_cliente_id_ficha );

ALTER TABLE agenda
    ADD CONSTRAINT agenda_cliente_fk FOREIGN KEY ( cliente_rut_cliente )
        REFERENCES cliente ( rut_cliente );

ALTER TABLE agenda
    ADD CONSTRAINT agenda_preparador_fisico_fk FOREIGN KEY ( preparador_fisico_rut_prep )
        REFERENCES preparador_fisico ( rut_prep );

ALTER TABLE bloque_horario
    ADD CONSTRAINT bloque_horario_agenda_fk FOREIGN KEY ( agenda_id_agendar,
                                                          agenda_fecha_agendar )
        REFERENCES agenda ( id_agendar,
                            fecha_agendar );

ALTER TABLE ciudad
    ADD CONSTRAINT ciudad_region_fk FOREIGN KEY ( region_id_region )
        REFERENCES region ( id_region );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_comuna_fk FOREIGN KEY ( comuna_id_comuna )
        REFERENCES comuna ( id_comuna );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_plan_fk FOREIGN KEY ( plan_id_plan )
        REFERENCES plan ( id_plan );

ALTER TABLE comuna
    ADD CONSTRAINT comuna_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad )
        REFERENCES ciudad ( id_ciudad );

ALTER TABLE contenerv2
    ADD CONSTRAINT contenerv2_ejercicio_fk FOREIGN KEY ( ejercicio_id_ejercicio )
        REFERENCES ejercicio ( id_ejercicio );

ALTER TABLE contenerv2
    ADD CONSTRAINT contenerv2_rutina_fk FOREIGN KEY ( rutina_id_rutina )
        REFERENCES rutina ( id_rutina );

ALTER TABLE contrato
    ADD CONSTRAINT contrato_plan_fk FOREIGN KEY ( plan_id_plan )
        REFERENCES plan ( id_plan );

ALTER TABLE definir
    ADD CONSTRAINT definir_bloque_horario_fk FOREIGN KEY ( bloque_horario_id_bloque )
        REFERENCES bloque_horario ( id_bloque );

ALTER TABLE definir
    ADD CONSTRAINT definir_preparador_fisico_fk FOREIGN KEY ( preparador_fisico_rut_prep )
        REFERENCES preparador_fisico ( rut_prep );

ALTER TABLE diseñar
    ADD CONSTRAINT diseñar_preparador_fisico_fk FOREIGN KEY ( preparador_fisico_rut_prep )
        REFERENCES preparador_fisico ( rut_prep );

ALTER TABLE diseñar
    ADD CONSTRAINT diseñar_rutina_fk FOREIGN KEY ( rutina_id_rutina )
        REFERENCES rutina ( id_rutina );

ALTER TABLE factura
    ADD CONSTRAINT factura_pago_fk FOREIGN KEY ( pago_id_pago )
        REFERENCES pago ( id_pago );

ALTER TABLE ofrecer
    ADD CONSTRAINT ofrecer_plan_fk FOREIGN KEY ( plan_id_plan )
        REFERENCES plan ( id_plan );

ALTER TABLE ofrecer
    ADD CONSTRAINT ofrecer_preparador_fisico_fk FOREIGN KEY ( preparador_fisico_rut_prep )
        REFERENCES preparador_fisico ( rut_prep );

ALTER TABLE pago
    ADD CONSTRAINT pago_contrato_fk FOREIGN KEY ( contrato_id_contrato )
        REFERENCES contrato ( id_contrato );

ALTER TABLE pago
    ADD CONSTRAINT pago_factura_fk FOREIGN KEY ( factura_id_factura )
        REFERENCES factura ( id_factura );

ALTER TABLE pago
    ADD CONSTRAINT pago_metodo_pago_fk FOREIGN KEY ( metodo_pago_id_metodo_pago )
        REFERENCES metodo_pago ( id_metodo_pago );

ALTER TABLE patologias
    ADD CONSTRAINT patologias_cat_patologia_fk FOREIGN KEY ( cat_patologia_id_cat )
        REFERENCES cat_patologia ( id_cat );

ALTER TABLE patologias
    ADD CONSTRAINT patologias_ficha_cliente_fk FOREIGN KEY ( ficha_cliente_id_ficha )
        REFERENCES ficha_cliente ( id_ficha );

ALTER TABLE preparador_fisico
    ADD CONSTRAINT preparador_fisico_comuna_fk FOREIGN KEY ( comuna_id_comuna )
        REFERENCES comuna ( id_comuna );

ALTER TABLE progre_cli
    ADD CONSTRAINT progre_cli_ficha_cliente_fk FOREIGN KEY ( ficha_cliente_id_ficha )
        REFERENCES ficha_cliente ( id_ficha );

ALTER TABLE region
    ADD CONSTRAINT region_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );

ALTER TABLE registrar
    ADD CONSTRAINT registrar_ficha_cliente_fk FOREIGN KEY ( ficha_cliente_id_ficha )
        REFERENCES ficha_cliente ( id_ficha );

ALTER TABLE registrar
    ADD CONSTRAINT registrar_metricas_cliente_fk FOREIGN KEY ( metricas_cliente_id_metrica )
        REFERENCES metricas_cliente ( id_metrica );

ALTER TABLE rutina
    ADD CONSTRAINT rutina_cliente_fk FOREIGN KEY ( cliente_rut_cliente )
        REFERENCES cliente ( rut_cliente );

ALTER TABLE sesion_entrenamiento
    ADD CONSTRAINT sesion_entrenamiento_agenda_fk FOREIGN KEY ( agenda_id_agendar,
                                                                agenda_fecha_agendar )
        REFERENCES agenda ( id_agendar,
                            fecha_agendar );

ALTER TABLE sesion_entrenamiento
    ADD CONSTRAINT sesion_entrenamiento_rutina_fk FOREIGN KEY ( rutina_id_rutina )
        REFERENCES rutina ( id_rutina );

ALTER TABLE tener
    ADD CONSTRAINT tener_cliente_fk FOREIGN KEY ( cliente_rut_cliente )
        REFERENCES cliente ( rut_cliente );

ALTER TABLE tener
    ADD CONSTRAINT tener_ficha_cliente_fk FOREIGN KEY ( ficha_cliente_id_ficha )
        REFERENCES ficha_cliente ( id_ficha );




