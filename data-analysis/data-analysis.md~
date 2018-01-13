---
title: Data Analysis and Cleaning
author:
  - Jonathon Baron
date: 2018-1-12
bibliography: data-analysis.bib
---

# Data Analysis and Cleaning

This chapter discusses some basic elements of working with data in `R`, from loading data into the environment, to cleaning variables, and performing basic analysis.

Particular emphasis is placed on the need to confirm the correctness of data prior to analysis. The chapter is organized so as to guide the researcher through stages of initial confirmation of coding accuracy, through several steps of data cleaning.

Despite careful design in both Qualtrics and MTurk, the researcher may find that additional data-cleaning is a necessity. Even after properly collecting, saving, and storing data, the data will likely require additional organization for the purposes of further analysis. This chapter highlights some best practices for cleaning and confirming the veracity of data.

## Downloading and Loading Data

### Downloading Qualtrics data
Prior to analysis, the researcher must first download data from Qualtrics in the correct format. To begin, navigate to Data & Analysis. Note that Qualtrics presents "Recorded Responses" as well as "Responses in Progress," and that these may not comport with the number of subjects recruited from MTurk. This will be discussed below.

To download data, click the "Export & Import" dropdown menu on the right side of the page, and select "Export Data..." A pop-up menu will appear with the title "Download Data Table." By default, Qualtrics offers data in `.csv` format, which is ideal for use in `R`. The researcher should click the "Use Legacy Exporter" link at the top-right of the pop-up menu, followed by "More Options" at the bottom-left corner. The researcher should now uncheck "Use Legacy View Results format" and ensure that the radio button indicating "Use numeric values" is selected; the researcher may also select the checkbox next to "Recode seen but unanswered questions as -99," noting that "-99" can be changed to another value, including "NA." Finally, the researcher may click the "Download" button on the bottom-right corner of the menu.

### Loading Qualtrics data into `R`
Once the researcher has successfully downloaded the data from Qualtrics, it may now be loaded into `R`. For `.csv` files, the researcher can load data using the built-in function `read.csv()`, storing the data as an object in the `R` environment:

```r
data <- read.csv("~/Path/to/data.csv", header = TRUE, stringsAsFactors = FALSE, row.names = 1)
```

Note the use of the `header = TRUE`, `stringsAsFactors = FALSE`, and `row.names = 1` arguments. The first argument sets as column names the first row of the dataset, which contains only character values pertaining to question names. The second argument is set in order to ensure greater ease of data formatting and cleaning, due to idiosyncracies presented by the factor class in `R`. Finally, `row.names` refers to the inclusion of a column pertaining to row numbers; this is typically irrelevant, and will be omitted when `row.names = 1`.

### Ensuring concordance betwen MTurk and Qualtrics
As noted above, the Qualtrics data may include responses by more individuals than were recruited on MTurk; this may occur when a respondent does not properly respond to the posted HIT on MTurk, but navigates to the Qualtrics survey nonetheless. To exclude these respondents, the researcher will need to download data on HITs from MTurk, and compare the included `Answer.surveycode` variable from the MTurk data with the `confirmation_code` variable included in the Qualtrics dataset.

As noted above, MTurk data can be easily downloaded via Manage &rarr; Results; the resultant `.csv` can then be loaded into `R` as noted above.

With both datasets loaded into `R`, the researcher may now remove all rows from the Qualtrics dataset that do not yield matches with the MTurk data by subsetting the Qualtrics data as follows:

```r
qualtrics <- qualtrics[qualtrics$confirmation_code %in% mturk$Answer.surveycode,]
```

It is worthwhile to note that some MTurk workers may enter their survey codes incorrectly, and so some data may be lost in the process of excluding additional respondents. However, it is not uncommon for MTurk workers to contact the researcher directly in the event that they provided an incorrect end-of-survey code. As a result, the researcher should always be prepared to carefully review the data on respondents alongside any received emails, in order to match by hand any respondents who were not coded properly by "automatical" means.

## Answer-Choice Codings

Prior to further analysis, the correctness of answer-choice codings represented in the collected data should be confirmed. It is recommended that the researcher examine *each* variable to ensure that it contains the correct numeric answer-choice codings, as established in the Qualtrics survey.

* It is of critical importance that the researcher perform this step diligently when comparing across surveys, or performing replication studies.

To this end, it is recommended that the researcher use at least one of the following methods to assess that data are coded correctly.

### Confirmation against codebooks
To the extent that the researcher is making use of preexisting data, the first resource the researcher uses should always be the codebook associated with those data. A codebook should provide information on the proper coding of each variable, including codings for missingness that can undermine analysis at later stages if not approached properly. Prior to running a survey that will be analyzed in relation preexisting data, the researcher may also wish to set coding values to comport with the external data source, via Qualtrics directly.

The researcher is also advised to create a codebook for any original data.

### Tabular assessment
The reseacher is also advised to confirm the veracity of data loaded into `R`. One efficient means of doing so is to use the `table()` command in R. Below is a short script that creates tabular output for each variable comprising one dataset, storing it in a `.txt` file in a named directory:

```r
sink("working/directory/output/output.txt", type = "output")
apply(data, 2, function (x) table(x, useNA = "ifany"))
sink()
```

Note the use of the `useNA = "ifany"` argument, which shows `NA` values in the tabular output for each variable that includes `NA`s. This is useful if the researcher is attempting to verify the complete removal of `NA` values, e.g., after performing imputation as described below.

The researcher may also compare multiple datasets for concordance; the following example expands upon that offered above to produce tabular output comparing two datasets. The datasets in this example are assumed to have been combined into the `combined` object, and are distinguished from one another by the indicator `DATASET`. The output will depict each variable by dataset, alongside its counterpart, which streamlines comparison and examination:

```r
sink("working/directory/output/combined_output.txt", type = "output")
apply(combined, 2, function (x) table(x, combined$DATASET, useNA = "ifany"))
sink()
```

### Graphical assessment
The researcher may also choose to assess variables graphically, e.g., using the `hist()` or `plot()` commands, or equivalent functions included in the `ggplot2` library. This is less recommended, however, due to the loss of efficiency and clarity relative to simple tabular output.


## Clean variables
Whenever possible, it is recommended that the researcher perform minor cleaning of variables within Qualtrics (see [Randomization](#randomization) for information on recoding variables following data collection). However, the researcher may also wish to recode variables "by hand" in `R`. Alternatively, the researcher may wish to further format variables by imputing missing values, altering codings for missingness, and so on. This section provides guidance for simple tasks in this vein.

### Format variables
Data saved from Qualtrics will include numericized answers, however these are likely to appear in `R` as character vectors, after data are loaded using the `stringsAsFactors = FALSE` argument. Thus, all truly numeric variables will need to be converted to the numeric class. For this task, it is recommended that the researcher employ the following `numericize()` function, which searches for strings starting with digits and extracts them before numericizing variables; thus, `numericize()` can convert to the numeric class a vector such as `c("1", "2", "3")`, as well as a vector such as `c("1. Item One", "2. Item Two", "3. Item Three"). The following example makes further use of `numericize()` in an `apply()` command leveraged on the whole dataset:

```r
# We thank a Stack Overflow user for advice in writing this function.
numericize <- function (x, data) {
  return(as.numeric(gsub("(\\d+\\.?\\d*).*$", "\\1", x, perl = TRUE)))
}
data <- as.data.frame(apply(data, 2, numericize))
```

Using `numericize()` in this manner will numericize *all* variables in the dataset using `numericize()`; thus, variables that should *not* be numericized should be excluded. For example, the researcher may with to retain all text-entry responses from the Qualtrics survey. Thus, the researcher should be sure to exclude certain variables, which can be accomplished using `grep()`. In the below example, `grep()` is used to identify all variable names ending in `TEXT` (this pattern is denoted by the tailing `$` following `TEXT`); the `apply()` command is then used on the dataset, excepting these exclusions (the indices of which have been saved in the object `text_response_vars`).

```r
text_response_vars <- grep("TEXT$", names(data))
data[, -text_response_vars] <- apply(data[, -text_response_vars], 2, numericize)
```

### Recoding missing values and other values in `R`
#### Recoding missing values
Researchers familiar with the ANES will be aware that missing values can take a variety of coding values, including negative numbers. As is implied by the `impute()` function offered below, missing values are often denoted with `99` or `-99`, though other codings such as `90` and `95` are frequently used (e.g., to indicate "Don't Know" or "Other" responses). When working in `R`, however, missingness is denoted by the `NA` coding; it is often advisable to convert these codings to `NA`.

Converting codings of missingness can be more complex if working with variables that include actual values greater than 90 or less than 0 (e.g., feeling thermometers or numeric party ID codings). The following function is provided for the researcher to convert values to `NA` as needed; the researcher will note that the function excludes all common codings of missingness by default; the researcher can also elect to exclude values such as `90`, `95`, and `99`, negative values, or both, by setting the `exclude` argument to `"90s"`, `"negatives"`, or `"all"`, respectively:

```r
conv_NA <- function (x, exclude = NULL) {
                     if (!is.null(exclude)) {
                         if (is.character(exclude)) {
                             if (exclude == "all") {
                                 x[x %in% c(998, 999)] <- NA
                             } else {
                               if (exclude == "90s") {
                                   x[x < 0 | x %in% c(998, 999)] <- NA
                               } else {
                                 if (exclude == "negatives") {
                                     x[x %in% c(90, 95, 99, 998, 999)] <- NA
                                 } else {
                                   x[x %in% exclude] <- NA
                                 }
                               }
                             }
                         } else {
                           x[x %in% exclude] <- NA
                         }
                     } else {
                       if (is.null(exclude)) {
                           x[x < 0 | x %in% c(90, 95, 99, 998, 999)] <- NA
                       }
                     }
                     return(x)
           }
```

#### Imputing missing values
Once missingness has been accounted for properly, the researcher may wish to impute missing values. For the purposes of imputation, it is recommended that the researcher follow the Standard Operating Procedures for the Green Lab at Columbia University (@lin2015standard), with one minor refinement (mode imputation):
	
* In cases in which more than 20% of responses are missing, the researcher should create an indicator variable denoting missingness in the given variable.
* In all other cases, mean or mode imputation should be employed; it is recommended that the researcher use mean imputation for all ordinal or binary variables, whereas mode imputation is recommended for categorical/nominal variables.
	The below `impute()` function will assess missingness in variables, and will perform imputation automatically, where appropriate (note that `impute()` performs mean imputation by default; the function will perform mode imputation if the researcher sets the `ord` argument to `FALSE`):
	
```r
impute <- function(x, ord = TRUE) {
                   if (ord) {
                       if (sum(is.na(x)) <= 20) {
                           x[is.na(x)] <- mean(x, na.rm = TRUE)
                       } else {
                       x[is.na(x)] <- -99
                       }
                   } else {
                     if (sum(is.na(x)) <= 20) {
                         x[is.na(x)] <- num_mode(x)
                     } else {
                       x[is.na(x)] <- -99
                     }
                   }
                   return(x)
          }
```

Note that this function only performs imputation when missingness is indicated by `NA` values; this may not generally be the case in survey data.

#### Recoding other values

The researcher may, in some cases, wish to recode variables in `R` in other ways. This can be simple, as in the case of recoding a single value of a variable. Here, the researcher may replace the value as demonstrated in the example below:

```r
variable <- c(1, 2, 3, 4, 99)

variable[variable == 99] <- NA
```

In instances in which the researcher must recode multiple values within a single variable at once, it is recommended that the researcher utilize a canned `recode()` command. Examples exist in both the `car` and the `dplyr` packages (each of which can be installed with `install.packages()`); the choice of canned command may be informed by syntax and data input/output. 

The `car::recode()` command is recommended due to its mildly greater flexibility with inputs (see description of `dplyr::recode()` below for further explanation). The command takes as its first argument a numeric or character vector, or a factor; and as its second argument, a character string of recode specifications. The function can be used as in the example below (note that the function is called as `car::recode()` so as to avoid conflict with `dplyr`):

```r
variable <- c(1, 2, 1, 1, 3, 4, 2, 5, 4, 2)

recoded_variable <- car::recode(variable, "1 = 5; 2 = 4; 4 = 2; 5 = 1")
```

In some versions of `R`, the syntax of `car::recode()` may disrupt highlighting appearing in the editor, especially if the `recodes` argument is split over several lines. For this and other reasons, researchers may instead prefer to make use of the `dplyr::recode()` command; `dplyr::recode()` also takes as its main argument a vector; unlike `car::recode()`, however, `dplyr::recode()` will not take as its argument a factor. Instead, the researcher must instead use `recode_factor()` in order to recode a factor within `dplyr`.

### Creating variables
#### Creating indicator variables

When working with questions featuring randomized text or randomized order, it may be useful to create indicator variables to denote which version a subject received (or received first). This operation is simple to perform using `ifelse()` in `R`; if missing values are coded as `NA` (which is recommended), the researcher may use the following code:

```r
version_1 <- c(1, NA, 2, NA, 3, NA, 4, NA, 5, NA)
version_2 <- c(NA, 1, NA, 2, NA, 3, NA, 4, NA, 5)
	
received_version_1 <- ifelse(is.na(version_1), 0, 1)
received_version_2 <- ifelse(is.na(version_2), 0, 1)
```
	
If missingness is coded differently, e.g., as `-99`, the researcher may instead employ the below code:
	
```r
version_1 <- c(1, -99, 2, -99, 3, -99, 4, -99, 5, -99)
version_2 <- c(-99, 1, -99, 2, -99, 3, -99, 4, -99, 5)
	
received_version_1 <- ifelse(version_1 == -99, 0, 1)
received_version_2 <- ifelse(version_2 == -99, 0, 1)
```

#### Coalescing variables
The researcher may also with to aggregate all answer selections into a single variable. In the case of variables that randomize over two instances, the variables can be coalesced using `ifelse()` similarly to the examples above:

```r
version_1 <- c(1, NA, 2, NA, 3, NA, 4, NA, 5, NA)
version_2 <- c(NA, 1, NA, 2, NA, 3, NA, 4, NA, 5)

treatment <- ifelse(is.na(version_1), version_2, version_1)
```

For any question with more than two versions, however, this operation requires a `coalesce()` function; reproduced below is an [efficient function](stackoverflow.com/questions/19253820/how-to-implement-coalesce-efficiently-in-r) to perform this operation:

```r
coalesce <- function(...) {
                     Reduce(function(x, y) {
                            i <- which(is.na(x))
                            x[i] <- y[i]
                            x},
                     list(...))
            }
```

The `coalesce()` function can then be used thusly, e.g., to aggregate three versions of a treatment:
	
```r
version_1 <- c(NA, 1, NA, 2, NA, 3, NA, 4, NA, 5)
version_2 <- c(1, NA, NA, NA, 2, NA, NA, NA, 3, NA)
version_3 <- c(NA, NA, 1, NA, NA, NA, 2, NA, NA, NA)
	
treatment <- coalesce(version_1, version_2, version_3)
```

## Advanced
means, bootstrap
