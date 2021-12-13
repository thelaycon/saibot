-- A Lua statistics module
require("math")


-- Computes sum of a table
export sum = (arr) ->
  total = 0
  for i in *arr
    total += i
  return total

-- Counts number of elements in a table
export count = (arr) -> 
  c = 0
  for i in *arr
    c +=1
  return c

-- Calculates the Arithmetic mean
export mean = (arr) ->
  total = sum arr
  len = count arr
  return total / len
  
-- Calculates the Standard Deviation  
export std = (arr) ->
  mean_ = mean(arr)
  xsquared = 0
  for i in *arr
    xs = math.pow i - mean_, 2
    xsquared += xs
  var = xsquared / count arr
  return math.sqrt var

exists_in = (a,arr) ->
  for i in *arr
    if i == a
      return true
  return false

get_keys_values = (arr) ->
  keys = {}
  values = {}
  for i,k in pairs arr
    table.insert keys, i
    table.insert values, k
  return keys, values

-- Calculates mode or return the least of a multi-modal table
export mode = (arr) ->
  track = {}
  mode_table = {} 
  for i in *arr
    if track[i] != nil
      track[i] +=1
    else
      track[i] = 1
      
  keys, values = get_keys_values track
  max_value = math.max unpack values
  
  for i,k in pairs track
    if k == max_value
      table.insert mode_table, i
  
  return math.min unpack mode_table