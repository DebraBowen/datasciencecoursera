## makCacheMatrix() builds a set of functions and returns the functions in a list
## to the parent environment.

## to run, use the following steps:
## 1. m <- matrix(c(1:4), nrow = 2, ncol = 2)
## 2. matr1 <- makeCacheMatrix(m)
## 3. cacheSolve(matr1)

makeCacheMatrix <- function(x = matrix()) {
        
        ## m is the inverse matrix to an original matrix; it is set to NULL in case the original
        ## matrix changes
        m <- NULL
        
        ## the set function allows m to be initialized if the matrix (& therefore its inverse) changes
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        
        ## get() is used to retrieve the original matrix
        get <- function() x
        
        ## setmatrix() is used to call the solve function and assign the inverse matrix to m
        setmatrix <- function(solve) m <<- solve
        
        ## getmatrix() is used to retrieve the cached inverse matrix
        getmatrix <- function() m
        
        ## the functions created are assigned to names so they can later be accessed using $
        list(set = set, get = get,
             setmatrix = setmatrix,
             getmatrix = getmatrix)
}


## cacheSolve() requires an argument of the object type returned by function makeCacheMatrix()
## in order to retrieve the cached inverse matrix stored in the makeCacheMatrix() object's
## environment

cacheSolve <- function(x, ...) {
        
        ## m is the inverse of an original matrix
        ## function getmatrix(), from the list of functions created in makecacheMatrix() is accessed
        m <- x$getmatrix()
        
        ## if the inverse matrix has previously been created and cached, it is retrieved and 
        ## a message is printed to the console
        ## the retrieved inverse matrix is returned to the console
        if(!is.null(m)) {
                message("getting cached matrix")
                return(m)
        }
        ## if the inverse matrix has not yet been cached, the original matrix is retrieved
        data <- x$get()
        
        ## the inverse is found and stored in m
        m <- solve(data, ...)
        
        ## function setmatrix() from the makecacheMatrix() object is accessed to cache the matrix
        x$setmatrix(m)
        
        ## the inverse matrix is printed to the console
        m
}