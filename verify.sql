-- Verification results produced from swiggy_capstone.db

-- SELECT COUNT(*) FROM restaurants;     --> 15
-- SELECT COUNT(*) FROM customers;       --> 50
-- SELECT COUNT(*) FROM orders;          --> 420
-- SELECT COUNT(*) FROM cuisine_targets; --> 6

-- SELECT status, COUNT(*) FROM orders GROUP BY status ORDER BY status;
-- Cancelled --> 35
-- Delivered --> 358
-- Pending   --> 27
