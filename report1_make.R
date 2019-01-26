source("R/packages.R")  # Load all the packages you need.
pkgconfig::set_config("drake::strings_in_dots" = "literals")
knitr::opts_knit$set(root.dir = "docs")
knitr::opts_knit$set(base.dir = "docs")

file.exists("docs/report1.Rmd")
source("R/functions.R") # Load all the functions into your environment.
source("R/plan.R")      # Build your workflow plan data frame.

#drake::clean("report", "pdf_report", "summary_report", "summary_pdf_report")
drake::clean("summary_report", "summary_pdf_report", "save_free", "all_free")

#if (file.exists("docs/index.md")) file.remove("docs/index.md") # so we always make fresh
make(report_background)

print("made background")
