import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../../shared/models/message/message_model.dart';

class HasuraMessageRepository extends Disposable {
  final HasuraConnect connection;

  HasuraMessageRepository(this.connection);

  Stream<List<MessageModel>> getMessages() {
    var query = """
      subscription {
        messages(order_by: {id: desc}) {
          content
          id
          user {
            name
            id
          }
        }
      }
    """;

    Snapshot snapshot = connection.subscription(query);
    return snapshot.stream.map(
      (jsonList) => MessageModel.fromJsonList(jsonList["data"]["messages"]),
    );
  }

  Future<dynamic> sendMessage({String message, int userId}) {
    var query = """
      sendMessage(\$message:String!,\$userId:Int!) {
        insert_messages(objects: {id_user: \$userId, content: \$message}) {
          affected_rows
        }
      }
    """;

    return connection.mutation(query, variables: {
      "message": message,
      "userId": userId,
    });
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    connection.dispose();
  }
}
