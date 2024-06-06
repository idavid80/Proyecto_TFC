import 'package:flutter/material.dart';  
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_of/one_of.dart';  
import 'package:ory_client/ory_client.dart';  
  
class SignInWithGoogleButton extends StatefulWidget {
  const SignInWithGoogleButton({super.key});
  
  @override
  _SignInWithGoogleButtonState createState() => _SignInWithGoogleButtonState();
}

class _SignInWithGoogleButtonState extends State<SignInWithGoogleButton> {


 final GoogleSignIn _googleSignIn = GoogleSignIn(  
  scopes: [  
    'email',  
     // Añadir más scopes 
  ],  
 );
  
 //SignInWithGoogleButton({super.key, required this.flowId, required this.ory});  
 
  
 void handleGoogleSignIn(GoogleSignInAccount? value) {  
  value?.authentication.then((value) {  
  var idToken = value.idToken;
  print('Google value: $value');
  if (idToken == null) {  
    print("idToken no encontrado");  
  return;  
 }  
  late String flowId;
 OryClient ory = OryClient();

 void getFlowId() async{
  final request = await OryClient().getFrontendApi().createNativeRegistrationFlow();
  setState(() {
    flowId = request.data!.id;
  });
  
 }

 // Crear la payload para el endpoint updateRegistrationFlow con el idToken de Google 
 var body = UpdateLoginFlowWithOidcMethod(  
  (b) => b  
    ..idToken = idToken  
    ..method = 'oidc'  
    ..provider = 'google',  
 );  
 
 // Submit el endpoint updateRegistrationFlow con payload  
  ory.getFrontendApi().updateRegistrationFlow(  
    flow: flowId,  
    updateRegistrationFlowBody: UpdateRegistrationFlowBody(  
    (b) => b..oneOf = OneOf.fromValue1(value: body)),  
    );  
  });  
 }  
/*
  @override  
  Widget build(BuildContext context) {  
    return TextButton(  
      child: const Text("Sign in with Google"),  
      onPressed: () => {_googleSignIn.signIn().then(handleGoogleSignIn)},  
    );  
  }  
*/
   void handleGoogleSignOut() async {
    try {
      await _googleSignIn.signOut();
      print("Sesión de Google cerrada correctamente");
    } catch (error) {
      print("Error al cerrar sesión de Google: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    
        TextButton(
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
             Image.network(
              'http://pngimg.com/uploads/google/google_PNG19635.png',
              fit:BoxFit.cover,
              width: 50.0,
              
          ) ,
const Text("Sign in with Google"),
           ],
          ), onPressed: () => _googleSignIn.signIn().then(handleGoogleSignIn),
          
          ),

        //      TextButton(
                 
     //     child: Text("Sign out"),
       //   onPressed: handleGoogleSignOut, 
      //  ),
    
      ],
    );
  }

}