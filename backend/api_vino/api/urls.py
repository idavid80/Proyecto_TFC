#from django.urls import path
#from .views import DatosTecnicosListCreateAPIView, DatosTecnicosRetrieveUpdateDestroyAPIView, ModeloVinoListCreateAPIView, ModeloVinoRetrieveUpdateDestroyAPIView
#from .views import DatosTecnicos, ModeloVinoViewSet

from django.urls import path, include
from rest_framework.routers import DefaultRouter
from api import views

router = DefaultRouter()
router.register(r'detalle', views.DatosTecnicosViewSet, basename='detalle')
router.register(r'modelo', views.ModeloVinoViewSet, basename='modelo')
router.register(r'valoracion', views.ValoracionViewSet, basename='valoracion')
router.register(r'usuarios', views.UsuarioViewSet, basename='usuarios')



# The API URLs are now determined automatically by the router.
urlpatterns = [
    path('', include(router.urls)),
    path('api/usuarios/create/', views.UsuarioViewSet.as_view({'post': 'create'})),
    path('api/valoraciones/create/', views.ValoracionViewSet.as_view({'post': 'create'})),
    path('api/modelo/<str:pk>/', views.ModeloVinoViewSet.as_view({'get': 'retrieve'}), name='modelo-detail'),
    path('api/modelo/get_average_rating/<str:pk>/', views.ModeloVinoViewSet.as_view({'get': 'retrieve'}), name='modelo-detail'),
  
]

"""get_average_rating
  path('obtener_json/', views.UsuarioViewSet.obtener_json, name='obtener_json'),
urlpatterns = [
    # Rutas para DatosTecnicos
    path('datos-tecnicos/', views.DatosTecnicosList.as_view(), name='datos-tecnicos-list'),
    path('datos-tecnicos/<int:pk>/', views.DatosTecnicosDetail.as_view(), name='datos-tecnicos-detail'),

    # Rutas para ModeloVino
    path('modelos-vino/', views.ModeloVinoList.as_view(), name='modelos-vino-list'),
    path('modelos-vino/<int:pk>/', views.ModeloVinoDetail.as_view(), name='modelos-vino-detail'),
    path('modelos-vino/model/<str:modelo>/', views.ModeloVinoByModel.as_view(), name='modelos-vino-by-model'),
]

"""

"""
urlpatterns = [
    path('datos_tecnicos/', DatosTecnicosListCreateAPIView.as_view(), name='vino-list-create'),
    path('datos_tecnicos/<int:pk>/', DatosTecnicosRetrieveUpdateDestroyAPIView.as_view(), name='vino-detail'),
    path('vinos/', ModeloVinoListCreateAPIView.as_view(), name='modelo-vino-list-create'),
    path('vinos/<int:pk>/', ModeloVinoRetrieveUpdateDestroyAPIView.as_view(), name='modelo-vino-detail'),

     #   path('mostrar-datos/', mostrar_datos, name='mostrar-datos'),
]
"""
