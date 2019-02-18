for(samp in c(0.25, 0.5, 0.75)){
    gac_mbk <- uac_mbk <- data.frame()
    # trees <- rep(list(vector(mode = "list", length = 100)), length(tip_number))
    for (i in seq(length(tip_number))){
        for (j in 1:100){
            print(paste("samp", samp*100, "matrix", i, "rep", j))
            matname <- paste0("samp", samp*100, "_mat", i, "_", j)
            load(file = paste0("data/0_global/aves_mat/", matname, ".rda"))
            phy <- patristic_matrix_to_phylo(patristic_matrix = get(matname))
            y <- microbenchmark(df <- get_all_calibrations(input= phy), times=1L)
            levels(y$expr)[1] <- paste0("samp", samp*100, "_mat", i)
            gac_mbk <- rbind(gac_mbk, y)
            obj_name <- paste0(matname, "_gac")
            assign(value = df, x = obj_name)
            save(list = obj_name, file = paste0("data/2_datagen/results/", obj_name, ".rda"))
            rm(list = obj_name)
            phyname <- paste0("aves_tree_", tip_number[i])
            load(paste0("data/0_global/aves_targets/", phyname, ".rda"))
            phy <- get(phyname)
            y <- microbenchmark(tree <- use_all_calibrations(phy = phy, all_calibrations = df), times=1L)
            levels(y$expr)[1] <- paste0("samp", samp*100, "_mat", i)
            uac_mbk <- rbind(uac_mbk, y)
            obj_name <- paste0(matname, "_uac")
            assign(value = tree, x = obj_name)
            save(list = obj_name, file = paste0("data/2_datagen/results/", obj_name, ".rda"))
            rm(list = obj_name)
            rm(df, tree, matname, phyname)
        }
    }
    obj_name <- paste0("samp", samp*100, "_gac_mbk")
    assign(value = gac_mbk, x = obj_name)
    save(list = obj_name, file = paste0("data/2_datagen/", obj_name, ".rda"))
    rm(list = obj_name)
    obj_name <- paste0("samp", samp*100, "_uac_mbk")
    assign(value = uac_mbk, x = obj_name)
    save(list = obj_name, file = paste0("data/2_datagen/", obj_name, ".rda"))
    rm(list = obj_name)
}

remv <- ls()
remv <- remv[grepl("samp25_mat", remv)]
remv
rm(list = remv)
