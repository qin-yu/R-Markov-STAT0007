# STAT2003/STAT3102 R Helper

If you are so lazy that you don't even bother to read the intro/manual/code provided on Moodle, here is the R code that is immediately helpful and directly related to the material we have covered in STAT2003/STAT3102. 

## Getting Started
This part is a very short introduction for users who run R on MacOS, not for users using RStudio, though I believe it doesn't make a big difference.

Firstly, one needs to make sure the "markovchain" package has been installed on their machine. To install the package, launch R:
```Shell
$ r
```
then call install.packages("markovchain"):
```r
> install.packages("markovchain")
```
then follow the instruction.

### The easiest way to use my code:
- Download and place *2003.R* in the directory/folder
- Go to that directory, launch Terminal.app and rename my code as *.rprofile* so it will be sourced everytime you launch R from this directory/folder. (In the latest version of MacOS one cannot rename a file to .rprofile in Finder.app)
```Shell
$ cp 2003.R .rprofile
$ r
```
### Alternatively:
If you don't want R to load my code on start up:
- Go to the directory/folder that has the file 2003.R, open terminal, call
```Shell
$ r
```
- In R, call 
```r
> source("2003.R")
```

## Some Examples
### The classic HIV example:
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
### Examples on Exercise Sheet 2:
To compute the marginal probability at time 10, call:
```r
> initialState * HIVmc ^ 10
          high     medium       low
[1,] 0.8035224 0.08930481 0.1071728
```
The chain in exercise 2 question 1 is called **cw2q1**, which has entries like 1/3. Some example calls:
```r
> printFraction(cw2mc)  # Print the transition matrix in question 1
  1   2   3   4  
1 1/2 1/2   0   0
2   1   0   0   0
3   0 1/2 1/3 1/6
4   0   0   0   1
> printFraction(cw2mc ^ 100) # Print the 100-step transition matrix in question 1
  1   2   3   4  
1 2/3 1/3   0   0
2 2/3 1/3   0   0
3 1/2 1/4   0 1/4
4   0   0   0   1
```
One can easily prove by induction that the 4 entries at the top right corner are always 0, but some selective computation makes it easier to realise these facts in the first place.

Also, it might be useful to verify a belief when a markov chain can be simulated. For example, in question 2(c) - How will the process behave in the long-run?
```r
> plotMarkov(cw2q2, 1, 50)  # For the MC in Ex2 Q2, take state 1 as initial state, simulate upto step 50
 [1] "2" "2" "2" "2" "2" "2" "3" "3" "3" "3" "4" "4" "5" "5" "5" "5" "5" "5" "5"
[20] "5" "5" "5" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6"
[39] "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6"
> plotMarkov(cw2q2, 1, 50)
 [1] "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6"
[20] "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6"
[39] "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6"
> plotMarkov(cw2q2, 1, 50)
 [1] "1" "1" "4" "5" "5" "5" "5" "5" "5" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6"
[20] "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6"
[39] "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6" "6"
```
![Image 1 of plotMarkov(cw2q2, 1, 50)](https://github.com/qin-yu/STAT2003-STAT3102-R/blob/master/images/cw2q2_1.png)
![Image 2 of plotMarkov(cw2q2, 1, 50)](https://github.com/qin-yu/STAT2003-STAT3102-R/blob/master/images/cw2q2_2.png)
![Image 3 of plotMarkov(cw2q2, 1, 50)](https://github.com/qin-yu/STAT2003-STAT3102-R/blob/master/images/cw2q2_3.png)
