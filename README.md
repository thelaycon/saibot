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


