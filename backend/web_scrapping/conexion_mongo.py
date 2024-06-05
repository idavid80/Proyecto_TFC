from bson.objectid import ObjectId
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from dotenv import load_dotenv
import os

load_dotenv()

# Acceder a las variables de entorno
MONGO_DB = os.getenv('MONGO_DB')


uri = MONGO_DB
# Create a new client and connect to the server
cliente = MongoClient(uri, server_api=ServerApi('1'))
# Send a ping to confirm a successful connection
try:
    cliente.admin.command('ping')
    print("Pinged your deployment. You successfully connected to MongoDB!")
except Exception as e:
    print(e)
# Establecer la conexión a la base de datos



class ConexionMongo():
    def __init__(self, nombre_coleccion):
        self.db = cliente["apiVino"]
        self.nombreColeccion = nombre_coleccion
        self.coleccion = self.db[self.nombreColeccion]

    def leer_todo(self):
        # Leer todos los documentos de la colección
        documentos = self.coleccion.find({})
        # Iterar sobre los documentos e imprimirlos
        lista_datos = list(documentos)
        return lista_datos


    def leer_numero(self, modelos):
        # Leer todos los documentos de la colección
        documentos = self.coleccion.find({}).limit(modelos)
        # Iterar sobre los documentos e imprimirlos
        lista_datos = list(documentos)
        return lista_datos


    def insertar_lista_datos_coleccion(self,documentos):
        # Insertar la lista de documentos en la colección
        resultado = self.coleccion.insert_many(documentos)
        # Imprimir los IDs de los documentos insertados
        return "Documentos insertados con los IDs:", resultado.inserted_ids


    def insertar_dato_coleccion(self, documento):
        # Insertar el documento en la colección
        resultado = self.coleccion.insert_one(documento)
        # Imprimir el ID del documento insertado
        return "Documento insertado con el ID:", resultado.inserted_id


    def eliminar_documento(self, filtro):
        # Filtro para encontrar el documento que deseas eliminar
        # filtro = {"clave": "valor"}
        # Eliminar el primer documento que coincida con el filtro
        resultado = self.coleccion.delete_one(filtro)
        # Imprimir el número de documentos eliminados
        print("Número de documentos eliminados:", resultado.deleted_count)


    def eliminar_documentos(self, filtro):
        # Eliminar todos los documentos que coincidan con el filtro
        # filtro = {"clave": "valor"}
        resultado = self.coleccion.delete_many(filtro)
        # Imprimir el número de documentos eliminados
        print("Número de documentos eliminados:", resultado.deleted_count)


    def eliminar_por_id(self, id_documento):
        # Convertir el ID del documento a ObjectId
        id_objeto = ObjectId(id_documento)
        # Crear el filtro por ID
        filtro = {"_id": id_objeto}
        # Eliminar el documento que coincida con el filtro por ID
        resultado = self.coleccion.delete_one(filtro)
        # Imprimir el número de documentos eliminados
        print("Número de documentos eliminados:", resultado.deleted_count)


    def eliminar_por_campo(self, nombre_campo, valor_campo):
        # Crear el filtro por el campo específico
        filtro = {nombre_campo: valor_campo}
        # Eliminar todos los documentos que coincidan con el filtro
        resultado = self.coleccion.delete_many(filtro)
        # Imprimir el número de documentos eliminados
        print("Número de documentos eliminados:", resultado.deleted_count)


    def buscar_por_campo(self, nombre_campo, valor_campo):
        # Crear el filtro por el campo específico
        filtro = {nombre_campo: valor_campo}
        # Buscar documentos que coincidan con el filtro
        resultados = self.coleccion.find(filtro)
        # Iterar sobre los resultados e imprimirlos
        for resultado in resultados:
            return resultado


    def buscar_por_id(self, id_documento):
        # Convertir el ID del documento a ObjectId
        id_objeto = ObjectId(id_documento)
        # Crear el filtro por ID
        filtro = {"_id": id_objeto}
        # Buscar el documento que coincida con el filtro por ID
        resultado = self.coleccion.find_one(filtro)
        # Imprimir el documento encontrado
        if resultado:
            print(resultado)
        else:
            print("No se encontró ningún documento con el ID especificado.")


    def modificar_campo(self, id_documento, nombre_campo, nuevo_valor):
        # Crear el filtro por el ID del documento
        filtro = {"_id": id_documento}
        # Crear el campo de actualización
        actualizacion = {"$set": {nombre_campo: nuevo_valor}}
        # Actualizar el campo en el documento
        resultado = self.coleccion.update_one(filtro, actualizacion)
        # Imprimir el número de documentos modificados
        print("Número de documentos modificados:", resultado.modified_count)


    def modificar_por_id(self, id_documento, nuevo_objeto):
        # Convertir el ID del documento a ObjectId
        id_objeto = ObjectId(id_documento)
        # Crear el filtro por ID
        filtro = {"_id": id_objeto}
        # Actualizar el documento con el nuevo objeto
        resultado = self.coleccion.update_one(filtro, {"$set": nuevo_objeto})
        # Imprimir el número de documentos modificados
        print("Número de documentos modificados:", resultado.modified_count)


    def comprobar_duplicidades(self):
        # Agrupar documentos por URL y contar cuántos hay de cada una
        pipeline = [
            {"$group": {"_id": "$url", "count": {"$sum": 1}}},
            {"$match": {"count": {"$gt": 1}}}
        ]
        return list(self.coleccion.aggregate(pipeline))
        
    def imprimir_duplicidades(self):
        duplicados = self.comprobar_duplicidades()
        for duplicado in duplicados:
            url = duplicado["_id"]
            return list(self.coleccion.find({"url": url}))

    def eliminar_duplicidades(self):
        duplicados = self.comprobar_duplicidades()
        for duplicado in duplicados:
            url = duplicado["_id"]
            documentos = list(self.coleccion.find({"url": url}))
            self.coleccion.delete_one({"_id": documentos[0] ["_id"]})
            return "Duplicado eliminado para la URL:", url 

    def obtener_urls(self):
        # Utilizar el método distinct() para obtener URLs únicas
        urls_unicas = self.coleccion.distinct("url")
        return urls_unicas
    
    def agregar_datos_tecnicos(self, id_vino, datos_tecnicos):
        self.coleccion.update_one(
            {"_id": id_vino},
            {"$set": {"datos_tecnicos": datos_tecnicos}}
        )

    def encontrar_vinos_por_datos_tecnicos(self, pais, region, do):
        # Crear un filtro basado en los datos técnicos
        filtro = {
            "detalle_tecnicos.pais": pais,
            "detalle_tecnicos.region": region,
            "detalle_tecnicos.do": do
        }

        # Buscar vinos en la colección ModeloVino que coincidan con los datos técnicos
        vinos_encontrados = list(self.coleccion.find(filtro))

        return vinos_encontrados


"""
    for duplicado in duplicados:
        url = duplicado["_id"]
        documentos = list(coleccion.find({"url": url}))
        coleccion.delete_one({"_id": documentos[0]["_id"]})
        return "Duplicado eliminado para la URL:", url    
duplicados
    



from pymongo import MongoClient
database = MongoClient ('mongodb://localhost' ,27017)

db = client.clientlist

connection = MongoClient ("localhost",
username = "user",
password = "password",
authSource = "admin",
authMechanism = "SCRAM-SHA-256")



uri = "mongodb+srv://idavid80:4ShMdVD8KzOdLRPt@cluster0.p3kifpt.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
# Create a new client and connect to the server
client = MongoClient(uri, server_api=ServerApi('1'))
# Send a ping to confirm a successful connection
try:
    client.admin.command('ping')
    print(client.list_collections())
    print("Pinged your deployment. You successfully connected to MongoDB!")
except Exception as e:
    print(e)


data_base = client.get_database("apiVino")

modelo_vino = data_base.get_collection('ModeloVinos')

vino = modelo_vino.insert_one({"modelo": "python"})

"""