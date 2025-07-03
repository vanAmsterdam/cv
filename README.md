# CV

A Quarto-based CV with reproducible R package management.

Made in Quarto with R code chunks for dynamic content (e.g., publication data via Google Scholar).

I used https://github.com/simonheb/markdown-cv as a starting point.

## Setup

This project uses `renv` for reproducible R package management.

### First-time setup:

**Option 1: From R/RStudio**
1. Open R/RStudio in this project directory
2. Run the setup script:
   ```r
   source("setup_renv.R")
   ```

**Option 2: From command line**
```bash
Rscript setup_renv.R
```

This will:
- Install `renv` if not already available
- Initialize the renv environment 
- Install required packages (`scholar`, `knitr`, `rmarkdown`)
- Create a lockfile with exact package versions

### Working with the project:

- When opening the project, renv will automatically activate (via `.Rprofile`)
- To restore packages when cloning this repo: `renv::restore()`
- To update the lockfile after installing new packages: `renv::snapshot()`
- To install new packages: `renv::install("package_name")`

## Rendering

Render the CV using Quarto:
```bash
quarto render cv.qmd
```

This will generate both HTML and PDF versions of the CV.
