% NGN211 Project Spring2025

clear; clc; close all;
%% Read the dataset
Data = readtable('CLV_Dataset_Sec2_Group2_Oregon_A.xlsx');

%% Section 1: Descriptive Statistics
% Calculated data
meanIncome = mean(Data.Income);
medIncome  = median(Data.Income);
stdIncome  = std(Data.Income);
fprintf('Section 1\n\n');
fprintf('Q1.1: Income - Mean: %.2f, Median: %.2f, Std: %.2f\n', meanIncome, medIncome, stdIncome);
meanClaims = mean(Data.T_Claims);
medClaims  = median(Data.T_Claims);
stdClaims  = std(Data.T_Claims);
fprintf('Q2.2: T_Claims - Mean: %.2f, Median: %.2f, Std: %.2f\n', meanClaims, medClaims, stdClaims);
meanCLV = mean(Data.CLV);
medCLV  = median(Data.CLV);
stdCLV  = std(Data.CLV);
fprintf('Q3.3: CLV - Mean: %.2f, Median: %.2f, Std: %.2f\n', meanCLV, medCLV, stdCLV);
% Figures
% Histogram of Income
figure;
histogram(Data.Income);
xlabel('Income');
ylabel('Count');
title('Histogram of Income');
% Histogram of CLV
figure;
histogram(Data.CLV);
xlabel('CLV');
ylabel('Count');
title('Histogram of CLV');
% Pie chart of Coverage levels
figure;
pie(categorical(Data.Coverage));
title('Coverage Distribution');
% Income by gender
figure;
boxplot(Data.Income, Data.Gender);
title('Income by Gender');
% T_Claims by gender
figure;
boxplot(Data.T_Claims, Data.Gender);
title('Total Claims by Gender');
% CLV by gender
figure;
boxplot(Data.CLV, Data.Gender);
title('CLV by Gender');


%% Section 2: Probability Distribution
figure;
histogram(Data.Income, 'Normalization', 'pdf');
hold on;
pd_income = fitdist(Data.Income, 'Normal');
x_income = min(Data.Income):1:max(Data.Income);
plot(x_income, pdf(pd_income, x_income), 'r', 'LineWidth', 2);
title('Q2: Income & Fitted Normal PDF');
% Mean and standard deviation
fprintf('\n\nSection 2\n\n');
fprintf('Income mean: %.2f\n', pd_income.mu);
fprintf('Income std: %.2f\n', pd_income.sigma);
% Confidence intervals
ci_income = paramci(pd_income);
muCI_income = ci_income(1, :);
sigCI_income = ci_income(2, :);
fprintf('Income mean 95%% CI: [%.2f, %.2f]\n', muCI_income);
fprintf('Income std  95%% CI: [%.2f, %.2f]\n', sigCI_income);
%Q2.4-2.6: T Claims
figure;
histogram(Data.T_Claims, 'Normalization', 'pdf');
hold on;
pd_tclaims = fitdist(Data.T_Claims, 'Normal');
x_tclaims = min(Data.T_Claims):1:max(Data.T_Claims);
plot(x_tclaims, pdf(pd_tclaims, x_tclaims), 'r', 'LineWidth', 2);
title('Q2: Total Claims & Fitted Normal PDF');
% Mean and standard deviation
fprintf('\nTotal claims mean: %.2f\n', pd_tclaims.mu);
fprintf('Total claims std: %.2f\n', pd_tclaims.sigma);
% Confidence intervals
ci_tclaims = paramci(pd_tclaims);
muCI_tclaims = ci_tclaims(1, :);
sigCI_tclaims = ci_tclaims(2, :);
fprintf('Total claims mean 95%% CI: [%.2f, %.2f]\n', muCI_tclaims);
fprintf('Total claims std  95%% CI: [%.2f, %.2f]\n', sigCI_tclaims);
%Q2.7-2.9: CLV
figure;
histogram(Data.CLV, 'Normalization', 'pdf');
hold on;
pd_clv = fitdist(Data.CLV, 'Normal');
x_clv = min(Data.CLV):1:max(Data.CLV);
plot(x_clv, pdf(pd_clv, x_clv), 'r', 'LineWidth', 2);
title('Q2: CLV & Fitted Normal PDF');
% Mean and standard deviation
fprintf('\nCLV mean: %.2f\n', pd_clv.mu);
fprintf('CLV std: %.2f\n', pd_clv.sigma);
% Confidence intervals
ci_clv = paramci(pd_clv);
muCI_clv = ci_clv(1, :);
sigCI_clv = ci_clv(2, :);
fprintf('CLV mean 95%% CI: [%.2f, %.2f]\n', muCI_clv);
fprintf('CLV std  95%% CI: [%.2f, %.2f]\n', sigCI_clv);


%% Section 3: Hypothesis Testing
% One‐sample test CLV ≠ 8450
fprintf('\n\nSection 3\n\n');
[h1, p1, ci1] = ttest(Data.CLV, 8450, 'Alpha', 0.05);
if h1==1
   decision1 = 'Reject';
else
   decision1 = 'Fail to reject';
end
fprintf('Q3.1 output: Test mean CLV ≠ 8450 \n');
fprintf('  Decision: %s the null hypothesis (H₀: μ = 8450) [h = %d]\n', decision1, h1);
fprintf('  p-value: %.4f\n', p1);
fprintf('  95%% CI for mean CLV: [%.2f, %.2f]\n\n', ci1(1), ci1(2));
% Income Basic vs Premium
indBasic   = ismember(Data.Coverage, 'Basic');
indPremium = ismember(Data.Coverage, 'Premium');
Basic      = Data(indBasic,:);
Premium    = Data(indPremium,:);
[hb, pb, ciB] = ttest2(Basic.Income, Premium.Income, 'Alpha', 0.05);
if hb==1
    decision2 = 'Reject';
else
    decision2 = 'Fail to reject';
end
fprintf('Q3.4 output: Compare Income of Basic vs Premium \n');
fprintf('  Decision: %s the null hypothesis (no difference in means) [h = %d]\n', decision2, hb);
fprintf('  p-value: %.4f\n', pb);
fprintf('  95%% CI for mean difference: [%.2f, %.2f]\n\n', ciB(1), ciB(2));
% CLV Basic vs Premium
[hc, pc, ciC] = ttest2(Basic.CLV, Premium.CLV, 'Alpha', 0.05);
if hc==1
    decision3 = 'Reject';
else
    decision3 = 'Fail to reject';
end
fprintf('Q3.5 output: Compare CLV of Basic vs Premium \n');
fprintf('  Decision: %s the null hypothesis (no difference in means) [h = %d]\n', decision3, hc);
fprintf('  p-value: %.4f\n', pc);
fprintf('  95%% CI for mean difference: [%.2f, %.2f]\n\n', ciC(1), ciC(2));


%% Section 4: Regression & Correlation Analysis
% 4.1: Scatter plot M Prem vs CLV
fprintf('\n\nSection 4\n\n');
figure;
scatter(Data.M_Prem, Data.CLV, 'filled');
xlabel('Monthly Premium'); ylabel('CLV');
title('Section 4.1: M Prem vs CLV');
% 4.2-4.3: Simple linear regression
mdl1 = fitlm(Data.M_Prem, Data.CLV);
b1   = mdl1.Coefficients.Estimate;
fprintf('Q4.3: CLV = %.2f + %.2f * MPrem\n', b1(1), b1(2));
% 4.4: Pearson correlation
r = corrcoef(Data.M_Prem, Data.CLV);
fprintf('Q4.4: Pearson r = %.3f\n', r(1,2));
% 4.5: Predictions at $30, $200, $500
newX = [30; 200; 500];
yPred = b1(1) + b1(2)*newX;
fprintf('Q4.5:\n');
for i = 1:length(newX)
    fprintf('  Predicted CLV for Monthly Premium $%.2f: %.2f\n', newX(i), yPred(i));
end
% 4.6: Multiple regression CLV
Xmulti = [Data.Income, Data.M_Prem, Data.T_Claims];
mdl2   = fitlm(Xmulti, Data.CLV);
b2     = mdl2.Coefficients.Estimate;
R2     = mdl2.Rsquared.Ordinary;
fprintf('Q4.6: CLV = %.2f + %.2f*Income + %.2f*MPrem + %.2f*Total Claims\n', b2);
fprintf('      R^2 = %.3f\n', R2);
% 4.7: Matrix of scatter plots
figure;
plotmatrix(Xmulti);

