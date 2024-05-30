// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'dart:io';

// void askForUsername(IO.Socket socket) 
// {
//   stdout.write('Enter your username: ');
//   String? username = stdin.readLineSync();
//   if (username != null && username.isNotEmpty) 
//   {
//     socket.emit('join', {'username': username});
//   } else 
//   {
//     print('Username cannot be empty. Please enter a valid username.\n');
//     askForUsername(socket); // Запитуємо ім'я знову, якщо воно було порожнім
//   }
// }
