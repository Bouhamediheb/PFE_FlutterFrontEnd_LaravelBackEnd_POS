import 'package:flutter/material.dart';

class ajoutDocument extends StatefulWidget {
  const ajoutDocument({Key key}) : super(key: key);

  @override
  State<ajoutDocument> createState() => _ajoutDocumentState();
}

String dropdownvalue = "Bon de Commande";

class _ajoutDocumentState extends State<ajoutDocument> {
  String DateNow = new DateTime.now().toString().substring(0, 16);
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1950, 1),
      lastDate: DateTime(2021, 12),
      helpText: "",
      cancelText: "Annuler",
      confirmText: "Confirmer",
      builder: (BuildContext context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  TextEditingController numeroDocController = TextEditingController();
  TextEditingController totalDocController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Ajouter Un Nouveau Document",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFFFFFFE),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(120, 50, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Type",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 230, 0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: DropdownButton<String>(
                              onChanged: (newvalue) =>
                                  setState(() => dropdownvalue = newvalue),
                              items: <String>[
                                'DEVIS',
                                'Bon de Commande',
                                'Bon de Livraison',
                                'Ticket',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade600,
                                      )),
                                );
                              }).toList(),
                              focusColor: Colors.white,
                              value: dropdownvalue,
                              alignment: Alignment.center,
                              underline: SizedBox(),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(120, 10, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Numéro",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(100, 10, 100, 0),
                          child: TextFormField(
                            controller: numeroDocController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Numéro de Document',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade400,
                              ),
                              prefixIcon: Icon(Icons.confirmation_num,
                                  color: Colors.grey.shade400),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade200),
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
                        Container(
                          padding: EdgeInsets.fromLTRB(120, 10, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Date",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10, left: 100),
                              child: SizedBox(
                                height: 50,
                                width: 200,
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: DateNow,
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade600,
                                        fontSize: 14),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 20),
                              child: Container(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () => _selectDate(context),
                                  child: Text(
                                    "Sélectionner une Date",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Montserrat',
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      primary: Color(0xFFFFFFFE),
                                      minimumSize: Size(200, 60),
                                      side: BorderSide(
                                          color: Colors.grey.shade400),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20))),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 70, 0, 0),
                          child: Row(
                            children: [
                              Text(
                                "Montant Total :",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 68),
                                child: SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: TextFormField(
                                    controller: totalDocController,
                                    decoration: InputDecoration(
                                      hintText: 'Total',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade400,
                                      ),
                                      prefixIcon: Icon(
                                          Icons.attach_money_outlined,
                                          color: Colors.grey.shade400),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade200),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1,
                                        ),
                                      ),
                                      contentPadding:
                                      EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 280),
                          child: ElevatedButton(
                            onPressed: (() {}),
                            child: Text(
                              "Confirmer",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Color.fromARGB(255, 41, 17, 173),
                                minimumSize: Size(150, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
