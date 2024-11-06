# ----------------------------------------------------------------
#            NOT IN THE SCRIPT, DO THIS IN THE CONSOLE ONLY 
# ----------------------------------------------------------------

# We want to make sure anything we install is saved in a folder called renv.
# This is so we can keep track of the packages we use. For other people to use our code,
# they can just run renv::restore() and it will install all the packages we used.

#  - We *don't* want to have install.packages() in the script or it will 
#    download the packages every time we run the script which is annoying and can
#    break the code if the package versions are different.

#  - When you create a new RProject, you can select a tick box "renv". 
#    If you don't see this, you will need to install renv onto your computer just the once:

#   - install.packages("renv") 
#   or use the Packages pane in RStudio

# Look in your RProject files, if you don't see a folder called renv
# you need to initialise it. 

#   - You can do this by double clicking 
#     your .RProject file in RStudio and going to the colourful "Environment" tab.
#     You'll see a tick box "use renv with this project".

#   - Alternatively you can do this in the console:
#     renv::init()

# Now we can install the packages we need using renv:

# ----Install the packages: ----
# renv::install("tidyverse")
# renv::install("palmerpenguins")
# renv::install("here")
# renv::install("janitor")

# You can use install.packages() to install, but you will need to update renv:
# renv::snapshot()

# Later when we come back to this project, or someone else wants to use it,
# we can restore the packages:
# renv::restore()

# Make sure you have the following files and subfolders in your project:

# - renv/
# - data/
#   - penguins_raw.csv (you should have this from the class, otherwise use the commented out code below)
# - functions/
#   - cleaning.R (get this from canvas)
# - penguin_analysis.Rmd (or .R This file)
# - penguinproject.Rproj
# - renv.lock (this is automatically created when you use renv)



# ----------------------------------------------------------------
#            INSIDE THE SCRIPT 
# ----------------------------------------------------------------

# ---- The top of our RMarkdown file ----

library(tidyverse)
library(palmerpenguins)
library(here)
library(janitor)

# This means we can use our own functions from cleaning.R file.
source(here("functions", "cleaning.R"))
# -------------------------------------

# ---- Save the raw data ----
# This is commented out because we already have the raw data saved.
# write_csv(penguins_raw, here("data", "penguins_raw.csv"))
# -------------------------------------

# ---- Load the raw data ----
penguins_raw <- read_csv(here("data", "penguins_raw.csv"))
# -------------------------------------

# ---- Check column names ----  
colnames(penguins_raw)
# -------------------------------------

# ---- Cleaning the data ----
# We can use the functions from libraries like janitor and also 
# our own functions, like those in cleaning.R. 
# I've used a pipe %>% to chain the functions together. You can also make this
# into a function if you want to (functions within functions).
penguins_clean <- penguins_raw %>%
  clean_column_names() %>%
  remove_columns(c("comments", "delta")) %>%
  shorten_species() %>%
  remove_empty_columns_rows()
# -------------------------------------

# ---- Check the output ----
colnames(penguins_clean)
# -------------------------------------

# ---- Save the clean data ----
write_csv(penguins_clean, here("data", "penguins_clean.csv"))
# -------------------------------------
