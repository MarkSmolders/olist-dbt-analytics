# **Olist E-Commerce Analysis**

This analysis covers the Olist E-Commerce dataset spanning September 2016 to August 2018. Prior to January 2017 the platform was in its launch phase with sparse data, and the transaction records end on 29 August 2018. For this reason the reliable analytical period used throughout this analysis is January 2017 to August 2018. Any apparent decline in Q3 2018 reflects the dataset cutoff rather than an actual business downturn, and is treated as a data limitation rather than a trend.

---
## Delivery findings and its impact on satisfaction
Customer satisfaction is measured through order reviews, scored from 1 to 5. This analysis is based on 95,607 reviews from delivered orders during the period January 2017 to August 2018.
### 1.1 Late delivery damages customer satisfaction
As seen in the table below the data shows a very strong correlation between delivery timing and customer satisfaction. As soon as the delivery delays even slightly the customer satisfaction plummets by 1.57 review points compared to on time deliveries. This problem is further exacerbated with moderately late deliveries dropping another 1.05 points to 1.67, after which satisfaction plateaus for more severe delays. The data shows that this is not a linear fall off but a sharp cliff. 

Negative reviews directly impact the sellers reputation and future purchasing decisions on the platform, harming potential revenue and potentially hurting the image of the platform. While the majority (93%) of deliveries are on time the roughly 7% of late deliveries drastically drag down platform satisfaction.

| Delivery Timing | Total Reviews | Average Review Score |
|-----------------|--------------|------------------|
| On time or early | 89,245 | 4.29 |
| Slightly late (1-7 days) | 3,589 | 2.72 |
| Moderately late (8-14 days) | 1,440 | 1.67 |
| Very late (15+ days) | 1,333 | 1.72 |

### 1.2 Where the delay originates
Having established that late deliveries negatively impact customer satisfaction, further research was done to discover the origin of the delays. The full logistic journey has two main stages: seller fulfilment (the time from purchase to the seller handing the order to the carrier) and carrier delivery (the time from carrier handoff to the customer receiving the order). 

An analysis of the data points overwhelmingly to the carrier stage. For on-time orders, seller fulfilment averages 2.5 days. As orders become later the seller fulfilment rises only to an average of 6.6 days even for the most severe delays. In contrast, carrier delivery time exploded from 7.5 days on average for on-time orders to 47.1 days on average for very late orders. A median of 42 days confirmed this reflects a genuine pattern rather than a handful of extreme outliers. 

This critical distinction makes it clear that the delay is almost exclusively caused at the carrier stage. Any effort to improve delivery performance should therefore primarily be focused on logistics and carrier partnerships rather than on seller fulfilment time.
### 1.3 Which regions or routes are worst affected
Breaking down delivery performance by customer state reveals that late deliveries are heavily concentrated in Brazil's Northeast. The five worst states are all Northeastern, with Alagoas being the worst at 21.4% late, more than five times the rate of the best-performing regions. The five best states are primarily Northern (Amazonas, Rondônia, Amapá, Acre) plus one Southern state (Paraná).

Notably, the delays are not correlated with order volume, with São Paulo accounting for over 40,000 orders, by far the largest of any state, while maintaining a late rate of just 4.5%. Combined with the earlier finding that delays originate at the carrier stage, this points to a specific weakness in the carrier network serving the Northeast. Prioritising carrier partnerships or alternative logistics providers in these states would target the problem where it is most concentrated.

| Worst 5 States | % Late | | Best 5 States | % Late |
|----------------|--------|---|---------------|--------|
| Alagoas (AL) | 21.4% | | Amazonas (AM) | 2.8% |
| Maranhão (MA) | 17.4% | | Rondônia (RO) | 2.9% |
| Sergipe (SE) | 15.2% | | Amapá (AP) | 3.0% |
| Piauí (PI) | 13.9% | | Acre (AC) | 3.8% |
| Ceará (CE) | 13.8% | | Paraná (PR) | 4.0% |
---
## 2. The top 10% of sellers generate two-thirds of revenue
As an e-commerce marketplace, Olist's revenue was expected to follow a Pareto distribution, but the concentration found is more extreme than the typical 80/20 rule. As seen in the table below, the top 10% of sellers generate 67.2% of all revenue, with the top 20% accounting for 82.5%. At the other end, the bottom half of sellers contributes just 5.6%.

This concentration is both a strength and a risk. A small group of high-performing sellers drives the majority of the platform's income, meaning the loss of even a few top sellers would have a disproportionate impact on revenue. Olist should therefore prioritise dedicated retention and support strategies for its top-tier sellers, while offering the long tail of smaller sellers low-touch tools to help them grow.


| Seller Group | Sellers | % of Total Revenue |
|--------------|---------|--------------------|
| Top 10% | 310 | 67.2% |
| Top 20% | 620 | 82.5% |
| Bottom 50% | 1,545 | 5.6% |
---
## 3. Category performance should guide platform strategy
As a marketplace, Olist does not control product quality directly, but it does decide which categories to promote, market and recruit sellers for. Following the standard marketplace model of percentage comission on each sale the most valuable categories to promote are those combining high revenue per item with strong satisfaction. Musical instruments and small appliances stand out, both generating around 190,000 BRL from less than 700 items sold. This means there is a high value per transaction, while maintaining a strong customer satisfcation with review scores averaging above 4.0.

On the other side, categories such as fixed telephony and audio generate moderate revenue but show the lowest customer satisfaction, with average review scores of 3.74 and 3.76 respectively. Rather than promoting these specifically, Olist should invest in tightening seller quality standards before pushing for their growth. Directing customers toward these categories without improving satisfaction first risks leaving them dissatisfied and further amplifying negative reviews.

| Category | Revenue (BRL) | Items Sold | Avg Review |
|----------|--------------|------------|------------|
| Luggage & Accessories | 140,430 | 1,092 | 4.34 |
| Musical Instruments | 191,499 | 680 | 4.10 |
| Small Appliances | 190,864 | 681 | 4.08 |
| Electronics | 160,247 | 2,767 | 4.08 |
| Consoles & Games | 158,000 | 1,138 | 3.97 |
| Fixed Telephony | 59,623 | 265 | 3.74 |
| Audio | 50,689 | 364 | 3.76 |

---
## Summary
This analysis surfaced three analytical insights with actionable findings for the Olist platform. Firstly, late delivery is a major driver of customer dissatisfaction, with review scores collapsing from 4.29 to below 1.7 once orders arrive late. These delays are almost exclusively caused at the carrier stage of the logistics chain and are heavily concentrated in Brazil's Northeast. Secondly, revenue follows an extreme Pareto distribution, with the top 10% of sellers generating two-thirds of all income, making top-seller retention a priority. Thirdly, high-value and well-reviewed categories such as musical instruments and small appliances offer the strongest returns on marketing and seller recruitment and warrant focused investment.

Together these findings point to three clear priorities: strengthen carrier partnerships in underperforming regions, protect and grow the small group of sellers driving most revenue, and focus category strategy on proven high-value, high-satisfaction segments.