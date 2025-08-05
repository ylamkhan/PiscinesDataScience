#!/bin/bash

# Piscine Data Science - Database Setup Script
echo "🚀 Setting up Piscine Data Science Database Environment"
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is installed
check_docker() {
    print_status "Checking Docker installation..."
    if command -v docker &> /dev/null; then
        print_success "Docker is installed"
        docker --version
    else
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
}

# Check if Docker Compose is installed
check_docker_compose() {
    print_status "Checking Docker Compose installation..."
    if command -v docker-compose &> /dev/null; then
        print_success "Docker Compose is installed"
        docker-compose --version
    else
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
}

# Create directory structure
create_directories() {
    print_status "Creating directory structure..."
    
    # Create main directories
    mkdir -p customer
    mkdir -p items
    mkdir -p ex00
    mkdir -p ex01
    mkdir -p ex02
    mkdir -p ex03
    mkdir -p ex04
    
    print_success "Directory structure created"
}

# Create sample CSV files
create_sample_csvs() {
    print_status "Creating sample CSV files..."
    
    # Create customer CSV files
    cat > customer/data_2022_dec.csv << 'EOF'
event_time,event_type,product_id,price,user_id,user_session
2022-12-01 00:00:00 UTC,remove_from_cart,5712790,6.27,576802932,51d85cb0-897f-48d2-918b-ad63965c12dc
2022-12-01 01:15:23 UTC,view,5764655,12.99,576802933,52d85cb0-897f-48d2-918b-ad63965c12dd
2022-12-01 02:30:45 UTC,cart,4958,25.50,576802934,53d85cb0-897f-48d2-918b-ad63965c12de
2022-12-01 03:45:12 UTC,purchase,5712790,6.27,576802932,51d85cb0-897f-48d2-918b-ad63965c12dc
2022-12-01 04:20:33 UTC,view,5764655,12.99,576802935,54d85cb0-897f-48d2-918b-ad63965c12df
EOF

    cat > customer/data_2022_nov.csv << 'EOF'
event_time,event_type,product_id,price,user_id,user_session
2022-11-01 00:00:00 UTC,view,5712790,6.27,576802932,41d85cb0-897f-48d2-918b-ad63965c12dc
2022-11-01 01:15:23 UTC,cart,5764655,12.99,576802933,42d85cb0-897f-48d2-918b-ad63965c12dd
2022-11-01 02:30:45 UTC,purchase,4958,25.50,576802934,43d85cb0-897f-48d2-918b-ad63965c12de
2022-11-01 03:45:12 UTC,remove_from_cart,5712790,6.27,576802932,41d85cb0-897f-48d2-918b-ad63965c12dc
2022-11-01 04:20:33 UTC,view,5764655,12.99,576802935,44d85cb0-897f-48d2-918b-ad63965c12df
EOF

    cat > customer/data_2022_oct.csv << 'EOF'
event_time,event_type,product_id,price,user_id,user_session
2022-10-01 00:00:00 UTC,view,5712790,6.27,576802932,31d85cb0-897f-48d2-918b-ad63965c12dc
2022-10-01 01:15:23 UTC,cart,5764655,12.99,576802933,32d85cb0-897f-48d2-918b-ad63965c12dd
2022-10-01 02:30:45 UTC,view,4958,25.50,576802934,33d85cb0-897f-48d2-918b-ad63965c12de
2022-10-01 03:45:12 UTC,purchase,5712790,6.27,576802932,31d85cb0-897f-48d2-918b-ad63965c12dc
2022-10-01 04:20:33 UTC,cart,5764655,12.99,576802935,34d85cb0-897f-48d2-918b-ad63965c12df
EOF

    cat > customer/data_2023_jan.csv << 'EOF'
event_time,event_type,product_id,price,user_id,user_session
2023-01-01 00:00:00 UTC,view,5712790,6.27,576802932,61d85cb0-897f-48d2-918b-ad63965c12dc
2023-01-01 01:15:23 UTC,purchase,5764655,12.99,576802933,62d85cb0-897f-48d2-918b-ad63965c12dd
2023-01-01 02:30:45 UTC,cart,4958,25.50,576802934,63d85cb0-897f-48d2-918b-ad63965c12de
2023-01-01 03:45:12 UTC,view,5712790,6.27,576802932,61d85cb0-897f-48d2-918b-ad63965c12dc
2023-01-01 04:20:33 UTC,remove_from_cart,5764655,12.99,576802935,64d85cb0-897f-48d2-918b-ad63965c12df
EOF

    # Create items CSV file
    cat > items/items.csv << 'EOF'
product_id,category_id,category_code,brand
5712790,1487580005268456192,,f.o.x
5764655,1487580005411062528,,cnd
4958,1487580009471148032,,runail
5712791,1487580005268456193,electronics.smartphone,samsung
5764656,1487580005411062529,beauty.cosmetics,loreal
4959,1487580009471148033,fashion.shoes,nike
5712792,1487580005268456194,home.kitchen,philips
5764657,1487580005411062530,sports.fitness,adidas
EOF

    print_success "Sample CSV files created"
}

# Install Python dependencies
install_python_deps() {
    print_status "Installing Python dependencies..."
    
    if command -v python3 &> /dev/null; then
        if command -v pip3 &> /dev/null; then
            pip3 install -r requirements.txt
            print_success "Python dependencies installed"
        else
            print_warning "pip3 not found. Please install pip3 first."
        fi
    else
        print_warning "Python3 not found. Please install Python3 first."
    fi
}

# Start Docker containers
start_containers() {
    print_status "Starting Docker containers..."
    
    # Stop any existing containers
    docker-compose down 2>/dev/null || true
    
    # Start containers
    docker-compose up -d
    
    if [ $? -eq 0 ]; then
        print_success "Docker containers started successfully"
        print_status "Waiting for PostgreSQL to be ready..."
        sleep 10
        
        # Test database connection
        docker-compose exec postgres pg_isready -U your_login -d piscineds
        if [ $? -eq 0 ]; then
            print_success "PostgreSQL is ready"
        else
            print_warning "PostgreSQL might still be starting up"
        fi
    else
        print_error "Failed to start Docker containers"
        exit 1
    fi
}

# Show connection information
show_connection_info() {
    print_status "Connection Information:"
    echo ""
    echo "📊 pgAdmin (Database Management):"
    echo "   URL: http://localhost:8080"
    echo "   Email: admin@example.com"
    echo "   Password: admin"
    echo ""
    echo "🗄️  PostgreSQL Database:"
    echo "   Host: localhost"
    echo "   Port: 5432"
    echo "   Database: piscineds"
    echo "   Username: your_login"
    echo "   Password: mysecretpassword"
    echo ""
    echo "🔗 Direct Connection Command:"
    echo "   psql -U your_login -d piscineds -h localhost -W"
    echo ""
}

# Create a test connection script
create_test_script() {
    print_status "Creating test connection script..."
    
    cat > test_connection.py << 'EOF'
#!/usr/bin/env python3

import psycopg2
import sys

def test_connection():
    try:
        conn = psycopg2.connect(
            host="localhost",
            database="piscineds",
            user="your_login",
            password="mysecretpassword",
            port="5432"
        )
        
        cursor = conn.cursor()
        cursor.execute("SELECT version();")
        version = cursor.fetchone()
        
        print("✅ Database connection successful!")
        print(f"PostgreSQL version: {version[0]}")
        
        cursor.close()
        conn.close()
        return True
        
    except Exception as e:
        print(f"❌ Database connection failed: {e}")
        return False

if __name__ == "__main__":
    test_connection()
EOF

    chmod +x test_connection.py
    print_success "Test connection script created (test_connection.py)"
}

# Update login in files
update_login() {
    read -p "Enter your student login (or press Enter to keep 'your_login'): " login
    
    if [ ! -z "$login" ]; then
        print_status "Updating login to '$login' in configuration files..."
        
        # Update docker-compose.yml
        sed -i.bak "s/your_login/$login/g" docker-compose.yml
        
        # Update Python scripts
        find . -name "*.py" -exec sed -i.bak "s/your_login/$login/g" {} \;
        
        # Update test script
        sed -i.bak "s/your_login/$login/g" test_connection.py
        
        print_success "Login updated to '$login'"
    else
        print_warning "Keeping default login 'your_login' - remember to update it manually"
    fi
}

# Main execution
main() {
    echo "Starting setup process..."
    
    check_docker
    check_docker_compose
    create_directories
    create_sample_csvs
    update_login
    install_python_deps
    start_containers
    create_test_script
    
    echo ""
    print_success "Setup completed successfully! 🎉"
    echo ""
    show_connection_info
    
    print_status "Next steps:"
    echo "1. Test the database connection: python3 test_connection.py"
    echo "2. Open pgAdmin: http://localhost:8080"
    echo "3. Run Exercise 02: cd ex02 && python3 table.py"
    echo "4. Run Exercise 03: cd ex03 && python3 automatic_table.py"
    echo "5. Run Exercise 04: cd ex04 && python3 items_table.py"
    echo ""
    print_status "To stop the containers: docker-compose down"
}

# Run main function
main