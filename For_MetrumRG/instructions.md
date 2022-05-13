# Applied Data Scientist I - Code Test

First off, thank you for your interest in being part of the Data Science team at Metrum Research Group, and thank you for taking the time to complete this "code test". We ask that you spend between 2 and 4 hours on this. The point is get a sense of your skills with basic data manipulation and visualization, and ideally with building a basic interactive app as well. Of course, general good code hygiene is appreciated as well.

_Note:_ Bonus points will be given for checking your code into a private github repo and making @seth127 (Seth Green, Manager of the Data Science Team) access to the repo. If you aren't comfortable with Github, you can just email the code as an attachment.

# Part 1

Accompanying this document is a `data.csv` file and a `conc-v-time-ref1.jpeg` file. Part 1 of the test is to recreate the plot in the reference `.jpeg` from the data in `data.csv`. The formatting, fonts, etc. are not particularly important (the defaults in `ggplot2` were used for the reference) but please make efforts to match the content and text of the plot as closely as possible. A data spec for `data.csv` is at the bottom of this document for your reference.

Please submit a script that reads in the data and outputs your plot.

_Note:_ This position will be primarily working in R, so we encourage you to do this in R if you are comfortable with it. However, if you would prefer to use another language (or a plotting package other than `ggplot2`) that is fine as well. 

# Part 2

Create an interactive app that lets the user filter the input data to the plot (from Part 1) by `AGE` and/or `WT`. This position will involve writing interactive Shiny apps in R. The ideal solution is simple Shiny app code, that can be run locally to let the user see the plot from Part 1 and interactively filter the data, then have the plot be re-rendered with the filtered data.

_Note:_ Don't worry about spending much (if any) time on the "aesthetics" of the app. It doesn't need to look nice. Again, we don't want you to spend more than roughly 4 hours on this, and the test here is whether you can put together a functional app in that amount of time.

Options:

* If you are not comfortable with Shiny, feel free to create an interactive visualization that implements the functionality described above in another framework or language.
* If you do not feel comfortable creating an interactive app in the time allotted, please submit code that implements an alternate method for letting the user filter the input data and render the resulting plot. For example, a parameterized `.Rmd`, or a `.py` script that can be called from the command line. This is not the ideal solution, but it is much better than _not_ completing this section of the test.

Please submit the necessary code and instructions for interacting with it (i.e. how to launch the app, or what arguments to pass to the script, etc.).

# Appendix: Data Specification

The `data.csv` file contains simulated data for a Pharmacokinetic (PK) analysis. It represents clinical trial data for 160 (fake) individuals, taking a (fictional) drug at varying doses and measuring the concentration of the drug in their blood at various time intervals. 

**Columns:**

* `ID` - unique identifier for each individual in the trial
* `AGE` - age of each individual, in years
* `WT` - weight of each individual, in kilograms
* `ACTARM` - the "arm" of the study that the individual is enrolled in, in this case representing the dose given
* `TAD` - time after dose, in hours
* `DV` - concentration of the drug in the individual's blood, in ng/mL

