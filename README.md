# STAT2003/STAT3102 R Helper

If you are so lazy that you don't even bother to read the intro/manual/code provided on Moodle, here is the R code that is immediately helpful and directly related to the material we have covered in STAT2003/STAT3102. 

The easiest way to use it:
- Go to the directory/folder that has the file 2003.R, open terminal, call
```bash
r
```
- In R, call 
```r
> source("2003.R")
```

The chain, which can be regarded as a matrix, for HIV example is called **HIVmc** and an initial state that can be easily changed is called **initialState**. 
```r
> HIVmatrix
       high medium  low
high   0.90   0.05 0.05
medium 0.60   0.25 0.15
low    0.25   0.25 0.50
```

To compute the 999-step transition matrix, call:
```r
> HIVmc ^ 999
HIV progression^999 
 A  3 - dimensional discrete Markov Chain defined by the following states: 
 high, medium, low 
 The transition matrix  (by rows)  is defined as follows: 
            high     medium       low
high   0.8035714 0.08928571 0.1071429
medium 0.8035714 0.08928571 0.1071429
low    0.8035714 0.08928571 0.1071429
```
Or if the floating point number doesn't make sense to you:
```r
> printFraction(HIVmc ^ 999)
       high  medium low  
high   45/56  5/56   3/28
medium 45/56  5/56   3/28
low    45/56  5/56   3/28
```

To compute the marginal probability at time 10, call:
```r
initialState * HIVmc ^ 10
```

The chain in exercise 2 in called **cw2mc**, which has entries like 1/3. Some example calls:
```r
> printFraction(cw2mc)
  1   2   3   4  
1 1/2 1/2   0   0
2   1   0   0   0
3   0 1/2 1/3 1/6
4   0   0   0   1
> printFraction(cw2mc ^ 2)
  1   2   3   4  
1 3/4 1/4   0   0
2 1/2 1/2   0   0
3 1/2 1/6 1/9 2/9
4   0   0   0   1
```
