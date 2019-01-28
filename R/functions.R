load_data <- function(path, object_name){
  load(path)
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
render_pdf <- function(file_in, file_out, dir, placeholder) {
    original.dir <- getwd()
    setwd(dir)
    system(paste0("pandoc ", file_in, " -o ", file_out))
    setwd(original.dir)
}
