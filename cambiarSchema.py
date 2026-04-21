
# -*- coding: utf-8 -*-
import os

# ✅ Nombres de schemas destino
schemas = [
    'sissgo',
    'jomart',
    'sissgopro',
    'medik',
    'viamedica',
    'familiaips',
    'sisacor',
    'odontopip',
    'claravision',
    'radiologos',
    'ligacancer',
    'manantiales',
    'guaranda',
    'funmanodios',
    'clidolorlu',
    'divinami'
]


# ✅ Archivo base SQL
input_file = 'base_script.sql'

# ✅ Palabra o schema base a reemplazar (sin punto al final)
schema_base = 'sissgo'

# ✅ Archivo SQL de salida único
output_file = 'scripts_para_todos_los_schemas.sql'

# ✅ Leer el SQL base
with open(input_file, 'r', encoding='utf-8') as f:
    base_sql = f.read()

# ✅ Crear y escribir el archivo combinado
with open(output_file, 'w', encoding='utf-8') as f_out:
    for schema in schemas:
        f_out.write(f"-- ================================================\n")
        f_out.write(f"-- Scripts para schema: {schema}\n")
        f_out.write(f"-- ================================================\n\n")

        schema_sql = base_sql
        # Reemplazar distintas variantes del schema base
        schema_sql = schema_sql.replace(f'{schema_base}.', f'{schema}.')         # sin comillas
        schema_sql = schema_sql.replace(f'"{schema_base}".', f'"{schema}".')     # con comillas dobles
        schema_sql = schema_sql.replace(f"'{schema_base}.", f"'{schema}.")       # dentro de comillas simples

        f_out.write(schema_sql)
        f_out.write('\n\n')

print(f"✅ Archivo generado con scripts para todos los schemas en: {output_file}")
