# R code for STAT2003/STAT3102 course (2017/18)
# Created - Jan 2018, last update - 24 Jan 2018
# by Qin Yu, qin.yu.15@ucl.ac.uk

Sys.setenv(LANG = "en")
library("markovchain")
library("MASS") # Now purely for converting decimal to fraction
print("----------------------------------------------------")

printFraction <- function(mc){
    # CAUTION: very small numbers will be displayed as 0
    # To print the transition matrix in mc, a markovchain, with entries displayed as fraction
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
print(HIVmc)

initialState <- c(0.7, 0.2, 0.1)
print("The initial state has been set as: ")
print(initialState)
print("----------------------------------------------------")


# Exercise Sheet 2:
cw2q1matrix = matrix(c(1/2, 1/2, 0, 0,
                     1, 0, 0, 0,
                     0, 1/2, 1/3, 1/6,
                     0, 0, 0, 1), byrow = TRUE, nrow = 4)
cw2q1 = new("markovchain",
            byrow = TRUE,
            transitionMatrix = cw2q1matrix,
            name = "CW2 Q1")
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



plotHIV <- function(t0, n){
    # Notice that the initial state is not plotted.
    # e.g. call plotHIV("low", 20)
    simulated_data <- rmarkovchain(n = n, object = HIVmc, t0 = t0)
    print(simulated_data)
    numeric_simulated_data <- (as.numeric(simulated_data == "low")
        + as.numeric(simulated_data == "medium") * 2
        + as.numeric(simulated_data == "high") * 3)
    t <- 1:n
    plot(t, numeric_simulated_data,
         yaxt = "n", type = "o", ylab = "State", xlab = "Time",
         main = "Simulation of the HIV Markov chain", col = "blue")
    axis(side = 2, at = c(1,2,3), labels = c("low", "medium", "high"))
}

valOfState <- function(object, s){
    for(i in 1:length(states(object)))
        if(states(object)[i] == s)
            return(i)
}

numericStates <- function(object){
    return(c(1:length(states(object))))
}

plotMarkov <- function(object, t0, n){
    # e.g. call plotHIV(cw2q2, 1, 50)
    simulated_data <- rmarkovchain(n = n, object = object, t0 = t0)
    numeric_simulated_data <- NULL
    for(i in 1:length(simulated_data))
        numeric_simulated_data <- c(numeric_simulated_data, valOfState(object, simulated_data[i]))
    t <- 1:n
    numeric_states <- numericStates(object)
    plot(t, numeric_simulated_data,
         yaxt = "n", type = "o", ylab = "State", xlab = "Time",
         main = "Simulation of Markov chain", col = "blue" )
    axis(side = 2, at = numeric_states, labels = states(object))
}
