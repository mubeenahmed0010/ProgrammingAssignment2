# Load the functions
source("cachematrix.R")    # adjust the path if needed

m <- matrix(c(2,1,1,2), nrow = 2, ncol = 2)
cm <- makeCacheMatrix(m)

# first call computes inverse
inv1 <- cacheSolve(cm)
print(inv1)
# Expected:
#      [,1]       [,2]
# [1,] 0.6666667 -0.3333333
# [2,] -0.3333333 0.6666667

# second call returns cached inverse (and prints message)
inv2 <- cacheSolve(cm)
# Console will show: "getting cached data"
cm$set(matrix(c(1,2,3,4), 2, 2))
cacheSolve(cm)   # computes new inverse
