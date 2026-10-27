--============================================================================
-- SQL
--CREACION DE TABLA PARA ALMACENAR LOS DATOS DEL RESUMEN DEL TOTAL DE CONTRATOS 
-- EN NUESTRA PLATAFORMA
--============================================================================

-- ELIMINAR TABLA EN CASO QUE YA EXISTA
DROP TABLE RESUMEN_CONTRATO_CLI CASCADE CONSTRAINTS;
--VACIAR LA TABLA 
TRUNCATE TABLE RESUMEN_CONTRATO_CLI;
--CREACION DE TABLA


-- CREACION DE TABLA
CREATE TABLE RESUMEN_CONTRATO_CLI
(
    id_resumen               NUMBER(7)      NOT NULL,
    id_contrato              NUMBER(7)      NOT NULL,
    rut_cliente              VARCHAR2(13)   NOT NULL,
    nombre_cliente           VARCHAR2(700)  NOT NULL,
    fecha_nac_cliente        DATE           NOT NULL,
    edad_cliente             NUMBER(3),
    nacionalidad_cliente     VARCHAR2(150),
    telefono_cliente         VARCHAR2(9)    NOT NULL,
    correo_cliente           VARCHAR2(100)  NOT NULL,
    id_comuna                NUMBER(3),
    nombre_comuna            VARCHAR2(50),
    id_plan                  NUMBER(7)      NOT NULL,
    nombre_plan              VARCHAR2(50)   NOT NULL,
    precio_plan              NUMBER(5)      NOT NULL,
    fecha_inicio_contrato    DATE           NOT NULL,
    fecha_termino_contrato   DATE           NOT NULL,
    estado_contrato          VARCHAR2(30)   NOT NULL,
    total_pagado             NUMBER(9)      NOT NULL,
    saldo_plan               NUMBER(9)      NOT NULL,
    dias_vigencia            NUMBER(5)      NOT NULL,
    id_ultimo_pago           NUMBER(7),
    monto_ultimo_pago        NUMBER(6),
    fecha_ultimo_pago        DATE,
    id_ultima_factura        NUMBER(7),
    total_ultima_factura     NUMBER(6),
    fecha_ultima_factura     DATE,
    fecha_proceso            DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT RESUMEN_CONTRATO_PK PRIMARY KEY (id_resumen),
    CONSTRAINT RESUMEN_CONTRATO_CON_FK FOREIGN KEY (id_contrato)
        REFERENCES CONTRATO_CLI (id_contrato),
    CONSTRAINT RESUMEN_CONTRATO_CLI_FK FOREIGN KEY (rut_cliente)
        REFERENCES CLIENTE (rut_cliente),
    CONSTRAINT RESUMEN_CONTRATO_PLAN_FK FOREIGN KEY (id_plan)
        REFERENCES PLAN (id_plan),
    CONSTRAINT RESUMEN_CONTRATO_COMUNA_FK FOREIGN KEY (id_comuna)
        REFERENCES COMUNA (id_comuna),
    CONSTRAINT RESUMEN_CONTRATO_PAG_FK FOREIGN KEY (id_ultimo_pago)
        REFERENCES PAGO (id_pago),
    CONSTRAINT RESUMEN_CONTRATO_FAC_FK FOREIGN KEY (id_ultima_factura)
        REFERENCES FACTURA (id_factura)
);

-- HACER LA CONSULTA A LA TABLA 
SELECT * FROM RESUMEN_CONTRATO_CLI ORDER BY id_resumen DESC;