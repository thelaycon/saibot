require("math")
sum = function(arr)
  local total = 0
  for _index_0 = 1, #arr do
    local i = arr[_index_0]
    total = total + i
  end
  return total
end
count = function(arr)
  local c = 0
  for _index_0 = 1, #arr do
    local i = arr[_index_0]
    c = c + 1
  end
  return c
end
mean = function(arr)
  local total = sum(arr)
  local len = count(arr)
  return total / len
end
std = function(arr)
  local mean_ = mean(arr)
  local xsquared = 0
  for _index_0 = 1, #arr do
    local i = arr[_index_0]
    local xs = math.pow(i - mean_, 2)
    xsquared = xsquared + xs
  end
  local var = xsquared / count(arr)
  return math.sqrt(var)
end
local exists_in
exists_in = function(a, arr)
  for _index_0 = 1, #arr do
    local i = arr[_index_0]
    if i == a then
      return true
    end
  end
  return false
end
local get_keys_values
get_keys_values = function(arr)
  local keys = { }
  local values = { }
  for i, k in pairs(arr) do
    table.insert(keys, i)
    table.insert(values, k)
  end
  return keys, values
end
mode = function(arr)
  local track = { }
  local mode_table = { }
  for _index_0 = 1, #arr do
    local i = arr[_index_0]
    if track[i] ~= nil then
      track[i] = track[i] + 1
    else
      track[i] = 1
    end
  end
  local keys, values = get_keys_values(track)
  local max_value = math.max(unpack(values))
  for i, k in pairs(track) do
    if k == max_value then
      table.insert(mode_table, i)
    end
  end
  return math.min(unpack(mode_table))
end
