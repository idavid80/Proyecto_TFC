import json
from bson import ObjectId
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, render
from pymongo import DESCENDING

"""
from rest_framework import generics
from .models import DatosTecnicos, ModeloVino
from .serializers import DatosTecnicosSerializer, ModeloVinoSerializer

# Vistas para DatosTecnicos
class DatosTecnicosList(generics.ListCreateAPIView):
    queryset = DatosTecnicos.objects.all()
    serializer_class = DatosTecnicosSerializer

class DatosTecnicosDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = DatosTecnicos.objects.all()
    serializer_class = DatosTecnicosSerializer

# Vistas para ModeloVino
class ModeloVinoList(generics.ListCreateAPIView):
    queryset = ModeloVino.objects.all()
    serializer_class = ModeloVinoSerializer

class ModeloVinoDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = ModeloVino.objects.all()
    serializer_class = ModeloVinoSerializer

class ModeloVinoByModel(generics.ListAPIView):
    serializer_class = ModeloVinoSerializer

    def get_queryset(self):
        modelo = self.kwargs['modelo']
        return ModeloVino.objects.filter(modelo=modelo)
"""


# Create your views here.
# from rest_framework import generics
from .serializers import DatosTecnicosSerializer, ModeloVinoSerializer, UsuarioSerializer, ValoracionSerializer
from django.shortcuts import render
from .mongodb import datosTecnicos, modelosVinos, usuarios, valoraciones
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import viewsets, status



# Create your views here.

class DatosTecnicosViewSet(viewsets.ModelViewSet):
    #queryset = DatosTecnicos.objects.all()
    queryset = list(datosTecnicos.find({}))
    serializer_class = DatosTecnicosSerializer
    

class ModeloVinoViewSet(viewsets.ModelViewSet):
    #queryset = ModeloVino.objects.all()
    queryset = list(modelosVinos.find({}))
    serializer_class = ModeloVinoSerializer

    
    def retrieve(self, request, pk=None):
        try:
            vino = modelosVinos.find_one({"_id": ObjectId(pk)})
            if vino:
                serializer = self.serializer_class(vino)
                return Response(serializer.data, status=status.HTTP_200_OK)
            return Response({"error": "Vino no encontrado"}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
        

    def get_object(self):
        modelo_id = self.kwargs.get('modelo_id')
        vino = get_object_or_404(modelosVinos, pk=modelo_id)
        return vino
    
    def wineById(self, modelo_id):
        # Convertir el ID del documento a ObjectId
        id_objeto = ObjectId(modelo_id)
        # Crear el filtro por ID
        filtro = {"_id": id_objeto}
        # Buscar el documento que coincida con el filtro por ID
        resultado = modelosVinos.find_one(filtro)
        # Imprimir el documento encontrado
        if resultado:
            serializer = self.serializer_class(resultado)
            return Response(serializer.data, status=status.HTTP_200_OK)
        else:
            print("No se encontró ningún documento con el ID especificado.")
   


    def wisneById(self, request, modelo_id=None):
        try:
            vino = modelosVinos.find_one({"_id": modelo_id})
            serializer = self.serializer_class(vino)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)    

class UsuarioViewSet(viewsets.ModelViewSet):
    queryset = list(usuarios.find({}))
    serializer_class = UsuarioSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            self.perform_create(serializer)
            usuarios.insert_one(serializer.data)
            headers = self.get_success_headers(serializer.data)
            return Response({'email': serializer.data['email'] + ' registrado'}, status=status.HTTP_201_CREATED, headers=headers)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def get_all(self, request, *args, **kwargs):
       documentos = usuarios.find({})
  
       
       return Response(documentos)


class ValoracionViewSet(viewsets.ModelViewSet):
    #queryset = ModeloVino.objects.all()
    queryset = list(valoraciones.find({}))
    serializer_class = ValoracionSerializer
    

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            self.perform_create(serializer)
            valoraciones.insert_one(serializer.data)
            headers = self.get_success_headers(serializer.data)
            
            valoracion_str = str(serializer.data['valoracion'])  # Convertir a cadena
        response_message = valoracion_str + ' registrado'

        return Response({'valoracion': response_message}, status=status.HTTP_201_CREATED, headers=headers)
    

    def valoraciones_por_usuario(self, request, usuario_id=None):
        try:
            valoraciones = list(usuarios.find({"usuario_id": usuario_id}).sort("valoracion", DESCENDING))
            serializer = self.serializer_class(valoraciones, many=True)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)