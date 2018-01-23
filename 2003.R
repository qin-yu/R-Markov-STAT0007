# R code for STAT2003/STAT3102 course (2017/18)
# Created - Jan 2018, last update - 23 Jan 2018
# by Qin Yu, qin.yu.15@ucl.ac.uk

Sys.setenv(LANG = "en")
library("markovchain")
library("MASS") # Now purely for converting decimal to fraction

# The HIV example is important and will be mentioned repeatedly:
HIVstates <- c("high--", "medium", "low---")
HIVmatrix <- matrix(c(0.9, 0.05, 0.05,
                      0.6, 0.25, 0.15,
                      0.25, 0.25, 0.5),
                    byrow = TRUE,
                    nrow = 3,
                    dimnames = list(HIVstates, HIVstates))  # To perform matrix multiplication on HIVmatrix, use %*% 
HIVmc = new("markovchain",
            states = HIVstates,
            byrow = TRUE,
            transitionMatrix = HIVmatrix,
            name = "HIV progression")  # To perform matrix multiplication on HIVmc, use * 
initialState <- c(0.7, 0.2, 0.1)
print("The initial state has been set as: ")
print(initialState)
print("The setting of HIV markov chain:")
printFraction(HIVmc)

# This transition matrix appears in both slide 2 and exercise 2:
cw2matrix = matrix(c(1/2, 1/2, 0, 0,
                     1, 0, 0, 0,
                     0, 1/2, 1/3, 1/6,
                     0, 0, 0, 1), byrow=TRUE, nrow=4)
cw2mc = new("markovchain",
            byrow=TRUE,
            transitionMatrix = cw2matrix,
            name = "CW2 Q1")
print("The setting of CW2 Q1")
printFraction(cw2mc)


plotHIV <- function(n, t0, t){
    simulated_data <- rmarkovchain(n = n, object = HIVmc, t0 = t0)
    print(simulated_data)
    numeric_simulated_data <- (as.numeric(simulated_data == "low---")
        + as.numeric(simulated_data == "medium") * 2
        + as.numeric(simulated_data == "high--") * 3)
    t <- 0:t 
    plot(t, numeric_simulated_data,
         yaxt="n", type="o", ylab="State", xlab="Time",
         main="Simulation of the HIV Markov chain", col="blue" )
}

printFraction <- function(mc){
    print(as.fractions(attributes(mc)$transitionMatrix))
}
