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

Creating docker and inserting data 

1.
   # Update package list
sudo apt update

# Install Python 3 and pip
sudo apt install python3 python3-pip python3-venv -y

# Verify installation
python3 --version
pip3 --version

2.
   # Create and navigate to project directory
mkdir ~/dbt_project
cd ~/dbt_project

3.
    # Create virtual environment
python3 -m venv dbt_venv

# Activate virtual environment
source dbt_venv/bin/activate

4.
   # Install dbt with PostgreSQL adapter
pip install dbt-postgres

# Verify installation
dbt --version

5. Create a Docker Network

    docker network create dbt_network
6.
   docker run -d \
  --name postgres_dbt \
  --network dbt_network \
  -e POSTGRES_USER=dbt_user \
  -e POSTGRES_PASSWORD=dbt_password \
  -e POSTGRES_DB=dbt_database \
  -p 5432:5432 \
  postgres:14

7.
   # Check container status
docker ps

# Connect to PostgreSQL to verify
docker exec -it postgres_dbt psql -U dbt_user -d dbt_database

8.
   \l  -- List databases
   \q  -- Quit

9.
    # Connect to PostgreSQL
docker exec -it postgres_dbt psql -U dbt_user -d dbt_database

10.
    -- Create a schema for raw data
CREATE SCHEMA IF NOT EXISTS raw_data;

-- Create a customers table
CREATE TABLE raw_data.customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    signup_date DATE
);

-- Create an orders table
CREATE TABLE raw_data.orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    order_amount DECIMAL(10, 2),
    status VARCHAR(20)
);

-- Insert sample customer data
INSERT INTO raw_data.customers (first_name, last_name, email, signup_date) VALUES
('John', 'Doe', 'john.doe@email.com', '2024-01-15'),
('Jane', 'Smith', 'jane.smith@email.com', '2024-02-20'),
('Bob', 'Johnson', 'bob.johnson@email.com', '2024-03-10'),
('Alice', 'Williams', 'alice.w@email.com', '2024-04-05');

-- Insert sample order data
INSERT INTO raw_data.orders (customer_id, order_date, order_amount, status) VALUES
(1, '2024-01-20', 150.00, 'completed'),
(1, '2024-02-15', 200.00, 'completed'),
(2, '2024-02-25', 75.50, 'completed'),
(2, '2024-03-01', 120.00, 'pending'),
(3, '2024-03-15', 300.00, 'completed'),
(4, '2024-04-10', 50.00, 'cancelled');

-- Verify data
SELECT * FROM raw_data.customers;
SELECT * FROM raw_data.orders;

-- Exit PostgreSQL
\q

11.
    # Make sure you're in the project directory with venv activated
cd ~/dbt_101

# Initialize dbt project
dbt init dbt_101

12 .
cd dbt_101
```

### 3.3 Understand the Folder Structure
```
my_dbt_project/
├── dbt_project.yml       # Main configuration file
├── README.md             # Project documentation
├── models/               # Where your SQL models live
│   └── example/          # Example models (can be deleted)
├── analyses/             # Ad-hoc queries
├── tests/                # Custom data tests
├── seeds/                # CSV files to load into database
├── macros/               # Reusable SQL functions
├── snapshots/            # Capture historical data changes
└── .gitignore           # Git ignore file

13.   
# Create .dbt directory in home folder
mkdir -p ~/.dbt

# Create profiles.yml file
nano ~/.dbt/profiles.yml

14. 
Add Configuration
Paste the following into profiles.yml:

dbt_101:
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
      keepalives_idle: 0

15.
# Test if dbt can connect to the database
dbt debug
You should see All checks passed! at the end.

Now create models fils as per above repo
Thanks !!!
