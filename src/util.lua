function defineProperties(obj, source, props)
  for _, prop in ipairs(props) do
    assert(source[prop], 'expected '..tostring(prop))
    obj[prop] = source[prop]
  end
end

function round(value)
  return math.floor(value + 0.5)
end