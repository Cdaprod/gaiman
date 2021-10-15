def ask_color()
    echo "Pick color?"
    let color = ask "color? "
    if color ~= /red/i then
      echo "I like red, it reminding me of the sun at sunset"
    else if color ~= /blue/i then
      echo "I like blue, it reminds me of the sky"
    else if color ~= /black/i then
      echo "I like black it reminds me of the darkest night"
    else
      echo "sorry I only know red, blue and black colors"
    end
    echo "Do you want to check another color?"
    let confirm = ask "yes/no? "
    if confirm ~= /yes/i then
      ask_color()
    else
      echo "Ok, have a nice day"
    end
end

let greetings = <<<GREET
                   ____       _
                  / ___| __ _(_)_ __ ___   __ _ _ __
                 | |  _ / _` | | '_ ` _ \ / _` | '_ \
                 | |_| | (_| | | | | | | | (_| | | | |
                  \____|\__,_|_|_| |_| |_|\__,_|_| |_|

                Gaiman Engine
                Copyright (C) 2021 Jakub Jankiewicz <https://jcubic.pl/me>
                Released under GPLv3 license

                GREET

echo greetings
sleep 1000
echo "Welcome stranger, can you tell me what is your name?"

let name = ask "name? "
if name then
  echo "Hi, $name. Welcome to the game generated by Gaiman"
  echo "Do you want to play?"
  let confirm = ask "yes/no? "
  if confirm ~= /yes/i then
    ask_color()
  else
    echo "Ok you can close the tab"
  end
end
