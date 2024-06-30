local Keys = {
  _alias = {},
  -- keeps information about keys that were checked for the "pressed" state
  -- so we can update its state on the next tick
  _checked = {},

  -- keeps keyboard state
  _holding = {},
  _pressed = {}
}

local function wasHolding(key)
  return Keys._holding[key] == true
end

local function wasPressed(key, originalKey)
  if Keys._pressed[key] == true then
    Keys._checked[originalKey] = true
    return true
  end

  return false
end

--[[ helpers ]]

function Keys.setAlias(keyA, keyB)
  Keys._alias[keyA] = keyB
end

function Keys.wasHolding(key)
  return wasHolding(key) or wasHolding(Keys._alias[key])
end

function Keys.wasPressed(key)
  return wasPressed(key, key) or wasPressed(Keys._alias[key], key)
end

--[[ hooks ]]

function Keys.keypressed(key)
  Keys._holding[key] = true
  Keys._pressed[key] = true
end

function Keys.keyreleased(key)
  Keys._holding[key] = nil
  Keys._pressed[key] = nil
end

function Keys.update()
  for key in pairs(Keys._checked) do
    Keys._pressed[key] = nil
  end

  for originalKey, key in pairs(Keys._alias) do
    if Keys._checked[originalKey] then
      Keys._pressed[key] = nil
    end
  end
end

return Keys