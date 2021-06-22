 
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import 'package:patientapp/NetworkHandler.dart';
import 'package:patientapp/pages/SignInPage.dart';


class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignUpPage> {
   bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[ 
              Clip(),
            ],
          ),
          SizedBox(
            height: 4,
          ),
         Form(
          key: _globalkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign up with email",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              usernameTextField(),
              emailTextField(),
              passwordTextField(),
              
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
                    "Sign Up",
                    style: TextStyle(
                         color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                   onPressed: () async {
                     setState(() {
                      circular = true;
                    });
                 await checkUser();
                  if (_globalkey.currentState.validate() && validate) {
                    // we will send the data to rest server
                    Map<String, String> data = {
                      "username": _usernameController.text,
                      "email": _emailController.text,
                      "password": _passwordController.text,
                    };
                    print(data);
                    var responseRegister =
                        await networkHandler.post("/user/register", data);

                    //Login Logic added here
                    if (responseRegister.statusCode == 200 ||
                        responseRegister.statusCode == 201) {
                      Map<String, String> data = {
                        "username": _usernameController.text,
                        "password": _passwordController.text,
                           "email": _emailController.text,
                      };
                      var response =
                          await networkHandler.post("/user/login", data);

                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        Map<String, dynamic> output =
                            json.decode(response.body);
                        print(output["token"]);
                        await storage.write(
                            key: "token", value: output["token"]);
                        setState(() {
                          validate = true;
                          circular = false;
                        });
                   
                  
               
                   Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInPage(),
                            ),
                            (route) => false);
                      } else {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Netwok Error")));
                      }
                    }

                    //Login Logic end here

                    setState(() {
                      circular = false;
                    });
                  } else {
                    setState(() {
                      circular = false;
                    });
                  }
                },
                ),
                
              )),
            ],
            
          ),
          
        ),
              SizedBox(height: 20,),
      
         
        ],
      ),
    );
  }
  checkUser() async {
    if (_emailController.text.length == 0) {
      setState(() {
        // circular = false;
        validate = false;
        errorText = "email Can't be empty";
      });
    } else {
      var response = await networkHandler
          .get("/user/checkemail/${_emailController.text}");
      if (response['Status']) {
        setState(() {
          // circular = false;
          validate = false;
          errorText = "email already taken";
        });
      } else {
        setState(() {
          // circular = false;
          validate = true;
        });
      }
    }
  }

  Widget usernameTextField() {
    return
    Material(
      elevation: 2.0,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: TextFormField(
      controller: _usernameController,
    validator: (value) {
    if (value.isEmpty) return "username can't be empty";
    return null;
            },
        onChanged: (String value){},
        cursorColor: Colors.deepOrange,
        decoration: InputDecoration(
          errorText: validate ? null : errorText,
            hintText: "username",
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
    );
  }

  Widget emailTextField() {
    return  Material(
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
    );
  }

  Widget passwordTextField() {
    return Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextFormField(
                onChanged: (String value){},
                cursorColor: Colors.deepOrange,
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
            );
}
}

class Clip extends StatelessWidget {
  const Clip({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
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


 
  
