import os

def unificar_archivos_en_txt(ruta_carpeta, archivo_salida="unificado.txt", extensiones_permitidas=None):
    with open(archivo_salida, "w", encoding="utf-8") as salida:
        for carpeta_raiz, _, archivos in os.walk(ruta_carpeta):
            archivos.sort()  # Opcional: ordena archivos alfabéticamente
            for archivo in archivos:
                ruta_archivo = os.path.join(carpeta_raiz, archivo)
                if extensiones_permitidas:
                    if not any(archivo.endswith(ext) for ext in extensiones_permitidas):
                        continue
                try:
                    with open(ruta_archivo, "r", encoding="utf-8") as f:
                        ruta_relativa = os.path.relpath(ruta_archivo, ruta_carpeta)
                        salida.write(f"\n# === {ruta_relativa} ===\n\n")
                        salida.write(f.read())
                        salida.write("\n")
                except Exception as e:
                    print(f"No se pudo leer {ruta_archivo}: {e}")

# USO
# Cambia esta ruta por la ruta absoluta o relativa de tu carpeta principal
ruta = "C:\\Users\\avila\\OneDrive\\Escritorio\\VaplureWeb\\src\\app"

unificar_archivos_en_txt(ruta, "salida_completa.txt", extensiones_permitidas=[".ts", ".html", ".scss", ".css"])
