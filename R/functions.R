assign_levels <- function(mbk, index, expr){
  for(i in seq_along(index)){
    levels(mbk$expr)[index[i]] <- expr[i]
  }
  mbk
}
make_plot_gfr <- function(mbk, filename, topmargin = 0.5, leftmargin = 0.5, ...){
  pdf(file = paste0("docs/plots/", filename, ".pdf"), height = 3, width = 7)
  plt <- autoplot.gfr(mbk, ...)
  plt <- plt + theme(plot.margin = margin(topmargin, 0.5, 0, leftmargin, "inch"))
  print(plt)
  dev.off()
}
autoplot.gfr <- function (object, log = TRUE, y_min = 0.1, y_max = 1.05 * max(object$time), flip = TRUE, xlab_angle = 270, ylab_angle = 315) {
  object$Time <- microbenchmark:::convert_to_unit(object$time, "t")
  #changing the name of the element itself is the easiest way to make it appear as axis label
  # object$'Query Length' <- object$expr #changing for a name with spaces won't work...
  plt <- ggplot2::ggplot(object, ggplot2::aes_string(x = "expr", y = "Time"))
  plt <- plt + coord_cartesian(ylim = c(y_min, y_max))
  plt <- plt + stat_ydensity()
  # plt <- plt + xlim(levels(object$expr)[length(levels(object$expr)):1])
  # plt <- plt + scale_x_discrete(name = "")
  plt <- plt + theme(axis.text.x = element_text(angle= xlab_angle))
  plt <- plt + theme(axis.text.y = element_text(angle= ylab_angle))
  plt <- if (log) {
    # plt + scale_y_log10(name = sprintf("", attr(object$ntime, "unit")))
    # this does not work...
    # plt + scale_y_log10(name = sprintf("Time", attr(object$ntime, "unit")))
    # this does not work...
    # plt + scale_y_log10(name = "Seconds") # this does not work either...
    plt + scale_y_log10(breaks=c(1e+03, 1e+035, 1e+04, 1e+045, 1e+05),
                        labels=c("1e+03"="1s", "1e+035"="", "1e+04"="10s",
                                 "1e+045"="", "1e+05"="100s"), position="top")
  }
  else {
    plt + scale_y_continuous(name = sprintf("Time [%s]", attr(object$ntime, "unit")))
  }
  if(flip){
    plt <- plt + ggplot2::coord_flip() # these exchanges the axis
    # if I inactivate this and y_min is 0 I get the following Warning message:
    # Transformation introduced infinite values in continuous y-axis
    # that is because log(0) = Inf
  }
  plt
}

make_plot <- function(mbk, filename, dir = "docs"){
  original.dir <- getwd()
  setwd(dir)
  pdf(file = paste0("plots/", filename, ".pdf"), height = 3, width = 7)
  print(microbenchmark:::autoplot.microbenchmark(mbk))
  dev.off()
  setwd(original.dir)
}
load_data <- function(path, object_name){
  load(file = path)
  object <- get(object_name)
  return(object)
}
make_res <- function(ninput, date, path){
  res = c()
	for(i in ninput){
		xname = paste0("aves",i,".1.gfr.runtime_", date)
		xpath = paste0(path, xname, ".RData")
		load(xpath)
		res = rbind(res, get(xname))
	}
  return(res)
}
make_res2 <- function(ninput, prefix, date, path){
  res = c()
	for(i in ninput){
		xname = paste0(prefix, date, "_",i,"_aves_spp")
		xpath = paste0(path, xname, ".RData")
		load(xpath)
		res = rbind(res, get(xname))
	}
  return(res)
}
make_report <- function(rmdname, mdname, placeholder){
  knitr::knit(knitr_in(rmdname), file_out(mdname), quiet = TRUE)
  print(placeholder)
}
render_pdf <- function(reportname, dir, placeholder) {
    original.dir <- getwd()
    setwd(dir)
    system(paste('pandoc', paste0(reportname, '.md'), '-o', paste0(reportname, '.pdf')))
    # system(paste0("pandoc ", file_in, " -o ", file_out))
    setwd(original.dir)
}
