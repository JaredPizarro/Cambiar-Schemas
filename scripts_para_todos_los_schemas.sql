-- ================================================
-- Scripts para schema: sissgo
-- ================================================

CREATE OR REPLACE FUNCTION sissgo.update_consecutivo_nominaby_tipodoc_web(
	p_tipodcto character varying,
	p_nuevo_consecutivo numeric)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_filas_actualizadas integer;
BEGIN
    UPDATE sissgo.tres_factu
    SET cons_actual = p_nuevo_consecutivo
    WHERE tipodcto = p_tipodcto;

    GET DIAGNOSTICS v_filas_actualizadas = ROW_COUNT;

    IF v_filas_actualizadas > 0 THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$BODY$;

-- ================================================
-- Scripts para schema: jomart
-- ================================================

CREATE OR REPLACE FUNCTION jomart.update_consecutivo_nominaby_tipodoc_web(
	p_tipodcto character varying,
	p_nuevo_consecutivo numeric)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_filas_actualizadas integer;
BEGIN
    UPDATE jomart.tres_factu
    SET cons_actual = p_nuevo_consecutivo
    WHERE tipodcto = p_tipodcto;

    GET DIAGNOSTICS v_filas_actualizadas = ROW_COUNT;

    IF v_filas_actualizadas > 0 THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$BODY$;

-- ================================================
-- Scripts para schema: sissgopro
-- ================================================

CREATE OR REPLACE FUNCTION sissgopro.update_consecutivo_nominaby_tipodoc_web(
	p_tipodcto character varying,
	p_nuevo_consecutivo numeric)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_filas_actualizadas integer;
BEGIN
    UPDATE sissgopro.tres_factu
    SET cons_actual = p_nuevo_consecutivo
    WHERE tipodcto = p_tipodcto;

    GET DIAGNOSTICS v_filas_actualizadas = ROW_COUNT;

    IF v_filas_actualizadas > 0 THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$BODY$;

-- ================================================
-- Scripts para schema: medik
-- ================================================

CREATE OR REPLACE FUNCTION medik.update_consecutivo_nominaby_tipodoc_web(
	p_tipodcto character varying,
	p_nuevo_consecutivo numeric)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_filas_actualizadas integer;
BEGIN
    UPDATE medik.tres_factu
    SET cons_actual = p_nuevo_consecutivo
    WHERE tipodcto = p_tipodcto;

    GET DIAGNOSTICS v_filas_actualizadas = ROW_COUNT;

    IF v_filas_actualizadas > 0 THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$BODY$;

-- ================================================
-- Scripts para schema: viamedica
-- ================================================

CREATE OR REPLACE FUNCTION viamedica.update_consecutivo_nominaby_tipodoc_web(
	p_tipodcto character varying,
	p_nuevo_consecutivo numeric)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_filas_actualizadas integer;
BEGIN
    UPDATE viamedica.tres_factu
    SET cons_actual = p_nuevo_consecutivo
    WHERE tipodcto = p_tipodcto;

    GET DIAGNOSTICS v_filas_actualizadas = ROW_COUNT;

    IF v_filas_actualizadas > 0 THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$BODY$;

-- ================================================
-- Scripts para schema: familiaips
-- ================================================

CREATE OR REPLACE FUNCTION familiaips.update_consecutivo_nominaby_tipodoc_web(
	p_tipodcto character varying,
	p_nuevo_consecutivo numeric)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_filas_actualizadas integer;
BEGIN
    UPDATE familiaips.tres_factu
    SET cons_actual = p_nuevo_consecutivo
    WHERE tipodcto = p_tipodcto;

    GET DIAGNOSTICS v_filas_actualizadas = ROW_COUNT;

    IF v_filas_actualizadas > 0 THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$BODY$;

-- ================================================
-- Scripts para schema: sisacor
-- ================================================

CREATE OR REPLACE FUNCTION sisacor.update_consecutivo_nominaby_tipodoc_web(
	p_tipodcto character varying,
	p_nuevo_consecutivo numeric)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_filas_actualizadas integer;
BEGIN
    UPDATE sisacor.tres_factu
    SET cons_actual = p_nuevo_consecutivo
    WHERE tipodcto = p_tipodcto;

    GET DIAGNOSTICS v_filas_actualizadas = ROW_COUNT;

    IF v_filas_actualizadas > 0 THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$BODY$;

-- ================================================
-- Scripts para schema: odontopip
-- ================================================

CREATE OR REPLACE FUNCTION odontopip.update_consecutivo_nominaby_tipodoc_web(
	p_tipodcto character varying,
	p_nuevo_consecutivo numeric)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_filas_actualizadas integer;
BEGIN
    UPDATE odontopip.tres_factu
    SET cons_actual = p_nuevo_consecutivo
    WHERE tipodcto = p_tipodcto;

    GET DIAGNOSTICS v_filas_actualizadas = ROW_COUNT;

    IF v_filas_actualizadas > 0 THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$BODY$;

-- ================================================
-- Scripts para schema: claravision
-- ================================================

CREATE OR REPLACE FUNCTION claravision.update_consecutivo_nominaby_tipodoc_web(
	p_tipodcto character varying,
	p_nuevo_consecutivo numeric)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_filas_actualizadas integer;
BEGIN
    UPDATE claravision.tres_factu
    SET cons_actual = p_nuevo_consecutivo
    WHERE tipodcto = p_tipodcto;

    GET DIAGNOSTICS v_filas_actualizadas = ROW_COUNT;

    IF v_filas_actualizadas > 0 THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$BODY$;

-- ================================================
-- Scripts para schema: radiologos
-- ================================================

CREATE OR REPLACE FUNCTION radiologos.update_consecutivo_nominaby_tipodoc_web(
	p_tipodcto character varying,
	p_nuevo_consecutivo numeric)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_filas_actualizadas integer;
BEGIN
    UPDATE radiologos.tres_factu
    SET cons_actual = p_nuevo_consecutivo
    WHERE tipodcto = p_tipodcto;

    GET DIAGNOSTICS v_filas_actualizadas = ROW_COUNT;

    IF v_filas_actualizadas > 0 THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$BODY$;

-- ================================================
-- Scripts para schema: ligacancer
-- ================================================

CREATE OR REPLACE FUNCTION ligacancer.update_consecutivo_nominaby_tipodoc_web(
	p_tipodcto character varying,
	p_nuevo_consecutivo numeric)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_filas_actualizadas integer;
BEGIN
    UPDATE ligacancer.tres_factu
    SET cons_actual = p_nuevo_consecutivo
    WHERE tipodcto = p_tipodcto;

    GET DIAGNOSTICS v_filas_actualizadas = ROW_COUNT;

    IF v_filas_actualizadas > 0 THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$BODY$;

