r_code <- c(
  "makeCacheMatrix <- function(x = matrix()) {",
  "  inv <- NULL",
  "  set <- function(y) {",
  "    x <<- y",
  "    inv <<- NULL",
  "  }",
  "  get <- function() x",
  "  setinverse <- function(inverse) inv <<- inverse",
  "  getinverse <- function() inv",
  "  list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)",
  "}",
  "",
  "cacheSolve <- function(x, ...) {",
  "  inv <- x$getinverse()",
  "  if (!is.null(inv)) {",
  "    message(\"getting cached data\")",
  "    return(inv)",
  "  }",
  "  mat <- x$get()",
  "  if (!is.matrix(mat)) stop(\"The stored object is not a matrix.\")",
  "  if (nrow(mat) != ncol(mat)) stop(\"Matrix must be square to compute its inverse.\")",
  "  inv <- tryCatch({",
  "    solve(mat, ...)",
  "  }, error = function(e) {",
  "    stop(\"Matrix inversion failed: \", e$message)",
  "  })",
  "  x$setinverse(inv)",
  "  inv",
  "}"
)
writeLines(r_code, "cachematrix.R")
getwd()               # shows the folder where cachematrix.R was written
file.exists("cachematrix.R")

source("cachematrix.R")

# quick test
m <- matrix(c(2,1,1,2), 2, 2)
cm <- makeCacheMatrix(m)

# first call computes inverse
cacheSolve(cm)

# second call should use cached result and print "getting cached data"
cacheSolve(cm)
