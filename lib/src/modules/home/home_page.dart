import 'package:flutter/material.dart';

import '../../models/message/message_model.dart';
import 'home_bloc.dart';
import 'home_module.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = HomeModule.to.bloc<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: StreamBuilder<List<MessageModel>>(
        stream: bloc.messagesController,
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
                padding: const EdgeInsets.fromLTRB(5,0,5,5),
                child: TextField(
                  controller: bloc.messageTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: bloc.sendMessage,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
