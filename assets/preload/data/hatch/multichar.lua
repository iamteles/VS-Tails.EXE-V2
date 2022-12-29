local a = onBeatHit
function onBeatHit()
  if a then
    a()
  end
  forEachChar(function(char)
    if curBeat % getProperty(char.tag..'.danceEveryNumBeats') == 0 and not stringStartsWith(getProperty(char.tag..'.animation.curAnim.name'), 'sing') and not getProperty(char.tag..'.stunned') then
      local formattedTag = '"'..char.tag:gsub('"', '\\"')..'"'
      runHaxeCode([[
        getVar(]]..formattedTag..[[).dance();
      ]])
    end
  end)
end
local a = onCountdownTick
local loopsLeft = 4
function onCountdownTick(tick)
  if a then
    a(tick)
  end
  forEachChar(function(char)
    if loopsLeft % getProperty(char.tag..'.danceEveryNumBeats') == 0 and not stringStartsWith(getProperty(char.tag..'.animation.curAnim.name'), 'sing') and not getProperty(char.tag..'.stunned') then
      local formattedTag = '"'..char.tag:gsub('"', '\\"')..'"'
      runHaxeCode([[
        getVar(]]..formattedTag..[[).dance();
      ]])
    end
  end)
  loopsLeft = loopsLeft - 1
end
local a = opponentNoteHit
function opponentNoteHit(id, data, type, sus)
  if a then
    a()
  end
  local noteProp = function(what)
    return getPropertyFromGroup('notes', id, what)
  end
  forEachChar(function(char)
    if char.noteType and not char.isPlayer and type == char.noteType and not gfSection then
      
      local altSuffix = noteProp 'animSuffix'
      if altAnim and not gfSection then
        altSuffix = '-alt'
      end
      playAnim(char.tag, singAnimations[data+1] .. altSuffix, true)
      setProperty(char.tag..'.holdTimer', 0)
    end
  end)
end
local a = goodNoteHit
function goodNoteHit(id, data, type, sus)
  if a then
    a()
  end
  local noteProp = function(what)
    return getPropertyFromGroup('notes', id, what)
  end
  forEachChar(function(char)
    if char.noteType and char.isPlayer and type == char.noteType and not gfSection then
      playAnim(char.tag, singAnimations[data+1] .. noteProp 'animSuffix', true)
      setProperty(char.tag..'.holdTimer', 0)
    end
  end)
end
local a = noteMiss
function noteMiss(id, data, type, sus)
  if a then
    a()
  end
  local noteProp = function(what)
    return getPropertyFromGroup('notes', id, what)
  end
  forEachChar(function(char)
    if char.noteType and char.isPlayer and type == char.noteType and not gfSection and getProperty(char.tag..'.hasMissAnimations') then
      playAnim(char.tag, singAnimations[data+1] .. 'miss' .. noteProp 'animSuffix', true)
    end
  end)
end
local a = onCreate
function onCreate()
  if a then
    a()
  end
  local a = playAnim
  function playAnim(...)
    local stuff = {...}
    local obj = stuff[1]
    if not getCharData(obj) then
      return a(...)
    else
      for i,thing in pairs(stuff) do
        if type(thing) == 'string' then 
          stuff[i] = '"'..thing:gsub('"', '\\"')..'"' 
        else 
          stuff[i] = tostring(thing) 
        end
      end
      table.remove(stuff, 1)
      local theSHIT = table.concat(stuff, ', ')
      runHaxeCode([[
        var char = getVar("]]..obj:gsub('"', '\\"')..[[");
        if(char != null)
          char.playAnim(]]..theSHIT..[[);
      ]])
    end
  end
  
end
local a = onCreatePost
function onCreatePost()
  if a then
    a()
  end

  makeChar('egg', 'origin eggman', -300, 100, 'eggnote') --tag, char, x, y, notetype for singing
  setProperty('egg.alpha', 0)
  addChar('egg', true)
end
chars = {}
singAnimations = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}

--char: the characters json name
--x: x
--y: y
--noteType: the noteType needed for the character to play an animation
--isPlayer: isPlayer
function makeChar(tag, char, x, y, noteType, isPlayer)
  x,y,isPlayer = x or 0, y or 0, isPlayer == true
  if not madeCharYet then
    madeCharYet = true
    addHaxeLibrary('Character')
    addHaxeLibrary('Boyfriend')
    runHaxeCode([[
      function startsWith(die, ok)
        return game.luaArray[0].call('stringStartsWith', [die, ok]);
      /*function debugPrint(?txt1, ?txt2, ?txt3, ?txt4, ?txt5)
      {
        var cool = [for(thing in [txt1, txt2, txt3, txt4, txt5]) if(thing != null) thing];
        if(cool.length > 0)
          game.addTextToDebug(cool.join(', '), 0xFFFFFFFF);
      }*/
    ]])
  end
  local formattedChar, formattedTag = '"'..char:gsub('"', '\\"')..'"', '"'..tag:gsub('"', '\\"')..'"'
  runHaxeCode([[
    var char = new Character(]]..table.concat({x, y, formattedChar}, ', ')..[[);
    if(]]..tostring(isPlayer == true)..[[)
      char.flipX = !char.flipX;
    setVar(]]..formattedTag..[[, char);
    char.dance();
  ]])
  for i = 0, getProperty 'unspawnNotes.length' -1 do
    if getPropertyFromGroup('unspawnNotes', i, 'noteType') == noteType and getPropertyFromGroup('unspawnNotes', i, 'mustPress') == isPlayer then
      
      setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
      setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', true)
    end
  end
  for i = 0, getProperty 'notes.length' -1 do
    if getPropertyFromGroup('notes', i, 'noteType') == noteType and getPropertyFromGroup('notes', i, 'mustPress') == isPlayer then
      setPropertyFromGroup('notes', i, 'noAnimation', true)
      setPropertyFromGroup('notes', i, 'noMissAnimation', true)
    end
  end
  table.insert(chars, {tag = tag, noteType = noteType, isPlayer = isPlayer or false})
end
function addChar(tag, onTop)
  if getCharData(tag) and not getCharData(tag).wasAdded then
    local formattedTag = '"'..tag:gsub('"', '\\"')..'"'
    runHaxeCode([[
      var tag:String = ]]..formattedTag..[[;
      var onTop:Bool = ]]..tostring(onTop == true)..[[;
      if(getVar(tag) != null)
      {
        if(onTop)
          game.add(getVar(tag));
        else
        {
          var position:Int = game.members.indexOf(game.gfGroup);
    			if(game.members.indexOf(game.boyfriendGroup) < position) {
    				position = game.members.indexOf(game.boyfriendGroup);
    			} else if(game.members.indexOf(game.dadGroup) < position) {
    				position = game.members.indexOf(game.dadGroup);
    			}
    			game.insert(position, getVar(tag));
        }
      }
    ]])
    getCharData(tag).wasAdded = true
  end
end
function removeChar(tag, destroy)
  forEachChar(function(char, i)
    if char.tag == tag then
      if destroy then
        runHaxeCode([[
          var char:Character = getVar("]]..char.tag:gsub('"', '\\"')..[[");
          char.kill();
          char.destroy();
        ]])
        table.remove(chars, i)
      else
        runHaxeCode([[
          var char:Character = getVar("]]..char.tag:gsub('"', '\\"')..[[");
          game.remove(char);
        ]])
        char.wasAdded = false
      end
      for i = 0, getProperty 'unspawnNotes.length' -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == char.noteType and getPropertyFromGroup('unspawnNotes', i, 'mustPress') == char.isPlayer then
          setPropertyFromGroup('unspawnNotes', i, 'noAnimation', false)
          setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', false)
        end
      end
      for i = 0, getProperty 'notes.length' -1 do
        if getPropertyFromGroup('notes', i, 'noteType') == char.noteType and getPropertyFromGroup('notes', i, 'mustPress') == char.isPlayer then
          setPropertyFromGroup('notes', i, 'noAnimation', false)
          setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', false)
        end
      end
    end
  end)  
end
--repeats a function for each char
function forEachChar(what)
  for k,v in pairs(chars) do
    what(v, k)
  end
end
function getCharData(tag)
  local idiot;
  forEachChar(function(char, id)
    if tag == char.tag then
      idiot = char
    end
  end)
  return idiot
end

function onStepHit()

  if curStep == 896 then
    setProperty('egg.alpha', 1)
  end
end