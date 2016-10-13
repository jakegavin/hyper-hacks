-- Add unpack function
function unpack(table, index)
  index = index or 1
  if table[index] ~= nil then
    return table[index], unpack(table, index + 1)
  end
end

-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, 'F17')

-- Enter Hyper Mode when F18 (Hyper) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)


-- Symbols Layer
-- .-----------------------------------------------------------------------------------.
-- |      |      |      |      |      |      |      |      |      |      |      |      |
-- |------+------+------+------+------+------+------+------+------+------+------+------|
-- |      |      |      |      |  \   |  +   |  -   |  /   |      |      |      |      |
-- |------+------+------+------+------+-------------+------+------+------+------+------|
-- |      |  <   |  {   |  [   |  (   |  =   |  _   |  )   |  ]   |  }   |  >   |  `   |
-- |------+------+------+------+------+------|------+------+------+------+------+------|
-- |      |      |      |      |  <   |      |  |   |  >   |      |      |      |      |
-- `-----------------------------------------------------------------------------------'

symbolsTable = {
  {'a', {{'shift'}, ','}},
  {'s', {{'shift'}, '['}},
  {'d', {{}, '['}},
  {'f', {{'shift'}, '9'}},
  {'g', {{}, '='}},
  {'h', {{'shift'}, '-'}},
  {'j', {{'shift'}, '0'}},
  {'k', {{}, ']'}},
  {'l', {{'shift'}, ']'}},
  {';', {{'shift'}, '.'}},
  {"'", {{}, '`'}},
  {'r', {{}, '\\'}},
  {'u', {{}, '/'}},
  {'v', {{'shift'}, ','}},
  {'m', {{'shift'}, '.'}},
  {'n', {{'shift'}, '\\'}},
  {'t', {{'shift'}, '='}},
  {'y', {{}, '-'}},
}

for i, keyTable in ipairs(symbolsTable) do
  k:bind(
    {},
    keyTable[1],
    function()
      hs.eventtap.keyStroke(unpack(keyTable[2]))
      k.triggered = true
    end
  )
end


-- Sequential keybindings
a = hs.hotkey.modal.new({}, "F16")

pressedA = function()
  a:enter()
end

releasedA = function()
end

k:bind({}, 'return', pressedA, releasedA)

-- Launch function
launch = function(appname)
  hs.application.launchOrFocus(appname)
  k.triggered = true
end

-- Launch apps with Hyper-Enter
apps = {
  {'a', 'Atom'},
  {'c', 'Google Chrome'},
  {'m', 'Spotify'},
  {'s', 'Slack'},
  {'t', 'iTerm'},
}

for i, app in ipairs(apps) do
  a:bind(
    {},
    app[1],
    function()
      launch(app[2])
      a:exit()
    end
  )
end

-- Exit launch mode with enter
a:bind(
  {},
  'return',
  function()
    a:exit()
  end
)
