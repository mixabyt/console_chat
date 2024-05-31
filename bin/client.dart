import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io';

bool awaitingUsername = true;

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
      if(message.isNotEmpty && message.length < 15)
        {socket.emit('join', {'username': message});}
      else 
      {
        print(message.isEmpty ? "Username cannot be empty. Please enter a valid username." : message.length > 15 ? 'Username cannot be longer than 10 symbols. Please enter a valid username.': "");
        stdout.write("Enter your name: ");
      }
      
    }
    else
    {
      socket.emit('message', {'SENDMESSAGE': message,}); // Надсилаємо введене повідомлення на сервер
    }
    
  });
}
