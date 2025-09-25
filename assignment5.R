# Assignment 5, Matrix Algebra in R

# 1) Create matrices
A <- matrix(1:100,  nrow = 10)
B <- matrix(1:1000, nrow = 10)

# 2) Inspect dimensions
cat("dim(A):", dim(A)[1], "x", dim(A)[2], "\n")   # 10 x 10
cat("dim(B):", dim(B)[1], "x", dim(B)[2], "\n")   # 10 x 100

# 3) Inverse and determinant for A
cat("\nA results\n")
detA <- det(A)
cat("det(A):", detA, "\n")
invA <- tryCatch(solve(A), error = function(e) e$message)
if (is.character(invA)) {
  cat("solve(A) error:", invA, "\n")
} else {
  print(invA)
}

# 4) Inverse and determinant for B with tryCatch
cat("\nB results\n")
detB <- tryCatch(det(B),   error = function(e) e$message)
cat("det(B):", if (is.character(detB)) detB else detB, "\n")
invB <- tryCatch(solve(B), error = function(e) e$message)
if (is.character(invB)) {
  cat("solve(B) error:", invB, "\n")
} else {
  print(invB)
}

# 5) Extras, correct matrix algebra
cat("\nExtras\n")
v <- 1:10
Av <- A %*% v
cat("dim(A %*% v):", dim(Av)[1], "x", dim(Av)[2], "\n")
C <- A %*% B
cat("dim(A %*% B):", dim(C)[1], "x", dim(C)[2], "\n")
