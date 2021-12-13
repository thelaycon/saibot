-- A Lua statistics module
require("math")


-- Computes sum of a table
export sum = (arr) ->
  total = 0
  for i in *arr
    total += i
  return total

-- Calculates the Arithmetic mean
export mean = (arr) ->
  total = 0
  total = sum arr
  return total / #arr
  
-- Calculates variance
export var = (arr) ->
  mean_ = mean(arr)
  xsquared = 0
  for i in *arr
    xs = math.pow i - mean_, 2
    xsquared += xs
  return xsquared / #arr
  
-- Calculates the Standard Deviation  
export std = (arr) ->
  return math.sqrt var(arr)

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
  
-- Calculates the median of a list
export median = (arr) ->
  table.sort arr
  if #arr%2 != 0
    return arr[#arr/2 + 0.5]
  else
    return (arr[#arr/2] + arr[#arr/2 + 1])/ 2
    
-- Calculates range
export range = (arr) ->
  return math.max(unpack arr) - math.min(unpack arr)

-- Calculates Pearson Correlation between two Random Variables
export corr = (xarr, yarr) ->
  xmean = mean xarr
  ymean = mean yarr
  xdev_ydev = 0
  xdev2_ydev2 = 0
  if #xarr == #yarr
    xdev_ydev =  sum [(xarr[i] - xmean)*(yarr[i] - ymean) for i=1,#xarr]
    xdev2 = sum [(xarr[i] - xmean)^2 for i=1,#xarr]
    ydev2 = sum [(yarr[i] - ymean)^2 for i=1,#yarr]
    xdev2_ydev2 = xdev2 * ydev2
  else
    print "Error: Both Variables must have equal length."
  return xdev_ydev / (math.sqrt xdev2_ydev2)
  
-- Simple linear regression model class
export class LinearRegression
  new: (xarr, yarr) =>
    @xarr = xarr
    @yarr = yarr
    @xmean = mean @xarr
    @ymean = mean @yarr
    
  find_b1: =>
    xdev_ydev =  sum [(@xarr[i] - @xmean)*(@yarr[i] - @ymean) for i=1,#@xarr]
    xdev2 = sum [(@xarr[i] - @xmean)^2 for i=1,#@xarr]
    return xdev_ydev / xdev2
  
  find_b0: =>
    return @ymean - (@find_b1()*@xmean)
  
  predict: (x) =>
    if #@xarr != #@yarr
      print "Error: Both Variables must have equal length."
    else
      return @find_b0() + (@find_b1()*x)
  
