local saibot = require("..saibot")
saibot = saibot.saibot
local mytests = { }
mytests.test_linear_regression = function()
  local xarr = {
    61,
    63,
    67,
    69,
    70,
    74,
    76,
    81,
    86,
    91,
    95,
    97
  }
  local yarr = {
    4.280,
    4.080,
    4.420,
    4.170,
    4.480,
    4.300,
    4.820,
    4.700,
    5.110,
    5.130,
    5.640,
    5.560
  }
  local model = saibot.LinearRegression(xarr, yarr)
  return assert(string.format("%.2f", model:predict(100)) == "5.64")
end
mytests.test_ANOVA = function()
  local model = saibot.ANOVA({
    ["1"] = {
      6.33,
      6.26,
      6.31,
      6.29,
      6.40
    },
    ["2"] = {
      6.26,
      6.36,
      6.23,
      6.27,
      6.19,
      6.50,
      6.19,
      6.22
    },
    ["3"] = {
      6.44,
      6.38,
      6.58,
      6.54,
      6.56,
      6.34,
      6.58
    },
    ["4"] = {
      6.29,
      6.23,
      6.19,
      6.21
    }
  })
  assert(model.dfc)
  assert(model.dfe == 20)
  assert(model.dft == 23)
  assert(string.format("%.4f", model:cal_ssc()) == "0.2366")
  assert(string.format("%.4f", model:cal_sse()) == "0.1549")
  assert(string.format("%.4f", model:cal_sst()) == "0.3915")
  assert(string.format("%.4f", model:cal_msc()) == "0.0789")
  assert(string.format("%.4f", model:cal_mse()) == "0.0077")
  assert(string.format("%.4f", model:f_value()) == "10.1810")
  return assert(string.format("%.4f", model.f_critical))
end
mytests.test_OneSampleTTest = function()
  local model = saibot.OneSampleTTest({
    22.6,
    27.0,
    26.2,
    25.8,
    22.2,
    26.6,
    25.3,
    30.4,
    23.2,
    23.1,
    28.1,
    28.6,
    27.4,
    26.9,
    24.2,
    23.5,
    24.5,
    24.9,
    26.1,
    23.6
  }, 25)
  return assert(string.format("%.4f", model:t_stat()) == "1.0399")
end
mytests.test_TwoSampleTTest = function()
  local model = saibot.TwoSampleTTest({
    56,
    50,
    52,
    44,
    52,
    47,
    47,
    53,
    45,
    48,
    42,
    51,
    42,
    43,
    44
  }, {
    59,
    54,
    55,
    65,
    52,
    57,
    64,
    53,
    53,
    56,
    53,
    57
  })
  assert(string.format("%.2f", model:t_stat()) == "-5.20")
  assert(string.format("%.2f", model:t_critical005()) == "1.71")
  assert(string.format("%.2f", model:t_critical0025()) == "2.06")
  model = saibot.TwoSampleTTest({
    56,
    50,
    52,
    44,
    52,
    47,
    47,
    53,
    45,
    48,
    42,
    51,
    42,
    43,
    44
  }, {
    59,
    54,
    55,
    65,
    52,
    57,
    64,
    53,
    53,
    56,
    53,
    57
  }, false)
  assert(string.format("%.2f", model:t_stat()) == "-5.22")
  assert(string.format("%.2f", model:t_critical005()) == "1.71")
  assert(string.format("%.2f", model:t_critical0025()) == "2.06")
  return assert(string.format("%.3f", model.df) == "24.034")
end
return mytests
