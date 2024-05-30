import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io';

bool awaitingUsername = true;
bool admin = false;
void main() 
{
  IO.Socket socket = IO.io('http://localhost:3002', <String, dynamic>
  {
    'transports': ['websocket'],
  });

  socket.on("connect", (_)
  {
    print("Connected to server!");
    stdout.write('Enter your username: ');
  });
  socket.on("nameTaken", (data)
  {
    print('username "${data["nickname"]}" is taken.');
    stdout.write('Enter your username: ');
  });
  
  socket.on("welcome", (data)
  {
    awaitingUsername = false;
    print("Welcome to server!");
    print(data['SENDMESSAGE']);
  });

  socket.on("becomeAdmin", (data)
  {
    admin = true;
  });

  socket.on("message", (data)
  {
    if (awaitingUsername) return;
    print(data);
  });
  
  

  socket.on('disconnect', (_) {
    print('Disconnected from server');
  });



  stdin.listen((data) 
  {
    stdout.write('\r');
    String message = String.fromCharCodes(data).trim(); // Перетворюємо введення у рядок і обрізаємо зайві пробіли
    if(awaitingUsername)
    {
      if(message.isNotEmpty)
        {socket.emit('join', {'username': message});}
      else 
      {
        print("Username cannot be empty. Please enter a valid username.");
        stdout.write("Enter your name: ");
      }
      
    }
    else
    {
      socket.emit('message', {'SENDMESSAGE': message, "ADMIN": admin}); // Надсилаємо введене повідомлення на сервер
    }
    
  });
}
