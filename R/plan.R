plan <- drake_plan(
	ninput = c(10,100,200,300,400,500,700,1000,1500,2000,3000,5000,7000,8000,9000,10000),
	aves.spp = load_data(path = "data/1_datasource/1_name_samples/", object_name = "aves.spp"),
	seeds = load_data(path = "data/1_datasource/1_name_samples/", object_name = "seeds"),
	aves400.1.gfr.runtime_2017.12.28 = load_data("data/1_datasource/2_tests/1_same_spp_names/",
	                                             object_name = "aves400.1.gfr.runtime_2017.12.28"),
  aves.all.gfr.runtime_2017.12.29 = load_data("data/1_datasource/2_tests/0_all_names/",
                                              object_name = "aves.all.gfr.runtime_2017.12.29"),
  aves.all.gfr.runtime_2018.01.12 = load_data("data/1_datasource/2_tests/0_all_names/",
                                              object_name = "aves.all.gfr.runtime_2018.01.12"),
	res28 = make_res(ninput, date = "2017.12.28", path = "data/1_datasource/2_tests/1_same_spp_names/"),
  res29 = make_res(ninput, date = "2017.12.29", path = "data/1_datasource/2_tests/1_same_spp_names/"),
  res01 = make_res2(ninput, prefix = "gfr_runtime_", date = "2018.01.10", path = "data/1_datasource/2_tests/2_random_spp_names/1_gfr/"),
	ninput2 = c(10,100,200,300,400,500,600,700,800,900,1000,2000,3000,5000,7000,8000,9000,10000),
  res04 = make_res2(ninput2, prefix = "gfr_runtime_", date = "2018.04.07", path = "data/1_datasource/2_tests/2_random_spp_names/1_gfr/"),
	report1 = knitr::knit(knitr_in("docs/report1.Rmd"), file_out("docs/report1.md"), quiet = TRUE),
  summary_pdf_report = render_pdf("report1.md", "report1.pdf", "docs", report1)
)
# config <- drake_config(plan)
# vis_drake_graph(config)
make(plan)
# outdated(config)
# diagnose(plan)
readd(aves.spp)
