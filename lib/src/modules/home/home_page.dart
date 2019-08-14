import 'package:flutter/material.dart';

import '../../shared/models/message/message_model.dart';
import '../../shared/widgets/stream_input_field.dart';
import 'home_bloc.dart';
import 'home_module.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = HomeModule.to.bloc<HomeBloc>();
  final _messageTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: StreamBuilder<List<MessageModel>>(
        stream: _bloc.messagesController,
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
              StreamInputField(
                hint: "Message",
                obscure: false,
                stream: _bloc.streamMessage,
                onChanged: _bloc.changeMessage,
                controller: _messageTextEditingController,
              ),
              RaisedButton(
                child: Text('Send'),
                onPressed: () {
                  _bloc.sendMessage();
                  _messageTextEditingController.text = '';
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
