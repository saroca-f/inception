FROM	debian:bullseye

RUN		apt update -y && apt upgrade -y
# apt update -y: Actualiza la lista de paquetes disponibles en los repositorios.
# apt upgrade -y: Actualiza todos los paquetes instalados a sus versiones más recientes.
# El -y significa "sí a todo" para evitar que el comando espere confirmaciones.

RUN		apt install nginx -y && apt install openssl -y
# Instala el servidor web nginx (una herramienta que sirve páginas web).
# Instala openssl, que se usa para generar certificados de seguridad (SSL/TLS).

RUN		mkdir -p /etc/nginx/ssl
# Crea un directorio /etc/nginx/ssl donde se almacenarán los archivos de certificados SSL.
# La opción -p asegura que no habrá errores si el directorio ya existe.
# ¿Por qué?: Para organizar los certificados en una ubicación conocida que nginx puede usar.

RUN		openssl req -x509 -nodes \
		-out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
		-subj "/C=ES/ST=Andalucia/L=Malaga/O=42/OU=42/CN=saroca-f.42.fr/UID=saroca-f"
# openssl req: Usa openssl para generar un certificado.
# -x509: Crea un certificado autofirmado (sin autoridad externa).
# -nodes: Evita que la clave privada esté cifrada (no pide contraseña).
# -out: Especifica el archivo de salida del certificado (inception.crt).
# -keyout: Especifica el archivo de salida de la clave privada (inception.key).
# -subj: Proporciona la información del certificado, como país, ciudad, nombre común (CN), etc.
# ¿Por qué?:
# HTTPS requiere un certificado para cifrar las conexiones.
# Este comando genera un certificado temporal para pruebas o entornos donde no necesitas certificados oficiales.

COPY conf/nginx.conf /etc/nginx/nginx.conf
# Copia un archivo de configuración de nginx desde el proyecto local (conf/nginx.conf) 
# a su ubicación en el contenedor (/etc/nginx/nginx.conf).
# ¿Por qué?: nginx necesita un archivo de configuración que define cómo manejar las solicitudes.
# Este comando asegura que uses tu propia configuración.

EXPOSE 80
# Expone el puerto 443 para permitir conexiones HTTPS.

CMD ["nginx", "-g", "daemon off;"]
# Ejecuta nginx en primer plano para que el contenedor no se detenga
# "daemon off": Instrucción para que nginx no se ejecute en segundo plano