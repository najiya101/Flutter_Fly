import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Callpage extends StatefulWidget {
  const Callpage({super.key});

  @override
  State<Callpage> createState() => _CallState();
}

class _CallState extends State<Callpage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),color: Colors.green,
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: Text('Call Page',selectionColor: Colors.green,),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(

            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                 onPressed: () async { final url = Uri(scheme: 'tel',path: '1234567890');
                 launchUrl(url);},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Container( width: double.infinity,
                  child: Text('Make a call',textAlign: TextAlign.center,),),
                ),
                SizedBox(height: 16,),
                ElevatedButton(
                 onPressed: ()  async { final GitHub = Uri.parse("https://github.com/najiya101");
                 launchUrl(GitHub);},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Container( width: double.infinity,
                  child: Text('GitHub',textAlign: TextAlign.center,),),
                ),
                SizedBox(height: 16,),
                ElevatedButton(
                 onPressed: () async { final insta = Uri.parse("https://www.instagram.com/cake_my._day?igsh=dXpudWpsYmRtbjd6");
                 launchUrl(insta);},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Container( width: double.infinity,
                  child: Text('Insta',textAlign: TextAlign.center,),),
                ),
              ],
            )
          ))
        
        
      ),
    );
  }
}
