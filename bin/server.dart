import 'package:socket_io/socket_io.dart';
import "../lib/server_function.dart" show show_history, command_exist, do_command, name_exist;
import "../lib/commands.dart" show commands;



// List<String> commands = ["/help", "/online", '/admin', ];

List <Map<String,String>> chat_history = 
[
  // {"user":'message',}
];

Map<String, Map<String, Object>> users = //TODO
{
  // "client.id": {
  //                 'username': "name",
  //                 "admin": false
  //                }
};




void main() {
  var io = Server();
   

  io.on('connection', (client) 
  {
    print('A user connected: ${client.id}');

    client.on('join', (data) {
      String try_username = data['username'];
      if (name_exist(try_username, users)) // якщо зайняте 
      {
        
        client.emit('nameTaken', {'message': 'This username is already taken. Please choose another one.', 'nickname':try_username});
      } else // Якщо ім'я вільне
      {
        users[client.id] = {'username': try_username, "admin":false};

        client.broadcast.emit("message", "\r$try_username joined to server!");
        client.emit('welcome', {'SENDMESSAGE':show_history(chat_history)});
      }
    });

    client.on("message", (data)
    {
      List<String> message = (data['SENDMESSAGE'] as String).split(" ");
      //оновлення історії
      if (chat_history.length > 100){ chat_history.removeAt(0); }
      
      if (!commands.containsKey(message[0]))
        {chat_history.add({"${users[client.id]!["username"]}" : "${data['SENDMESSAGE']}"});}
      // if (data['SENDMESSAGE'] == "/kick") io.sockets.sockets[client.id].disconnect();
      
      if(command_exist(message[0]))
        { do_command(client, message, users); }
      else 
        { client.broadcast.emit("message", '\r${users[client.id]!['username']}: ${data['SENDMESSAGE']}'); }
      
    });

    client.on('disconnect', (reason) {
      
    client.broadcast.emit("message", "${users[client.id]!['username']} has left.");


    Map<String, Object>? removedUSER = users.remove(client.id);
      if (removedUSER != null) {
        print('User disconnected: $removedUSER');
      } else {
        print('sad');
      }


    });
  });

  io.listen(3002);
  print('Server listening on *:3002');
}
