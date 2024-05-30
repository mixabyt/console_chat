
import 'dart:io';

void main() async {
  
  String command1 = 'echo server: && echo: && dart run server.dart';
  String command2 = 'echo client1 && echo: && dart run client.dart';
  String command3 = 'echo client2 && echo: && dart run client.dart';

  // ignore: unused_local_variable
  Process server = await Process.start(
    'cmd',
    ['/c', 'start', 'cmd', '/k', command1],
    runInShell: true,
  );

  // ignore: unused_local_variable
  Process client1 = await Process.start(
    'cmd',
    ['/c', 'start', 'cmd', '/k', command2],
    runInShell: true,
  );

  // ignore: unused_local_variable
  Process client2 = await Process.start(
    'cmd',
    ['/c', 'start', 'cmd', '/k', command3],
    runInShell: true,
  );

  
}
