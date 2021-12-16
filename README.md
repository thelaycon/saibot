Noob Saibot always felt like a cheatcode, I needed a similar solution to simple or perhaps complex statistics problems on Lua. 

Saibot is a statistics library for Lua and currently supports a few descriptive and inferential statistics techniques.


# Usage

Import Saibot

Lua:

```

require("saibot")

print(mean({1,2,4})


```

MoonScript:

```

require "saibot"

print mean {1,2,4}


```


# Descriptive Statistics

Saibot currently supports a few popular descriptive statistics techniques for 2D Lua arrays.  

```

mean(arr) -- Calculates mean of arr.
median(arr) -- Calculates median of arr.
mode(arr) -- Calculates mode of arr. If arr is multimodal, the smallest value is returned.
std(arr) -- Calculates standard deviation of arr.
var(arr) -- Calculates variance of arr.
corr(arr1, arr2) -- Calculates Pearson Moment correlation coefficient of arr1 and arr2.
range(arr) -- Calculates range of arr.


```
 

# Inferential Statistics


**Linear Regression:**

MoonScript:

```
model = LinearRegression(X, Y)
print model\predict(x) -- Predicts the y value for x

```


**One Way ANOVA**

MoonScript:

```
model = ANOVA({"1":{6.33, 6.26, 6.31, 6.29, 6.40}, "2":{6.26, 6.36, 6.23, 6.27, 6.19, 6.50, 6.19, 6.22}, "3":{6.44, 6.38, 6.58, 6.54, 6.56, 6.34, 6.58}, "4":{6.29, 6.23, 6.19, 6.21}})
  
print model\summary()

Source 		 df 		 SS   		 MS   		 F

Between 		 3 		 0.2366 		 0.0789 		 10.1810

Error 		 20 		 0.1549 		 0.0077

Between 		 23 		 0.3915

```

More ANOVA functions:

```
model.cal_ssc() -- Calculates SSC
model.cal_sse() -- Calculates SSE
model.cal_sst() -- Calculates SST
model.cal_msc() -- Calculates MSC
model.cal_mse() -- Calculates MSE
model.f_value() -- Calculates F Value
```


**t-Test for a single sample**

MoonScript:

```
model = OneSampleTTest({22.6, 27.0, 26.2, 25.8, 22.2, 26.6, 25.3, 30.4, 23.2, 23.1, 28.1, 28.6, 27.4, 26.9, 24.2, 23.5, 24.5, 24.9, 26.1, 23.6}, 25)
model\summary()

t-Test of a single population: mu = 25

-------------------------------

Variable 		 N 		 Mean 		 StD 			 T

Weight 		 20 		 25.5100 		 2.1933 		 1.0399
```


**t-Test for two sample**

MoonScript:

```
-- Assuming equal variances

model = TwoSampleTTest({56, 50, 52, 44, 52, 47, 47, 53, 45, 48, 42, 51, 42, 43, 44}, {59, 54, 55, 65, 52, 57, 64, 53, 53, 56, 53, 57})
model\summary()

t-Test of two populations assuming equal variances

--------------------------

Hypothesized Mean Difference = 0

        		 N 		 Mean 		 StD

Method A 		 15 		 47.7333 		 4.4153

Method B 		 12 		 56.5000 		 4.2747

df = 25
t-Stat =  -5.20

-- Assuming unequal variances

model = TwoSampleTTest({56, 50, 52, 44, 52, 47, 47, 53, 45, 48, 42, 51, 42, 43, 44}, {59, 54, 55, 65, 52, 57, 64, 53, 53, 56, 53, 57}, false)
model\summary()

t-Test of two populations assuming *unequal variances

--------------------------

Hypothesized Mean Difference = 0

        		 N 		 Mean 		 StD

Method A 		 15 		 47.7333 		 4.4153

Method B 		 12 		 56.5000 		 4.2747

df = 24.034065489287
t-Stat =  -5.22

```