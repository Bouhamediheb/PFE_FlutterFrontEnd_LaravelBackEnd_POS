class LineItem {
  final String description;
  final double cost;

  LineItem(this.description, this.cost);
}

class Invoice {
  final String customer;
  final String address;
  final String name;
  final List<LineItem> items;
  Invoice({
    required this.customer,
    required this.address,
    required this.items,
    required this.name,
  });
  double totalCost() {
    return items.fold(
        0, (previousValue, element) => previousValue + element.cost);
  }

  List listeInvoice = [
    Invoice(
      customer: 'Iheb',
      address: '1234 Main St',
      items: [
        LineItem(
          'Laptop',
          1000,
        ),
        LineItem(
          'Mouse',
          100,
        ),
        LineItem(
          'Keyboard',
          100,
        ),
      ],
      name: 'Iheb',
    ),
  ];
}
