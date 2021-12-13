require("math")
sum = function(arr)
  local total = 0
  for _index_0 = 1, #arr do
    local i = arr[_index_0]
    total = total + i
  end
  return total
end
mean = function(arr)
  local total = 0
  total = sum(arr)
  return total / #arr
end
var = function(arr)
  local mean_ = mean(arr)
  local xsquared = 0
  for _index_0 = 1, #arr do
    local i = arr[_index_0]
    local xs = math.pow(i - mean_, 2)
    xsquared = xsquared + xs
  end
  return xsquared / #arr
end
std = function(arr)
  return math.sqrt(var(arr))
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
median = function(arr)
  table.sort(arr)
  if #arr % 2 ~= 0 then
    return arr[#arr / 2 + 0.5]
  else
    return (arr[#arr / 2] + arr[#arr / 2 + 1]) / 2
  end
end
range = function(arr)
  return math.max(unpack(arr)) - math.min(unpack(arr))
end
corr = function(xarr, yarr)
  local xmean = mean(xarr)
  local ymean = mean(yarr)
  local xdev_ydev = 0
  local xdev2_ydev2 = 0
  if #xarr == #yarr then
    xdev_ydev = sum((function()
      local _accum_0 = { }
      local _len_0 = 1
      for i = 1, #xarr do
        _accum_0[_len_0] = (xarr[i] - xmean) * (yarr[i] - ymean)
        _len_0 = _len_0 + 1
      end
      return _accum_0
    end)())
    local xdev2 = sum((function()
      local _accum_0 = { }
      local _len_0 = 1
      for i = 1, #xarr do
        _accum_0[_len_0] = (xarr[i] - xmean) ^ 2
        _len_0 = _len_0 + 1
      end
      return _accum_0
    end)())
    local ydev2 = sum((function()
      local _accum_0 = { }
      local _len_0 = 1
      for i = 1, #yarr do
        _accum_0[_len_0] = (yarr[i] - ymean) ^ 2
        _len_0 = _len_0 + 1
      end
      return _accum_0
    end)())
    xdev2_ydev2 = xdev2 * ydev2
  else
    print("Error: Both Variables must have equal length.")
  end
  return xdev_ydev / (math.sqrt(xdev2_ydev2))
end
do
  local _class_0
  local _base_0 = {
    find_b1 = function(self)
      local xdev_ydev = sum((function()
        local _accum_0 = { }
        local _len_0 = 1
        for i = 1, #self.xarr do
          _accum_0[_len_0] = (self.xarr[i] - self.xmean) * (self.yarr[i] - self.ymean)
          _len_0 = _len_0 + 1
        end
        return _accum_0
      end)())
      local xdev2 = sum((function()
        local _accum_0 = { }
        local _len_0 = 1
        for i = 1, #self.xarr do
          _accum_0[_len_0] = (self.xarr[i] - self.xmean) ^ 2
          _len_0 = _len_0 + 1
        end
        return _accum_0
      end)())
      return xdev_ydev / xdev2
    end,
    find_b0 = function(self)
      return self.ymean - (self:find_b1() * self.xmean)
    end,
    predict = function(self, x)
      if #self.xarr ~= #self.yarr then
        return print("Error: Both Variables must have equal length.")
      else
        return self:find_b0() + (self:find_b1() * x)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, xarr, yarr)
      self.xarr = xarr
      self.yarr = yarr
      self.xmean = mean(self.xarr)
      self.ymean = mean(self.yarr)
    end,
    __base = _base_0,
    __name = "LinearRegression"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  LinearRegression = _class_0
end
