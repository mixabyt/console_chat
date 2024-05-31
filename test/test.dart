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


String name1 = "dima";
String name2 = 'pisik2005333333333333333333333333';
String name3 = 'mamke 1088';

Map<String, Map<String, Object>> mapa = 
{
  "client.id": {
                'username': name1,
                "admin": false
                },
  "client.id2": {
                'username': name2,
                "admin": false
                },
  "client.id3": {
                'username': name3,
                "admin": true
                }                 
};

String bigger(String prev, String next)
{
  return prev.length > next.length ? prev : next;
}

String max(Map<String, Map<String, Object>> mapa)
{
  var value = "";
  for (var i in mapa.values)
  {
    value = bigger(value, i['username'] as String); 
  }
  return value;
}





void main()
{
  String value = max(mapa);
  String online_list = '$value';
  for (var i in mapa.values)
  {
    String name = i['username'] as String;
    int name_len = name.length;
    for (int j = 0; j < (value.length - name_len); j++)
    {
      name += " ";
    }
    print(name.length);
    online_list += "-$name                                     ${i['admin']}\n";
  }
  print(online_list);
}