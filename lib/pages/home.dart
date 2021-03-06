import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  Map data = {};

  @override
  Widget build(BuildContext context) {
    
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    String bgImage = data['isDaytime'] ? 'day.jpg' : 'night.jpg';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 180.0, 0.0, 0.0),
          child: Column(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                    'time': result['time'],
                    'location': result['location'],
                    'isDaytime': result['isDaytime'],
                    'flag': result['flag'],
                    };
                  });
                },
                label: Text(
                  'Edit location',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 16.0,
                  ),
                ),
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0,),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 66.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}