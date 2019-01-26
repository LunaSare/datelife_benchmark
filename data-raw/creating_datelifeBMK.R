install.packages("usethis")
library(usethis)
setwd("~/datelife_benchmark")
create_package("datelife_benchmark")
use_data_raw()
use_readme_md()
load("~/Desktop/datelife/data-raw/benchmark/runtime_tests/2_tests/0_all_names/aves.all.gfr.runtime_2017.12.29.RData")
use_data(aves.all.gfr.runtime_2017.12.29)



# Miercoles 27 a Viernes 28 de Diciembre 2017
# testing fns run time with Rprof() function
Rprof(filename = "make_bold_otol_tree_Rprof_1", append = FALSE, interval = 0.02,
       memory.profiling = TRUE, gc.profiling = FALSE,
       line.profiling = TRUE, numfiles = 100L, bufsize = 10000L)
asd <- "((Zea mays,Oryza sativa),((Arabidopsis thaliana,(Glycine max,Medicago sativa)),Solanum lycopersicum)Pentapetalae);"
asd.bt <- make_bold_otol_tree(asd)
Rprof(NULL)
# # running profiles graphically

library(GUIProfiler)
?GUIProfiler
x <- summaryRprof(filename = "make_bold_otol_tree_Rprof_1")
ls(x)


