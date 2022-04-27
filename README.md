
<!-- README.md is generated from README.Rmd. Please edit that file -->

# 2020 ACS update + community profiles

Distribution-ready files are in [`to_distro`](to_distro). CSV file for
populating website’s community profiles is in [`website`](website).

## Output

                                                levelName
    1  .                                                 
    2   ¦--fetch_data                                    
    3   ¦   °--acs_basic_2020_fetch_all.rds              
    4   ¦--output_data                                   
    5   ¦   ¦--acs_nhoods_by_city_2020.rds               
    6   ¦   ¦--acs_town_basic_profile_2020.csv           
    7   ¦   ¦--acs_town_basic_profile_2020.rds           
    8   ¦   °--cws_basic_indicators_2021.rds             
    9   ¦--to_distro                                     
    10  ¦   ¦--bridgeport_acs_basic_neighborhood_2020.csv
    11  ¦   ¦--hartford_acs_basic_neighborhood_2020.csv  
    12  ¦   ¦--new_haven_acs_basic_neighborhood_2020.csv 
    13  ¦   ¦--stamford_acs_basic_neighborhood_2020.csv  
    14  ¦   °--town_acs_basic_distro_2020.csv            
    15  °--website                                       
    16      °--5year2020town_profile_expanded_CWS.csv    

## Development

Call `make` to rerun scripts in the proper order. I’ll move the global
year variables (`yr` and `cws_yr`) to the makefile soon.
