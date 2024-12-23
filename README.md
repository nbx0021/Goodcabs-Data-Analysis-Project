# Goodcabs Data Analysis Project

## **Overview**
This project analyzes trip data for Goodcabs, a cab service provider operating in tier-2 cities across India. The goal is to provide actionable insights into trip performance, passenger behavior, and revenue trends. The analysis includes comparisons of actual performance against targets and explores emerging trends to enhance operational efficiency and customer satisfaction.

---

## **Problem Statement**
Goodcabs aims to improve its performance across key metrics such as:
- Trip volume variance
- Repeat passenger rate (RPR%)
- Revenue contribution
- Customer satisfaction

The project identifies top and bottom-performing cities, evaluates peak and low-demand periods, and provides strategic recommendations for improvement.

---

## **Objectives**
1. Analyze city-wise trip performance to identify patterns and trends.
2. Evaluate actual performance against targets for trips and ratings.
3. Identify high and low-demand periods and corresponding cities.
4. Assess repeat passenger trends and city contributions to loyalty programs.
5. Develop actionable recommendations to boost customer retention and revenue.

---

## **Data Overview**
### **Sources:**
1. `trips_db`: Contains trip and passenger details.
2. `targets_db`: Includes monthly performance targets.

### **Key Tables Used:**
- `fact_trips`: Trip-level data including distance, fare, and ratings.
- `dim_city`: Metadata about cities.
- `fact_passenger_summary`: Aggregated passenger metrics.
- `monthly_target_trips`: City-specific target trip counts.

---

## **Methodology**
1. **Data Extraction**: Queried data using Python (SQLAlchemy and Pandas).
2. **Data Cleaning**: Ensured consistency in city mappings and removed duplicates.
3. **Analysis**:
   - Calculated key metrics such as RPR%, variance, and average ratings.
   - Identified top and bottom-performing cities.
4. **Visualization**: Created charts using Matplotlib and Seaborn for insights.

---

## **Key Findings**
### **Top and Bottom Cities by Trip Volume Variance:**
- **Top:** Jaipur (9,388), Mysore (2,738), Kochi (1,202)
- **Bottom:** Lucknow (-7,701), Vadodara (-5,474), Surat (-2,157)

### **Average Distance Traveled and Fare:**
- **Top Cities:** Jaipur (30.02 KM, ₹483), Kochi (24.07 KM, ₹335.25)
- **Bottom Cities:** Surat (11.00 KM, ₹117.27), Vadodara (11.52 KM, ₹118.27)

### **Repeat Passenger Ratio (RPR%):**
- **Current Top Cities:** Surat (42.63%), Lucknow (37.12%), Indore (32.68%)
- **6-Month Top Cities:** Surat (49.17%), Lucknow (46.70%)

---

## **Key Visualizations**
1. **Top and Bottom Cities by Trip Volume Variance:**
 ![Top and Bottom Cities by Trip Volume](https://github.com/user-attachments/assets/7c662196-07fc-4ac8-80fd-0c81312fd466)


2. **Average Distance Traveled by City:**
 ![Average Distance Travelled by City](https://github.com/user-attachments/assets/4e21dd34-8cac-4db8-a8d9-041dd6620fed)



3. **Repeat Passenger Ratio (RPR%) by City:**
   ![Repeat Passenger Ratio (RPR) Percentage by City](https://github.com/user-attachments/assets/2775d8da-c72c-4133-9e4b-4bfef2e628b9)


4. **Actual vs Target Trips:**
   ![Actual Trips vs Target Trips by City](https://github.com/user-attachments/assets/eae0d819-388b-4673-b9b1-1abdcf2420a8)

---

## **Recommendations**
1. **Marketing Strategies:**
   - Increase marketing in low-performing cities (e.g., Lucknow, Surat).
   - Highlight top-performing cities in campaigns to attract new users.

2. **Operational Improvements:**
   - Implement loyalty rewards for repeat passengers.
   - Optimize driver allocation during peak-demand periods.

3. **Adopt Emerging Trends:**
   - Introduce electric vehicles to align with sustainability goals.
   - Develop partnerships with local businesses to boost demand.

4. **Event-Specific Promotions:**
   - Leverage local events and tourism seasons to drive trip volumes.

---

## **Tools and Technologies**
- **Data Extraction:** SQLAlchemy, Pandas
- **Data Cleaning:** Python, Pandas
- **Visualization:** Matplotlib, Seaborn
- **Database Management:** MySQL

---

## **Challenges**
1. Inconsistent data formats across databases.
2. Seasonal variability affecting trip volumes.
3. Limited granularity in target trip data.

---

## **Future Scope**
- Enhance data collection to include passenger feedback and operational efficiency metrics.
- Integrate AI-driven demand forecasting for better resource planning.
- Expand analysis to tier-3 cities for growth opportunities.

---

## **Conclusion**
This project provides actionable insights into Goodcabs’ performance, focusing on data-driven strategies to improve customer satisfaction, enhance operational efficiency, and boost revenue. By implementing the recommendations, Goodcabs can achieve its goals and maintain a competitive edge in the cab service market.

