saibot = require "..saibot"
saibot = saibot.saibot
mytests = {}

mytests.test_mean = ->
  arr = {1,2,3}
  assert saibot.mean(arr) == 2

mytests.test_mode = ->
  arr = {1,2,2,3}
  assert saibot.mode(arr) == 2
  arr = {1,2,3}
  assert saibot.mode(arr) == 1

mytests.test_median = ->
  arr = {1,3,2}
  assert saibot.median(arr) == 2
  arr = {1,2,5,3}
  assert saibot.median(arr) == 2.5

mytests.test_sum = ->
  arr = {1,2,3}
  assert saibot.sum(arr) == 6

mytests.test_variance = ->
  arr = {5,9,16,17,18}
  assert saibot.var(arr) == 26.0

mytests.test_std = ->
  arr = {5,9,16,17,18}
  assert math.floor(saibot.std(arr)) == 5.0

mytests.test_range = ->
  arr = {1,2,3,4,5}
  assert saibot.range(arr) == 4

mytests.test_corr = ->
  xarr = {7.43, 7.48, 8.00, 7.75, 7.60, 7.63, 7.68, 7.67, 7.59, 8.07, 8.03, 8.00}
  yarr = {221, 222, 226, 225, 224, 223, 223, 226, 226, 235, 233, 241}
  corr = saibot.corr(xarr, yarr)
  assert string.format("%.3f", corr) == "0.815"

return mytests
