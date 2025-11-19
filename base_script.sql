DO $$
DECLARE
    r            RECORD;
    seq_actual   text;
    seq_base     text;
    seq_nueva    text;
    max_val      bigint;
    esquema_destino text := 'manantiales';
BEGIN
    -- Crear schema si no existe
    PERFORM 1 FROM pg_namespace WHERE nspname = esquema_destino;
    IF NOT FOUND THEN
        EXECUTE 'CREATE SCHEMA ' || quote_ident(esquema_destino);
        RAISE NOTICE 'Schema % creado.', esquema_destino;
    END IF;

    -- Recorrer todas las columnas con DEFAULT = nextval(...)
    FOR r IN
        SELECT 
            n.nspname AS schema_tabla,
            c.relname AS tabla,
            a.attname AS columna,
            pg_get_expr(d.adbin, d.adrelid) AS def_expr
        FROM pg_attrdef d
        JOIN pg_attribute a ON a.attrelid = d.adrelid AND a.attnum = d.adnum
        JOIN pg_class c     ON c.oid = d.adrelid
        JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE n.nspname = esquema_destino
          AND pg_get_expr(d.adbin, d.adrelid) LIKE 'nextval%'
          AND a.attnum > 0 AND NOT a.attisdropped
    LOOP

        ------------------------------------------------------------------
        -- 1. Extraer el nombre de la secuencia (funciona con y sin comillas)
        ------------------------------------------------------------------
        -- Ejemplos que maneja:
        -- nextval('"TNOMINA_DIAN_EMPLEADOS_ID_DIAN_EMPLEADO_SEQ"'::regclass)
        -- nextval('public.tnomina_seq'::regclass)
        -- nextval('tnomina_seq'::regclass)
        seq_actual := trim(both '"' FROM 
                        regexp_replace(r.def_expr, 
                            '^nextval\(\s*[''"]?([^''"]+)[''"]?::regclass.*$', '\1')
                        );

        RAISE NOTICE 'Tabla: %.% → Columna: % → Secuencia actual: %',
                     r.schema_tabla, r.tabla, r.columna, seq_actual;

        -- Quitar esquema anterior (si tiene) → quedamos solo con el nombre base
        seq_base := split_part(seq_actual, '.', 2);
        IF seq_base = '' THEN
            seq_base := seq_actual;
        END IF;

        -- Forzar a minúsculas (recomendado y evita problemas futuros)
        seq_base := lower(seq_base);

        -- Nombre final en el schema correcto
        seq_nueva := esquema_destino || '.' || quote_ident(seq_base);

        ------------------------------------------------------------------
        -- 2. Crear la secuencia en manantiales si no existe
        ------------------------------------------------------------------
        IF NOT EXISTS (
            SELECT 1 FROM pg_class c
            JOIN pg_namespace n ON n.oid = c.relnamespace
            WHERE c.relkind = 'S'
              AND n.nspname = esquema_destino
              AND c.relname = seq_base
        ) THEN
            EXECUTE format(
                'SELECT COALESCE(MAX(%I), 0) + 1 FROM %I.%I',
                r.columna, r.schema_tabla, r.tabla
            ) INTO max_val;

            RAISE NOTICE '   → CREANDO secuencia % (inicia en %)', seq_nueva, max_val;

            EXECUTE format(
                'CREATE SEQUENCE %I.%I START WITH %s OWNED BY %I.%I.%I',
                esquema_destino, seq_base, max_val,
                r.schema_tabla, r.tabla, r.columna
            );
        ELSE
            RAISE NOTICE '   → Secuencia % ya existe en manantiales', seq_nueva;
        END IF;

        ------------------------------------------------------------------
        -- 3. Cambiar el DEFAULT de la columna
        ------------------------------------------------------------------
        EXECUTE format(
            'ALTER TABLE %I.%I ALTER COLUMN %I SET DEFAULT nextval(%L)',
            r.schema_tabla, r.tabla, r.columna, seq_nueva
        );

        ------------------------------------------------------------------
        -- 4. (Opcional) Mover la secuencia antigua a manantiales si está fuera
        ------------------------------------------------------------------
        IF seq_actual ~ '\.' OR seq_actual <> seq_base THEN
            PERFORM 1 FROM pg_class c
            JOIN pg_namespace ns ON ns.oid = c.relnamespace
            WHERE c.relkind = 'S'
              AND (ns.nspname || '.' || c.relname = seq_actual
                OR quote_ident(ns.nspname) || '.' || quote_ident(c.relname) = seq_actual);

            IF FOUND THEN
                RAISE NOTICE '   → Moviendo secuencia antigua % → manantiales', seq_actual;
                BEGIN
                    EXECUTE format('ALTER SEQUENCE %I SET SCHEMA %I', seq_actual, esquema_destino);
                EXCEPTION WHEN others THEN
                    RAISE NOTICE '   → No se pudo mover % (quizás ya está en manantiales o no existe)', seq_actual;
                END;
            END IF;
        END IF;

        RAISE NOTICE '   → Columna actualizada correctamente';

    END LOOP;

    RAISE NOTICE '%¡TODO COMPLETADO! Todas las secuencias ahora usan el schema manantiales correctamente.', chr(10);
END $$;



DO $$
DECLARE
    seq_schema text;
    seq_name text;
BEGIN
    FOR seq_schema, seq_name IN
        SELECT sequence_schema, sequence_name
        FROM information_schema.sequences
        WHERE sequence_schema = 'manantiales'
    LOOP
        
        -- anon
        EXECUTE 'GRANT USAGE, SELECT, UPDATE ON SEQUENCE "' 
            || seq_schema || '"."' || seq_name || '" TO anon';

        -- authenticated
        EXECUTE 'GRANT USAGE, SELECT, UPDATE ON SEQUENCE "' 
            || seq_schema || '"."' || seq_name || '" TO authenticated';

        -- dashboard_user
        EXECUTE 'GRANT USAGE, SELECT, UPDATE ON SEQUENCE "' 
            || seq_schema || '"."' || seq_name || '" TO dashboard_user';

        -- postgres
        EXECUTE 'GRANT USAGE, SELECT, UPDATE ON SEQUENCE "' 
            || seq_schema || '"."' || seq_name || '" TO postgres';

        -- service_role
        EXECUTE 'GRANT USAGE, SELECT, UPDATE ON SEQUENCE "' 
            || seq_schema || '"."' || seq_name || '" TO service_role';
    END LOOP;
END $$;

