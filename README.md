# Proyecto_TFC

## Descripción

wine App es una aplicación móvil que pretende ayudar a sus usuarios a la elección a la hora de elegir una botella de vino, teniendo en cuenta los gustos tanto del usuario en particular como la red de personas que tenga creada. Ayudando así en la elección del vino en función de su o sus necesidades.

Para conseguir dicho propósito, la aplicación cuenta con un sistema de recomendaciones que ayudará al algoritmo a elegir otros vinos con características similares. También, cuenta con un sistema de seguimiento de otras personas, que permite conocer las valoraciones de nuestros contactos y establecer un sistema de recomendaciones según la selección del grupo de contacto que se realice.

El sistema cuenta con una variedad de más de 3000 modelos de vinos con sus descripciones, zonas, premios y datos técnicos. La aplicación accede a los datos de la base de datos mediante la API creada en este proyecto.

Los datos de la base de datos han sido extraídos de forma automatizada (webscrapping) de páginas especializadas en el sector vinícola, una vez extraído los datos, se actualizan con la base de datos.

Por último, para que la garantizar el buen uso de los datos sensibles de la aplicación y sus usuarios, la aplicación cuenta con un sistema de autentificación que garantiza la seguridad. Este sistema está configurado dentro de una máquina virtual donde se almacenan los datos de los usuarios, quedando aislado de la aplicación y la base de datos.

## Índice

- [Frontend: Flutter](#frontend)

- [Extracción de datos: webscrapping](#backend)

- [Django: Rest Framework](#django)

- [Autentificación: Ory](#ory)

- [Base Datos: MongoDB](#mongo)

- [Recomendaciones: numby + panda](#recomendaciones)

- [Bibliografia](#bibliografia)

(id="frontend")

## Frontend

El interfaz de usuario esta desarrollado con el frameworks de Google Flutter, el cual utiliza como lenguaje de programación Dart, y nos va a permitir que la aplicación sea multiplataforma. La estructura de la aplicación es la siguiente:

### Instalación

Instalar Flutter, este paso conviene utilizar la [documentación oficial](https://docs.flutter.dev/get-started/install), puesto que depende del sistema operativo y posiblemente con el tiempo surjan algunas modificaciones.

#### Preparación

- Crear el archivo .env para almacenar las variables de entorno del proyecto

- Crear una carpeta asstets dentro del proyecto y habilitarla en el archivo pubspec.yaml

```yaml
assets:
  - assets/images/

  - .env
```

#### Dependencias flutter

```yaml
http: ^1.2.1

flutter_dotenv: ^5.1.0

dio: ^5.4.3+1

ory_client: ^1.6.2

shared_preferences: ^2.2.3

carousel_slider: ^4.2.1

google_sign_in: ^6.2.1

image_picker: ^1.1.2

url_launcher: ^6.3.0
```

- **http**: Permite realizar solicitudes HTTP, lo que es esencial para interactuar con APIs web.

- **flutter_dotenv**: Carga variables de entorno desde un archivo .env, lo cual es útil para gestionar configuraciones sensibles y diferenciadas por entorno (desarrollo, producción).

- **dio**: Es una biblioteca para realizar solicitudes HTTP más avanzada que http, ofreciendo características como interceptores, cancelación de solicitudes, y más. Es obligatorio instalarla para usar el SDK de ory

- **ory_client**: Cliente para interactuar con los servicios de Ory, como Hydra o Kratos, que son herramientas para la gestión de identidad y acceso.

- **shared_preferences**: Permite almacenar datos simples de manera persistente en el dispositivo del usuario, como configuraciones y preferencias.

- **carousel_slider**: Proporciona un widget para mostrar un carrusel de imágenes u otros widgets, con diversas opciones de personalización.

- **google_sign_in**: Implementa el inicio de sesión mediante la cuenta de Google, facilitando la autenticación con Google.

- **image_picker**: Permite seleccionar imágenes y videos de la galería del dispositivo o tomar nuevas fotos y videos usando la cámara.

- **url_launcher**: Permite abrir URLs en el navegador web, enviar correos electrónicos, hacer llamadas telefónicas, o enviar SMS directamente desde la aplicación.

### Estructura

Las carpetas donde se generan los componentes e interfaz en Flutter se almacenan en el directorio **lib**. La estructura de este proyecto es la siguiente:

```plaintext

app_vino/

├── dar_tool

├── .idea/

├── android/

├── assets

│   ├── images

│   │   ├── avatar.jpg

│   │   ├── logo.png

├── build/

├── ios/

├── lib/

│   ├── model/

│   ├── pages/

│   ├── services/

│   ├── theme/

│   ├── widget/

├── main.dart

│   ├── linux/

│   ├── macos/

│   ├── test/

│   ├── web/

│   ├── windows/

├── .env

├── .flutter-pluggins

├── .flutter-pluggins-dependencies

├── .metadata

├── analysis_options.yaml

├── app_vino.iml

├── pubspec.lock

└── pubspec.yaml

```

#### Descripción de los directorios

- **widget**: almacena los widget (componentes) de la aplicación que pueden ser usado por las distintas páginas de la app, para aplicar el principio de evitar la duplicidad.

- **page**: almacena las pantallas de la aplicación.

- **services**: almacena los archivos de servicios, como el sistema de autentifición, almacenamiento en el dispositivo, conexiones con la API y el uso de la cámara del dispositivo.

- **theme**: Almacena los estilos de la aplicación, colores, estilos, etc.

- **route**: contiene los archivos que proporcionan el interfaz de usuario.

- **model**: almacena los modelos necesarios para la aplicación

- **assets**: carpeta que almacena los recursos de la app, en este caso sólo imagen del logo y avatar.

(id="backend")

## Backend

### WebScrapping. Capa de Información

#### Dependencias websrapping

> python -m pip install requests
>
> python -m pip install beautifulsoup4
>
> python -m pip install pymongo
>
> python -m pip install bson

#### Funciones de las librerías

- **requests** se utiliza para realizar solicitudes HTTP.

- **beautifulsoup4**, es una biblioteca que facilita el scrapping de datos de archivos HTML y XML.

- **pymongo** biblioteca permite interactuar con bases de datos MongoDB desde aplicaciones Python.

- **bson** es una biblioteca para trabajar con BSON (Binary JSON), que es el formato binario utilizado por MongoDB para almacenar documentos.

### Sistema Recomendaciones

#### Dependencias sistema recomendación

> python -m pip install -U matplotlib
>
> python -m pip install numpy
>
> python -m pip install pandas
>
> python -m pip install seaborn

- **numpy** es una biblioteca fundamental para la computación científica en Python. Proporciona soporte para matrices multidimensionales (arrays) y una gran colección de funciones matemáticas para operar con estos arrays de manera eficiente.

- **pandas** es una biblioteca poderosa para la manipulación y análisis de datos. Proporciona estructuras de datos de alto rendimiento y fáciles de usar, como DataFrames y Series, que son fundamentales para trabajar con datos tabulares.

- **seaborn** es una biblioteca para la visualización de datos basada en matplotlib. Proporciona una interfaz de alto nivel para dibujar atractivos y informativos gráficos estadísticos. Es especialmente útil para la visualización de relaciones entre variables.

<a id="django"></a>

## Api Django

Para la API se a utilizado el framework de Django, junto con Django REST Framework, porque ofrece una solución completa y robusta para el desarrollo de APIs, facilitando muchas tareas comunes y permitiendo centrarse en la lógica y las funcionalidades específicas de la aplicación.

### Instalación Django

Seguir la documentación oficial de [Django](https://docs.djangoproject.com/en/5.0/intro/install/) como de [Django rest Framework](https://www.django-rest-framework.org/tutorial/quickstart/), puesto que puede encontrar tutoriales desactualizados.

> py -m pip install Django
>
> django-admin startproject api_vino
>
> cd api_vinod

### Estructura de Django

```plaintext

api_vino/

├── manage.py

├── api_vino/

│   ├── __init__.py

│   ├── settings.py

│   ├── urls.py

│   ├── wsgi.py

│   ├── asgi.py

├── api/

│   ├── __init__.py

│   ├── admin.py

│   ├── apps.py

│   ├── models.py

│   ├── serializers.py

│   ├── tests.py

│   ├── urls.py

│   ├── views.py

│   ├── migrations/

│   │   └── __init__.py

├── templates/

│   └── (archivos HTML)

├── static/

│   └── (archivos CSS, JS, imágenes)

└── requirements.txt

```

**manage.py**: Un script que facilita la administración del proyecto Django. Permite ejecutar comandos como runserver, makemigrations, migrate, startapp, etc.

**settings.py**: Archivo de configuración principal del proyecto. Aquí se configuran las aplicaciones instaladas, la base de datos, las configuraciones de middleware, y otros ajustes del proyecto.

```py



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



ALLOWED_HOSTS = ['localhost', '127.0.0.1']



MONGO_DB="http://127.0.0.1:2017"



"""

DATABASES = {

        'default': {

            'ENGINE': 'djongo',

            'NAME': 'wine_api',

            'ENFORCE_SCHEMA': False,

            'CLIENT': {

                'host': "http://127.0.0.1:2017"

            }

        }

}



"""

```

**urls.py**: El archivo de enrutamiento principal del proyecto. Define las URL del proyecto y las vincula con las vistas correspondientes. Es necesario, conectar desde el archivo url.py del proyecto api_vino con el archivo url.py del directorio api que se genera al introducir el siguiente comando (python manage.py startapp api)

```python

from django.contrib import admin

from django.urls import path, include

from rest_framework.documentation import include_docs_urls



urlpatterns = [

    path('admin/', admin.site.urls),

    path("api/", include('api.urls')), # inclute la puta de la carpeta api

    path('docs/', include_docs_urls(title='Api Documentation')), # uso de rest_framework.documentation



]

```

### Creacion de la api y sus librerías

> python manage.py startapp api

crea una carpeta llamada 'api' con la estructura básica para la aplicación donde definirás tus modelos, vistas y lógica de la API.

### Estructura startapp

> pip install djangorestframework

Instalar y configurar Django REST Framework que proporciona las herramientas necesarias para crear y gestionar las rutas y serializaciones de tu API.

> pip install djongo

Configurar MongoDB permite que tu proyecto Django use MongoDB, configurando la conexión en el archivo settings.py.

> pip install django-cors-headers

Gestionar CORS, configurar las políticas de CORS, asegurando que tu API pueda ser accedida de manera segura desde diferentes dominios.

> pip install coreapi

Mejora la capacidad de documentar y explorar tu API, facilitando la interacción y comprensión de los endpoints disponibles.

### Migración

Una vez tenemos instalado todo, debemos crear los modelos de nuestra API, la serialización de los modelos, las vistas y por último los endpoints. Todos estos archivos estarían dentro de la carpeta api, que se generó al introducir el comando python manage.py startapp api.

Una vez los hemos creados según nuestras necesidades, se generan los archivos que describen los cambios a realizar en la base de datos para la aplicación api.

> python manage.py makemigrations api

Y, posteriormente, se aplican los cambios a la base de datos, actualizando su estructura para que refleje los modelos definidos en tu aplicación.

> python manage.py migrate

Actualizamos el archivo settings.py

para arrancar el servidor usamos el comando

> python manage.py runserver

Si queremos que la api eschuche cualquier ip, entonces

> python manage.py runserver 0.0.0.0:8000

<a id="ory"></a>

## Sistema de autentificación Ory

Para garantizar la seguridad de los datos de los usuarios, y autentificar que los datos establecidos los aporta el mismo usuario, se ha establecido un sistema de autentificación y permisos de código abierto como Ory. Con Ory podemos obtener un sistema tan seguro como Firebase. Ory dispone de una infraestructura que se adaptan a las necesidades presentes y futuras de la aplicación.

### Implementación

Para implementar el docker en la parte backend así como del uso del SDK en la aplicación Flutter, se ha utilizado la documentación oficial, dentro de toda la documentación de ory, la mayor parte de implementación está en los siguientes enlaces:

- [kratos](https://www.ory.sh/docs/kratos/quickstart)

- [API Kratos](https://www.ory.sh/docs/kratos/reference/api)

- [SDK Kratos](https://pub.dev/packages/ory_kratos_client)

- [Google Sign](https://www.ory.sh/docs/kratos/social-signin/google#flutter-code-example)

> [!NOTE]

> Para realizar el trabajo se ha utilizado prácticamente toda la documentación de ory, **ory keto** está configurado en el proyecto, aunque no está implementado en esta versión

La implementación de ory se ha realizado a través de un contenedor Dockers, el cual se ha configurado para disponer del uso de Ory Kratos, Oauth y Keto. Ory kratos y Oauth nos va a permitir la autentificación del usuario, así como de la gestión de los tokens, cookies, gestión de usuarios contraseñas.

Los datos son almacenados dentro de base de datos del contenedor docker, que se implementará en la parte del backend de la aplicación.

Para el frontend de la aplicación, se ha optado por implementar el SDK disponible. El uso del SDK de ory se encuentran en el archivo ory_services.dart en el directorio de services de Flutter.

### Mejoras

Como mejoras en esta capa de la aplicación estaría la de implementar el sistema de permisos de Keto, el cual está configurado y utilizar Kubernets para que establezca su sistema de orquestación entre las máquinas virtuales.

<a id="mongo"> </a>

## Base de datos

La base de datos es MongoDB porque proporciona escalabilidad, flexibilidad de esquema, y la capacidad de manejar datos no estructurados o semiestructurados. Además, es muy recomendable para aplicaciones IoT (Internet of Things), Análisis en Tiempo Real y Big Data.

### Instalación de Mongo

MongoDB tiene [cursos gratuitos](https://learn.mongodb.com/courses/data-modeling-for-mongodb-overview) con tutoriales con instalación en función del lenguaje de programación de la aplicación. Estos cursos, también cuentan como recomendaciones para estructurar tu modelo de datos. Para poder usar mongoDB es necesario estar registrado. Dispone de una herramienta de escritorio [MongoDB Compass](https://www.mongodb.com/es/products/tools/compass)

### Esquema de Base de Datos

La base de datos MongoDB se organiza en colecciones, cada una de las cuales almacena documentos con un esquema flexible. A continuación, se presenta una descripción de las colecciones principales y sus campos.

Todas las colecciones de la base de datos cuentan con un campo **\_id** que es creado por mongoDB

#### ModeloVino

Ésta colección se almacena todos los datos obtenidos por la capa de información sobre el producto. Su estructura es la siguiente:

- **modelo**: obtenemos la descripción del modelo de vino.

- **url**: establece la página web de donde se ha obtenido los datos, y proporcionará un enlace al usuario para poder comprar el producto.

- **imagen**: es una url con la imagen del producto.

- **datos_tecnicos**: es un campo que está indexado de otra colección.

#### DatosTecnicos

En esta colección se almacenará los datos técnicos del vino, que son necesarios para el sistema de recomendaciones. Sus claves son las siguientes:

- **pais**: país de origen del vino

- **region**: Región del país al que pertenece.

- **do\_**: Denominación de origen.

- **variedades**: es una lista con las variedades de uvas con las que se ha realizado.

- **modelo_vino_id**: almacena el id del vino al que pertenece los datos técnicos.

#### Usuario

En esta colección se almacena los datos necesarios de los usuarios. Sus claves son las siguientes:

- **usuario_id**: id proporcionado por el sistema de autentificación (Ory Kratos).

- **email**: email introducido por el usuario.

- **username**; nombre usuario proporcionado por el cliente.

- **avatar**: esta pensado para almacenar una imagen del cliente, aunque finalmente se almacena en el dispositivo del usuario.

#### Valoraciones

Esta colección también se utilizará para el sistema de recomendaciones. Estos datos son proporcionado por el usuario. Sus claves son las siguientes:

- **rating**: valoración establecida con un rango de 1 a 5.

- **comentario**: este campo está establecido para ayudar al usuario a recordar su experiencia con el producto.

- **modelo_vino_id**: almacena el id del vino valorado.

- **usuario_id**: id del usuario que ha realizado la valoración, para poder establecer los criterios de recomendaciones.

<a id="recomendaciones"></a>

## Sistema recomendaciones

<a id="bibliografia"></a>

## Bibliografia

### Documentacion oficial

- [Flutter](https://docs.flutter.dev/get-started/install)
- [Django](https://docs.djangoproject.com/en/5.0/intro/install/)
- [Django rest Framework](https://www.django-rest-framework.org/tutorial/quickstart/)
- [kratos](https://www.ory.sh/docs/kratos/quickstart)
- [API Kratos](https://www.ory.sh/docs/kratos/reference/api)
- [SDK Kratos](https://pub.dev/packages/ory_kratos_client)
- [Google Sign](https://www.ory.sh/docs/kratos/social-signin/google#flutter-code-example)
- [cursos MongoDB](https://learn.mongodb.com/courses/data-modeling-for-mongodb-overview)
- [MongoDB Compass](https://www.mongodb.com/es/products/tools/compass)

### Otra documentación de Flutter

- [flutter_dotenv](https://www.youtube.com/watch?v=xTxwjbcd8kA)
- [Pull to Refresh in Flutter](https://www.youtube.com/watch?v=D0-ZpybCbC8)
- [Flutter Scrollable](https://www.dhiwise.com/post/how-to-implement-flutter-scrollable-column)
- [Card Carousel](https://medium.com/flutter-community/how-to-create-card-carousel-in-flutter-979bc8ecf19)
- [Cards](https://andygeek.com/posts/Creando-cards-en-flutter/)

### Django

- [Django Seccion de Likes y Comentarios](https://www.youtube.com/watch?v=G8FWGtGk5ig)
- [Django + Mongo con djongo](https://jacobsood.medium.com/integrating-mongodb-atlas-with-django-using-djongo-962dfd1513eb)
- [Django + Mongo con pymongo](https://www.digitalocean.com/community/tutorials/how-to-connect-a-django-app-to-mongodb-with-pymongo)

### Sistema de recomendaciones

- [Deep learnig with python - François Chollet](https://www.google.com/search?q=fran%C3%A7ois+chollet+deep+learning+with+python&sca_esv=0fe395fae313f6fd&sca_upv=1&rlz=1C1GCEA_enES1111ES1111&sxsrf=ADLYWIJo1kffYn5_BLNIi34Qfbw4w_YYnQ%3A1717709397768&ei=VSpiZunELoKK9u8Pz5TXqAw&ved=0ahUKEwipw-yT9seGAxUChf0HHU_KFcUQ4dUDCBA&uact=5&oq=fran%C3%A7ois+chollet+deep+learning+with+python&gs_lp=Egxnd3Mtd2l6LXNlcnAiK2ZyYW7Dp29pcyBjaG9sbGV0IGRlZXAgbGVhcm5pbmcgd2l0aCBweXRob24yBxAuGIAEGBMyBxAAGIAEGBMyCBAAGBMYFhgeMggQABgTGBYYHjIIEAAYExgWGB4yCBAAGBMYFhgeMggQABgTGBYYHjIIEAAYExgWGB4yCBAAGBMYFhgeMggQABgTGBYYHjIWEC4YgAQYExiXBRjcBBjeBBjgBNgBAUjxAVAAWABwAHgAkAEAmAF-oAF-qgEDMC4xuAEDyAEA-AEBmAIBoAKDAZgDALoGBggBEAEYFJIHAzAuMaAHpww&sclient=gws-wiz-serp)

### Repository

- [web Scrapping](https://realpython.com/beautiful-soup-web-scraper-python/)
