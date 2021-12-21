local saibot = require("..saibot")
saibot = saibot.saibot
local mytests = { }
mytests.test_mean = function()
  local arr = {
    1,
    2,
    3
  }
  return assert(saibot.mean(arr) == 2)
end
mytests.test_mode = function()
  local arr = {
    1,
    2,
    2,
    3
  }
  assert(saibot.mode(arr) == 2)
  arr = {
    1,
    2,
    3
  }
  return assert(saibot.mode(arr) == 1)
end
mytests.test_median = function()
  local arr = {
    1,
    3,
    2
  }
  assert(saibot.median(arr) == 2)
  arr = {
    1,
    2,
    5,
    3
  }
  return assert(saibot.median(arr) == 2.5)
end
mytests.test_sum = function()
  local arr = {
    1,
    2,
    3
  }
  return assert(saibot.sum(arr) == 6)
end
mytests.test_variance = function()
  local arr = {
    5,
    9,
    16,
    17,
    18
  }
  return assert(saibot.var(arr) == 26.0)
end
mytests.test_std = function()
  local arr = {
    5,
    9,
    16,
    17,
    18
  }
  return assert(math.floor(saibot.std(arr)) == 5.0)
end
mytests.test_range = function()
  local arr = {
    1,
    2,
    3,
    4,
    5
  }
  return assert(saibot.range(arr) == 4)
end
mytests.test_corr = function()
  local xarr = {
    7.43,
    7.48,
    8.00,
    7.75,
    7.60,
    7.63,
    7.68,
    7.67,
    7.59,
    8.07,
    8.03,
    8.00
  }
  local yarr = {
    221,
    222,
    226,
    225,
    224,
    223,
    223,
    226,
    226,
    235,
    233,
    241
  }
  local corr = saibot.corr(xarr, yarr)
  return assert(string.format("%.3f", corr) == "0.815")
end
return mytests
