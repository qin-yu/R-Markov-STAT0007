# R code for STAT2003/STAT3102 course (2017/18)
# Created - Jan 2018, last update - 23 Jan 2018
# by Qin Yu, qin.yu.15@ucl.ac.uk

Sys.setenv(LANG = "en")
library("markovchain")
library("MASS") # Now purely for converting decimal to fraction
print("----------------------------------------------------")

printFraction <- function(mc){
    # To print the transition matrix in mc, a markovchain, with entries in fraction
    # e.g call printFraction(HIVmc^10)
    print(as.fractions(attributes(mc)$transitionMatrix))
}


# The HIV example is important and will be mentioned repeatedly:
HIVstates <- c("high", "medium", "low")
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
print("The setting of HIV markov chain:")
printFraction(HIVmc)

initialState <- c(0.7, 0.2, 0.1)
print("The initial state has been set as: ")
print(initialState)
print("----------------------------------------------------")


# Exercise Sheet 2:
cw2matrix = matrix(c(1/2, 1/2, 0, 0,
                     1, 0, 0, 0,
                     0, 1/2, 1/3, 1/6,
                     0, 0, 0, 1), byrow = TRUE, nrow = 4)
cw2mc = new("markovchain",
            byrow = TRUE,
            transitionMatrix = cw2matrix,
            name = "CW2 Q1")
cw2q1matrix = cw2matrix
cw2q1 = cw2mc
print("The setting of CW2 Q1")
printFraction(cw2q1)

cw2q2matrix = matrix(c(1/6, 1/6, 1/6, 1/6, 1/6, 1/6,
                       0, 1/3, 1/6, 1/6, 1/6, 1/6,
                       0, 0, 1/2, 1/6, 1/6, 1/6,
                       0, 0, 0, 2/3, 1/6, 1/6,
                       0, 0, 0, 0, 5/6, 1/6,
                       0, 0, 0, 0, 0, 1), byrow = TRUE, nrow = 6)
cw2q2 = new("markovchain",
            byrow = TRUE,
            transitionMatrix = cw2q2matrix,
            name = "CW2 Q2")
print("The setting of CW2 Q2")
printFraction(cw2q2)

cw2q3matrix = matrix(c(1/4, 0, 1/2, 1/4,
                     0, 1/5, 0, 4/5,
                     0, 1, 0, 0,
                     1/3, 1/3, 0, 1/3), byrow = TRUE, nrow = 4)
cw2q3 = new("markovchain",
            byrow = TRUE,
            transitionMatrix = cw2q3matrix,
            name = "CW2 Q3")
print("The setting of CW2 Q3")
printFraction(cw2q3)
print("----------------------------------------------------")



plotHIV <- function(n, t0){
    # Notice that the initial state is not on the output graph.
    # e.g. call plotHIV(20, "low")
    simulated_data <- rmarkovchain(n = n, object = HIVmc, t0 = t0)
    print(simulated_data)
    numeric_simulated_data <- (as.numeric(simulated_data == "low")
        + as.numeric(simulated_data == "medium") * 2
        + as.numeric(simulated_data == "high") * 3)
    t <- 1:n
    plot(t, numeric_simulated_data,
         yaxt="n", type="o", ylab="State", xlab="Time",
         main="Simulation of the HIV Markov chain", col="blue" )
}


plotMarkov <- function(object, t0, n){
    # To use this method make sure that the Markov chain has no state name.
    # e.g. call plotHIV(20, "high", 19)
    simulated_data <- rmarkovchain(n = n, object = object, t0 = t0)
    print(simulated_data)
    numeric_simulated_data <- as.numeric(simulated_data)
    t <- 1:n
    plot(t, numeric_simulated_data,
         yaxt="n", type="o", ylab="State", xlab="Time",
         main="Simulation of Markov chain", col="blue" )
    axis(side=2, at=states(object), labels=TRUE)
}
