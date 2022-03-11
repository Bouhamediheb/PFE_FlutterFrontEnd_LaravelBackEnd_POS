import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
            width: 50,
            height: 50,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    "Créer un compte",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 28,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.shade200,
                  thickness: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
                  child: TextFormField(
                    controller: emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade400,
                      ),
                      prefixIcon:
                          Icon(Icons.email, color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    ),
                    style: TextStyle(
                        fontFamily: 'Montserrat', color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Mot de Passe',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade400,
                      ),
                      prefixIcon:
                          Icon(Icons.vpn_key, color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    ),
                    style: TextStyle(
                        fontFamily: 'Montserrat', color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: MaterialButton(
                      onPressed: () {},
                      color: Color.fromARGB(255, 41, 17, 173),
                      elevation: 1,
                      minWidth: 200,
                      height: 48,
                      child: Text(
                        "Se Connecter",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous n'avez pas de compte ? Créez un compte ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Colors.grey.shade600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: InkWell(
                          onTap: () {},
                          child: Text("ici",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 41, 17, 173))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
