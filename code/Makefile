all:	dsc-vash dsc-gtex-vash

dsc-vash:	./dsc-vash/dsc-vash-files/res.RData	
dsc-gtex-vash:	./dsc-gtex-vash/dsc-gtex-files/res_scaled.RData	

./dsc-vash/dsc-vash-files/res.RData:
	cd dsc-vash; R CMD BATCH run_dsc.R

./dsc-gtex-vash/dsc-gtex-files/res_scaled.RData:
	cd dsc-gtex-vash; R CMD BATCH run_dsc_agg.R