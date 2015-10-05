# EuroShip_analysis
R script to explore a Kaggle dataset: https://www.kaggle.com/c/climate-data-from-ocean-ships

The dataset comprised log entries of ocean-going European ships mostly between the years 1750 and 1850. 

The aim of this preliminary study is to see whether there is a pattern to extreme weather on a scale of decades. I correlate wind force reported in the logs with corresponding Beaufort scale indices. I define extreme weather arbitrarily as Beaufort index > 8 (wind speed > 19 meters per second), the number of such occurrences being normalized by the total number of log entries for all Beaufort indices. I do the exercise separately for British, Spanish and Dutch ships.

A couple of caveat of this study:

  - Log entries made on successive days on the same ship are treated as being uncorrelated, which is incorrect, for example, in cases of single storms spanning multiple days and vast areas of the ocean. 

  - Ship routes are not taken into account, though this can be expected to affect any time variation of extreme weather patterns.

An elaborate statistical analysis involving nations of origin, routes, time variations, and month (ie, season) of year should yield some interesting results.

