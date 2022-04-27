# meta = utils/2020_website_meta.rds
# fetch_acs = fetch_data/acs_basic_2020_fetch_all.rds
# calc_cws = output_data/cws_basic_indicators_2021.rds
# calc_acs_town = output_data/acs_town_basic_profile_2020.rds
# distro_nhood = output_data/acs_nhoods_by_city_2020.rds
# distro_town = website/5year2020town_profile_expanded_CWS.csv


.PHONY: all
all: output_data/acs_nhoods_by_city_2020.rds website/5year2020town_profile_expanded_CWS.csv

# writes website_meta, downloads reg_puma_list
utils/2020_website_meta.rds: scripts/00_make_meta.R
	Rscript $<
	
# writes acs_basic_2020_fetch_all
fetch_data/acs_basic_2020_fetch_all.rds: scripts/01_fetch_acs_data.R
	Rscript $<
	
# writes cws_basic_indicators_2021
output_data/cws_basic_indicators_2021.rds: scripts/02_calc_cws_data.R
	Rscript $<
	
# writes acs_town_basic_profile_2020.csv, acs_town_basic_profile_2020.rds, to_distro/town_acs_basic_distro_2020.rds
output_data/acs_town_basic_profile_2020.rds to_distro/town_acs_basic_distro_2020.csv: scripts/03_calc_acs_towns.R fetch_data/acs_basic_2020_fetch_all.rds utils/indicator_headings.txt
	Rscript $<
	
# writes acs_nhoods_by_city_2020.rds, csv per city
output_data/acs_nhoods_by_city_2020.rds: scripts/04_calc_acs_nhoods.R fetch_data/acs_basic_2020_fetch_all.rds utils/indicator_headings.txt
	Rscript $<

# writes 5year2020town_profile_expanded_CWS.csv
website/5year2020town_profile_expanded_CWS.csv: scripts/05_assemble_for_distro.R utils/2020_website_meta.rds output_data/acs_town_basic_profile_2020.rds utils/indicator_headings.txt
	Rscript $<


cleanall:
	rm -f output_data/* to_distro/*
