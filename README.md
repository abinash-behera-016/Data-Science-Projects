# Data Science Portfolio

Welcome to my Data Science Portfolio on GitHub! This repository contains a variety of projects where I apply machine learning algorithms to solve real-world problems. Each project folder includes relevant datasets in CSV format, R or Python scripts detailing the analysis, and a README explaining the project's context and findings.

## Technologies Used
- R, Python
- Linear Regression
- Logistic Regression
- Decision Trees
- Random Forest
- XGBoost
- Neural Networks
- Packages for modelling: tree, rpart, randomForest, xgboost, nnet, neuralnet, tseries, forecast, scikit-learn, keras, tensoflow
- Packages for visualization: ggplot2, matplotlib, seaborn

Feel free to explore the projects and reach out if you have questions or would like to collaborate!

## Contact
- [Click here to visit my LinkedIn](https://www.linkedin.com/in/abinash-behera-1b7127112/)
- [Click here to mail me](mailto:abinashb206@gmail.com)

Enjoy exploring my projects, and I appreciate any feedback or contributions to improve my work!

`Note`: I have often used a function createDummies, given by our instructor during the course, to create dummies out of character columns. This function can take a threshold frequncy value below which an observation won't get it's own dummy. I usually keep the threshold as 2% of total number of rows. You can find it's R script above. Another package [fastDummies](https://cran.r-project.org/web/packages/fastDummies/index.html) available on CRAN works great too but does't take threshold frequency as an input, as a result you might end up with loads of new dummies corresponding to observations that rarely occur in a column.
