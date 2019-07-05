#######################################################################
########### EJUF Code to Evaluate Landlord Data for Bailey ############
########################## Joan Meiners 2017 ##########################

## Trying to figure out who are landlords by who owes multiple properties, 
## and which properties and landlords have most reported code violations

parent_dir = dirname(rstudioapi::getSourceEditorContext()$path)
setwd(parent_dir)

library(dplyr)
library(plyr)
library(ggplot2)

# load initial dataset from bailey of addresses and owners, 
# just for zip 32641 (see end of script for code sorting all addresses by number 
# of owners and violations)
bailey = read.csv("Energy-Poverty 32641 homes.csv")

levels(bailey$OWNERNME1) # how many different property owners are there
dim(bailey)

# count properties per owner and sort owners by how many properties they own
landlords = dplyr::count(bailey, OWNERNME1, sort = TRUE)

# only keep owners that have more than one property = likely landlords
landlords = subset(landlords, n>1) 

View(landlords)

# calculate the total cost of utilities per owner
by_owner = group_by(bailey, OWNERNME1)
utilities = dplyr::summarise(by_owner, cost = sum(Unit.Utilities.Cost))
View(utilities)

# combine datasets on who the likely landlords are with how many properties 
# they own and the combined utility cost at those properties 
# (only for zip code 32641)
ownercost = plyr::join(landlords, utilities, by = 'OWNERNME1')
View(ownercost)
colnames(ownercost)[colnames(ownercost)=="n"] <- "num_properties" # rename column

# add column of average utility cost per property for each owner
ownercost$cost_per_property = ownercost$cost / ownercost$num_properties 

# save dataset to file
write.csv(ownercost, file = "owner_cost.csv", row.names=FALSE)


## Now looking at landlord data to find out which addresess have had the most complainst against them
# load data on reported code violations
violations = read.csv("Bailey_landlord.csv", header= TRUE)
dim(violations)
View(violations)

# code to group the reported code violations by address, 
# commented out because saved result is loaded from repository in next step
addresses = violations %>% 
  dplyr::group_by(PrimaryParty, Address) %>% 
  dplyr::summarise(viol_per_address = n())
addresses = addresses[order(-addresses$viol_per_address),] # sort in order of decreasing number of code violations
View(addresses)
write.csv(addresses, "worst_addresses.csv", row.names = FALSE) # save to file

# load file created in commented out code above for addresses with the most code violations, and who ownes them
addresses = read.csv("worst_addresses.csv", header = TRUE)

adds = tidyr::separate(addresses, Address, into = c("Number", "Street"), sep = "\\ ", extra = "merge")

# reformat addresses and pull in zip code information from another dataset
# number coded as a five digit with leading zeros, separate out and classify as numeric 
# to remove differing numbers of leading zeros from address number
adds$Number = as.numeric(adds$Number)

# paste address number and street fields back together
adds$ADDRESS = paste(adds$Number, adds$Street, sep=" ")

adds$viols = adds$viol_per_address # rename column

adds = subset(adds, select = c("ADDRESS", "viols"))
adds$ADDRESS = trimws(adds$ADDRESS) # remove extra whitespace from address field
dim(adds)

# pull in cleaned dataset on property values from Hal Knowles
value = read.csv("value.csv", header = TRUE)
zipviol = plyr::join(adds, value, by = "ADDRESS") # join property value to code violations dataset by address
zipviol = subset(zipviol, POSTAL != "NA" & CNTASSDVALUE > 20000, select = c("ADDRESS", "POSTAL", "viols", "CNTASSDVALUE")) # filter out any addresses without a zip code and those valued at below $20,000 as likely not a residence
zipviol$viols = as.numeric(zipviol$viols)
zipviol$POSTAL = as.factor(zipviol$viols)

# look for trends in violations per zip code
hist(zipviol$viols) # need to transform

# zero-inflated, probably passable for this simple analysis -- checked 
# and still significant when add 1 to values or restrict to addresses with multiple code violations,
# but this allows us to still look at those addresses with only one code violation for 
# comparison along property value gradient
hist(log10(zipviol$viols)) 
hist(log10(zipviol$CNTASSDVALUE)) # normal
violzip = glm(log10(viols) ~ log10(CNTASSDVALUE), data = zipviol)
summary(violzip)
violzip

# plot number of code violations per address against the property value of address
quartz(width = 12, height = 6) # this is view window, to save figure to file, turn on line below instead of this one
# tiff(filename = "Violations_value.tiff", units = "in", compression = "lzw", res = 300, width = 12, height = 6)
ggplot(aes(y = viols, x = CNTASSDVALUE), data = zipviol) +
  scale_x_log10(breaks = c(2000000 ,200000, 20000), labels = function(x) paste0("$", scales::comma(x))) +
  geom_point(color = "grey") +
  xlab("County-assessed Property Value (USD)") + ylab("Number of code violations per address") +
  theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=15)) +
  theme(axis.text = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=12)) +
  geom_smooth(method = "lm", se=FALSE, color="darkgreen")
# dev.off()

# arrange data by owners with most addresses
owners = addresses %>% 
  dplyr::group_by(PrimaryParty) %>% 
  dplyr::summarize(addresses_per_owner = n())
owners = owners[order(-owners$addresses_per_owner),]
View(owners)

# arrange data by owners with most code violations
viol = subset(addresses[, c("PrimaryParty", "viol_per_address")])
viol = viol %>% 
  dplyr::group_by(PrimaryParty) %>% 
  dplyr::summarize(violations_per_owner = sum(viol_per_address))
viol = viol[order(-viol$violations_per_owner),]
View(viol)
  
# combine datasets on number of properties and number of code violations by owner
owner_violations = plyr::join(viol, owners, by = "PrimaryParty")
owner_violations$avg_owner_violations_per_address = owner_violations$violations_per_owner / owner_violations$addresses_per_owner
owner_violations = subset(owner_violations, addresses_per_owner > 1)
owner_violations = owner_violations[order(-owner_violations$avg_owner_violations_per_address),]
View(owner_violations)

# write out file of most code-violating owners
write.csv(owner_violations, "owner_violations", row.names = FALSE)
