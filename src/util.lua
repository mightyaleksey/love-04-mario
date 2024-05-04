function defineProperties(obj, source, props)
  for _, prop in ipairs(props) do
    assert(source[prop], 'expected '..tostring(prop))
    obj[prop] = source[prop]
  end
end

--[[ math ]]

function round(value)
  return math.floor(value + 0.5)
end

--[[ table ]]

function findIndex(collection, predicate, startIndex)
  assert(type(predicate) == 'function')

  for index = startIndex or 1, #collection do
    if predicate(collection[index]) then
      return index
    end
  end

  return -1
end

function findLastIndex(collection, predicate, startIndex)
  assert(type(predicate) == 'function')

  for index = startIndex or #collection, 1, -1 do
    if predicate(collection[index]) then
      return index
    end
  end

  return -1
end

function findKey(collection, predicate)
  assert(type(predicate) == 'function')

  for key, elem in pairs(collection) do
    if predicate(elem) then
      return key
    end
  end

  return nil
end

function includes(collection, elem)
  for _, a in ipairs(collection) do
    if a == elem then
      return true
    end
  end

  return false
end

--[[ collisions ]]

function collides(left, right)
  if
    -- horizontal
    left.x > right.x + right.width or
    left.x + left.width < right.x
  then
    return false
  end

  if
    -- vertical
    left.y > right.y + right.height or
    left.y + left.height < right.y
  then
    return false
  end

  return true
end