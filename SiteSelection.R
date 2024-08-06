
install.packages("jpeg")
install.packages("raster")
install.packages("devtools")
install.packages("dplyr")


#USING coveR
#instructions- https://canopyphotography.wordpress.com/2022/01/15/cover-an-r-package-for-processing-digital-cover-images-of-tree-canopies/
devtools::install_gitlab("fchianucci/coveR")


###################GETTING CANOPY COVER

###ANALYZING N IMAGES

process_image <- function(image_path) {
  tryCatch({
    res <- coveR(image_path, exif = TRUE, gapmethod = 'macfarlane', thd = 0.5 / 100, k = 0.65, export.image = TRUE)
    res$filename <- basename(image_path)  # Add the filename to the result
    
    # Convert to data frame and ensure consistent column names
    res_df <- as.data.frame(res)
    return(res_df)
  }, error = function(e) {
    message("Error processing image ", image_path, ": ", e)
    return(NULL)
  })
}

# List all image files in the directory
image_dir <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/N"
image_files <- list.files(image_dir, pattern = "\\.jpg$", full.names = TRUE)

# Process all images and compile results into a data frame
results_list <- lapply(image_files, process_image)

# Remove NULL results from the list
results_list <- Filter(Negate(is.null), results_list)
# Combine all results into a single data frame
results_df <- bind_rows(results_list)

# Print the resulting data frame
print(results_df)

# Optionally, save the data frame to a CSV file
write.csv(results_df, file = "/Users/reymendez/Desktop/SiteSelection/Canopycover/N.csv", row.names = FALSE)

##########Plot Processed and Original Images Together for Comparison
###Make File Names match

folder_path <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/Nresults"

# List the files in the folder
files <- list.files(folder_path, full.names = TRUE)

# Loop through each file and rename it
for (file in files) {
  # Get the base file name (without path)
  base_name <- basename(file)
  
  # Remove "class" from the file name
  new_base_name <- gsub("class_", "", base_name)
  
  # Define the new file name with full path
  new_file <- file.path(folder_path, new_base_name)
  
  # Rename the file
  file.rename(file, new_file)
}

print("File renaming completed.")

#Put Images Together
install.packages("magick")
install.packages("ggplot2")

library(magick)
library(ggplot2)

# Define the directories
folder1 <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/N"
folder2 <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/Nresults"
output_folder <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/IMAGE_CHECK/N_IMAGE_CHECK"

# List the files in both folders
files1 <- list.files(folder1, full.names = TRUE)
files2 <- list.files(folder2, full.names = TRUE)

# Find common files
common_files <- intersect(basename(files1), basename(files2))

# Ensure the output folder exists
if (!dir.exists(output_folder)) {
  dir.create(output_folder)
}

# Loop through the common files, combine and save the images
for (file in common_files) {
  # Read images from both folders
  img1 <- image_read(file.path(folder1, file))
  img2 <- image_read(file.path(folder2, file))
  
  # Combine images side by side
  combined_img <- image_append(c(img1, img2))
  
  # Save the combined image
  image_write(combined_img, path = file.path(output_folder, file))
}

####ANALYZING 0.5 IMAGES

library(coveR)
library(jpeg)
library(dplyr)
## AUTOMATING IMAGE ANALYSIS

# Define the image processing function
process_image <- function(image_path) {
  tryCatch({
    res <- coveR(image_path, exif = TRUE, gapmethod = 'macfarlane', thd = 0.5 / 100, k = 0.65, export.image = TRUE)
    res$filename <- basename(image_path)  # Add the filename to the result
    
    # Convert to data frame and ensure consistent column names
    res_df <- as.data.frame(res)
    return(res_df)
  }, error = function(e) {
    message("Error processing image ", image_path, ": ", e)
    return(NULL)
  })
}

# List all image files in the directory
image_dir <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/0.5"
image_files <- list.files(image_dir, pattern = "\\.jpg$", full.names = TRUE)

# Process all images and compile results into a data frame
results_list <- lapply(image_files, process_image)

# Remove NULL results from the list
results_list <- Filter(Negate(is.null), results_list)
# Combine all results into a single data frame
results_df <- bind_rows(results_list)

# Print the resulting data frame
print(results_df)

# Optionally, save the data frame to a CSV file
write.csv(results_df, file = "/Users/reymendez/Desktop/SiteSelection/Canopycover/0.5.csv", row.names = FALSE)

##########Plot Processed and Original Images Together for Comparison
###Make File Names match

folder_path <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/0.5results"

# List the files in the folder
files <- list.files(folder_path, full.names = TRUE)

# Loop through each file and rename it
for (file in files) {
  # Get the base file name (without path)
  base_name <- basename(file)
  
  # Remove "class" from the file name
  new_base_name <- gsub("class_", "", base_name)
  
  # Define the new file name with full path
  new_file <- file.path(folder_path, new_base_name)
  
  # Rename the file
  file.rename(file, new_file)
}

print("File renaming completed.")

#Put Images Together
install.packages("magick")
install.packages("ggplot2")

library(magick)
library(ggplot2)

# Define the directories
folder1 <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/0.5"
folder2 <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/0.5results"
output_folder <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/IMAGE_CHECK/0.5_IMAGE_CHECK"

# List the files in both folders
files1 <- list.files(folder1, full.names = TRUE)
files2 <- list.files(folder2, full.names = TRUE)

# Find common files
common_files <- intersect(basename(files1), basename(files2))

# Ensure the output folder exists
if (!dir.exists(output_folder)) {
  dir.create(output_folder)
}

# Loop through the common files, combine and save the images
for (file in common_files) {
  # Read images from both folders
  img1 <- image_read(file.path(folder1, file))
  img2 <- image_read(file.path(folder2, file))
  
  # Combine images side by side
  combined_img <- image_append(c(img1, img2))
  
  # Save the combined image
  image_write(combined_img, path = file.path(output_folder, file))
}


####ANALYZING 1 IMAGES

library(coveR)
library(jpeg)
library(dplyr)
## AUTOMATING IMAGE ANALYSIS

# Define the image processing function
process_image <- function(image_path) {
  tryCatch({
    res <- coveR(image_path, exif = TRUE, gapmethod = 'macfarlane', thd = 0.5 / 100, k = 0.65, export.image = TRUE)
    res$filename <- basename(image_path)  # Add the filename to the result
    
    # Convert to data frame and ensure consistent column names
    res_df <- as.data.frame(res)
    return(res_df)
  }, error = function(e) {
    message("Error processing image ", image_path, ": ", e)
    return(NULL)
  })
}

# List all image files in the directory
image_dir <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/1"
image_files <- list.files(image_dir, pattern = "\\.jpg$", full.names = TRUE)

# Process all images and compile results into a data frame
results_list <- lapply(image_files, process_image)

# Remove NULL results from the list
results_list <- Filter(Negate(is.null), results_list)
# Combine all results into a single data frame
results_df <- bind_rows(results_list)

# Print the resulting data frame
print(results_df)

# Optionally, save the data frame to a CSV file
write.csv(results_df, file = "/Users/reymendez/Desktop/SiteSelection/Canopycover/1.csv", row.names = FALSE)

##########Plot Processed and Original Images Together for Comparison
###Make File Names match

folder_path <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/1results"

# List the files in the folder
files <- list.files(folder_path, full.names = TRUE)

# Loop through each file and rename it
for (file in files) {
  # Get the base file name (without path)
  base_name <- basename(file)
  
  # Remove "class" from the file name
  new_base_name <- gsub("class_", "", base_name)
  
  # Define the new file name with full path
  new_file <- file.path(folder_path, new_base_name)
  
  # Rename the file
  file.rename(file, new_file)
}

print("File renaming completed.")

#Put Images Together
install.packages("magick")
install.packages("ggplot2")

library(magick)
library(ggplot2)

# Define the directories
folder1 <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/1"
folder2 <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/1results"
output_folder <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/IMAGE_CHECK/1_IMAGE_CHECK"

# List the files in both folders
files1 <- list.files(folder1, full.names = TRUE)
files2 <- list.files(folder2, full.names = TRUE)

# Find common files
common_files <- intersect(basename(files1), basename(files2))

# Ensure the output folder exists
if (!dir.exists(output_folder)) {
  dir.create(output_folder)
}

# Loop through the common files, combine and save the images
for (file in common_files) {
  # Read images from both folders
  img1 <- image_read(file.path(folder1, file))
  img2 <- image_read(file.path(folder2, file))
  
  # Combine images side by side
  combined_img <- image_append(c(img1, img2))
  
  # Save the combined image
  image_write(combined_img, path = file.path(output_folder, file))
}

####ANALYZING 1.5 IMAGES

library(coveR)
library(jpeg)
library(dplyr)

## AUTOMATING IMAGE ANALYSIS

# Define the image processing function
process_image <- function(image_path) {
  tryCatch({
    res <- coveR(image_path, exif = TRUE, gapmethod = 'macfarlane', thd = 0.5 / 100, k = 0.65, export.image = TRUE)
    res$filename <- basename(image_path)  # Add the filename to the result
    
    # Convert to data frame and ensure consistent column names
    res_df <- as.data.frame(res)
    return(res_df)
  }, error = function(e) {
    message("Error processing image ", image_path, ": ", e)
    return(NULL)
  })
}

# List all image files in the directory
image_dir <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/N/NPOL242-N"
image_files <- list.files(image_dir, pattern = "\\.jpg$", full.names = TRUE)

# Process all images and compile results into a data frame
results_list <- lapply(image_files, process_image)

# Remove NULL results from the list
results_list <- Filter(Negate(is.null), results_list)
# Combine all results into a single data frame
results_df <- bind_rows(results_list)

# Print the resulting data frame
print(results_df)

# Optionally, save the data frame to a CSV file
write.csv(results_df, file = "/Users/reymendez/Desktop/SiteSelection/Canopycover/1.5.csv", row.names = FALSE)

##########Plot Processed and Original Images Together for Comparison
###Make File Names match

folder_path <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/1.5results"

# List the files in the folder
files <- list.files(folder_path, full.names = TRUE)

# Loop through each file and rename it
for (file in files) {
  # Get the base file name (without path)
  base_name <- basename(file)
  
  # Remove "class" from the file name
  new_base_name <- gsub("class_", "", base_name)
  
  # Define the new file name with full path
  new_file <- file.path(folder_path, new_base_name)
  
  # Rename the file
  file.rename(file, new_file)
}

print("File renaming completed.")

#Put Images Together
install.packages("magick")
install.packages("ggplot2")

library(magick)
library(ggplot2)

# Define the directories
folder1 <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/1.5"
folder2 <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/1.5results"
output_folder <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/IMAGE_CHECK/1.5_IMAGE_CHECK"

# List the files in both folders
files1 <- list.files(folder1, full.names = TRUE)
files2 <- list.files(folder2, full.names = TRUE)

# Find common files
common_files <- intersect(basename(files1), basename(files2))

# Ensure the output folder exists
if (!dir.exists(output_folder)) {
  dir.create(output_folder)
}

# Loop through the common files, combine and save the images
for (file in common_files) {
  # Read images from both folders
  img1 <- image_read(file.path(folder1, file))
  img2 <- image_read(file.path(folder2, file))
  
  # Combine images side by side
  combined_img <- image_append(c(img1, img2))
  
  # Save the combined image
  image_write(combined_img, path = file.path(output_folder, file))
}

###### MAKINGA NEST ID COLUMN IN THE IMAGE CANOPY COVER DATA

###N

# Install and load necessary packages
install.packages("tidyverse")
library(tidyverse)

# Example path to input and output CSV file (same file)
file_path <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/N.csv"

# Read the CSV file into a data frame
df <- read.csv(file_path, stringsAsFactors = FALSE)

# Modify the data frame as needed, for example:
df <- df %>%
  mutate(NestID = str_extract(id, "^[^-]+"))

# Write the modified data frame back to the same CSV file
write.csv(df, file_path, row.names = FALSE)

print("File processing completed and saved.")


###0.5

# Install and load necessary packages
install.packages("tidyverse")
library(tidyverse)

# Example path to input and output CSV file (same file)
file_path <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/0.5.csv"

# Read the CSV file into a data frame
df <- read.csv(file_path, stringsAsFactors = FALSE)

# Modify the data frame as needed, for example:
df <- df %>%
  mutate(NestID = str_extract(id, "^[^-]+"))

# Write the modified data frame back to the same CSV file
write.csv(df, file_path, row.names = FALSE)

print("File processing completed and saved.")


###1

# Install and load necessary packages
install.packages("tidyverse")
library(tidyverse)

# Example path to input and output CSV file (same file)
file_path <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/1.csv"

# Read the CSV file into a data frame
df <- read.csv(file_path, stringsAsFactors = FALSE)

# Modify the data frame as needed, for example:
df <- df %>%
  mutate(NestID = str_extract(id, "^[^-]+"))

# Write the modified data frame back to the same CSV file
write.csv(df, file_path, row.names = FALSE)

print("File processing completed and saved.")


###1.5

# Install and load necessary packages
install.packages("tidyverse")
library(tidyverse)

# Example path to input and output CSV file (same file)
file_path <- "/Users/reymendez/Desktop/SiteSelection/Canopycover/1.5.csv"

# Read the CSV file into a data frame
df <- read.csv(file_path, stringsAsFactors = FALSE)

# Modify the data frame as needed, for example:
df <- df %>%
  mutate(NestID = str_extract(id, "^[^-]+"))

# Write the modified data frame back to the same CSV file
write.csv(df, file_path, row.names = FALSE)

print("File processing completed and saved.")

####################MERGING MY DATA AND CANOPY COVER DATA

###N

# Step 1: Load the CSV files
file1 <- read.csv("/Users/reymendez/Desktop/SiteSelection/Canopycover/N.csv")
file2 <- read.csv("/Users/reymendez/Desktop/SiteSelection/Data_Entry.csv")

# Step 2: Merge only the "CC" column from file1 into file2 based on the shared column
merged_data <- merge(file2, file1[, c("NestID", "CC")], by = "NestID", all.x = TRUE)

# Step 3: Rename the merged column to "NewColumnName"
colnames(merged_data)[which(names(merged_data) == "CC")] <- "CanopyCoverN"

# Step 4: Overwrite file2.csv with the merged and renamed data
write.csv(merged_data, "/Users/reymendez/Desktop/SiteSelection/Data_Entry.csv", row.names = FALSE)

# Optionally, you can view the updated file2 data frame
print(merged_data)

###0.5

# Step 1: Load the CSV files
file1 <- read.csv("/Users/reymendez/Desktop/SiteSelection/Canopycover/0.5.csv")
file2 <- read.csv("/Users/reymendez/Desktop/SiteSelection/Data_Entry.csv")

# Step 2: Merge only the "CC" column from file1 into file2 based on the shared column
merged_data <- merge(file2, file1[, c("NestID", "CC")], by = "NestID", all.x = TRUE)

# Step 3: Rename the merged column to "NewColumnName"
colnames(merged_data)[which(names(merged_data) == "CC")] <- "CanopyCover0.5"

# Step 4: Overwrite file2.csv with the merged and renamed data
write.csv(merged_data, "/Users/reymendez/Desktop/SiteSelection/Data_Entry.csv", row.names = FALSE)

# Optionally, you can view the updated file2 data frame
print(merged_data)

###1

# Step 1: Load the CSV files
file1 <- read.csv("/Users/reymendez/Desktop/SiteSelection/Canopycover/1.csv")
file2 <- read.csv("/Users/reymendez/Desktop/SiteSelection/Data_Entry.csv")

# Step 2: Merge only the "CC" column from file1 into file2 based on the shared column
merged_data <- merge(file2, file1[, c("NestID", "CC")], by = "NestID", all.x = TRUE)

# Step 3: Rename the merged column to "NewColumnName"
colnames(merged_data)[which(names(merged_data) == "CC")] <- "CanopyCover1"

# Step 4: Overwrite file2.csv with the merged and renamed data
write.csv(merged_data, "/Users/reymendez/Desktop/SiteSelection/Data_Entry.csv", row.names = FALSE)

# Optionally, you can view the updated file2 data frame
print(merged_data)

###1.5

# Step 1: Load the CSV files
file1 <- read.csv("/Users/reymendez/Desktop/SiteSelection/Canopycover/1.5.csv")
file2 <- read.csv("/Users/reymendez/Desktop/SiteSelection/Data_Entry.csv")

# Step 2: Merge only the "CC" column from file1 into file2 based on the shared column
merged_data <- merge(file2, file1[, c("NestID", "CC")], by = "NestID", all.x = TRUE)

# Step 3: Rename the merged column to "NewColumnName"
colnames(merged_data)[which(names(merged_data) == "CC")] <- "CanopyCover1.5"

# Step 4: Overwrite file2.csv with the merged and renamed data
write.csv(merged_data, "/Users/reymendez/Desktop/SiteSelection/Data_Entry.csv", row.names = FALSE)

# Optionally, you can view the updated file2 data frame
print(merged_data)


data <- read.csv("/Users/reymendez/Desktop/SiteSelection/Data_Entry.csv")

# Step 2: Identify columns to delete
columns_to_delete <- c("CanopyCoverN.1", "CanopyCoverN.2","CanopyCoverN.3")

# Step 3: Remove columns from the data frame
data <- data[, !(names(data) %in% columns_to_delete)]

# Step 4: Write the modified data frame back to a CSV file
write.csv(data, "/Users/reymendez/Desktop/SiteSelection/Data_Entry.csv", row.names = FALSE)

# Optionally, you can view the modified data frame
print(data)

############# USING GRAYSCALE TO FIX SOME NEST IMAGES
library(jpeg)
library(raster)
library(devtools)

img <- readJPEG("/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/N/SLAK244-N2.jpg")

############# USING GRAYSCALE TO FIX SOME NEST IMAGES
library(jpeg)
library(raster)
library(devtools)

# Read the image
img <- readJPEG("/Users/reymendez/Desktop/SiteSelection/ELIN241-.5.jpg")

#### Convert to grayscale manually
img_gray <- 0.21 * img[,,1] + 0.7152 * img[,,2] + 0.0722 * img[,,3]

# Example of thresholding - adjust threshold value as needed
threshold_value <- 0.2 # Example threshold value
binary_img <- img_gray > threshold_value

# Check the structure and content of binary_img
str(binary_img)
table(binary_img)

# Calculate canopy cover percentage
canopy_cover_percentage <- mean(binary_img, na.rm = TRUE) * 100
print(canopy_cover_percentage)

# Alternative plotting method using raster::plot()
raster::plot(raster(binary_img), main = "Thresholded Image")

#### Saving to a folder
# Set the path where you want to save the image
save_path <- file.path("/Users/reymendez/Desktop/SiteSelection/Canopycover/ANALYZED_IMAGES/GrayscaleCorrections", "thresholded_image.jpg")

# Open a JPEG device
jpeg(filename = save_path, width = 800, height = 600)  # Adjust width and height as needed

# Plot the raster image
plot(raster(binary_img), main = "Thresholded Image")

# Close the device to save the file
dev.off()


#########################MERGING MY DATA AND DATABASE DATA

###MAKINGA NEST ID COLUMN

# Install and load the required packages
install.packages("readr")
install.packages("dplyr")
install.packages("stringr")

library(readr)
library(dplyr)
library(stringr)

# Read the CSV file into a data frame
df <- read_csv("/Users/reymendez/Desktop/SiteSelection/2024NestData_EM.csv")

# Display the first few rows of the data frame
print(head(df))

# Add a new column by concatenating values from existing columns
df <- df %>%
  mutate(NewColumn = ifelse(Broodnum > 1,
                            str_c(Terr, substr(NestYear, 3, 4), NestNum, Broodnum),
                            str_c(Terr, substr(NestYear, 3, 4), NestNum)))
# Rename the column
df <- df %>%
  rename(NestID = NewColumn)

# Display the first few rows of the updated data frame
print(head(df))

# Optionally, save the updated data frame back to a CSV file
write_csv(df, "/Users/reymendez/Desktop/SiteSelection/2024NestData_EM.csv")

#####MERGING THE CSV'S WHILE ELIMINATING NONMEASURED NESTS

# Read the CSV files into data frames
df1 <- read_csv("/Users/reymendez/Desktop/SiteSelection/2024NestData_EM.csv")
df2 <- read_csv("/Users/reymendez/Desktop/SiteSelection/Data_Entry.csv")

# Display the first few rows of the original data frames
print("df1:")
print(head(df1))
print("df2:")
print(head(df2))

# Filter rows in df1 and df2 where column 'C' is present
df1_filtered <- df1 %>% filter(NestID %in% df2$NestID)
df2_filtered <- df2 %>% filter(NestID %in% df1$NestID)

# Select only certain columns from df1
df1_selected <- df1_filtered %>% select(NestID, FoundDate, IncubDate, NestHt, ShrubHt, NestShrub, Smilax, NestShrubDead, Comments, FldgAmbig, FldgDate, FldgNum, NestDateAmbig)

# Select only certain columns from df2
df2_selected <- df2_filtered %>% select(NestID, Date_Sampled, Conceal_N, Depth_N, Conceal_E, Depth_E, Conceal_W, Depth_W, Conceal_S, Depth_S, Min_Conceal, NOTES, CanopyCoverN, CanopyCover0.5, CanopyCover1, CanopyCover1.5)

# Merge the selected columns from df1 and df2 based on matching values in column 'C'
df_combined <- merge(df1_selected, df2_selected, by = "NestID")

## CHECK TO MAKE SURE ALL NESTS THAT ARE EXCLUDED IS CORRECT
nestid1 <- df1$NestID
nestid2 <- df2$NestID

# Find values unique to each column
unique_to_df1 <- setdiff(nestid1, nestid2)
unique_to_df2 <- setdiff(nestid2, nestid1)

# Print the unique values
print("Values in df1$nestid that are not in df2$nestid:")
print(unique_to_df1)

print("Values in df2$nestid that are not in df1$nestid:")
print(unique_to_df2)
# Display the combined data frame
print("Combined Data Frame:")
print(head(df_combined))

# Save the combined data frame back to a CSV file
write.csv(df_combined, "EMCompleteData.csv", row.names = FALSE)




################ Finding Julian Day

library(lubridate)


# Step 1: Read the CSV file into a data frame
df <- read.csv("/Users/reymendez/Desktop/SiteSelection/FINAL_DATA_AND_ANALYSIS/EMCompleteData.csv", stringsAsFactors = FALSE)

# Step 2: Convert the character dates to date-time format using lubridate
df$FoundDate <- mdy_hm(df$FoundDate)

# Step 3: Convert the dates to Julian day
df$FoundDate <- yday(df$FoundDate)

# Step 2: Convert the character dates to date-time format using lubridate
df$IncubDate <- mdy_hm(df$IncubDate)

# Step 3: Convert the dates to Julian day
df$IncubDate <- yday(df$IncubDate)

# Step 2: Convert the character dates to date format using lubridate
df$Date_Sampled <- mdy(df$Date_Sampled)

# Step 3: Convert the dates to Julian day
df$Date_Sampled <- yday(df$Date_Sampled)

# Assuming df is your data frame and FldgDate is in "MM/DD/YY" format
df$FldgDate <- mdy(df$FldgDate)

# Convert the dates to Julian days
df$FldgDate <- yday(df$FldgDate)


######Finding Sampling Time Window 

df$date_difference <- df$IncubDate - df$FoundDate

# Calculate the average of the differences
average_difference <- mean(df$date_difference, na.rm = TRUE)

# Print the average difference
print(average_difference)

#On average Incubation date is  3.263158 days before found date. The impact on sampling window should be minimal for using found date instead when necessary

library(dplyr)

# Create the SampleDelay column with the described logic
df <- df %>%
  mutate(SampleDelay = ifelse(is.na(IncubDate), Date_Sampled - FoundDate, Date_Sampled - IncubDate))

summary(df$SampleDelay)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#-9.00   10.00   20.00   25.26   33.00  100.00 

# Create the SampleWindowSuitable column
df <- df %>%
  mutate(SampleWindowSuitable = ifelse(SampleDelay <= 33, "y", "n"))

df %>%
  count(SampleWindowSuitable)
#SampleWindowSuitable   n
#1                    n  46
#2                    y 111

###### Make Nest Date Column for Nest Success analysis
# Load the necessary package
library(dplyr)

# Step 1: Read the CSV file into a data frame
data <- read.csv("EMCompleteData.csv")

# Step 2: Create the NestDate column and convert Julian days to Date
data <- data %>%
  mutate(
    # Create NestDate by taking IncubationDate if available, otherwise FoundDate
    NestDate = coalesce(IncubationDate, FoundDate)
  )

write.csv(df, "EMCompleteData.csv", row.names = FALSE)

###### Make Palmetto Nests Suitable Regardless of timeframe

# Read the CSV file into a data frame
df <- read.csv("EMCompleteData.csv")

# List of species to update
species_to_update <- c("Sabal etonii", "Serenoa repens")

# Update the 'Valid' column
df <- df %>%
  mutate(Valid = ifelse(NestShrub %in% species_to_update, "y", SampleWindowSuitable))

# Write the updated data frame to a new CSV file

write.csv(df, "EMCompleteData.csv", row.names = FALSE)


###### Make Sure Special Case Nests are Suitable 

######Making a Nest Attempt Column

# Load necessary package
library(dplyr)

# Read the CSV file into a data frame
data <- read.csv("/Users/reymendez/Desktop/SiteSelection/FINAL_DATA_AND_ANALYSIS/EMCompleteData.csv")

# Add a new column 'NestAttempt' with the 5th character of 'NestID'
data <- data %>%
  mutate(NestAttempt = substr(NestID, 7, 7))

# Save the modified data frame to a new CSV file
write.csv(data, "/Users/reymendez/Desktop/SiteSelection/FINAL_DATA_AND_ANALYSIS/EMCompleteData.csv", row.names = FALSE)

#####Make Dataset for Canopy cover analysis

library(dplyr)
library(tidyr)

# Read the CSV file into a data frame
df <- read.csv("/Users/reymendez/Desktop/SiteSelection/FINAL_DATA_AND_ANALYSIS/EMCompleteData.csv")

# Filter rows where 'Valid' is 'y'
filtered_df <- df %>%
  filter(SampleWindowSuitable == "y")

# Write the filtered data frame to a new CSV file
write.csv(filtered_df, "CanopyCoverAnalysisData.csv", row.names = FALSE)

#########Make Canopy Cover Data Long

# Read the CSV file into a data frame
data <- read.csv("CanopyCoverAnalysisData.csv")


# Reshape data from wide to long format

long_data <- data %>%
  pivot_longer(
    cols = c('CanopyCoverN', 'CanopyCover0.5', 'CanopyCover1', 'CanopyCover1.5'), # Columns to pivot
    names_to = "CanopyCoverHeight", # New column for the variable names
    values_to = "PercentCanopyCover"    # New column for the values
  )

# Save the reshaped data to a new CSV file

write.csv(long_data, "/Users/reymendez/Desktop/SiteSelection/FINAL_DATA_AND_ANALYSIS/CanopyCoverAnalysisData.csv", row.names = FALSE)


##################################Analysis

library(tidyverse)
EMCompleteData<-read.csv("/Users/reymendez/Desktop/SiteSelection/FINAL_DATA_AND_ANALYSIS/CanopyCoverAnalysisData.csv",stringsAsFactors = FALSE)

boxplot(MeanConceal~NestSuccess,EMCompleteData)

##Linear Mixed Model

install.packages(lmerTest)
library(lmerTest)

summary(glmer(PercentCanopyCover ~ CanopyCoverHeight + NestHeight + NestShrub + MeanConceal + Smilax + NestShrubDead + (1|Terr)+(1 | NestHeight), data = long_data, family = gaussian))

         
 # Fit the GLMM
 model <- glmer(PercentCanopyCover ~ CanopyCoverHeight * NestHeight + ControlVar1 + ControlVar2 + ControlVar3 + (1 | Terr) + (1 | NestHeight), 
                        data = data_long, 
                        family = gaussian,  # Change family if needed
                        control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 2e5)))  # Adjust control parameters if needed         
