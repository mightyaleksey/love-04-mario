local Keys = {
  _alias = {},
  _state = {}
}

--[[ helpers ]]

function Keys.setAlias(keyA, keyB)
  Keys._alias[keyA] = keyB
end

function Keys.wasPressed(key)
  if
    Keys._alias[key] ~= nil and
    Keys._state[Keys._alias[key]]
  then
    return true
  end

  return Keys._state[key] == true
end

--[[ hooks ]]

function Keys.keypressed(key)
  Keys._state[key] = true
end

function Keys.keyreleased(key)
  Keys._state[key] = nil
end

function Keys.update()
end

return Keys