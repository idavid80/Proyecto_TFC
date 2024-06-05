from django.db import models


# Create your models here.
class DatosTecnicos(models.Model):
    _id = models.CharField(max_length=255, null=True)
    pais = models.CharField(max_length=100)
    region = models.CharField(max_length=100)
    do = models.CharField(max_length=100)
    variedades = models.JSONField()  # Si estás usando Django 3.1 o superior
    modelo_vino_id = models.CharField(max_length=255, null=True)



class Valoracion(models.Model):
    #_id = models.CharField(max_length=255, null=True)
    valoracion = models.PositiveSmallIntegerField(choices=[(i, i) for i in range(1, 6)])
    comentario = models.TextField(blank=True)
    fecha_creacion = models.DateTimeField(auto_now_add=True)
    fecha_modificacion = models.DateTimeField(auto_now=True)
    modelo_vino_id = models.CharField(max_length=255, null=True)
    usuario_id = models.CharField(max_length=255, null=True)

class ModeloVino(models.Model):
    _id = models.CharField(max_length=255, null=True)
    modelo = models.CharField(max_length=255)
    url = models.URLField()
    imagen = models.URLField()
    datos_tecnicos = models.ForeignKey(DatosTecnicos, on_delete=models.CASCADE)
    # rating: models.Aggregate(Valoracion.modelo_vino_id)




class Usuario(models.Model):
    _id = models.CharField(max_length=255)
    email = models.CharField(max_length=320)
    username = models.CharField(max_length=320)
    avatar = models.CharField(max_length=320, blank=True, null=True)
    valoraciones = models.ManyToManyField(Valoracion, blank=True)

