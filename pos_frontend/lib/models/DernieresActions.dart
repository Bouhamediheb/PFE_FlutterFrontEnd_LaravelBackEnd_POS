// ignore_for_file: non_constant_identifier_names, file_names
// ignore_for_file: camel_case_types
class DerniereAction {
  final String? icon, nomActivite, date, nomPersonne;

  DerniereAction({this.icon, this.nomActivite, this.date, this.nomPersonne});
}

List DernieresActions = [
  for (var i = 0; i < 10; i++)
    DerniereAction(
      icon: "assets/icons/unknown.svg",
      nomActivite: "Bon de commande",
      date: "14/03/2022",
      nomPersonne: "Karim Hachicha",
    ),
];
