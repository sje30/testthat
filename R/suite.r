#' Stub object for managing a suite of tests.
#' Do not clone directly from this file
Suite$do({
  self$context <- ""
  self$test <- ""
    
  self$start_suite <- function() {}
  self$start_context <- function(desc) {
    self$context <- desc
  }
  self$start_test <- function(desc) {
    self$test <- desc
  }
  self$add_result <- function(result) {}
  self$end_test <- function() {}
  self$end_context <- function() {}
  self$end_suite <- function() {}
})

suite_accessors <- local({
  # Default has to be the stop suite, since it is this that will be run by
  # default from the command line and in R CMD test.
  suite <- StopSuite$clone()
  
  set <- function(value) {
    suite <<- value
  }
  get <- function() {
    suite
  }
  
  list(get = get, set = set)
})
test_suite <- suite_accessors$get
change_suite_to <- suite_accessors$set

with_suite <- function(suite, code) {
  cur_suite <- test_suite()
  change_suite_to(suite)
  
  suite$start_suite()
  force(code)
  suite$end_suite()
    
  change_suite_to(cur_suite)
  invisible(suite)
}