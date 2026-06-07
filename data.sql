INSERT INTO customers VALUES
(1, 'Priya Sharma',    'priya@email.com',    'Mumbai',   '2023-01-15'),
(2, 'Rohan Mehta',     'rohan@email.com',    'Delhi',    '2023-02-20'),
(3, 'Ananya Singh',    'ananya@email.com',   'Pune',     '2023-03-10'),
(4, 'Vikram Nair',     'vikram@email.com',   'Bangalore','2023-04-05'),
(5, 'Sneha Iyer',      'sneha@email.com',    'Chennai',  '2023-05-18'),
(6, 'Arjun Verma',     'arjun@email.com',    'Hyderabad','2023-06-22'),
(7, 'Kavya Reddy',     'kavya@email.com',    'Mumbai',   '2023-07-30'),
(8, 'Rahul Gupta',     'rahul@email.com',    'Delhi',    '2023-08-14');

INSERT INTO products VALUES
(1,  'Wireless Headphones', 'Electronics',  2999.00),
(2,  'Running Shoes',        'Sports',        3499.00),
(3,  'Cotton T-Shirt',       'Clothing',       599.00),
(4,  'Yoga Mat',             'Sports',        899.00),
(5,  'Smartphone Case',      'Electronics',  349.00),
(6,  'Backpack',             'Accessories',   1799.00),
(7,  'Water Bottle',         'Sports',        449.00),
(8,  'Desk Lamp',            'Home',          1299.00),
(9,  'Notebook Set',         'Stationery',    299.00),
(10, 'Bluetooth Speaker',    'Electronics',  4599.00);

INSERT INTO orders VALUES
(1, 1, '2024-01-10', 'completed'),
(2, 2, '2024-01-15', 'completed'),
(3, 3, '2024-02-05', 'completed'),
(4, 1, '2024-02-20', 'returned'),
(5, 4, '2024-03-01', 'completed'),
(6, 5, '2024-03-15', 'completed'),
(7, 2, '2024-04-10', 'completed'),
(8, 6, '2024-04-22', 'pending'),
(9, 7, '2024-05-05', 'completed'),
(10,3, '2024-05-18', 'completed'),
(11,8, '2024-06-01', 'completed'),
(12,1, '2024-06-10', 'completed');

INSERT INTO order_items VALUES
(1,  1,  1,  1, 2999.00),
(2,  1,  5,  2,  349.00),
(3,  2,  2,  1, 3499.00),
(4,  3,  4,  1,  899.00),
(5,  3,  7,  2,  449.00),
(6,  4,  3,  3,  599.00),
(7,  5,  10, 1, 4599.00),
(8,  6,  6,  1, 1799.00),
(9,  7,  8,  1, 1299.00),
(10, 8,  9,  4,  299.00),
(11, 9,  1,  1, 2999.00),
(12, 10, 2,  1, 3499.00),
(13, 11, 10, 2, 4599.00),
(14, 12, 6,  1, 1799.00);