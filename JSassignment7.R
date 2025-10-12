# assignment7.R

rm(list = ls())
cat("Starting Assignment 7\n")

# 1. Data loading and inspection
data("mtcars")
cat("\n=== head(mtcars) ===\n")
print(head(mtcars))
cat("\n=== str(mtcars) ===\n")
str(mtcars)

# 2. Generic functions on base objects
cat("\n=== print(mtcars) ===\n")
print(mtcars)
cat("\n=== summary(mtcars) ===\n")
print(summary(mtcars))

cat("\n=== plot mpg vs hp ===\n")
plot(mtcars$mpg, mtcars$hp,
     main = "MPG vs Horsepower",
     xlab = "mpg",
     ylab = "hp")

# Inspect class system and underlying types
cat("\n=== class, typeof, isS4 ===\n")
print(class(mtcars))
print(typeof(mtcars))
print(isS4(mtcars))

# 3. S3 example
s3_obj <- list(name = "Myself", age = 29, GPA = 3.5)
class(s3_obj) <- "student_s3"

print.student_s3 <- function(x, ...) {
  cat("Name:", x$name, "\nAge:", x$age, "\nGPA:", x$GPA, "\n")
}

summary.student_s3 <- function(object, ...) {
  list(name = object$name, is_adult = object$age >= 18, GPA = object$GPA)
}

cat("\n=== S3 dispatch: print ===\n")
print(s3_obj)
cat("\n=== S3 dispatch: summary ===\n")
print(summary(s3_obj))

cat("\n=== S3 no method example: plot ===\n")
tryCatch(
  {
    plot(s3_obj)
  },
  error = function(e) {
    cat("As expected, no plot method for class 'student_s3'. Reason:", conditionMessage(e), "\n")
  }
)

# 4. S4 example
library(methods)

# Clean up any previous definitions
if (methods::isGeneric("studentInfo")) {
  suppressWarnings(methods::removeGeneric("studentInfo"))
}
if ("student_s4" %in% methods::getClasses()) {
  suppressWarnings(methods::removeMethods("show", "student_s4"))
  suppressWarnings(methods::removeClass("student_s4"))
}

# Define S4 class
setClass("student_s4",
         slots = c(name = "character",
                   age = "numeric",
                   GPA = "numeric"))

# Create S4 object
s4_obj <- new("student_s4", name = "Myself", age = 29, GPA = 3.5)

# Custom show for S4
setMethod("show", "student_s4", function(object) {
  cat("Name:", object@name,
      "\nAge:", object@age,
      "\nGPA:", object@GPA, "\n")
})

# Define the generic every time
setGeneric("studentInfo", function(object) standardGeneric("studentInfo"))

# Add method
setMethod("studentInfo", "student_s4", function(object) {
  list(name = object@name, is_adult = object@age >= 18, GPA = object@GPA)
})

# Tests
cat("\n=== S4 dispatch: show ===\n")
print(s4_obj)
cat("\n=== S4 dispatch: studentInfo ===\n")
print(studentInfo(s4_obj))

# Introspection helpers
cat("\n=== Introspection on S4 object ===\n")
print(isS4(s4_obj))
print(class(s4_obj))
print(typeof(s4_obj))
showMethods("show")
showMethods("studentInfo")

cat("\nAll sections ran successfully\n")

