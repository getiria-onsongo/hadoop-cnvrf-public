cnv_random_forest_classify <- function(path_to_train,path_to_test,path_to_output){
    # Read in training dataset
    training <- read.table(path_to_train, sep = "\t");
    # Read in test (identified) dataset
    test <- read.table(path_to_test, sep = "\t");
    # Combine the two so we can do feature scaling and mean normalization
    
    combined <- rbind(training, test);
    
    # Add column name
    colnames(combined)<- c("time_stamp","username","sample","control","window_id","gene","avg_cnv_ratio","avg_bowtie_bwa_ratio","bb_std","cnv_ratio_std","cov_std","avg_cov","avg_dup_ratio","gc_perc","allele_freq","read_stats","is_training","het_classification");
    # Create output data frame
    classified_output <- test;
    colnames(classified_output)<- c("time_stamp","username","sample","control","window_id","gene","avg_cnv_ratio","avg_bowtie_bwa_ratio","bb_std","cnv_ratio_std","cov_std","avg_cov","avg_dup_ratio","gc_perc","allele_freq","read_stats","is_training","het_classification");
    
    # Do feature scaling and mean normalization
    combined[,"avg_cnv_ratio"] <- scale_n_mean_normalize_column(as.numeric(combined[,"avg_cnv_ratio"]));
    combined[,"bb_std"] <- scale_n_mean_normalize_column(as.numeric(combined[,"bb_std"]));
    combined[,"cnv_ratio_std"] <- scale_n_mean_normalize_column(as.numeric(combined[,"cnv_ratio_std"]));
    combined[,"cov_std"] <- scale_n_mean_normalize_column(as.numeric(combined[,"cov_std"]));
    combined[,"avg_cov"] <- scale_n_mean_normalize_column(as.numeric(combined[,"avg_cov"]));
    combined[,"avg_dup_ratio"] <- scale_n_mean_normalize_column(as.numeric(combined[,"avg_dup_ratio"]));
    combined[,"gc_perc"] <- scale_n_mean_normalize_column(as.numeric(combined[,"gc_perc"]));
    combined[,"allele_freq"] <- scale_n_mean_normalize_column(as.numeric(combined[,"allele_freq"]));
    combined[,"read_stats"] <- scale_n_mean_normalize_column(as.numeric(combined[,"read_stats"]));

    dataTrain = combined[combined$is_training == 1,]
    dataTest = combined[combined$is_training == 0,]
    
    dataTrain[,18] <- as.factor(dataTrain[,18]);
    dataTest[,18] <- as.factor(dataTest[,18]);
    
    # NOTE: class in the formula below contains the different classes we want to classify. In out case 1 if it is a true het variant
    r_formula <- formula(het_classification ~ avg_cnv_ratio + bb_std + cnv_ratio_std + cov_std + avg_cov + avg_dup_ratio + gc_perc + allele_freq + read_stats);
    randomForestmodel <- randomForest(r_formula, data=dataTrain);
    
    predict_forest <-predict(randomForestmodel,type="class",newdata=dataTest);
    classified_output[,18] <- predict_forest;
    write.table(classified_output, path_to_output, sep="\t",row.names=FALSE);
}

scale_n_mean_normalize_column <- function(data_column){
    if(max(data_column,na.rm=TRUE) == min(data_column,na.rm=TRUE)){
        data_column <- data_column - mean(data_column,na.rm=TRUE);
    }else{
        data_column <- (data_column - mean(data_column,na.rm=TRUE))/(max(data_column,na.rm=TRUE) - min(data_column,na.rm=TRUE));
    }
    return (data_column);
}

file_paths = readLines("cnv_rf_data_paths.txt")

training_data <- strsplit(file_paths[grepl("training_data", file_paths)],"=")[[1]][2];
sample_name <- strsplit(file_paths[grepl("sample_name", file_paths)],"=")[[1]][2];
ident_het_path <- strsplit(file_paths[grepl("ident_het_path", file_paths)],"=")[[1]][2];
classified_het_path <- strsplit(file_paths[grepl("classified_het_path", file_paths)],"=")[[1]][2];   
R_libs <- strsplit(file_paths[grepl("R_libs", file_paths)],"=")[[1]][2];

cmd <- paste("hadoop", "fs", "-getmerge", ident_het_path, "ident_het.txt", sep=" ");
cmd_response <- try(system(cmd, intern = TRUE));

print(R_libs)
library('randomForest',lib.loc =R_libs);
cnv_random_forest_classify(training_data,"ident_het.txt","classified_het_data.txt")

cmd <- paste("hadoop", "fs", "-put", "classified_het_data.txt", classified_het_path, sep=" ");
cmd_response <- try(system(cmd, intern = TRUE));

# clean up
cmd <- paste("rm", "-rf", "ident_het.txt", sep=" ");
cmd_response <- try(system(cmd, intern = TRUE));

cmd <- paste("rm", "-rf", "classified_het_data.txt", sep=" ");
cmd_response <- try(system(cmd, intern = TRUE));
