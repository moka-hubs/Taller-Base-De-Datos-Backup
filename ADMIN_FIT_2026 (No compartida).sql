--============================================================================
-- FIT MANAGER PRO  - PL/SQL
-- 3 FUNCIONES ALMACENADAS + 3 PROCEDIMIENTOS ALMACENADOS + BLOQUE ANONIMO
-- El bloque recorre TODOS los contratos de la base de datos, obtiene los
-- datos de cada cliente y guarda un resumen en RESUMEN_CONTRATO_CLI.
-- Orden del script:
--   SECCION A : FUNCIONES ALMACENADAS
--   SECCION B : PROCEDIMIENTOS ALMACENADAS
--   SECCION C : BLOQUE ANONIMO
--============================================================================

SET SERVEROUTPUT ON SIZE 1000000;
SET LINESIZE 200;

-- SECCION A - FUNCIONES ALMACENADAS
--============================================================================
-- FUNCION 1 - FN_TOTAL_PAGADO
-- Suma todos los pagos reales de un contrato.
-- Retorna 0 si el contrato no tiene pagos.
--============================================================================
CREATE OR REPLACE FUNCTION FN_TOTAL_PAGADO (
    VFN_ID_CONTRATO IN NUMBER
) RETURN NUMBER
IS
    VFN_TOTAL NUMBER := 0;
BEGIN
    SELECT NVL(SUM(P.MONTO_PAGO), 0)
      INTO VFN_TOTAL
      FROM PAGO P
     WHERE P.CONTRATO_CLI_ID_CONTRATO = VFN_ID_CONTRATO;

    RETURN VFN_TOTAL;
END FN_TOTAL_PAGADO;
/

--============================================================================
-- FUNCION 2 - FN_CALCULAR_EDAD
-- Calcula la edad del cliente a la fecha del sistema.
--============================================================================
CREATE OR REPLACE FUNCTION FN_CALCULAR_EDAD (
    VFN_FECHA_NAC_CLIENTE IN DATE
) RETURN NUMBER
IS
BEGIN
    IF VFN_FECHA_NAC_CLIENTE IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, VFN_FECHA_NAC_CLIENTE) / 12);
END FN_CALCULAR_EDAD;
/

--============================================================================
-- FUNCION 3 - FN_DIAS_VIGENCIA
-- Calcula los dias que faltan para el termino del contrato.
-- Si la fecha ya paso, retorna cero
--============================================================================
CREATE OR REPLACE FUNCTION FN_DIAS_VIGENCIA (
    VFN_FECHA_TERMINO IN DATE
) RETURN NUMBER
IS
BEGIN
    IF VFN_FECHA_TERMINO IS NULL THEN
        RETURN 0;
    END IF;

    RETURN GREATEST(0, TRUNC(VFN_FECHA_TERMINO) - TRUNC(SYSDATE));
END FN_DIAS_VIGENCIA;
/

-- SECCION B - PROCEDIMIENTOS ALMACENADOS
--============================================================================
-- PROCEDIMIENTO 1 - SP_OBTENER_ULTIMO_PAGO
-- Obtiene el pago real mas reciente del contrato.
-- Si no hay pagos, devuelve NULL en los tres parametros.
--============================================================================
CREATE OR REPLACE PROCEDURE SP_OBTENER_ULTIMO_PAGO (
    VPC_ID_CONTRATO IN  NUMBER,
    VPC_ID_PAGO     OUT NUMBER,
    VPC_MONTO       OUT NUMBER,
    VPC_FECHA_PAGO  OUT DATE
)
IS
BEGIN
    SELECT P.ID_PAGO,
           P.MONTO_PAGO,
           P.FECHA_PAGO
      INTO VPC_ID_PAGO,
           VPC_MONTO,
           VPC_FECHA_PAGO
      FROM (
            SELECT P.ID_PAGO,
                   P.MONTO_PAGO,
                   P.FECHA_PAGO
              FROM PAGO P
             WHERE P.CONTRATO_CLI_ID_CONTRATO = VPC_ID_CONTRATO
             ORDER BY P.FECHA_PAGO DESC, P.ID_PAGO DESC
           ) P
     WHERE ROWNUM = 1;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        VPC_ID_PAGO := NULL;
        VPC_MONTO := NULL;
        VPC_FECHA_PAGO := NULL;
END SP_OBTENER_ULTIMO_PAGO;
/

--============================================================================
-- PROCEDIMIENTO 2 - SP_OBTENER_ULTIMA_FACTURA
-- Obtiene la factura real mas reciente asociada al contrato.
-- Si no hay facturas, devuelve NULL en los tres parametros.
--============================================================================
CREATE OR REPLACE PROCEDURE SP_OBTENER_ULTIMA_FACTURA (
    VPC_ID_CONTRATO   IN  NUMBER,
    VPC_ID_FACTURA    OUT NUMBER,
    VPC_TOTAL_FACTURA OUT NUMBER,
    VPC_FECHA_EMISION OUT DATE
)
IS
BEGIN
    SELECT F.ID_FACTURA,
           F.TOTAL_FACTURA,
           F.FECHA_EMISION
      INTO VPC_ID_FACTURA,
           VPC_TOTAL_FACTURA,
           VPC_FECHA_EMISION
      FROM (
            SELECT F.ID_FACTURA,
                   F.TOTAL_FACTURA,
                   F.FECHA_EMISION
              FROM FACTURA F
              JOIN PAGO P ON P.ID_PAGO = F.PAGO_ID_PAGO
             WHERE P.CONTRATO_CLI_ID_CONTRATO = VPC_ID_CONTRATO
             ORDER BY F.FECHA_EMISION DESC, F.ID_FACTURA DESC
           ) F
     WHERE ROWNUM = 1;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        VPC_ID_FACTURA := NULL;
        VPC_TOTAL_FACTURA := NULL;
        VPC_FECHA_EMISION := NULL;
END SP_OBTENER_ULTIMA_FACTURA;
/

--============================================================================
-- PROCEDIMIENTO 3 - SP_INSERTAR_RESUMEN
-- Inserta una fila en RESUMEN_CONTRATO_CLI con todos los datos obtenidos.
-- Los parametros van en el mismo orden de las columnas de la tabla.
--============================================================================
CREATE OR REPLACE PROCEDURE SP_INSERTAR_RESUMEN (
    VPC_ID_RESUMEN               IN  NUMBER,
    VPC_ID_CONTRATO              IN  NUMBER,
    VPC_RUT_CLIENTE              IN  VARCHAR2,
    VPC_NOMBRE_CLIENTE           IN  VARCHAR2,
    VPC_FECHA_NAC_CLIENTE        IN  DATE,
    VPC_EDAD_CLIENTE             IN  NUMBER,
    VPC_NACIONALIDAD_CLIENTE     IN  VARCHAR2,
    VPC_TELEFONO_CLIENTE         IN  VARCHAR2,
    VPC_CORREO_CLIENTE           IN  VARCHAR2,
    VPC_ID_COMUNA                IN  NUMBER,
    VPC_NOMBRE_COMUNA            IN  VARCHAR2,
    VPC_ID_PLAN                  IN  NUMBER,
    VPC_NOMBRE_PLAN              IN  VARCHAR2,
    VPC_PRECIO_PLAN              IN  NUMBER,
    VPC_FECHA_INICIO_CONTRATO    IN  DATE,
    VPC_FECHA_TERMINO_CONTRATO   IN  DATE,
    VPC_ESTADO_CONTRATO          IN  VARCHAR2,
    VPC_TOTAL_PAGADO             IN  NUMBER,
    VPC_SALDO_PLAN               IN  NUMBER,
    VPC_DIAS_VIGENCIA            IN  NUMBER,
    VPC_ID_ULTIMO_PAGO           IN  NUMBER,
    VPC_MONTO_ULTIMO_PAGO        IN  NUMBER,
    VPC_FECHA_ULTIMO_PAGO        IN  DATE,
    VPC_ID_ULTIMA_FACTURA        IN  NUMBER,
    VPC_TOTAL_ULTIMA_FACTURA     IN  NUMBER,
    VPC_FECHA_ULTIMA_FACTURA     IN  DATE,
    VPC_FILAS_INSERTADAS         OUT NUMBER
)
IS
BEGIN
    INSERT INTO RESUMEN_CONTRATO_CLI (
        ID_RESUMEN,
        ID_CONTRATO,
        RUT_CLIENTE,
        NOMBRE_CLIENTE,
        FECHA_NAC_CLIENTE,
        EDAD_CLIENTE,
        NACIONALIDAD_CLIENTE,
        TELEFONO_CLIENTE,
        CORREO_CLIENTE,
        ID_COMUNA,
        NOMBRE_COMUNA,
        ID_PLAN,
        NOMBRE_PLAN,
        PRECIO_PLAN,
        FECHA_INICIO_CONTRATO,
        FECHA_TERMINO_CONTRATO,
        ESTADO_CONTRATO,
        TOTAL_PAGADO,
        SALDO_PLAN,
        DIAS_VIGENCIA,
        ID_ULTIMO_PAGO,
        MONTO_ULTIMO_PAGO,
        FECHA_ULTIMO_PAGO,
        ID_ULTIMA_FACTURA,
        TOTAL_ULTIMA_FACTURA,
        FECHA_ULTIMA_FACTURA,
        FECHA_PROCESO
    ) VALUES (
        VPC_ID_RESUMEN,
        VPC_ID_CONTRATO,
        VPC_RUT_CLIENTE,
        VPC_NOMBRE_CLIENTE,
        VPC_FECHA_NAC_CLIENTE,
        VPC_EDAD_CLIENTE,
        VPC_NACIONALIDAD_CLIENTE,
        VPC_TELEFONO_CLIENTE,
        VPC_CORREO_CLIENTE,
        VPC_ID_COMUNA,
        VPC_NOMBRE_COMUNA,
        VPC_ID_PLAN,
        VPC_NOMBRE_PLAN,
        VPC_PRECIO_PLAN,
        VPC_FECHA_INICIO_CONTRATO,
        VPC_FECHA_TERMINO_CONTRATO,
        VPC_ESTADO_CONTRATO,
        VPC_TOTAL_PAGADO,
        VPC_SALDO_PLAN,
        VPC_DIAS_VIGENCIA,
        VPC_ID_ULTIMO_PAGO,
        VPC_MONTO_ULTIMO_PAGO,
        VPC_FECHA_ULTIMO_PAGO,
        VPC_ID_ULTIMA_FACTURA,
        VPC_TOTAL_ULTIMA_FACTURA,
        VPC_FECHA_ULTIMA_FACTURA,
        SYSDATE
    );

    VPC_FILAS_INSERTADAS := SQL%ROWCOUNT;
END SP_INSERTAR_RESUMEN;
/

-- SECCION C - BLOQUE ANONIMO


DECLARE
    --========================================================================
    -- RECORD CON LA MISMA ESTRUCTURA DE LA TABLA NUEVA
    --========================================================================
    TYPE REC_RESUMEN IS RECORD (
        ID_RESUMEN               RESUMEN_CONTRATO_CLI.ID_RESUMEN%TYPE,
        ID_CONTRATO              RESUMEN_CONTRATO_CLI.ID_CONTRATO%TYPE,
        RUT_CLIENTE              RESUMEN_CONTRATO_CLI.RUT_CLIENTE%TYPE,
        NOMBRE_CLIENTE           RESUMEN_CONTRATO_CLI.NOMBRE_CLIENTE%TYPE,
        FECHA_NAC_CLIENTE        RESUMEN_CONTRATO_CLI.FECHA_NAC_CLIENTE%TYPE,
        EDAD_CLIENTE             RESUMEN_CONTRATO_CLI.EDAD_CLIENTE%TYPE,
        NACIONALIDAD_CLIENTE     RESUMEN_CONTRATO_CLI.NACIONALIDAD_CLIENTE%TYPE,
        TELEFONO_CLIENTE         RESUMEN_CONTRATO_CLI.TELEFONO_CLIENTE%TYPE,
        CORREO_CLIENTE           RESUMEN_CONTRATO_CLI.CORREO_CLIENTE%TYPE,
        ID_COMUNA                RESUMEN_CONTRATO_CLI.ID_COMUNA%TYPE,
        NOMBRE_COMUNA            RESUMEN_CONTRATO_CLI.NOMBRE_COMUNA%TYPE,
        ID_PLAN                  RESUMEN_CONTRATO_CLI.ID_PLAN%TYPE,
        NOMBRE_PLAN              RESUMEN_CONTRATO_CLI.NOMBRE_PLAN%TYPE,
        PRECIO_PLAN              RESUMEN_CONTRATO_CLI.PRECIO_PLAN%TYPE,
        FECHA_INICIO_CONTRATO    RESUMEN_CONTRATO_CLI.FECHA_INICIO_CONTRATO%TYPE,
        FECHA_TERMINO_CONTRATO   RESUMEN_CONTRATO_CLI.FECHA_TERMINO_CONTRATO%TYPE,
        ESTADO_CONTRATO          RESUMEN_CONTRATO_CLI.ESTADO_CONTRATO%TYPE,
        TOTAL_PAGADO             RESUMEN_CONTRATO_CLI.TOTAL_PAGADO%TYPE,
        SALDO_PLAN               RESUMEN_CONTRATO_CLI.SALDO_PLAN%TYPE,
        DIAS_VIGENCIA            RESUMEN_CONTRATO_CLI.DIAS_VIGENCIA%TYPE,
        ID_ULTIMO_PAGO           RESUMEN_CONTRATO_CLI.ID_ULTIMO_PAGO%TYPE,
        MONTO_ULTIMO_PAGO        RESUMEN_CONTRATO_CLI.MONTO_ULTIMO_PAGO%TYPE,
        FECHA_ULTIMO_PAGO        RESUMEN_CONTRATO_CLI.FECHA_ULTIMO_PAGO%TYPE,
        ID_ULTIMA_FACTURA        RESUMEN_CONTRATO_CLI.ID_ULTIMA_FACTURA%TYPE,
        TOTAL_ULTIMA_FACTURA     RESUMEN_CONTRATO_CLI.TOTAL_ULTIMA_FACTURA%TYPE,
        FECHA_ULTIMA_FACTURA     RESUMEN_CONTRATO_CLI.FECHA_ULTIMA_FACTURA%TYPE
    );

    --========================================================================
    -- CURSOR CON TODOS LOS CONTRATOS Y LOS DATOS DE CADA CLIENTE
    --========================================================================
    CURSOR C_CONTRATOS IS
        SELECT C.ID_CONTRATO,
               C.FECHA_INICIO_CONTRATO,
               C.FECHA_TERMINO_CONTRATO,
               C.ESTADO_CONTRATO,
               C.PLAN_ID_PLAN,
               C.CLIENTE_RUT_CLIENTE,
               CLI.PNOMBRE_CLIENTE,
               CLI.SNOMBRE_CLIENTE,
               CLI.PAPELLIDO_CLIENTE,
               CLI.SAPELLIDO_CLIENTE,
               CLI.FECHA_NAC_CLIENTE,
               CLI.NACIONALIDAD_CLIENTE,
               CLI.TELEFONO_CLIENTE,
               CLI.CORREO_CLIENTE,
               CLI.COMUNA_ID_COMUNA,
               CO.NOMBRE_COMUNA,
               PL.NOMBRE_PLAN,
               PL.PRECIO_PLAN
          FROM CONTRATO_CLI C
          JOIN CLIENTE CLI ON CLI.RUT_CLIENTE = C.CLIENTE_RUT_CLIENTE
          JOIN PLAN PL ON PL.ID_PLAN = C.PLAN_ID_PLAN
          LEFT JOIN COMUNA CO ON CO.ID_COMUNA = CLI.COMUNA_ID_COMUNA
         ORDER BY C.ID_CONTRATO;

    --========================================================================
    -- VARIABLES DEL BLOQUE
    --========================================================================
    OBJ_RESUMEN         REC_RESUMEN;
    V_ID_RESUMEN        NUMBER := 0;
    V_CONT_PROCESADOS   NUMBER := 0;
    V_CONT_ERRORES      NUMBER := 0;
    V_SUMA_TOTAL_PAGADO NUMBER := 0;
    V_SUMA_SALDO        NUMBER := 0;
    V_PROMEDIO_TOTAL    NUMBER := 0;
    V_FILAS_INSERTADAS  NUMBER := 0;

BEGIN

    DBMS_OUTPUT.PUT_LINE('===============================================================');
    DBMS_OUTPUT.PUT_LINE('RESUMEN DE CONTRATOS Y CLIENTES');
    DBMS_OUTPUT.PUT_LINE(' FECHA DE PROCESO: ' || TO_CHAR(SYSDATE, 'DD-MM-YYYY HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('===============================================================');

    -- Siempre inicia desde 0 para que falle al re-ejecutar (violación de PK)
    V_ID_RESUMEN := 0;

    --========================================================================
    -- RECORRER TODOS LOS CONTRATOS
    --========================================================================
    FOR i IN C_CONTRATOS LOOP

        -- Sub-bloque para controlar errores por cada contrato sin detener
        -- el procesamiento de los demas.
        BEGIN

            OBJ_RESUMEN.ID_RESUMEN := V_ID_RESUMEN + 1;

            OBJ_RESUMEN.ID_CONTRATO := i.ID_CONTRATO;
            OBJ_RESUMEN.RUT_CLIENTE := i.CLIENTE_RUT_CLIENTE;
            OBJ_RESUMEN.NOMBRE_CLIENTE := TRIM( i.PNOMBRE_CLIENTE || ' ' ||NVL(i.SNOMBRE_CLIENTE, '') || ' ' ||
                i.PAPELLIDO_CLIENTE || ' ' ||
                NVL(i.SAPELLIDO_CLIENTE, '')
            );

            OBJ_RESUMEN.FECHA_NAC_CLIENTE := i.FECHA_NAC_CLIENTE;
            OBJ_RESUMEN.EDAD_CLIENTE := FN_CALCULAR_EDAD(i.FECHA_NAC_CLIENTE);
            OBJ_RESUMEN.NACIONALIDAD_CLIENTE := i.NACIONALIDAD_CLIENTE;
            OBJ_RESUMEN.TELEFONO_CLIENTE := i.TELEFONO_CLIENTE;
            OBJ_RESUMEN.CORREO_CLIENTE := i.CORREO_CLIENTE;
            OBJ_RESUMEN.ID_COMUNA := i.COMUNA_ID_COMUNA;
            OBJ_RESUMEN.NOMBRE_COMUNA := i.NOMBRE_COMUNA;

            OBJ_RESUMEN.ID_PLAN := i.PLAN_ID_PLAN;
            OBJ_RESUMEN.NOMBRE_PLAN := i.NOMBRE_PLAN;
            OBJ_RESUMEN.PRECIO_PLAN := i.PRECIO_PLAN;
            OBJ_RESUMEN.FECHA_INICIO_CONTRATO := i.FECHA_INICIO_CONTRATO;
            OBJ_RESUMEN.FECHA_TERMINO_CONTRATO := i.FECHA_TERMINO_CONTRATO;
            OBJ_RESUMEN.ESTADO_CONTRATO := i.ESTADO_CONTRATO;

            OBJ_RESUMEN.TOTAL_PAGADO := FN_TOTAL_PAGADO(i.ID_CONTRATO);
            OBJ_RESUMEN.SALDO_PLAN := i.PRECIO_PLAN - OBJ_RESUMEN.TOTAL_PAGADO;
            OBJ_RESUMEN.DIAS_VIGENCIA := FN_DIAS_VIGENCIA(i.FECHA_TERMINO_CONTRATO);

            SP_OBTENER_ULTIMO_PAGO(
                i.ID_CONTRATO,
                OBJ_RESUMEN.ID_ULTIMO_PAGO,
                OBJ_RESUMEN.MONTO_ULTIMO_PAGO,
                OBJ_RESUMEN.FECHA_ULTIMO_PAGO
            );

            SP_OBTENER_ULTIMA_FACTURA(
                i.ID_CONTRATO,
                OBJ_RESUMEN.ID_ULTIMA_FACTURA,
                OBJ_RESUMEN.TOTAL_ULTIMA_FACTURA,
                OBJ_RESUMEN.FECHA_ULTIMA_FACTURA
            );

            --========================================================================
            -- INSERCION EN LA TABLA NUEVA
            --========================================================================
            SP_INSERTAR_RESUMEN(
                OBJ_RESUMEN.ID_RESUMEN,
                OBJ_RESUMEN.ID_CONTRATO,
                OBJ_RESUMEN.RUT_CLIENTE,
                OBJ_RESUMEN.NOMBRE_CLIENTE,
                OBJ_RESUMEN.FECHA_NAC_CLIENTE,
                OBJ_RESUMEN.EDAD_CLIENTE,
                OBJ_RESUMEN.NACIONALIDAD_CLIENTE,
                OBJ_RESUMEN.TELEFONO_CLIENTE,
                OBJ_RESUMEN.CORREO_CLIENTE,
                OBJ_RESUMEN.ID_COMUNA,
                OBJ_RESUMEN.NOMBRE_COMUNA,
                OBJ_RESUMEN.ID_PLAN,
                OBJ_RESUMEN.NOMBRE_PLAN,
                OBJ_RESUMEN.PRECIO_PLAN,
                OBJ_RESUMEN.FECHA_INICIO_CONTRATO,
                OBJ_RESUMEN.FECHA_TERMINO_CONTRATO,
                OBJ_RESUMEN.ESTADO_CONTRATO,
                OBJ_RESUMEN.TOTAL_PAGADO,
                OBJ_RESUMEN.SALDO_PLAN,
                OBJ_RESUMEN.DIAS_VIGENCIA,
                OBJ_RESUMEN.ID_ULTIMO_PAGO,
                OBJ_RESUMEN.MONTO_ULTIMO_PAGO,
                OBJ_RESUMEN.FECHA_ULTIMO_PAGO,
                OBJ_RESUMEN.ID_ULTIMA_FACTURA,
                OBJ_RESUMEN.TOTAL_ULTIMA_FACTURA,
                OBJ_RESUMEN.FECHA_ULTIMA_FACTURA,
                V_FILAS_INSERTADAS
            );

            COMMIT;

            --========================================================================
            -- CONTADORES Y ACUMULADORES
            --========================================================================
            V_ID_RESUMEN := OBJ_RESUMEN.ID_RESUMEN;
            V_CONT_PROCESADOS := V_CONT_PROCESADOS + V_FILAS_INSERTADAS;
            V_SUMA_TOTAL_PAGADO := V_SUMA_TOTAL_PAGADO + OBJ_RESUMEN.TOTAL_PAGADO;
            V_SUMA_SALDO := V_SUMA_SALDO + OBJ_RESUMEN.SALDO_PLAN;

            --========================================================================
            -- DETALLE POR CONTRATO CON DBMS_OUTPUT
            --========================================================================
            DBMS_OUTPUT.PUT_LINE('===============================================================');
            DBMS_OUTPUT.PUT_LINE('CONTRATO ' || OBJ_RESUMEN.ID_CONTRATO ||
                                 ' - ' || OBJ_RESUMEN.NOMBRE_CLIENTE);
            DBMS_OUTPUT.PUT_LINE('===============================================================');
            DBMS_OUTPUT.PUT_LINE('ID RESUMEN        : ' || OBJ_RESUMEN.ID_RESUMEN);
            
            DBMS_OUTPUT.PUT_LINE('RUT CLIENTE       : ' || OBJ_RESUMEN.RUT_CLIENTE);
            
            DBMS_OUTPUT.PUT_LINE('NOMBRE CLIENTE    : ' || OBJ_RESUMEN.NOMBRE_CLIENTE);
            
            DBMS_OUTPUT.PUT_LINE('FECHA NACIMIENTO  : ' || TO_CHAR(OBJ_RESUMEN.FECHA_NAC_CLIENTE, 'DD-MM-YYYY'));
                            
            DBMS_OUTPUT.PUT_LINE('EDAD CLIENTE      : ' || NVL(TO_CHAR(OBJ_RESUMEN.EDAD_CLIENTE), 'Sin dato'));
                                 
            DBMS_OUTPUT.PUT_LINE('NACIONALIDAD      : ' || NVL(OBJ_RESUMEN.NACIONALIDAD_CLIENTE, 'Sin dato'));
                                 
            DBMS_OUTPUT.PUT_LINE('TELEFONO          : ' || OBJ_RESUMEN.TELEFONO_CLIENTE);
            
            DBMS_OUTPUT.PUT_LINE('CORREO            : ' || OBJ_RESUMEN.CORREO_CLIENTE);
            
            DBMS_OUTPUT.PUT_LINE('COMUNA            : ' || NVL(OBJ_RESUMEN.NOMBRE_COMUNA, 'Sin dato'));
                                 
            DBMS_OUTPUT.PUT_LINE('PLAN              : ' || OBJ_RESUMEN.NOMBRE_PLAN);
            DBMS_OUTPUT.PUT_LINE('PRECIO PLAN       : ' || TO_CHAR(OBJ_RESUMEN.PRECIO_PLAN, 'FML999G999G999'));
                                 
            DBMS_OUTPUT.PUT_LINE('FECHA INICIO      : ' || TO_CHAR(OBJ_RESUMEN.FECHA_INICIO_CONTRATO, 'DD-MM-YYYY'));
                                 
            DBMS_OUTPUT.PUT_LINE('FECHA TERMINO     : ' || TO_CHAR(OBJ_RESUMEN.FECHA_TERMINO_CONTRATO, 'DD-MM-YYYY'));
                                 
            DBMS_OUTPUT.PUT_LINE('ESTADO CONTRATO   : ' || OBJ_RESUMEN.ESTADO_CONTRATO);
            DBMS_OUTPUT.PUT_LINE('TOTAL PAGADO      : ' || TO_CHAR(OBJ_RESUMEN.TOTAL_PAGADO, 'FML999G999G999'));
                                 
            DBMS_OUTPUT.PUT_LINE('SALDO PLAN        : ' || TO_CHAR(OBJ_RESUMEN.SALDO_PLAN, 'FML999G999G999'));
                                 
            DBMS_OUTPUT.PUT_LINE('DIAS VIGENCIA     : ' || OBJ_RESUMEN.DIAS_VIGENCIA);
            DBMS_OUTPUT.PUT_LINE('ID DE PAGO       : ' || NVL(TO_CHAR(OBJ_RESUMEN.ID_ULTIMO_PAGO), 'Sin pagos'));
                                 
            DBMS_OUTPUT.PUT_LINE('MONTO ULTIMO PAGO : ' || NVL(TO_CHAR(OBJ_RESUMEN.MONTO_ULTIMO_PAGO,'FML999G999G999'), 'Sin pagos'));
                                
            DBMS_OUTPUT.PUT_LINE('FECHA ULTIMO PAGO : ' || NVL(TO_CHAR(OBJ_RESUMEN.FECHA_ULTIMO_PAGO,'DD-MM-YYYY'), 'Sin pagos'));
                                 
            DBMS_OUTPUT.PUT_LINE('ULTIMA FACTURA    : ' || NVL(TO_CHAR(OBJ_RESUMEN.ID_ULTIMA_FACTURA), 'Sin facturas'));
                                 
            DBMS_OUTPUT.PUT_LINE('TOTAL ULTIMA FACT : ' || NVL(TO_CHAR(OBJ_RESUMEN.TOTAL_ULTIMA_FACTURA,'FML999G999G999'), 'Sin facturas'));
                                             
            DBMS_OUTPUT.PUT_LINE('FECHA ULTIMA FACT : ' || NVL(TO_CHAR(OBJ_RESUMEN.FECHA_ULTIMA_FACTURA,'DD-MM-YYYY'), 'Sin facturas'));
                                               
            DBMS_OUTPUT.PUT_LINE('FILAS INSERTADAS  : ' || V_FILAS_INSERTADAS);

        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                ROLLBACK;
                V_CONT_ERRORES := V_CONT_ERRORES + 1;
                DBMS_OUTPUT.PUT_LINE('ERROR CONTRATO ' || i.ID_CONTRATO ||': ID_RESUMEN duplicado.');
                                     

            WHEN OTHERS THEN
                ROLLBACK;
                V_CONT_ERRORES := V_CONT_ERRORES + 1;
                DBMS_OUTPUT.PUT_LINE('ERROR CONTRATO ' || i.ID_CONTRATO || ': ' || SQLERRM);
                                     
        END;

    END LOOP;

    COMMIT;

    --========================================================================
    -- PROMEDIO Y REPORTE FINAL
    --========================================================================
    IF V_CONT_PROCESADOS > 0 THEN
        V_PROMEDIO_TOTAL := ROUND(V_SUMA_TOTAL_PAGADO / V_CONT_PROCESADOS);
    END IF;

    DBMS_OUTPUT.PUT_LINE('===============================================================');
    DBMS_OUTPUT.PUT_LINE(' REPORTE FINAL DEL PROCESO');
    DBMS_OUTPUT.PUT_LINE('===============================================================');
    DBMS_OUTPUT.PUT_LINE('CONTRATOS PROCESADOS : ' || V_CONT_PROCESADOS);
    DBMS_OUTPUT.PUT_LINE('CONTRATOS CON ERROR  : ' || V_CONT_ERRORES);
    DBMS_OUTPUT.PUT_LINE('SUMA TOTAL PAGADO    : ' || TO_CHAR(V_SUMA_TOTAL_PAGADO, 'FML999G999G999G999'));          
    DBMS_OUTPUT.PUT_LINE('SUMA SALDOS          : ' || TO_CHAR(V_SUMA_SALDO, 'FML999G999G999G999'));                   
    DBMS_OUTPUT.PUT_LINE('PROMEDIO PAGADO      : ' || TO_CHAR(V_PROMEDIO_TOTAL, 'FML999G999G999G999'));                  
    DBMS_OUTPUT.PUT_LINE('===============================================================');
    DBMS_OUTPUT.PUT_LINE('PROCESO FINALIZADO CON COMMIT.');
    DBMS_OUTPUT.PUT_LINE('===============================================================');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR GENERAL: ' || SQLCODE || ': ' || SQLERRM);
END;
/


