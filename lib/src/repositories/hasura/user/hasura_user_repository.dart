import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../../shared/models/user/user_model.dart';

class HasuraUserRepository extends Disposable {
  final HasuraConnect connection;

  HasuraUserRepository(this.connection);

  Future<UserModel> getUser(String name, String password) async {
    String query = """
      getUser(\$name:String!, \$password:String!){
        users(where: {name: {_eq: \$name}, password: {_eq: \$password}}) {
          name
          id
        }
      }
    """;

    Map<String, dynamic> data = await connection
        .query(query, variables: {"name": name, "password": password});
    if (data["data"]["users"].isEmpty) {
      return null; //createUser(name);
    } else {
      return UserModel.fromJson(data["data"]["users"][0]);
    }
  }

  Future<UserModel> createUser(String name) async {
    String query = """
      mutation createUser(\$name:String!) {
        insert_users(objects: {name: \$name}) {
          returning {
            id
          }
        }
      }
    """;

    Map<String, dynamic> data =
        await connection.mutation(query, variables: {"name": name});
    int id = data["data"]["insert_users"]["returning"][0]["id"];
    return UserModel(id: id, name: name);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    connection.dispose();
  }
}
