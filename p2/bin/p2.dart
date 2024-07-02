//import 'package:p2/p2.dart' as p2;
class car{
  String? brand;
  String? model;
  int? year;

car(this.brand,this.model,this.year);

 void printDetails() {
    print('Brand: $brand, Model: $model, Year: $year');
  }
}
void main(List<String> arguments) {
  car Car=car('toyota', 'corolla', 2020);
  Car.printDetails();
}
