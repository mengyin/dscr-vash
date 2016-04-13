all: rrmse rrmse_gtex tissuepairs

rrmse:
	R CMD BATCH plot_rrmse.R

rrmse_gtex:
	R CMD BATCH plot_rrmse_gtex.R

tissuepairs:
	R CMD BATCH choose_tissue_pair.R

.PHONY: clean
clean:
	$(RM) ../paper/*.eps