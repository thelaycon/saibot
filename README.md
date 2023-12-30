## Saibot: A Lua Statistics Library

Saibot is a powerful statistics library for Lua, designed to provide efficient solutions for both simple and complex statistical problems. Inspired by the reliability of Noob Saibot, Saibot aims to simplify statistical analysis on Lua with a focus on descriptive and inferential statistics techniques.

![Noob Saibot](https://c.tenor.com/ckUZEMepZw4AAAAC/mortal-kombat-noob-saibot.gif)

### Tests

Unit tests are conducted using [Factos](http://github.com/thelaycon/factos), a quick and effective unit testing module for Lua.

```bash
lua54 factos.lua
```

### Compilation

Saibot leverages C++ libraries, particularly the Boost libraries, for rapid statistical analysis. Ensure the Boost libraries are in the path before compiling the C++ modules. Additionally, include Lua binaries in the working directory before compiling the C++ modules for Saibot. For Windows users, `lua54.dll` should be present in the compilation directory.

#### Linux

```bash
# Example
g++ -shared -o saistats.so -llua saistats.cpp
```

#### Windows

```bash
# Example
g++ -shared -o saistats.dll lua54.dll saistats.cpp
```

### Usage

Import Saibot in your Lua or MoonScript code:

#### Lua

```lua
local s = require("saibot")
print(s.saibot.mean({1,2,4}))
```

#### MoonScript

```moon
s = require "saibot"
print s.saibot.mean {1,2,4}
```

### Descriptive Statistics

Saibot currently supports various descriptive statistics techniques for 2D Lua tables:

```lua
mean(arr)       -- Calculates the mean of arr.
median(arr)     -- Calculates the median of arr.
mode(arr)       -- Calculates the mode of arr.
std(arr)        -- Calculates the standard deviation of arr.
var(arr)        -- Calculates the variance of arr.
corr(arr1, arr2)-- Calculates Pearson Moment correlation coefficient of arr1 and arr2.
range(arr)      -- Calculates the range of arr.
```

### Inferential Statistics

#### Linear Regression

```moon
model = s.saibot.LinearRegression(X, Y)
print model\predict(x) -- Predicts the y value for x
```

#### One Way ANOVA

```moon
model = s.saibot.ANOVA({
  "1": {6.33, 6.26, 6.31, 6.29, 6.40},
  "2": {6.26, 6.36, 6.23, 6.27, 6.19, 6.50, 6.19, 6.22},
  "3": {6.44, 6.38, 6.58, 6.54, 6.56, 6.34, 6.58},
  "4": {6.29, 6.23, 6.19, 6.21}
})
print model\summary()
```

| Source   | df  | SS    | MS    | F      |
|----------|----|-------|-------|--------|
| Between  | 3  | 0.2366| 0.0789| 10.1810|
| Error    | 20 | 0.1549| 0.0077|        |
| Total    | 23 | 0.3915|       |        |

F Critical (Alpha=0.05) => 3.0984
Conclusion: Reject NULL Hypothesis.

For more ANOVA functions:

```lua
model.cal_ssc()
model.cal_sse()
model.cal_sst()
model.cal_msc()
model.cal_mse()
model.f_value()
```

#### t-Test for a Single Sample

```moon
model = s.saibot.OneSampleTTest({22.6, 27.0, ...}, 25)
model\summary()
```

*t-Test of a single population: mu = 25*

| Variable | N  | Mean  | StD   | T      |
|----------|----|-------|-------|--------|
| Weight   | 20 | 25.5100| 2.1933| 1.0399 |

#### t-Test for Two Samples

Assuming equal variances:

```moon
model = s.saibot.TwoSampleTTest({56, 50, ...}, {59, 54, ...})
model\summary()
```

Assuming unequal variances:

```moon
model = s.saibot.TwoSampleTTest({56, 50, ...}, {59, 54, ...}, false)
model\summary()
```

For detailed results, including means, standard deviations, t-Stats, and critical values.

### References

Ken Black, 2010. *Business Statistics For Contemporary Decision Making.*
