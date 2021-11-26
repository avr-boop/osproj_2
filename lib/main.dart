import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SmsQuery query = new SmsQuery();
  List<SmsMessage> allmessages;

  @override
  void initState() {
    getAllMessages();
    super.initState();
  }

  void getAllMessages() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      List<SmsMessage> messages = await query.querySms(
        kinds: [SmsQueryKind.Inbox, SmsQueryKind.Sent, SmsQueryKind.Draft],
        count: 1000,
      );

      setState(() {
        allmessages = messages;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SMS Fetch"),
          backgroundColor: Colors.deepOrangeAccent,
          shadowColor: Colors.blueGrey,
          elevation: 5.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(5),
            child: allmessages == null
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.deepOrangeAccent,
                  ))
                : Column(
                    children: allmessages.map((messageone) {
                    return Container(
                      child: Card(
                          child: ListTile(
                        leading: Icon(Icons.message_rounded),
                        title: Padding(
                            child: Text(messageone.address),
                            padding: EdgeInsets.only(bottom: 5, top: 5)),
                        subtitle: Padding(
                            child: Text(messageone.body),
                            padding: EdgeInsets.only(bottom: 5, top: 5)),
                      )),
                    );
                  }).toList()),
          ),
        ));
  }
}
