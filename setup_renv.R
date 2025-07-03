# Initialize renv for this project
# This script should be run once to set up the renv environment

# Set CRAN mirror for Netherlands (or fallback to cloud mirror)
options(repos = c(CRAN = "https://cran.r-project.org/"))

# On macOS, prefer binary packages to avoid compilation issues
if (Sys.info()["sysname"] == "Darwin") {
  options(pkgType = "binary")
  cat("macOS detected: Using binary packages to avoid compilation issues.\n")
}

# Install renv if not already installed
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

# Initialize renv for this project
renv::init()

# Try to install packages, with fallback for compilation issues
packages_to_install <- c("scholar", "knitr", "rmarkdown")

cat("Installing required packages...\n")
for (pkg in packages_to_install) {
  cat("Installing", pkg, "...\n")
  
  # First try regular install
  result <- tryCatch({
    renv::install(pkg)
    TRUE
  }, error = function(e) {
    cat("Failed to install", pkg, "from source. Trying binary...\n")
    
    # Try installing binary version (pre-compiled)
    tryCatch({
      renv::install(pkg, type = "binary")
      TRUE
    }, error = function(e2) {
      cat("Failed to install", pkg, "as binary. Trying from CRAN...\n")
      
      # Try installing from CRAN directly
      tryCatch({
        install.packages(pkg, repos = "https://cran.r-project.org/")
        TRUE
      }, error = function(e3) {
        cat("ERROR: Could not install", pkg, "\n")
        cat("Error details:", conditionMessage(e3), "\n")
        FALSE
      })
    })
  })
  
  if (!result) {
    cat("Skipping", pkg, "due to installation failure.\n")
  }
}

# Take a snapshot of the current package versions
cat("Taking snapshot of installed packages...\n")
renv::snapshot()

cat("renv has been initialized successfully!\n")
cat("The project now has reproducible package management.\n")
cat("Use 'renv::restore()' to restore packages when cloning this project.\n")
