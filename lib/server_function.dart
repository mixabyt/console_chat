import 'commands.dart' show commands;
import 'password.dart' show hashPassword;

bool name_exist(final String name, Map<String, Map<String, Object>> users)
{
  for (var i in users.values)
  {
    if(i["username"] == name) return true;
  }
  return false;
}


String show_history(List <Map<String,String>> chat_history)
{
  String message = ''; 
  for (Map<String,String> i in chat_history)
  {
    message = message + "${i.keys.first}: ${i.values.first}\n";
  }
  return message;
}

bool command_exist(String data)
{
  for (String i in commands.keys)
  {
    if (data == i) return true;
  }
  // ?todo
  return false;
}




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


void do_command(var client, List<String> data, Map<String, Map<String, Object>> users)
{
  
  switch(data[0]) 
  {
    case '/help':
      String helplist = '---------------------------------------------------\n';
      for (String i in commands.keys)
      {helplist += "$i - ${commands[i]}\n";}
      helplist += '---------------------------------------------------';
      client.emit("message", helplist);
      break;
    
    case '/online':
      String onlinelist = '---------------------------------------------------\n';

      
      String value = max(users);
      
      for (var i in users.values)
      {
        String name = i['username'] as String;
        int name_len = name.length;
        for (int j = 0; j < (value.length - name_len); j++)
        {
          name += " ";
        }
        onlinelist += "-$name                                     ${i['admin']as bool?"admin":""}\n";
      }

        onlinelist += '---------------------------------------------------';
        client.emit("message", onlinelist);
  
      break;
    
    case '/admin':
      if (data.length > 1)
      {
        String password = hashPassword(data[1]);
        if (password == '93d95e07afde65f61b4f08859e72d994a1a2c9982269f741d3bf375419bbd10a')
        {
          client.emit("message", 'you are admin now!');
          users[client.id]!["admin"] = true;
          break;
        }
        else 
        {
          client.emit("message", 'wrong password!');
          break;
        }
      }
      client.emit("message", ((users[client.id]!["admin"] as bool) ? "you are admin" : "you are't admin"));
      
      break;
      

  }
  
}
