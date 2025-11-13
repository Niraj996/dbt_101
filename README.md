dbt_101 - Data Build Tool Learning Project
A hands-on dbt (Data Build Tool) project demonstrating data transformation best practices using PostgreSQL.
📋 Project Overview
This project showcases a complete dbt implementation including:

Data staging models
Business logic transformations
Data quality tests
Automated documentation

🏗️ Architecture
Raw Data (PostgreSQL) → Staging Models → Marts Models → Analytics
📊 Data Models
Staging Layer

stg_customers: Cleaned and standardized customer data
stg_orders: Cleaned and standardized order data (excludes cancelled orders)

Marts Layer

customer_orders_summary: Aggregated customer metrics including:

Total orders per customer
Total amount spent
Average order value
Last order date



🚀 Getting Started
Prerequisites

Ubuntu system (or WSL)
Python 3.7+
Docker
Git

Installation

Clone the repository

bashgit clone https://github.com/Niraj996/dbt_101.git
cd dbt_101

Set up Python virtual environment

bashpython3 -m venv dbt_venv
source dbt_venv/bin/activate

Install dbt

bashpip install dbt-postgres

Start PostgreSQL database

bashdocker run -d \
  --name postgres_dbt \
  -e POSTGRES_USER=dbt_user \
  -e POSTGRES_PASSWORD=dbt_password \
  -e POSTGRES_DB=dbt_database \
  -p 5432:5432 \
  postgres:14

Load sample data

bashdocker exec -it postgres_dbt psql -U dbt_user -d dbt_database -f setup/sample_data.sql

Configure dbt profile

Create ~/.dbt/profiles.yml:
yamlmy_dbt_project:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: dbt_user
      password: dbt_password
      port: 5432
      dbname: dbt_database
      schema: analytics
      threads: 4

Test connection

bashdbt debug
🔧 Usage
Run Models
bash# Run all models
dbt run

# Run specific model
dbt run --select stg_customers

# Run model and all downstream dependencies
dbt run --select stg_customers+
Run Tests
bash# Run all tests
dbt test

# Run tests for specific model
dbt test --select stg_customers
Generate Documentation
bash# Generate documentation
dbt docs generate

# Serve documentation locally
dbt docs serve
```

Visit `http://localhost:8080` to view interactive documentation.

## 📁 Project Structure
```
dbt_101/
├── models/
│   ├── staging/
│   │   ├── stg_customers.sql
│   │   ├── stg_orders.sql
│   │   └── schema.yml
│   └── marts/
│       ├── customer_orders_summary.sql
│       └── schema.yml
├── tests/
│   └── assert_positive_order_amounts.sql
├── dbt_project.yml
└── README.md

🧪 Data Quality Tests

### Generic Tests (schema.yml)
- **Uniqueness**: Ensures primary keys are unique
- **Not Null**: Validates required fields are populated

### Custom Tests
- **Positive Order Amounts**: Validates all order amounts are greater than zero

📊 Sample Data

The project includes sample data for:
- **4 customers** with various attributes
- **6 orders** with different statuses and amounts

🛠️ Key dbt Commands

| Command | Description |
|---------|-------------|
| `dbt run` | Execute all models |
| `dbt test` | Run all tests |
| `dbt docs generate` | Generate documentation |
| `dbt docs serve` | Serve documentation locally |
| `dbt debug` | Test database connection |
| `dbt clean` | Clean generated files |

📖 What You'll Learn

- Setting up a dbt project from scratch
- Creating staging and mart layer models
- Writing SQL transformations with dbt
- Implementing data quality tests
- Using dbt's ref() function for dependencies
- Generating and viewing documentation
- Best practices for data modeling

🎯 Key Concepts Demonstrated

1. **Modularity**: Separating staging and business logic
2. **DRY Principle**: Using ref() instead of hardcoding table names
3. **Testing**: Ensuring data quality at every layer
4. **Documentation**: Auto-generated, always up-to-date docs
5. **Materialization**: Using views and tables strategically

🔄 Data Flow

raw_data.customers  →  stg_customers  →  customer_orders_summary
raw_data.orders     →  stg_orders     ↗
📝 Model Details
stg_customers

Combines first_name and last_name into full_name
Standardizes email to lowercase
Source: raw_data.customers
Materialized as: View

stg_orders

Filters out cancelled orders
Standardizes status to lowercase
Source: raw_data.orders
Materialized as: View

customer_orders_summary

Aggregates customer order metrics
Handles customers with no orders (LEFT JOIN)
Uses COALESCE for NULL handling
Materialized as: Table

🤝 Contributing
This is a learning project. Feel free to:

Fork the repository
Experiment with the models
Add new transformations
Submit pull requests

📚 Resources

dbt Documentation
dbt Best Practices
dbt Discourse Community

🔍 Next Steps
After completing this project, explore:

Incremental models for large datasets
Macros for reusable SQL code
Snapshots for slowly changing dimensions
dbt packages (dbt_utils, dbt_expectations)
CI/CD integration
Production deployment strategies

📧 Contact
For questions or feedback, please open an issue in this repository.
📄 License
This project is open source and available for educational purposes.

Happy Data Transforming! 🚀
