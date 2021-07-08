import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:patientapp/NetworkHandler.dart';
import 'package:patientapp/pages/SignInPage.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
    TextEditingController _emailController = TextEditingController();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              
              
              ClipPath(
                clipper: WaveClipper1(),
                child: Container(
                  
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Icon(
                        Icons.local_pharmacy_outlined,
                        color: Colors.white,
                        size: 60,
                      ),
                      
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "  Dweya  ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 30),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF69F0AE), Color(0xFF00E676)])),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Form(
             
          key: _globalkey,
                      child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: 
              
 Material(
      elevation: 2.0,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: TextFormField(
      controller: _emailController,
    validator: (value) {
    if (value.isEmpty) return "Email can't be empty";
    if (!value.contains("@")) return "Email is Invalid";
    return null;
            },
        onChanged: (String value){},
        cursorColor: Colors.deepOrange,
        decoration: InputDecoration(
          errorText: validate ? null : errorText,
            hintText: "Email",
            prefixIcon: Material(
              elevation: 0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Icon(
                Icons.email,
                 color: Colors.greenAccent[400],
              ),
            ),
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
      ),
    ),                 
            ),
          ),
          SizedBox(
            height: 20,
          ),
         Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextFormField(
               // onChanged: (String value){},
                //cursorColor: Colors.deepOrange,
              controller: _passwordController,
           validator: (value) {
              if (value.isEmpty) return "Password can't be empty";
              return null;
            },
          obscureText: vis,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
                    hintText: "Password",
                    
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: Colors.greenAccent[400],
                      ),
                    ),
                    suffixIcon: IconButton(
                        color: Colors.greenAccent[400],
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                     color: Colors.greenAccent[400],),
           child: FlatButton(
                  child: Text(
                    "Update password",
                    style: TextStyle(
                         color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                 
                
                  onPressed: () async {
                    Map<String, String> data = {
                      "password": _passwordController.text
                    };
                    print("/user/update/${_emailController.text}");
                    var response = await networkHandler.patch(
                        "/user/update/${_emailController.text}", data);

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      print("/user/update/${_emailController.text}");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage()),
                          (route) => false);
                    }

                    // login logic End here
                  },
                ),
                   
           ),
                   
                  
              ),
            
                
              ],
            ),
          
        
      
    );
  }

  Widget usernameTextField() {
    return Column(
      children: [
        Text("email"),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget passwordTextField() {
    return Column(
      children: [
        Text("Password"),
        TextFormField(
          controller: _passwordController,
          obscureText: vis,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            suffixIcon: IconButton(
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
            helperStyle: TextStyle(
              fontSize: 14,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

  
}