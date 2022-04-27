YR=2020
CWS_YR=2021

.PHONY: all
all: distro_nhood distro_town

make_meta: utils/$(YR)_website_meta.rds
fetch_acs: fetch_data/acs_basic_$(YR)_fetch_all.rds
calc_cws: output_data/cws_basic_indicators_$(CWS_YR).rds
calc_acs_town: output_data/acs_town_basic_profile_$(YR).rds
distro_nhood: output_data/acs_nhoods_by_city_$(YR).rds
distro_town: website/5year$(YR)town_profile_expanded_CWS.csv

# writes website_meta, downloads reg_puma_list
utils/$(YR)_website_meta.rds: scripts/00_make_meta.R
	Rscript $< $(YR) $(CWS_YR)
	
# writes acs_basic_2020_fetch_all
fetch_data/acs_basic_$(YR)_fetch_all.rds: scripts/01_fetch_acs_data.R
	Rscript $< $(YR) $(CWS_YR)
	
# writes cws_basic_indicators_2021
output_data/cws_basic_indicators_$(CWS_YR).rds: scripts/02_calc_cws_data.R
	Rscript $< $(YR) $(CWS_YR)
	
# writes acs_town_basic_profile_2020.csv, acs_town_basic_profile_2020.rds, to_distro/town_acs_basic_distro_2020.rds
output_data/acs_town_basic_profile_$(YR).rds to_distro/town_acs_basic_distro_$(YR).csv: scripts/03_calc_acs_towns.R fetch_acs utils/indicator_headings.txt
	Rscript $< $(YR) $(CWS_YR)
	
# writes acs_nhoods_by_city_2020.rds, csv per city
output_data/acs_nhoods_by_city_$(YR).rds: scripts/04_calc_acs_nhoods.R fetch_acs utils/indicator_headings.txt
	Rscript $< $(YR) $(CWS_YR)
# writes 5year2020town_profile_expanded_CWS.csv
website/5year$(YR)town_profile_expanded_CWS.csv: scripts/05_assemble_for_distro.R make_meta calc_acs_town utils/indicator_headings.txt
	Rscript $< $(YR) $(CWS_YR)

cleanall:
	rm -f output_data/* to_distro/*
