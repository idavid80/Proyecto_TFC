import requests
from bs4 import BeautifulSoup
from conexion_mongo import ConexionMongo
import concurrent.futures


class WineIsSocial:
    url = "https://wineissocial.com/1719-vinos?page="
    info_id = "js-product-list"
    div_all_data = "div"
    class_all_data="product-image"

    def comprobar_conexion(self, page):
        request = requests.get(self.url + str(page))
        soup = BeautifulSoup(request.content, "html.parser")
        # Comprueba si los vinos de wine is social estan disponible
        info = soup.find(id=self.info_id)
        return info

    # Extrae los datos de vino de la pagina de productos
    def extraerVinosPorPagina(self, page):
        request = requests.get(self.url + str(page))
        soup = BeautifulSoup(request.content, "html.parser")
        info = soup.find(id=self.info_id)
        vinos_html = info.find_all(self.div_all_data, self.class_all_data)

        lista_vinos = []
        for vino in vinos_html:
            link_url = vino.find("a", class_="thumbnail product-thumbnail")
            # Aplicampos el metodo strip para eliminar espacios
            link = link_url["href"].strip()
            imagen = vino.find("img", class_="img-fluid")["data-src"].strip()
            modelo = vino.find("img", class_="img-fluid")["alt"].strip()
            lista_vinos.append({"modelo": modelo, "url": link, "imagen": imagen})
        #    print("datosTecnicos", get_datos_tecnicos(link))
        #  lista_vinos.append({"modelo": modelo, "url": link, "imagen": imagen, "datosTecnicos": get_datos_tecnicos(link)})

        return lista_vinos

    # Obtiene los datos tecnicos de la página del vino
    def get_datos_tecnicos(self, wine_url):
        # Obtenemos html
        request = requests.get(wine_url)
        soup = BeautifulSoup(request.content, "html.parser")

        # Obtenemos los datos que el html en id="js-product-list")
        info = soup.find(id="main")

        datos = info.find("section", class_="product-features")
        #print("datos",datos)
        # Pais
        linea_pais = datos.find("li", class_="pais").get_text(strip=True).replace("\t", "")
        pais = linea_pais.replace("País:", "").strip()

        # Region
        linea_zona = datos.find("li", class_="zona").get_text(strip=True).replace("\t", "")
        region = linea_zona.replace("Región:", "").strip()

        # Denominaciones de origen
        linea_do = datos.find("li", class_="denominacion").get_text(strip=True).replace("\t", "")
        do = linea_do.replace("Zona/D.O.:", "").strip()

        # variedades
        linea_variedades = datos.find(id="vari2").get_text(strip=True).replace("\t", "").replace(" ", "")

        # Convertimos la cadena de variedades en un array con las variedades
        lista_variedades = linea_variedades.split("/")

        # Insertamos los datos obtenidos en un diccionario

        datos_tecnicos = {
            "pais": pais,
            "region": region,
            "do": do,
            "variedades": lista_variedades
        }

        return datos_tecnicos


    def extraer_vino_html(self, page):

        return self.extraerVinosPorPagina(page)


    # Exgtracción de vinos por hilos
    def extraer_vinos_multipagina(self, numero_paginas):
        lista_total_vinos = []
        with concurrent.futures.ThreadPoolExecutor() as executor:
            # Crear una lista de futures para las solicitudes HTTP
            futuros = [executor.submit(self.extraerVinosPorPagina, page) for page in range(1, numero_paginas + 1)]
            # Obtener los resultados de las futures completadas
            for futuro in concurrent.futures.as_completed(futuros):
                lista_vinos_pagina = futuro.result()
                lista_total_vinos.extend(lista_vinos_pagina)
        return lista_total_vinos


# Crear coleccion ModeloVino
"""
wine = WineIsSocial()
lista_vinos = wine.extraer_vino_html(1)
ModeloVinos = ConexionMongo("ModeloVinos")
ModeloVinos.insertar_lista_datos_coleccion(lista_vinos)
"""

# creamos coleccion DatosTecnicos
"""
wine = WineIsSocial()
lista_vinos = wine.extraer_vino_html(1)
DatosTecnicos = ConexionMongo("ModeloVinos")
DatosTecnicos.insertar_lista_datos_coleccion(lista_vinos)
"""
# Indexar Datos tecnicos en vino y crear como coleccion nueva
"""
ModeloVinos = ConexionMongo("ModeloVinos")
lista = ModeloVinos.leer_todo()
DatosTecnicos = ConexionMongo("DatosTecnicos")
wine = WineIsSocial()
for dato in lista:
    datoTecnico = wine.get_datos_tecnicos(dato['url'])
    datoTecnico['modelo_vino_id'] = dato['_id']
    ModeloVinos.agregar_datos_tecnicos(dato['_id'],datoTecnico)
    # print(datoTecnico)
    DatosTecnicos.insertar_dato_coleccion(datoTecnico)
"""

ModeloVinos = ConexionMongo("ModeloVinos")
lista = ModeloVinos.leer_numero(2)
print(lista)

# wine = WineIsSocial()
# ModeloVinos = ConexionMongo("ModeloVinos")
#
# obtener_url_detalles_vinos = ModeloVinos.obtener_urls()
# lista_datos = wine.get_datos_tecnicos(obtener_url_detalles_vinos)
# print(obtener_url_detalles_vinos)
# ModeloVinos.insertar_lista_datos_coleccion(lista_datos)

# lista_vinos = wine.extraer_vinos_multipagina(65)
# prueba = {'modelo': 'Cruor', 'url': 'https://wineissocial.com/1000059-87396-cruor-casa-gran-del-siurana-vino-tinto.html#/172-anada-2019', 'imagen': 'https://wineissocial.com/23505-home_default/cruor-casa-gran-del-siurana-vino-tinto.jpg'}

# DatosTecnicos.insertar_lista_datos_coleccion(lista_datos)
# print(guardar_documento(prueba))
# pepe = buscar_por_campo("modelo","Cruor")
# listaUrl = obtener_urls()
# datoTecnico = wine.get_datos_tecnicos("https://wineissocial.com/1000059-87396-cruor-casa-gran-del-siurana-vino-tinto.html#/172-anada-2019")
# print(datoTecnico)
# print(lista_datos)






#print(comprobar_duplicidades())
#print(imprimir_duplicidades())
#print(eliminar_duplicidades())
#print("pepe", pepe)
# guardar_documentos(lista_vinos)
#buscar_por_campo('url')
