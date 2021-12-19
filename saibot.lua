local math = require("math")
local saistats = require("saistats")
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
  return xsquared / (#arr - 1)
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
do
  local _class_0
  local _base_0 = {
    cal_ssc = function(self)
      local ssc = { }
      for i, j in pairs(self.anovadesign) do
        local imean = mean(j)
        local sc = #j * ((imean - self.totalmean) ^ 2)
        table.insert(ssc, sc)
      end
      return sum(ssc)
    end,
    cal_sst = function(self)
      local sst = { }
      for i, j in pairs(self.anovadesign) do
        for _index_0 = 1, #j do
          local k = j[_index_0]
          table.insert(sst, (k - self.totalmean) ^ 2)
        end
      end
      return sum(sst)
    end,
    cal_sse = function(self)
      return self:cal_sst() - self:cal_ssc()
    end,
    cal_msc = function(self)
      return self:cal_ssc() / self.dfc
    end,
    cal_mse = function(self)
      return self:cal_sse() / self.dfe
    end,
    f_value = function(self)
      return self:cal_msc() / self:cal_mse()
    end,
    summary = function(self)
      local FC = saistats.f(0.05, self.dfc, self.dfe)
      print("ANOVA Table\n")
      print("------------------------------\n")
      print("Source  \t\t df \t\t SS \t\t MS \t\tF\n")
      print("Between \t\t " .. tostring(self.dfc) .. " \t\t " .. tostring(string.format("%6.4f", self:cal_ssc())) .. "   \t" .. tostring(string.format("%6.4f", self:cal_msc())) .. " \t\t" .. tostring(string.format("%6.4f", self:f_value())) .. "\n")
      print("Error   \t\t " .. tostring(self.dfe) .. " \t\t " .. tostring(string.format("%6.4f", self:cal_sse())) .. "   \t" .. tostring(string.format("%6.4f", self:cal_mse())) .. "\n")
      print("Total   \t\t " .. tostring(self.dft) .. " \t\t " .. tostring(string.format("%6.4f", self:cal_sst())) .. "\n")
      print("F Critical (Alpha=0.05) =====> " .. tostring(string.format("%6.4f", FC)) .. "\n")
      if self:f_value() < FC then
        return print("Conclusion: Accept NULL Hypothesis.\n")
      else
        return print("Conclusion: Reject NULL Hypothesis.\n")
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, anovadesign)
      self.anovadesign = anovadesign
      self.cols = 0
      for i, j in pairs(self.anovadesign) do
        self.cols = self.cols + 1
      end
      self.totalmean = { }
      self.dfc = self.cols - 1
      self.N = 0
      for i, j in pairs(self.anovadesign) do
        for _index_0 = 1, #j do
          local k = j[_index_0]
          self.N = self.N + 1
          table.insert(self.totalmean, k)
        end
      end
      self.totalmean = mean(self.totalmean)
      self.dfe = self.N - self.cols
      self.dft = self.N - 1
    end,
    __base = _base_0,
    __name = "ANOVA"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  ANOVA = _class_0
end
do
  local _class_0
  local _base_0 = {
    t_stat = function(self)
      return (self.xbar - self.mu) / (self.s / math.sqrt(self.N))
    end,
    summary = function(self)
      print("t-Test of a single population: mu = " .. tostring(self.mu) .. "\n")
      print("-------------------------------\n")
      print("Variable \t\t N \t\t Mean \t\t StD \t\t\t T\n")
      return print("Weight \t\t " .. tostring(self.N) .. " \t\t " .. tostring(string.format("%6.4f", self.xbar)) .. " \t\t " .. tostring(string.format("%6.4f", self.s)) .. " \t\t " .. tostring(string.format("%6.4f", self:t_stat())) .. "\n")
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, arr, mu)
      self.xbar = mean(arr)
      self.s = std(arr)
      self.N = #arr
      self.mu = mu
    end,
    __base = _base_0,
    __name = "OneSampleTTest"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  OneSampleTTest = _class_0
end
do
  local _class_0
  local _base_0 = {
    t_stat = function(self)
      if self.equal == true then
        local numerator = (self.xbar1 - self.xbar2)
        local deno1 = math.sqrt((((self.s1 ^ 2) * (self.N1 - 1)) + ((self.s2 ^ 2) * (self.N2 - 1))) / self.df)
        local deno2 = math.sqrt(((1 / self.N1) + (1 / self.N2)))
        return numerator / (deno1 * deno2)
      else
        local numerator = (self.xbar1 - self.xbar2)
        local deno = math.sqrt(((self.s1 ^ 2) / self.N1) + ((self.s2 ^ 2) / self.N2))
        return numerator / deno
      end
    end,
    summary = function(self)
      if self.equal == true then
        print("t-Test of two populations assuming equal variances\n")
        print("--------------------------\n")
        print("Hypothesized Mean Difference = 0\n")
        print("        \t\t N \t\t Mean \t\t StD\n")
        print("Method A \t\t " .. tostring(self.N1) .. " \t\t " .. tostring(string.format("%6.4f", self.xbar1)) .. " \t\t " .. tostring(string.format("%6.4f", self.s1)) .. "\n")
        print("Method B \t\t " .. tostring(self.N2) .. " \t\t " .. tostring(string.format("%6.4f", self.xbar2)) .. " \t\t " .. tostring(string.format("%6.4f", self.s2)) .. "\n")
        print("df = " .. tostring(self.df))
        return print("t-Stat = " .. tostring(string.format("%6.2f", self:t_stat())))
      else
        print("t-Test of two populations assuming *unequal variances\n")
        print("--------------------------\n")
        print("Hypothesized Mean Difference = 0\n")
        print("        \t\t N \t\t Mean \t\t StD\n")
        print("Method A \t\t " .. tostring(self.N1) .. " \t\t " .. tostring(string.format("%6.4f", self.xbar1)) .. " \t\t " .. tostring(string.format("%6.4f", self.s1)) .. "\n")
        print("Method B \t\t " .. tostring(self.N2) .. " \t\t " .. tostring(string.format("%6.4f", self.xbar2)) .. " \t\t " .. tostring(string.format("%6.4f", self.s2)) .. "\n")
        print("df = " .. tostring(self.df))
        return print("t-Stat = " .. tostring(string.format("%6.2f", self:t_stat())))
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, arr1, arr2, equal)
      if equal == nil then
        equal = true
      end
      self.xbar1 = mean(arr1)
      self.xbar2 = mean(arr2)
      self.s1 = std(arr1)
      self.s2 = std(arr2)
      self.N1 = #arr1
      self.N2 = #arr2
      self.equal = equal
      if self.equal == true then
        self.df = (self.N1 + self.N2 - 2)
      else
        local numerator = math.pow(((self.s1 ^ 2) / self.N1) + ((self.s2 ^ 2) / self.N2), 2)
        local deno = ((((self.s1 ^ 2) / self.N1) ^ 2) / (self.N1 - 1)) + ((((self.s2 ^ 2) / self.N2) ^ 2) / (self.N2 - 1))
        self.df = numerator / deno
      end
    end,
    __base = _base_0,
    __name = "TwoSampleTTest"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  TwoSampleTTest = _class_0
end
