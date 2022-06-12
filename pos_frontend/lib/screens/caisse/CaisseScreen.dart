import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Caisse extends StatefulWidget {
  Caisse({Key? key}) : super(key: key);

  @override
  State<Caisse> createState() => _CaisseState();
}

class _CaisseState extends State<Caisse> {
  int selectedTable = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF331f61),
          elevation: 0,
          centerTitle: false,
          actions: [
            Text(
              "Table : $selectedTable / 20",
              style: TextStyle(fontSize: 16),
            ),
          ]),
      backgroundColor: Color(0xFF331f61),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: 100,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF462c86),
                                  fixedSize: Size(50, 50),
                                  shape: CircleBorder(),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedTable = index++;
                                  });
                                },
                                child: Text("${index = index + 1}")),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: 450,
                  width: 275,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF462c86),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "Produits",
                            style: TextStyle(
                                color: Color(0xFFac98de),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {},
                          child: Text("Boissons",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFe9d8ff),
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {},
                          child: Text("Aliments",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFe9d8ff),
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {},
                          child: Text("Viennoiserie",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFe9d8ff),
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    width: 275,
                    height: 410,
                    decoration: BoxDecoration(
                      color: Color(0xFF462c86),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 20),
            child: Container(
              width: 1000,
              decoration: BoxDecoration(
                color: Color(0xFF462c86),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 20),
              child: Container(
                width: 450,
                height: 500,
                decoration: BoxDecoration(
                  color: Color(0xFF462c86),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
