# Proyecto_TFC
Trabajo de Fin de Ciclo del Grado Superior de DAM

## Frontend

### Instalación

Instalar Flutter

#### Preparación

- Crear el archivo .env para almacenar las variables de entorno del proyecto
- Crear una carpeta asstets dentro del proyecto y habilitarla en el archivo pubspec.yaml

~~~yaml
  assets:
    - assets/images/
    - .env
~~~

#### Dependencias flutter

~~~yaml
  http: ^1.2.1
  flutter_dotenv: ^5.1.0
  dio: ^5.4.3+1
  ory_client: ^1.6.2
  shared_preferences: ^2.2.3
  carousel_slider: ^4.2.1
  google_sign_in: ^6.2.1
  image_picker: ^1.1.2
  url_launcher: ^6.3.0
~~~

- http: Permite realizar solicitudes HTTP, lo que es esencial para interactuar con APIs web.

- flutter_dotenv: Carga variables de entorno desde un archivo .env, lo cual es útil para gestionar configuraciones sensibles y diferenciadas por entorno (desarrollo, producción).

- dio: Es una biblioteca para realizar solicitudes HTTP más avanzada que http, ofreciendo características como interceptores, cancelación de solicitudes, y más. Es obligatorio instalarla para usar el SDK de ory

- ory_client: Cliente para interactuar con los servicios de Ory, como Hydra o Kratos, que son herramientas para la gestión de identidad y acceso.

- shared_preferences: Permite almacenar datos simples de manera persistente en el dispositivo del usuario, como configuraciones y preferencias.

carousel_slider: Proporciona un widget para mostrar un carrusel de imágenes u otros widgets, con diversas opciones de personalización.

- google_sign_in: Implementa el inicio de sesión mediante la cuenta de Google, facilitando la autenticación con Google.

- image_picker: Permite seleccionar imágenes y videos de la galería del dispositivo o tomar nuevas fotos y videos usando la cámara.

- url_launcher: Permite abrir URLs en el navegador web, enviar correos electrónicos, hacer llamadas telefónicas, o enviar SMS directamente desde la aplicación.

### Estructura

Las carpetas donde se generan los componentes e interfaz en Flutter se almacenan en el directorio **lib**. La estructura de este proyecto es la siguiente:

## Backend

### WebScrapping. Capa de Información

#### Dependencias websrapping

> python -m pip install requests
> python -m pip install beautifulsoup4
> python -m pip install pymongo
> python -m pip install bson

#### Funciones de las librerías

- requests se utiliza para realizar solicitudes HTTP.
- beautifulsoup4, es una biblioteca que facilita el scraping de datos de archivos HTML y XML.
- pymongo biblioteca permite interactuar con bases de datos MongoDB desde aplicaciones Python.
- bson es una biblioteca para trabajar con BSON (Binary JSON), que es el formato binario utilizado por MongoDB para almacenar documentos.

### Sistema Recomendaciones

#### Dependencias sistema recomendación

> python -m pip install -U matplotlib
> python -m pip install numpy
> python -m pip install pandas
> python -m pip install seaborn

- numpy es una biblioteca fundamental para la computación científica en Python. Proporciona soporte para matrices multidimensionales (arrays) y una gran colección de funciones matemáticas para operar con estos arrays de manera eficiente.
- pandas es una biblioteca poderosa para la manipulación y análisis de datos. Proporciona estructuras de datos de alto rendimiento y fáciles de usar, como DataFrames y Series, que son fundamentales para trabajar con datos tabulares.
- seaborn es una biblioteca para la visualización de datos basada en matplotlib. Proporciona una interfaz de alto nivel para dibujar atractivos y informativos gráficos estadísticos. Es especialmente útil para la visualización de relaciones entre variables.

### Api Vino

> py -m pip install Django
> django-admin startproject api_vino
> cd backenapi_vinod
> python manage.py startapp api
> pip install djangorestframework
> pip install djongo
> pip install django-cors-headers
> pip install coreapi


Actualizamos el archivo settings.py

Una vez tenemos serializers, model y url
> python manage.py makemigrations api
> python manage.py migrate

~~~py

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    'rest_framework',
    'corsheaders',
    'api',
    'coreapi',
]
REST_FRAMEWORK = {
    ...: ...,
    "DEFAULT_SCHEMA_CLASS": "rest_framework.schemas.coreapi.AutoSchema",
}

CORS_ORIGIN_ALLOW_ALL = False
CORS_ORIGIN_WHITELIST = (
    'http://localhost:8081',
)

ALLOWED_HOSTS = ['192.168.1.37', 'localhost', '127.0.0.1']
~~~

para arrancar el servidor

> python manage.py runserver 0.0.0.0:8000

## Sistema de autentificación

Para garantizar la seguridad de los datos de los usuarios, y autentificar que los datos establecidos los aporta el mismo usuario, se ha establecido un sistema de autentificación y permisos de código abierto como Ory. Con Ory podemos obtener un sistema tan seguro como Firebase. Ory dispone de una infraestructura que se adaptan a las necesidades presentes y futuras de la aplicación.

### Implementación

La implementación de ory se ha realizado a través de un contenedor Dockers, el cual se ha configurado para disponer del uso de Ory Kratos, Oauth y Keto. Ory kratos y Oauth nos va a permitir la autentificación del usuario, así como de la gestión de los token, cookies, gestión de usuarios contraseñas.
Los datos son almacenados dentro de base de datos del contenedor docker, que se implementará en la parte del backend de la aplicación.
Para el frontend de la aplicación, se ha optado por implementar el SDK dispoble.

### Mejoras

Como mejoras en esta capa de la aplicación estaría la de implementar el sistema de permisos de Keto, el cual está configurado y utilizar Kubernets para que establezca su sistema de orquestación entre las máquinas virtuales.

Ory

> docker-compose -f quickstart.yml -f oathkeeper-quickstart.yml up --build

## Frontend Cambios

El interfaz de usuario esta desarrollado con el fraameworks de Google Flutter, el cual utiliza como lenguaje de programación Dart, y nos va a permitir que la aplicación sea multiplataforma. La estructura de la aplicación es la siguiente:

Descripción de los directorios:

- widget: almacena los widget (componentes) de la aplicación que pueden ser usado por las distintas páginas de la app, para aplicar el princiio de evitar la duplicidad.
- screen: almacena las pantallas de la aplicación.
- services: almacena los archivos de servicios, como el sistema de autentifición, almacenamiento en el dispositivo, conexiones con la API
- route: contiene los archivos que proporcionan el interfaz de usuario.
