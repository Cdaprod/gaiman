// Gaiman conversation language

Start = statements:statements* {
  return statements;
}

statements = _ statement:(function_definition / if / echo / var /  command ) _ {
   return {"statements": statement}
}

if = _ "if" _ cond:(command / expression) _ "then" _ body:statements* _ next:else_if* _ last:if_rest? "end" _ {
   return {"if": [{"cond": cond, "body": body}].concat(next), "else": last };
}

if_rest = _ "else" _ body:statements* {
   return body
}

else_if = _ "else" _ "if" _ cond:expression _ "then" _ body:statements* {
   return {"if": cond, "body": body}
}

function_call = name _ "(" names:(name _ "," _ ?)* ")" {

}

function_definition = _ "def" _ name:name _ "(" args:(name _ ","? _)* ")" _  body:statements* _ "end" _ {
   var args = args.map(function(arg) { return arg[0]; });
   return {"function": name, args: args, body: body };
}

var = _ "set" _ name:expression _ "=" _ expression:(command / expression) _ {
   return {"set": name, "value": expression };
}

echo = "echo" _ string:string {
  return {"echo": string };
}

string = "\"" ([^"] / "\\\\\"")*  "\"" {
  return JSON.parse(text());
}

expression = expression:(property / function_call / name) {
   return {"expression": expression};
}

command = ask / post / get / match

get = _ "get" _ url:string _ {
  return {"get": url}
}
post = _ "post" _ url:string _ data: object _ {
   return {"post": url, data: data }
}

ask = _ "ask" _ string:(string / property / name ) _ {
   return {"ask": string};
}

match = expression:(property / name) _ "~=" _ re:re _ {
  return { "var": expression, "match": re };
}

object = _ "{" _ props:(object_prop ","?)* _ "}" {
   var props =  props.map(function(prop) { return prop[0]; });
   return {"properties": props}
}

object_prop = _ prop:name _ ":" _ value:expression _  {
  return { prop: prop, value: value };
}

re = "/" re:([^/] / "\\\\/")* "/" flags:[i]* {
   if (flags) {
     return new RegExp(re.join(''), flags.join(''));
   } else {
     return new RegExp(re.join(''));
   }
}
property = struct:name "." prop:name {
   return {"struct": struct, "prop": prop };
}

name = [A-Z_a-z][A-Z_a-z0-9]* { return {'var': text()}; }

_ "whitespace"
  = [ \t\n\r]*