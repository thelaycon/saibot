-- A Lua statistics module
saistats = require "saibot.saistats"


-- Computes sum of a table
sum = (arr) ->
  total = 0
  for i in *arr
    total += i
  return total

-- Calculates the Arithmetic mean
mean = (arr) ->
  total = 0
  total = sum arr
  return total / #arr
  
-- Calculates variance
var = (arr, sample=false) ->
  mean_ = mean(arr)
  xsquared = 0
  for i in *arr
    xs = math.pow i - mean_, 2
    xsquared += xs
   
  if sample == true
    return xsquared / (#arr-1)
  else
    return xsquared / (#arr)
  
-- Calculates the Standard Deviation  
std = (arr, sample=false) ->
  return math.sqrt var(arr, sample)

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
mode = (arr) ->
  track = {}
  mode_table = {} 
  for i in *arr
    if track[i] != nil
      track[i] +=1
    else
      track[i] = 1
      
  keys, values = get_keys_values track
  max_value = math.max table.unpack values
  
  for i,k in pairs track
    if k == max_value
      table.insert mode_table, i
  
  return math.min (table.unpack mode_table)
  
-- Calculates the median of a list
median = (arr) ->
  table.sort arr
  if #arr%2 != 0
    return arr[#arr/2 + 0.5]
  else
    return (arr[#arr/2] + arr[#arr/2 + 1])/ 2
    
-- Calculates range
range = (arr) ->
  return math.max(table.unpack arr) - math.min(table.unpack arr)

-- Calculates Pearson Correlation between two Random Variables
corr = (xarr, yarr) ->
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
class LinearRegression
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
  
-- One Way ANOVA
class ANOVA
  new: (anovadesign) =>
    @anovadesign = anovadesign
    
    @cols = 0
    for i,j in pairs @anovadesign
      @cols +=1
      
    @totalmean = {}
    @dfc = @cols - 1
    
    @N = 0
    for i,j in pairs @anovadesign
      for k in *j
        @N += 1
        table.insert @totalmean, k
    
    @totalmean = mean(@totalmean)
    
    @dfe = @N - @cols
    @dft = @N - 1 
    
    @f_critical = saistats.f(0.05, @dfc, @dfe)
    
  cal_ssc: =>
    ssc = {}
    for i,j in pairs @anovadesign
      imean = mean(j)
      sc = #j * ((imean-@totalmean)^2)
      table.insert ssc, sc
    return sum(ssc)
  
  cal_sst: =>
    sst = {}
    for i,j in pairs @anovadesign
      for k in *j
        table.insert sst, (k-@totalmean)^2
    return sum(sst)
    
  cal_sse: =>
    return @cal_sst() - @cal_ssc()
    
  cal_msc: =>
    return @cal_ssc() / @dfc
    
  cal_mse: =>
    return @cal_sse() / @dfe
  
  f_value: =>
    return @cal_msc() / @cal_mse()
    
  summary: =>
    print "ANOVA Table\n"
    print "------------------------------\n"
    print "Source  \t\t df \t\t SS \t\t MS \t\tF\n"
    print "Between \t\t #{@dfc} \t\t #{string.format "%.4f", @cal_ssc()}   \t#{string.format "%.4f", @cal_msc()} \t\t#{string.format "%.4f", @f_value()}\n"
    print "Error   \t\t #{@dfe} \t\t #{string.format "%.4f", @cal_sse()}   \t#{string.format "%.4f", @cal_mse()}\n"    
    print "Total   \t\t #{@dft} \t\t #{string.format "%.4f", @cal_sst()}\n"
    print "F Critical (Alpha=0.05) =====> #{string.format "%.4f", @f_critical}\n"
    
    if @f_value() < @f_critical
      print "Conclusion: Accept NULL Hypothesis.\n"
    else
      print "Conclusion: Reject NULL Hypothesis.\n"
    

-- One Sample T test
class OneSampleTTest
  new: (arr, mu) =>
    @xbar = mean(arr)
    @s = std(arr, true)
    @N = #arr
    @mu = mu
    
  t_stat: =>
    return (@xbar - @mu)/ (@s / math.sqrt @N)
  
  summary: =>
    print "t-Test of a single population: mu = #{@mu}\n"
    print "-------------------------------\n"
    print "Variable \t\t N \t\t Mean \t\t StD \t\t\t T\n"
    print "Weight \t\t #{@N} \t\t #{string.format "%.4f", @xbar} \t\t #{string.format "%.4f", @s} \t\t #{string.format "%.4f", @t_stat()}\n"
    
    
class TwoSampleTTest
  new: (arr1, arr2, equal=true) =>
    @xbar1 = mean(arr1)
    @xbar2 = mean(arr2)
    @s1 = std(arr1, true)
    @s2 = std(arr2, true)
    @N1 = #arr1
    @N2 = #arr2
    @equal = equal
    
    if @equal == true
      @df = (@N1 + @N2 - 2)
    else
      numerator = math.pow ((@s1^2)/@N1) + ((@s2^2)/@N2), 2
      deno = ((((@s1^2)/@N1)^2)/(@N1 - 1)) + ((((@s2^2)/@N2)^2)/(@N2 - 1))
      @df = numerator / deno
    
  t_critical005: =>
    return saistats.t(0.05, @df)
  
  t_critical0025: =>
    return saistats.t(0.025, @df)
    
  t_stat: =>
    if @equal == true
      numerator = (@xbar1 - @xbar2)
      deno1 = math.sqrt (((@s1^2)*(@N1 - 1)) + ((@s2^2)*(@N2 - 1))) / @df
      deno2 = math.sqrt ((1/@N1) + (1/@N2))
      return  numerator / (deno1 * deno2)
    else
      numerator = (@xbar1 - @xbar2)
      deno = math.sqrt ((@s1^2)/@N1) + ((@s2^2)/@N2)
      return numerator / deno
  
  summary: =>
    if @equal == true
      print "t-Test of two populations assuming equal variances\n"
      print "--------------------------\n"
      print "Hypothesized Mean Difference = 0\n"
      print "        \t\t N \t\t Mean \t\t StD\n"
      print "Method A \t\t #{@N1} \t\t #{string.format "%.4f", @xbar1} \t\t #{string.format "%.4f", @s1}\n"
      print "Method B \t\t #{@N2} \t\t #{string.format "%.4f", @xbar2} \t\t #{string.format "%.4f", @s2}\n"
      print "df = #{@df}"
      print "t-Stat = #{string.format "%.2f", @t_stat()}"
      print "t-Critical (One sided) = #{string.format "%.2f", @t_critical005()}" 
      print "t-Critical (Two sided) = #{string.format "%.2f", @t_critical0025()}" 
    else
      print "t-Test of two populations assuming *unequal variances\n"
      print "--------------------------\n"
      print "Hypothesized Mean Difference = 0\n"
      print "        \t\t N \t\t Mean \t\t StD\n"
      print "Method A \t\t #{@N1} \t\t #{string.format "%.4f", @xbar1} \t\t #{string.format "%.4f", @s1}\n"
      print "Method B \t\t #{@N2} \t\t #{string.format "%.4f", @xbar2} \t\t #{string.format "%.4f", @s2}\n"
      print "df = #{@df}"
      print "t-Stat = #{string.format "%.2f", @t_stat()}" 
      print "t-Critical (One sided) = #{string.format "%.2f", @t_critical005()}" 
      print "t-Critical (Two sided) = #{string.format "%.2f", @t_critical0025()}" 



return {
	sum:sum,
	mean:mean,
	var:var,
	std:std,
	mode:mode,
	median:median,
	range:range,
	corr:corr,
	LinearRegression:LinearRegression,
	ANOVA:ANOVA,
	OneSampleTTest:OneSampleTTest,
	TwoSampleTTest:TwoSampleTTest,
	}

