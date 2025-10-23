# Assignment 9, Visualization in R – Base, Lattice, ggplot2
# Save as assignment9.R and run

# Packages
# install.packages(c("lattice", "ggplot2"))

library(lattice)
library(ggplot2)

# Data
data("iris", package = "datasets")
head(iris)

set.seed(42)

# Base R graphics

# Scatter plot with legend
png("base_scatter_iris.png", width = 900, height = 650, res = 120)
species_cols <- c(setosa = "steelblue", versicolor = "tomato", virginica = "darkgreen")
plot(iris$Sepal.Length, iris$Petal.Length,
     main = "Base: Petal.Length vs Sepal.Length",
     xlab = "Sepal.Length",
     ylab = "Petal.Length",
     col = species_cols[iris$Species],
     pch = 16)
legend("topleft",
       legend = levels(iris$Species),
       col = species_cols,
       pch = 16,
       bty = "n",
       title = "Species")
dev.off()

# Histogram
png("base_hist_iris.png", width = 900, height = 650, res = 120)
hist(iris$Sepal.Length,
     main = "Base: Distribution of Sepal.Length",
     xlab = "Sepal.Length",
     ylab = "Count",
     breaks = 15)
dev.off()

# Lattice graphics

# Conditional scatter plot by Species
png("lattice_xy_iris.png", width = 900, height = 650, res = 120)
print(
  xyplot(Petal.Length ~ Sepal.Length | Species,
         data = iris,
         layout = c(3, 1),
         main = "Lattice: Petal.Length vs Sepal.Length by Species",
         xlab = "Sepal.Length",
         ylab = "Petal.Length",
         pch = 16)
)
dev.off()

# Box and whisker plot
png("lattice_bw_iris.png", width = 900, height = 650, res = 120)
print(
  bwplot(Sepal.Length ~ Species,
         data = iris,
         main = "Lattice: Sepal.Length by Species",
         xlab = "Species",
         ylab = "Sepal.Length")
)
dev.off()

# ggplot2

# Scatter with linear trend by Species
p1 <- ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "ggplot2: Petal.Length vs Sepal.Length with linear trend",
       x = "Sepal.Length",
       y = "Petal.Length")
ggsave("ggplot_scatter_iris.png", plot = p1, width = 7.5, height = 5.2, dpi = 120)

# Faceted histogram
p2 <- ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(binwidth = 0.3) +
  facet_wrap(~ Species, nrow = 1) +
  labs(title = "ggplot2: Sepal.Length distribution by Species",
       x = "Sepal.Length",
       y = "Count")
ggsave("ggplot_hist_iris.png", plot = p2, width = 9, height = 4, dpi = 120)
