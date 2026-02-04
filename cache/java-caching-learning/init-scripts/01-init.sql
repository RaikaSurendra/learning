-- Initialize the database with sample data

CREATE TABLE IF NOT EXISTS products (
    id BIGSERIAL PRIMARY KEY,
    sku VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(100),
    stock_quantity INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_products_sku ON products(sku);
CREATE INDEX idx_products_category ON products(category);

-- Insert sample products
INSERT INTO products (sku, name, description, price, category, stock_quantity) VALUES
('SKU-001', 'Wireless Mouse', 'Ergonomic wireless mouse with USB receiver', 29.99, 'Electronics', 150),
('SKU-002', 'Mechanical Keyboard', 'RGB backlit mechanical keyboard', 89.99, 'Electronics', 75),
('SKU-003', 'USB-C Hub', '7-in-1 USB-C hub with HDMI', 49.99, 'Electronics', 200),
('SKU-004', 'Monitor Stand', 'Adjustable monitor stand with USB ports', 39.99, 'Accessories', 100),
('SKU-005', 'Webcam HD', '1080p HD webcam with microphone', 59.99, 'Electronics', 80),
('SKU-006', 'Desk Lamp', 'LED desk lamp with adjustable brightness', 34.99, 'Home Office', 120),
('SKU-007', 'Mouse Pad XL', 'Extra large gaming mouse pad', 19.99, 'Accessories', 250),
('SKU-008', 'Headphone Stand', 'Aluminum headphone stand', 24.99, 'Accessories', 90),
('SKU-009', 'Cable Organizer', 'Desktop cable management kit', 14.99, 'Accessories', 300),
('SKU-010', 'Laptop Stand', 'Foldable aluminum laptop stand', 44.99, 'Accessories', 110);

-- Create users table for advanced examples
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, email) VALUES
('john_doe', 'john@example.com'),
('jane_smith', 'jane@example.com'),
('bob_wilson', 'bob@example.com');
