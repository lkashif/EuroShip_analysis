# We want to correlate ship origins with the wind force indicators (Beaufort scale) given in the Lookup_*_WindForce CSVs, as a fcn of time
# origin: Nationality or country of institute where log was retrieved

# cliwoc = read.csv(file="CLIWOC/CLIWOC15.csv",head=TRUE,sep=",", fileEncoding="UTF-8")[,c("WindForce","InstLand","Year")]
# wind = read.csv(file="CLIWOC/Lookup_UK_WindForce.csv",head=TRUE,sep=",", fileEncoding="UTF-8")

bad = numeric(10)
norm = numeric(10)
merged = merge(cliwoc, wind, by="WindForce", incomparables = NA)

for (j in 1:10)
{
	yearStart = 1740 + (j*10)
	yearEnd = yearStart + 10
	norm[j] = length(merged$Beaufort[merged$Year >= yearStart  & merged$Year < yearEnd & !is.na(merged$Beaufort)])
	bad[j] = length(merged$Beaufort[merged$Beaufort > 8 & merged$Year >= yearStart & merged$Year < yearEnd & !is.na(merged$Beaufort)])
}

year = c(1755, 1765, 1775, 1785, 1795, 1805, 1815, 1825, 1835, 1845)
# normalize by total number of entries for ship from given country
frac = bad/norm

# poisson errors for numbers of ships, binomial for the fraction
err_norm_yup = norm + sqrt(norm)
err_norm_ydown = norm - sqrt(norm)
err_bad_yup = bad + sqrt(bad)
err_bad_ydown = bad - sqrt(bad)
err_frac_yup = frac + sqrt(frac*(1-frac)/norm)
err_frac_ydown = frac - sqrt(frac*(1-frac)/norm)

# now plot them vs time
par(mfrow=c(3,1))
plot(year, norm, main='British ships encountering bad weather (Beaufort scale > 8) per decade in period 1750 - 1850', xlab='Year', ylab='Total ships')
arrows(year, err_norm_yup, year, err_norm_ydown, angle=90,length=0.3,code=3)

plot(year, bad, xlab='Year', ylim=c(0, max(err_bad_yup)), ylab='Ships in bad weather')
arrows(year, err_bad_yup, year, err_bad_ydown, angle=90,length=0.3,code=3)

plot(year, frac, ylim=c(0, 0.1), xlab='Year', ylab='Fraction of ships in bad weather')
arrows(year, err_frac_yup, year, err_frac_ydown, angle=90,length=0.3,code=3)