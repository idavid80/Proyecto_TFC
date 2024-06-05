import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_vino/main.dart';
import 'package:app_vino/services/imagen_dispositivo.dart';
import 'package:app_vino/services/ory_services.dart';
import 'package:app_vino/services/routers.dart';
import 'package:app_vino/widget/bottom_nav.dart';
import 'package:app_vino/widget/app_bar_custom.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int index = 0;
  BottomNav? bottomNav;
  late String email;
  late String username;
  bool isLoad = false;
  String avatar = "";

  @override
  void initState() {
    bottomNav = BottomNav(
      currentIndex: (page) {
        setState(() {
          index = page;
        });
      },
    );
    cargarDatos();
    super.initState();
  }

  void cargarDatos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString("email") ?? "";
      avatar = prefs.getString('avatar') ?? 'assets/images/avatar.jpg';
      isLoad = true;
      username = prefs.getString("username") ?? "No encontrado";
    });
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final sessionToken = prefs.getString("sessionToken");
    final bool isLogout = await OryServices().logout(sessionToken.toString());

      prefs.clear();
      const SnackBar(content: Text('Cerrando sesión'));
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => const SplashScreen()),
      );

  }

  Future<void> _selectAvatar() async {
    final cameraGalleryService = CameraGalleryService();
    final path = await cameraGalleryService.selectPhoto();
    if (path != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('avatar', path);
      setState(() {
        avatar = path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(logout: logout, isLogin: true),
      drawer: Drawer(
        backgroundColor: theme.colorScheme.secondary,
        child: ListView(
          children: <Widget>[
            
           
             UserAccountsDrawerHeader(
              accountName: isLoad
                  ? Text(username, style: theme.textTheme.titleSmall)
                  : const Text(""),
              accountEmail: isLoad ? Text(email, style: theme.textTheme.titleMedium) : const Text(""),
              currentAccountPicture: CircleAvatar(
                backgroundColor: theme.colorScheme.tertiary,
                foregroundImage:
                    avatar.isNotEmpty ? FileImage(File(avatar)) : null,
                child: avatar.isEmpty
                    ? Image.asset('assets/images/avatar.png', width: 50)
                    : null,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
              ),
            ),

        
           
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: ElevatedButton(
                onPressed: _selectAvatar,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  backgroundColor: theme.colorScheme.tertiary,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: theme.colorScheme.onPrimary,
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    Text('Select Avatar',
                        style: TextStyle(color: theme.colorScheme.surface)),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('Add contact', style: theme.textTheme.bodyLarge),
              leading: const Icon(Icons.person_add_alt), iconColor: theme.colorScheme.primary,
            ),
            ListTile(
              title: Text('My rating', style: theme.textTheme.bodyLarge),
              leading: const Icon(Icons.star_half_outlined),iconColor: theme.colorScheme.primary,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: logout,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  backgroundColor: theme.colorScheme.tertiary,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      color: theme.colorScheme.onPrimary,
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    Text('Logout',
                        style: TextStyle(color: theme.colorScheme.surface)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: RoutesPage(index: index),
      bottomNavigationBar: bottomNav,
    );
  }
}


/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_vino/main.dart';
import 'package:app_vino/services/imagen_dispositivo.dart';
import 'package:app_vino/services/ory_client.dart';
import 'package:app_vino/services/routers.dart';
import 'package:app_vino/widget/bootom_nav.dart';
import 'package:app_vino/widget/custom_app_bar.dart';
import 'package:app_vino/widget/imagen_avatar.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // late List<Vino> vinos = [];
  int index = 0;
  BottomNav? bottomNav;

  @override
  void initState() {
    // inicializamos BottomNav con la funcion paginacion
    bottomNav = BottomNav(
      currentIndex: (page) {
        setState(() {
          index = page;
        });
      },
    );
    cargarDatos();
    super.initState();
  }

  late String email;
  late String username;
  bool isLoad = false;
  String avatar = "";

  void cargarDatos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      email = prefs.getString("email") ?? "";
      avatar = prefs.getString('avatar') ?? "";
      isLoad = true;
      username = prefs.getString("username") ?? "No encontrado";
    });
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final sessionToken = prefs.getString("sessionToken");
    
   // if (sessionToken != null) {
  //    ScaffoldMessenger.of(context).showSnackBar(
     //   SnackBar(content: Text('Bienvenido, ${prefs.get("email")}')),
   //   );
 //   } else {
      final bool isLogout = await OryServices().logout(sessionToken.toString());

      if(isLogout) {
        prefs.clear();
        const SnackBar(content: Text('Cerrando sesión'));
      navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (context) => const SplashScreen(),));

      }else{

        const SnackBar(content: Text('Error  al cerrrar sesión'));

      }      

  final CameraGalleryService cameraGalleryService = CameraGalleryService();

String photoPath = 'assets/images/avatar.jpg';
      
 //   }else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //    const SnackBar(content: Text('Error')));    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
   // appBarTheme: appBarTheme,
    return Scaffold(
       
      
      
      appBar: CustomAppBar(logout: logout, isLogin: true,),
      /*AppBar(
        backgroundColor: theme.colorScheme.primary,
        leading: Builder(
          
          
      builder: (context) {
        return IconButton(
          icon: Icon(Icons.view_headline,  color:  theme.colorScheme.secondary),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      }
    ),
        title: Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo.png',
              width: 50,
            )),
        
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout_rounded,
              color: theme.colorScheme.secondary,
              size: 30,
            ),
            onPressed: logout,
          ),
        ],
      ),*/
      
      
      drawer: Drawer(
        backgroundColor: theme.colorScheme.secondary,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: isLoad ? Text(username, style: theme.textTheme.bodyLarge) : const Text(""),
              accountEmail: isLoad ? Text(email) : const Text(""),
              currentAccountPicture:
                  CircleAvatar(backgroundColor:theme.colorScheme.tertiary,

                child: avatar != "null" ? Image.asset(
          'assets/images/logo.png',
          width: 50,
        ) : Image.asset(
          avatar,
          width: 50,
        ),
                  ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
              ),
            ), const GetImageMovil(),
            ListTile(
              title: Text('Add contact', style: theme.textTheme.bodyLarge),
              leading: const Icon(Icons.person_add_alt),
            ),
            ListTile(
              title: Text('My rating', style: theme.textTheme.bodyLarge),
              leading: const Icon(Icons.star_half_outlined),
            ),
            Padding(padding: const EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0, bottom: 0.0),
            child: 
ElevatedButton(
  onPressed: logout,
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    backgroundColor: theme.colorScheme.tertiary

  ),
  child: Column(
    mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del Row al contenido
    children: [
      Icon(
        Icons.logout_rounded,
        color: theme.colorScheme.onPrimary, // Color del ícono
        size: 30,
      ),
      const SizedBox(width: 8), // Espacio entre el ícono y el texto
      Text('Logout', style: TextStyle(color: theme.colorScheme.surface)),
      
    ],
  ),
),),
          ],
        ),
      ),
      body: RoutesPage(index: index),
      
      bottomNavigationBar: bottomNav,
    );
  }
}
*/