
# 🥇 Olympic Medals Dashboard

An interactive Shiny dashboard built in R for exploring Olympic medal counts by event, and country. This app provides a rich visualization experience powered by real-world Olympic data, allowing users to analyze trends and national performance.

---

## 📦 Project Structure

```
Olympic-Medals-dashboard/
├── app.R                # Main Shiny app file
├── data/                # CSV files with Olympic medal data
├── images/              # Icons and flags used in the app
├── rsconnect/           # Deployment metadata
├── LICENSE              # Apache 2.0 License
└── README.md            # Project documentation
```

---

## 🚀 Features

- Dynamic filtering by:
  - **Event** (Summer Olympics only)
  - **Country**
- Visualizations include:
  - Medal count bar charts
  - Details about each athlete
  - Plots split up by each medal type
- Smooth, intuitive UI built with R Shiny

---

## 📊 Data Sources

The data lives in `data/` and includes:
- `medals.csv`: Athlete and medal event-level data
- Pre-processed data files for faster loading

Data sourced from [Kaggle's 2024 summer Olympic dataset](https://www.kaggle.com/datasets/piterfm/paris-2024-olympic-summer-games/data?select=medals.csv).

---

## 🛠 Getting Started

### Prerequisites

Install the required R packages:

```r
install.packages(c("shiny", "ggplot2", "dplyr", "readr", "tidyr", "lubridate"))
```

### Run the App

```r
shiny::runApp("app.R")
```

Then navigate to `http://localhost:8100` (or the port R assigns) in your browser.

---

## 🧠 Motivation

This project was created to practice and showcase data visualization and dashboard-building skills in R, using historical sports data as a medium. It’s great for demonstrating:
- Data wrangling
- Dynamic UI elements
- Deployment with `rsconnect` (shinyapps.io)

---

## 🌐 Deployment

This app is structured for deployment to [shinyapps.io](https://www.shinyapps.io/) using `rsconnect`. Just log in with:

```r
rsconnect::deployApp('path/to/Olympic-Medals-dashboard')
```

---

## 🛡 License

This project is licensed under the Apache 2.0 License – see the `LICENSE` file for details.

---

## 👤 Author

**Chad Readey**  
Data Science Portfolio  
[LinkedIn](https://www.linkedin.com/in/chad-readey-364206230)

---
