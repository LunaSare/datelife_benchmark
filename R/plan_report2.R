plan_report2 <- drake_plan(
    # aves_spp = load_data(path = "data/0_global/", object_name = aves_spp), # uncomment this when make_datelife_query function works correctly 2019.01.27
    aves_dr = load_data(path = "data/0_global/aves_dr.rda", object_name = aves_dr),
    # aves_phylo = load_data(path = "data/0_global/", object_name = aves_phylo),
    # aves_mat = load_data(path = "data/0_global/", object_name = aves_mat),
    # aves_trees = load_data(path = "data/0_global/", object_name = aves_trees),
    wd = getwd()
)
make(plan_report2)
