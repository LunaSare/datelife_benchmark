install.packages("pbapply")
install.packages("GUIProfiler")
# # # install GUIProfiler depedencies not in cran:
install.packages("RCurl")
install.packages("rmetasim")
# source("https://bioconductor.org/biocLite.R")
biocLite("Rgraphviz")
# # # # retry installation of packages that had non-sero exit status

biocLite("graph")
