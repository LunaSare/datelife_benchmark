reqins_pkg <- function(pkg){
  x <- require(pkg, character.only = TRUE, quietly = TRUE)
  if(!x){
    install.packages(pkg)
    require(pkg, character.only = TRUE, quietly = TRUE)
  }
}

# source("https://bioconductor.org/biocLite.R")
# # # install GUIProfiler depedencies not in cran:
if (!requireNamespace("BiocManager", quietly = TRUE)){
  install.packages("BiocManager")
}
if (!requireNamespace("Rgraphviz", quietly = TRUE)){
  BiocManager::install("Rgraphviz", version = "3.8")
}


pkgs <- c("microbenchmark", "drake", "testthat", "pbapply", "datelife",
          "GUIProfiler", "RCurl", "rmetasim", "graph")
x <- lapply(pkgs, reqins_pkg)
if(!all(unlist(lapply(x, is.null)))){
  print("Some packages could not be loaded")
}
# ?pbapply #adding progress bar to apply functions
# # running profiles graphically: GUIProfiler
