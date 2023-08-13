# Esty bulk-discounts

[View Project as Merchants on Fly.io](https://esty-bulk-discounts.fly.dev/merchants) </br>
[View Project as Admin on Fly.io](esty-bulk-discounts.fly.dev/admin/dashboard) </br>
> *Please Note: The deployed app is setup to disconnect from the server when not being used, and may take a few minutes to load.*

## Project Overview
*"Esty Bulk Discounts"* is a comprehensive e-commerce project that integrates complex ActiveRecord queries to compute maximum percent discounts available for each item in an invoice, and calculating total discounts and revenue after applying discounts for invoices. The project also incorporates real-time data consumed from the Nager.Date API to display upcoming US holidays and gives merchants the functionality to manage discounts available to their products. 

---
### Languages, Frameworks, and Tools used
- **Building:** Ruby, Rails, HTML, CSS, and some SQL
- **Testing:** RSpec, Capybara, ShouldaMatchers
- **Queries:** Postico, Rails Console, Rails Database Console
- **Consuming API:** Faraday HTTP client library

### Project Challenges:
- At the beginning of the project I was most nervous about writing a complex ActiveRecord query for determining the highest discount percentage available for each item on an invoice and calculating the total disounted revenue for invoices. Since this involved so many different models and required multiple aggregations/calculations, it was very intimidating. I think my feelings were justified because it was the most complex and challenging query I have had to write so far. However, it was extrememly rewarding to achieve the desired results using only ActiveRecord and not needing to lean on ruby methods.
- One thing that I got stuck on during this project was deploying the app to the internet. I went down a rabbit hole trying to launch on a free deployment website to find out it only works on front-end applications and did not support hosting the postgres database. This ended up extending the time it took to deploy my website, but also helped me learn what to look for in the future.

### Accomplishments:
- Advanced ActiveRecord Queries: Through Esty Bulk Discounts, I developed a deep understanding of complex ActiveRecord queries, enabling me to efficiently find and apply the maximum percent discount for each item on an invoice. This experience helped me learn the power of using ActiveRecord to create dynamic functionality across the app.
- API Integration Proficiency: Integrating the Nager.Date API into the project exposed me to real-time data retrieval and display, enhancing my skills in working with external APIs. By dynamically rendering the next 3 US holidays, I gained practical experience in handling real-time data updates leveraging Faraday HTTP client library abstraction.
- E-commerce Insights: Creating and managing merchant discounts provided valuable insights into e-commerce workflows. By implementing features like viewing, adding, editing, and removing discounts, I developed a practical understanding of the key functionalities that enhance (merchant) user experience. 
