import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';
import '../../../models/message/message_model.dart';
import '../../../models/user/user_model.dart';

class HasuraMessageRepository extends Disposable {
  final HasuraConnect connection;

  HasuraMessageRepository(this.connection);

  Future<MessageModel> sendMessage(String message, int userId) async {
    String query = """
      sendMessage(\$message:String!,\$userId:Int!) {
        insert_messages(objects: {id_user: \$userId, content: \$message}) {
          affected_rows
        }
      }
    """;

    Map<String, dynamic> data = await connection.mutation(query, variables: {
      "message": message,
      "userId": userId,
    });
    Map<String, dynamic> returning = data["data"]["insert_users"]["returning"][0];

    return MessageModel(
      id: returning['id'],
      content: message,
      user: UserModel.fromJson(returning["users"]),
    );
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    connection.dispose();
  }
}
