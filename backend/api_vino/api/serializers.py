from rest_framework import serializers
from .models import DatosTecnicos, ModeloVino, Usuario, Valoracion

class DatosTecnicosSerializer(serializers.ModelSerializer):
    class Meta:
        model = DatosTecnicos
        fields = '__all__'




class ValoracionSerializer(serializers.ModelSerializer):

    class Meta:        
        model = Valoracion
        fields = '__all__'
        
        extra_kwargs = {
            'validacion': {'required': False},
        }
        
class ModeloVinoSerializer(serializers.ModelSerializer):
    datos_tecnicos = DatosTecnicosSerializer()
    valoracines = ValoracionSerializer()
    class Meta:      
        model = ModeloVino
        fields = '__all__'
        #fields = ['modelo', 'url', 'imagen', 'datos_tecnicos']
        


class UsuarioSerializer(serializers.ModelSerializer):
    valoraciones = ValoracionSerializer(many=True, read_only=True,)
    class Meta:
        model = Usuario
        fields = '__all__'
        
        extra_kwargs = {
            'password': {'write_only': True},
            'valoraciones': {'required': False},  # Hacer el campo opcional
        }
        
