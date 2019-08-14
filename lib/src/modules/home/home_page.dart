import 'package:flutter/material.dart';

import '../../shared/models/message/message_model.dart';
import 'home_bloc.dart';
import 'home_module.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _blocMessage = HomeModule.to.bloc<HomeBloc>();
  bool _enableSend = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: StreamBuilder<List<MessageModel>>(
        stream: _blocMessage.messagesController,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].user.name),
                      subtitle: Text(snapshot.data[index].content),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: TextField(
                  controller: _blocMessage.messageTextEditingController,
                  onChanged: (value) {
                    print(_blocMessage.messageTextEditingController.text);
                    setState(() {
                      value.isEmpty ? _enableSend = false : _enableSend = true;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Send'),
                onPressed: _enableSend &&
                        _blocMessage
                            .messageTextEditingController.text.isNotEmpty
                    ? _blocMessage.sendMessage
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
