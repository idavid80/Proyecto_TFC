from pymongo import MongoClient

from api_vino.settings import MONGO_DB

client = MongoClient(MONGO_DB)
db = client['apiVino']
# Create your views here.
datosTecnicos = db.get_collection("DatosTecnicos")
modelosVinos = db.get_collection("ModeloVinos")
usuarios = db.get_collection("Usuarios")
valoraciones = db.get_collection("Valoraciones")

