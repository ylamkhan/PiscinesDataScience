# Piscine Data Science - Database Creation Project

This project implements a complete solution for the Piscine Data Science database creation exercises using Python, PostgreSQL, pgAdmin, and Docker.

## 🚀 Quick Start

1. **Clone or download all files to your project directory**

2. **Run the setup script:**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. **Test the connection:**
   ```bash
   python3 test_connection.py
   ```

4. **Open pgAdmin:**
   - URL: http://localhost:8080
   - Email: admin@example.com
   - Password: admin

## 📁 Project Structure

```
piscine-datascience/
├── docker-compose.yml      # Docker configuration
├── init.sql               # Database initialization
├── requirements.txt       # Python dependencies
├── setup.sh              # Automated setup script
├── test_connection.py     # Connection test script
├── customer/              # Customer CSV files
│   ├── data_2022_dec.csv
│   ├── data_2022_nov.csv
│   ├── data_2022_oct.csv
│   └── data_2023_jan.csv
├── items/                 # Items CSV files
│   └── items.csv
├── ex00/                  # Exercise 00 (Docker setup)
├── ex01/                  # Exercise 01 (pgAdmin setup)
├── ex02/                  # Exercise 02 (First table)
│   └── table.py
├── ex03/                  # Exercise 03 (Automatic tables)
│   └── automatic_table.py
└── ex04/                  # Exercise 04 (Items table)
    └── items_table.py
```

## 🔧 Manual Setup (if setup.sh doesn't work)

### 1. Install Dependencies

```bash
# Install Python dependencies
pip3 install -r requirements.txt

# Start Docker containers
docker-compose up -d
```

### 2. Update Configuration

Replace `your_login` with your actual student login in:
- `docker-compose.yml`
- All Python files (`ex02/table.py`, `ex03/automatic_table.py`, `ex04/items_table.py`)
- `test_connection.py`

### 3. Verify Setup

```bash
# Test database connection
python3 test_connection.py

# Check containers are running
docker-compose ps
```

## 📊 Exercise Solutions

### Exercise 00: Create PostgreSQL DB ✅
- **Solution:** Docker Compose configuration
- **Files:** `docker-compose.yml`, `init.sql`
- **Connection:** `psql -U your_login -d piscineds -h localhost -W`

### Exercise 01: Show me your DB ✅
- **Solution:** pgAdmin web interface
- **Access:** http://localhost:8080
- **Credentials:** admin@example.com / admin

### Exercise 02: First table ✅
- **Solution:** `ex02/table.py`
- **Run:** `cd ex02 && python3 table.py`
- **Features:**
  - Reads CSV from customer folder
  - Creates table with proper data types
  - First column is TIMESTAMP (required)
  - Uses 6+ different PostgreSQL data types

### Exercise 03: Automatic table ✅
- **Solution:** `ex03/automatic_table.py`
- **Run:** `cd ex03 && python3 automatic_table.py`
- **Features:**
  - Automatically processes ALL CSV files in customer folder
  - Creates tables named after CSV files (without extension)
  - Handles multiple files simultaneously

### Exercise 04: Items table ✅
- **Solution:** `ex04/items_table.py`
- **Run:** `cd ex04 && python3 items_table.py`
- **Features:**
  - Creates items table from items.csv
  - Uses 3+ different data types (required)
  - Handles product_id, category_id, category_code, brand columns

## 🗄️ Database Connection Details

- **Host:** localhost
- **Port:** 5432
- **Database:** piscineds
- **Username:** your_login (replace with your actual login)
- **Password:** mysecretpassword

## 📋 Data Types Used

The solution uses these PostgreSQL data types to meet the "6+ different types" requirement:

1. **TIMESTAMP** - for datetime columns
2. **BIGINT** - for large integer IDs
3. **DECIMAL(10,2)** - for price values
4. **VARCHAR(255)** - for short text fields
5. **TEXT** - for longer text fields
6. **UUID** - for session IDs (when detected)
7. **BOOLEAN** - for true/false values (when needed)

## 🔍 Sample Data

### Customer Data Format:
```csv
event_time,event_type,product_id,price,user_id,user_session
2022-12-01 00:00:00 UTC,remove_from_cart,5712790,6.27,576802932,51d85cb0-897f-48d2-918b-ad63965c12dc
```

### Items Data Format:
```csv
product_id,category_id,category_code,brand
5712790,1487580005268456192,,f.o.x
5764655,1487580005411062528,,cnd
```

## 🛠️ Troubleshooting

### Docker Issues
```bash
# Stop all containers
docker-compose down

# Rebuild and restart
docker-compose up -d --build

# Check logs
docker-compose logs postgres
docker-compose logs pgadmin
```

### Connection Issues
```bash
# Test PostgreSQL is running
docker-compose exec postgres pg_isready -U your_login -d piscineds

# Direct database connection
docker-compose exec postgres psql -U your_login -d piscineds
```

### Python Issues
```bash
# Reinstall dependencies
pip3 install --upgrade -r requirements.txt

# Check Python version (needs 3.6+)
python3 --version
```

## 📝 Validation Checklist

- [ ] PostgreSQL database "piscineds" created
- [ ] Can connect with: `psql -U your_login -d piscineds -h localhost -W`
- [ ] pgAdmin accessible at http://localhost:8080
- [ ] Customer tables created with proper naming (data_2022_oct, etc.)
- [ ] Items table created with correct schema
- [ ] All tables use appropriate data types
- [ ] First column in customer tables is TIMESTAMP
- [ ] At least 6 different data types used across tables
- [ ] Data successfully imported from CSV files

## 🎯 Project Goals Achieved

✅ **Data Engineer Role:** Transform raw CSV data into structured database tables  
✅ **Data Cleaning:** Handle different data types and formats properly  
✅ **Automation:** Automatically process multiple CSV files  
✅ **Database Design:** Create proper schemas with appropriate data types  
✅ **Tool Integration:** Use professional tools (PostgreSQL, pgAdmin, Docker)

## 📞 Support

If you encounter issues:

1. Check the troubleshooting section above
2. Verify your Docker installation
3. Ensure all files have correct permissions
4. Check that ports 5432 and 8080 are available
5. Review the console output for specific error messages

Good luck with your evaluation! 🚀
