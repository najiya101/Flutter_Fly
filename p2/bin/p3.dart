class animal{
  void makesound(){
    print('some generic animal sound');
  }
}

class dog extends animal{
  void makesound(){
    print('Bark');
  }
}
void main(List<String> arguments) {
 dog myDog =dog();
 myDog.makesound();
}
