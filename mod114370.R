# ----------------------------------------------------------------------
# 1. Helper Function: tukey.outlier (Required for the main function)
# ----------------------------------------------------------------------
tukey.outlier <- function(vec) {
  # Calculate quartiles and IQR
  q <- quantile(vec, probs = c(0.25, 0.75), na.rm = TRUE)
  iqr <- q[2] - q[1]
  
  # Calculate fences (1.5 * IQR rule)
  lower_fence <- q[1] - 1.5 * iqr
  upper_fence <- q[2] + 1.5 * iqr
  
  # Return logical vector: TRUE if outlier, FALSE otherwise
  return(vec < lower_fence | vec > upper_fence)
}

# ----------------------------------------------------------------------
# 2. The Original Buggy Function (For Error Reproduction)
# ----------------------------------------------------------------------
tukey_multiple_buggy <- function(x) {
  outliers <- array(TRUE, dim = dim(x))
  for (j in 1:ncol(x)) {
    # BUG LINE: Uses logical AND (&&) instead of element-wise AND (&)
    outliers[, j] <- outliers[, j] && tukey.outlier(x[, j])
  }
  outlier.vec <- vector("logical", length = nrow(x))
  for (i in 1:nrow(x)) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  return(outlier.vec)
}

# ----------------------------------------------------------------------
# 3. Task: Reproduce the Error
# ----------------------------------------------------------------------
# set.seed(123)
# test_mat <- matrix(rnorm(50), nrow = 10)
# 
# # This line should produce the error: 
# # Error in outliers[, j] && tukey.outlier(x[, j]) : 'length = 10' in coercion to 'logical(1)'
# tukey_multiple_buggy(test_mat)

# ----------------------------------------------------------------------
# 4. The Corrected Function (Final Submission Version)
# ----------------------------------------------------------------------
# This function incorporates the fix and the suggested improvements (seq_len, logical(n))
corrected_tukey <- function(x) {
  outliers <- array(TRUE, dim = dim(x))
  for (j in seq_len(ncol(x))) {
    # FIX: Replaced && with the element-wise & operator
    outliers[, j] <- outliers[, j] & tukey.outlier(x[, j]) 
  }
  
  outlier.vec <- logical(nrow(x)) 
  for (i in seq_len(nrow(x))) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  return(outlier.vec)
}

# ----------------------------------------------------------------------
# 5. Task: Validate Your Fix
# ----------------------------------------------------------------------
set.seed(123)
test_mat <- matrix(rnorm(50), nrow = 10)

# Running the corrected function should produce a logical vector of length 10 without error
cat("--- Validation Output ---\n")
print(corrected_tukey(test_mat))
cat("-------------------------\n")