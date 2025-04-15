install.packages("ncdf4")
install.packages("openxlsx")

# Set working path
setwd("D:/Data and code/Data/SST_extraction")

# Define the NetCDF filename
f = "sst.mnmean.nc"

# Load ncdf4 package for NetCDF file handling
library(ncdf4)


# Open the NetCDF file
ddd = nc_open(f)

# Get longitude variable data
lons = ncvar_get(ddd,"lon")
# Print longitude data
lons

# Print overall NetCDF file information
print(ddd)

# Get latitude variable data
lats = ncvar_get(ddd,"lat")
# Print latitude data
lats

# Get time variable data
tims = ncvar_get(ddd,"time")
# Print raw time data
tims

# Convert time to actual date format (starting from 1800-01-01)
as.Date(tims,origin="1800-01-01")

# Get sea surface temperature (SST) data
val = ncvar_get(ddd,"sst")

# Check data dimensions
dim(val) # 2037

# Check data type
class(val) # array
nc_close(ddd)



#-------------------- Calculate the annual mean:

head(val[1:5,1:5,])

# Extract year range:
years = 2011:2018
n = substr(as.Date(tims,origin="1800-01-01"),1,4) %in% years
sum(n) # 372
372 / 12

# Extract data within the specified year range:
yval = val[,,n]
dim(yval) # 180 89 372

# -- Generate each year value:
y = c()
for(i in 1:dim(yval)[3])
{
year = 2011+(i-0.001) %/% 12
print(year)
y = c(y,year)
}
table(y) # 12

# -- Merge monthly data into a two-dimensional matrix:
yddd = NULL
for(i in 1:dim(yval)[3])
{
newd = yval[,,i]
newd = data.frame(newd)
dim(newd) # 180 89
colnames(newd) = lats
newd$rows= lons
newd$year = y[i]
print(head(newd))
yddd = rbind(yddd,newd)
}
dim(yddd) # 66960 91
str(yddd)
head(yddd)

#-- Calculate the annual mean (within each grid) :
ymean = aggregate(yddd,by=list(year=yddd$year,lon = yddd$rows),mean,na.rm=T)
head(ymean)
result = ymean[order(ymean$year,ymean$lon),]
head(result)
dim(result) # 5580 93
library(openxlsx)
write.xlsx(result,"Annual mean SST for each raster data.xlsx")



#--------------------Calculate the regional mean:

dir()
qu = read.xlsx( "Geographical coordinates.xlsx" )
head(qu)
head(result)
str(result)

# -- Define a region calculated mean function:
fun_qu = function(x1,x2,y1,y2,year) # x1 = 14; x2=25; y1=36; y2 = 46; year
{
if(x1 > x2)
{
x0 = x2; x2=x1; x1 = x0
}
if(y1 > y2)
{
y0 = y2; y2=y1; y1 = y0
}
n1 = result$year==year
n2 = result$lon >= x1 & result$lon<=x2
n3 = as.numeric(names(result))>=y1 & as.numeric(names(result)) <=y2
n3[is.na(n3)] = F
if(abs(x1-x2)>180)
{
n2 = result$lon>=max(x1,x2) | result$lon<=min(x1,x2)
}
df = result[n1 & n2, n3  ]
df_mean = mean(unlist(df),na.rm=T)
df_mean
}

# -- Calculate the mean within each country region:
max(13,5,9)
fun_qu(3,15,33,45,1990)
i = 2
fun_qu(qu$x1[i],qu$x2[i],qu$y1[i],qu$y2[i],year)
for(i in 1:dim(qu)[1])
{
for(ys in years)
{
qu[i,as.character(ys)]=fun_qu(qu$x1[i],qu$x2[i],qu$y1[i],qu$y2[i],ys)
}
print(i)
}
write.xlsx(qu,"SST annual mean data of each country.xlsx")
