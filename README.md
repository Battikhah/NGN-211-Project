# NGN211 Project Spring2025

This project analyzes customer data from the `CLV_Dataset_Sec2_Group2_Oregon_A.xlsx` (https://www.kaggle.com/datasets/pankajjsh06/ibm-watson-marketing-customer-value-data) file using MATLAB. It includes descriptive statistics, probability distributions, hypothesis testing, and regression analysis to derive insights about customer lifetime value (CLV), income, and claims.

## Project Structure

- **Dataset**: The project reads data from `CLV_Dataset_Sec2_Group2_Oregon_A.xlsx`.
- **MATLAB Script**: The main script is [`Project.m`](Project.m), which performs the following analyses:
  - **Section 1: Descriptive Statistics**
    - Calculates mean, median, and standard deviation for income, total claims, and CLV.
    - Generates visualizations such as histograms, pie charts, and boxplots.
  - **Section 2: Probability Distribution**
    - Fits normal distributions to income, total claims, and CLV.
    - Computes confidence intervals for the mean and standard deviation.
  - **Section 3: Hypothesis Testing**
    - Performs one-sample and two-sample t-tests to compare means.
  - **Section 4: Regression & Correlation Analysis**
    - Conducts simple and multiple linear regression.
    - Computes Pearson correlation coefficients.
    - Makes predictions based on regression models.

## Requirements

- MATLAB R2023a or later.
- The dataset file `CLV_Dataset_Sec2_Group2_Oregon_A.xlsx` must be in the same directory as the script.

## How to Run

1. Open the `Project.m` file in MATLAB.
2. Ensure the dataset file is present in the same directory.
3. Run the script to generate outputs and visualizations.

## Outputs

- **Descriptive Statistics**: Summary statistics printed to the console.
- **Visualizations**: Histograms, pie charts, boxplots, scatter plots, and matrix plots.
- **Regression Models**: Equations and R² values printed to the console.
- **Hypothesis Testing Results**: Decisions, p-values, and confidence intervals printed to the console.

## Example Visualizations

- Histogram of Income
- CLV by Gender (Boxplot)
- Scatter Plot of Monthly Premium vs. CLV

## Contact

For questions or feedback, please contact [Khalid Hamdan](mailto:khalidhamdan@example.com).
