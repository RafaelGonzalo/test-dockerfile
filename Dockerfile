# 1. Imagen base (versión específica para reproducibilidad)
FROM python:3.11-slim

# 2. Instalar dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 3. Directorio de trabajo
WORKDIR /app

# 4. Copiar requirements.txt primero (para aprovechar cache de Docker)
COPY requirements.txt .

# 5. Instalar dependencias de Python
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 6. Copiar el resto de la aplicación
COPY app.py .

# 7. Exponer puerto de la aplicación
EXPOSE 5000

# 8. Comando por defecto (usar exec form)
CMD ["python", "app.py"]