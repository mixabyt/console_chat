import 'commands.dart' show commands;




String show_history(List <Map<String,String>> chat_history)
{
  String message = ''; 
  for (Map<String,String> i in chat_history)
  {
    message = message + "${i.keys.first}: ${i.values.first}\n";
  }
  return message;
}

bool command_exist(Map<String,dynamic> data)
{
  for (String i in commands.keys)
  {
    if (data["SENDMESSAGE"] == i) return true;
  }
  if (data["SENDMESSAGE"] == "/admin fominvic1488") return true;// ?todo
  return false;
}

void do_command(var client, var data,Map <String, String> users, bool admin)
{
  switch(data['SENDMESSAGE'])
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
      for (String i in users.values)
      {onlinelist = "$onlinelist-$i\n";}
      onlinelist += '---------------------------------------------------';
      client.emit("message", onlinelist);
      break;
    
    case '/admin':
      client.emit("message", (admin ? "you are admin" : "you are't admin"));
      break;
    
    case '/admin fominvic1488':
      client.emit("becomeAdmin", {});
      client.emit('message',"you are admin now!");
      break;

  }
  
}
