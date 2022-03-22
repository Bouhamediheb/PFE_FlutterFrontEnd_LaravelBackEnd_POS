import 'package:admin/screens/fonctionalite/DocumentScreen/Screen/ajouterunDct.dart';
import 'package:admin/screens/main/TestScreen.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../main/main_screen.dart';

class ChoixDocument extends StatefulWidget {
  const ChoixDocument({Key key}) : super(key: key);

  @override
  State<ChoixDocument> createState() => _ChoixDocumentState();
}

class _ChoixDocumentState extends State<ChoixDocument> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Choississez le type de document souhaité",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    width: 240,
                    height: 200,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MainScreen(ajouterUnDocument(1))));
                      },
                      child: Container(
                          height: 110,
                          child: Column(
                            children: [
                              Container(
                                  padding:
                                      EdgeInsets.all(defaultPadding * 0.75),
                                  height: 60,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "../../../../../assets/images/commande.png"),
                                    ),

                                    //color: Colors.grey[300],
                                    // borderRadius: BorderRadius.circular(20.0),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Bon de commande ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  )),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 240,
                    height: 200,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ajouterUnDocument(2)));
                      },
                      child: Container(
                          height: 110,
                          child: Column(
                            children: [
                              Container(
                                  padding:
                                      EdgeInsets.all(defaultPadding * 0.75),
                                  height: 60,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "../../../../../assets/images/livraison.png"),
                                    ),

                                    //color: Colors.grey[300],
                                    // borderRadius: BorderRadius.circular(20.0),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Bon de livraison ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  )),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 200,
                    width: 240,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ajouterUnDocument(3)));
                      },
                      child: Container(
                          height: 110,
                          child: Column(
                            children: [
                              Container(
                                  padding:
                                      EdgeInsets.all(defaultPadding * 0.75),
                                  height: 60,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "../../../../../assets/images/commande.png"),
                                    ),

                                    //color: Colors.grey[300],
                                    // borderRadius: BorderRadius.circular(20.0),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Bon de retour ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  )),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 200,
                    width: 240,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ajouterUnDocument(4)));
                      },
                      child: Container(
                          height: 110,
                          child: Column(
                            children: [
                              Container(
                                  padding:
                                      EdgeInsets.all(defaultPadding * 0.75),
                                  height: 60,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "../../../../../assets/images/commande.png"),
                                    ),

                                    //color: Colors.grey[300],
                                    // borderRadius: BorderRadius.circular(20.0),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Devis commercial ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  )),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(height: 90),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    width: 240,
                    height: 200,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ajouterUnDocument(5)));
                      },
                      child: Container(
                          height: 110,
                          child: Column(
                            children: [
                              Container(
                                  padding:
                                      EdgeInsets.all(defaultPadding * 0.75),
                                  height: 60,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "../../../../../assets/images/commande.png"),
                                    ),

                                    //color: Colors.grey[300],
                                    // borderRadius: BorderRadius.circular(20.0),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Bon de commande ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  )),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 200,
                    width: 240,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ajouterUnDocument(6)));
                      },
                      child: Container(
                          height: 110,
                          child: Column(
                            children: [
                              Container(
                                  padding:
                                      EdgeInsets.all(defaultPadding * 0.75),
                                  height: 60,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "../../../../../assets/images/livraison.png"),
                                    ),

                                    //color: Colors.grey[300],
                                    // borderRadius: BorderRadius.circular(20.0),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Bon de livraison ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  )),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 200,
                    width: 240,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ajouterUnDocument(7)));
                      },
                      child: Container(
                          height: 110,
                          child: Column(
                            children: [
                              Container(
                                  padding:
                                      EdgeInsets.all(defaultPadding * 0.75),
                                  height: 60,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "../../../../../assets/images/commande.png"),
                                    ),

                                    //color: Colors.grey[300],
                                    // borderRadius: BorderRadius.circular(20.0),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Bon de retour ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  )),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 200,
                    width: 240,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ajouterUnDocument(8)));
                      },
                      child: Container(
                          height: 110,
                          child: Column(
                            children: [
                              Container(
                                  padding:
                                      EdgeInsets.all(defaultPadding * 0.75),
                                  height: 60,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "../../../../../assets/images/commande.png"),
                                    ),

                                    //color: Colors.grey[300],
                                    // borderRadius: BorderRadius.circular(20.0),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Devis commercial ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  )),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
Text(
                "Choississez le type de document souhaité",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              
              
*/