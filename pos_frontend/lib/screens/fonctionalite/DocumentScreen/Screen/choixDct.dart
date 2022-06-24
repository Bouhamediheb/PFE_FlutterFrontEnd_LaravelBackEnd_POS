import 'package:projetpfe/screens/fonctionalite/DocumentScreen/Screen/ajouterunDct.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../main/main_screen.dart';
import 'ajouterunDctFrs.dart';

class ChoixDocument extends StatefulWidget {
  const ChoixDocument({Key? key}) : super(key: key);

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
              const Text(
                "Choississez le type de document souhaité",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Divider(
                    thickness: 2,
                  ),
                  Container(
                    width: 240,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen(
                                    ajouterUnDocument2(1, 'BON DE COMMANDE'))));
                      },
                      child: SizedBox(
                          height: 110,
                          child: Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(
                                      defaultPadding * 0.75),
                                  height: 60,
                                  width: 80,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "../../../../../assets/images/commande.png"),
                                    ),

                                    //color: Colors.grey[300],
                                    // borderRadius: BorderRadius.circular(20.0),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Bon de commande ",
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
                  const SizedBox(height: 2),
                  Container(
                    width: 240,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen(
                                    ajouterUnDocument(2, 'BON DE LIVRAISON'))));
                      },
                      child: SizedBox(
                          height: 110,
                          child: Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(
                                      defaultPadding * 0.75),
                                  height: 60,
                                  width: 80,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "../../../../../assets/images/livraison.png"),
                                    ),

                                    //color: Colors.grey[300],
                                    // borderRadius: BorderRadius.circular(20.0),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Bon de livraison ",
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
                  const SizedBox(height: 5),
                  Container(
                    height: 200,
                    width: 240,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen(
                                    ajouterUnDocument2(3, 'BON DE RETOUR'))));
                      },
                      child: SizedBox(
                          height: 110,
                          child: Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(
                                      defaultPadding * 0.75),
                                  height: 60,
                                  width: 80,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "../../../../../assets/images/commande.png"),
                                    ),

                                    //color: Colors.grey[300],
                                    // borderRadius: BorderRadius.circular(20.0),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Bon de retour ",
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
                  const SizedBox(height: 5),
                  Container(
                    height: 200,
                    width: 240,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ajouterUnDocument(4, 'DEVIS')));
                      },
                      child: SizedBox(
                          height: 110,
                          child: Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(
                                      defaultPadding * 0.75),
                                  height: 60,
                                  width: 80,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "../../../../../assets/images/commande.png"),
                                    ),

                                    //color: Colors.grey[300],
                                    // borderRadius: BorderRadius.circular(20.0),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Devis commercial ",
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
              const SizedBox(
                width: 15,
              ),
              const SizedBox(height: 20),
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