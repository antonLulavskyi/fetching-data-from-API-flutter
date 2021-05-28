import 'package:flutter/material.dart';
import 'Service.dart';
import 'Users.dart';

void main() => runApp(MyApp());



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<User> _users;
  bool _loading = true;


  @override
  void initState() {
    super.initState();
    Service.getUsers().then((users) {
      setState(() {
        _users = users;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(_loading ? 'Loading...': 'Users'),
        ),
        body: Center(
          child: Container(
            color: Colors.white,
            child: Center(
              child: !_loading ? ListView.builder(
                  itemCount: null == _users ? 0 : _users.length,
                  itemBuilder: (context, index) {
                    User user = _users[index];
                    return ListTile(
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User id: ${user.id}', style: TextStyle(
                            fontSize: 8.0,
                            fontWeight: FontWeight.w100,
                            color: Colors.grey,
                          ),),
                          Text(user.name),
                        ]

                      ),

                      subtitle: Text(user.email),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Company Name', style: TextStyle(
                            fontSize: 8.0,
                            fontWeight: FontWeight.w100,
                            color: Colors.grey,
                          ),),
                          Text(user.company.name),
                        ],
                      )
                    );
                  }
              ) : CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}

