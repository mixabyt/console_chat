// chat history
import 'dart:async';
import 'dart:io';

List <Map<String,String>> chat_history = 
[
  // {"user":'message',}
];

void show_history(chat_history)
{
  String message = ''; 
  for (Map<String,String> i in chat_history)
  {
    message = message + "${i.keys.first}: ${i.values.first}\n";
  }
}

void main()
{
  int counter = 0;
  
  while (true)
  {
    if (chat_history.length > 10){ chat_history.removeAt(0); }
    
    chat_history.add({"user" : "message$counter"});
    counter++;
    print('\n');
    show_history(chat_history);
    sleep(Duration(milliseconds: 1000));
  }
  
}