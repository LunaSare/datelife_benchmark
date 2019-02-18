# in this plan we load all the profiles that are already saved on disk to be able to use them for the report
plan_report1_data <- drake_plan(
	ninput = c(10,100,200,300,400,500,700,1000,1500,2000,3000,5000,7000,8000,9000,10000),
	aves.spp = load_data(path = "data/1_datasource/1_name_samples/aves.spp.RData", object_name = "aves.spp"),
	seeds = load_data(path = "data/1_datasource/1_name_samples/seeds.RData", object_name = "seeds"),
	aves400.1.gfr.runtime_2017.12.28 = load_data("data/1_datasource/2_tests/1_same_spp_names/aves400.1.gfr.runtime_2017.12.28.RData",
	                                             object_name = "aves400.1.gfr.runtime_2017.12.28"),
  aves.all.gfr.runtime_2017.12.29 = load_data("data/1_datasource/2_tests/0_all_names/aves.all.gfr.runtime_2017.12.29.RData",
                                              object_name = "aves.all.gfr.runtime_2017.12.29"),
  aves.all.gfr.runtime_2018.01.12 = load_data("data/1_datasource/2_tests/0_all_names/aves.all.gfr.runtime_2018.01.12.RData",
                                              object_name = "aves.all.gfr.runtime_2018.01.12"),
	res28 = make_res(ninput, date = "2017.12.28", path = "data/1_datasource/2_tests/1_same_spp_names/"),
  res29 = make_res(ninput, date = "2017.12.29", path = "data/1_datasource/2_tests/1_same_spp_names/"),
  res01 = make_res2(ninput, prefix = "gfr_runtime_", date = "2018.01.10", path = "data/1_datasource/2_tests/2_random_spp_names/1_gfr/"),
	ninput2 = c(10,100,200,300,400,500,600,700,800,900,1000,2000,3000,5000,7000,8000,9000,10000),
  res04 = make_res2(ninput2, prefix = "gfr_runtime_", date = "2018.04.07", path = "data/1_datasource/2_tests/2_random_spp_names/1_gfr/")
)
# config <- drake_config(plan)
# vis_drake_graph(config)
make(plan_report1_data)
# outdated(config)
# diagnose(plan)
# readd(aves.spp)
loadd(ninput)
loadd(ninput2)
loadd(aves.spp)
loadd(seeds)
loadd(aves400.1.gfr.runtime_2017.12.28)
loadd(aves.all.gfr.runtime_2017.12.29)
loadd(aves.all.gfr.runtime_2018.01.12)
loadd(res29f)
loadd(res29f2)
loadd(res01)
loadd(res04)
plan_report1_pdf <- drake_plan(
  first_test = rbind(aves400.1.gfr.runtime_2017.12.28, aves400.1.gfr.runtime_2017.12.28),
  plot1 = make_plot(mbk = first_test, filename = "plot1_first_test"),
  res28f = rbind(res28, aves.all.gfr.runtime_2017.12.29), # we need to call the target differenty, otherwise it unloads the object named like it from the environment. In this case, this messes up the construction of the object
  plot2 = make_plot(mbk = res28f, filename = "plot2_res28"),
  res29f = rbind(res29, aves.all.gfr.runtime_2017.12.29),
  plot3 = make_plot(mbk = res29f, filename = "plot3_res29"),
  plot4 = make_plot_gfr(mbk = res29f, filename = "plot4_res29", topmargin = 0.5),
  plot4notlog = make_plot_gfr(mbk = res29f, filename = "plot4_res29notlog", topmargin = 0.5, log = FALSE),
  res29f2 = assign_levels(res29f, index = 17, expr = "all names (12750)"),
  plot5 = make_plot_gfr(mbk = res29f2, filename = "plot5_res29", topmargin = 0.5, flip = FALSE, xlab_angle = 90, ylab_angle = 0, y_min = 400, y_max = 1e+5),
  report1 = make_report("docs/report1.Rmd", "docs/report1.md", "done"),
  summary_pdf_report = render_pdf(reportname = "report1", dir = "docs", report1)
)
make(plan_report1_pdf)
