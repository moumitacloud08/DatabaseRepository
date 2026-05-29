// =========================================
// MONGODB SAMPLE DATABASE
// =========================================

// USE DATABASE

use companydb

// =========================================
// CUSTOMERS COLLECTION
// =========================================

db.customers.insertMany([
{
customer_id: 1,
customer_name: "Raj Sharma",
email: "[raj@gmail.com](mailto:raj@gmail.com)",
city: "Delhi",
country: "India"
},
{
customer_id: 2,
customer_name: "Sarah Johnson",
email: "[sarah@gmail.com](mailto:sarah@gmail.com)",
city: "New York",
country: "USA"
},
{
customer_id: 3,
customer_name: "Mohit Verma",
email: "[mohit@gmail.com](mailto:mohit@gmail.com)",
city: "Mumbai",
country: "India"
},
{
customer_id: 4,
customer_name: "Lisa White",
email: "[lisa@gmail.com](mailto:lisa@gmail.com)",
city: "London",
country: "UK"
},
{
customer_id: 5,
customer_name: "Ahmed Ali",
email: "[ahmed@gmail.com](mailto:ahmed@gmail.com)",
city: "Dubai",
country: "UAE"
}
])

// =========================================
// PRODUCTS COLLECTION
// =========================================

db.products.insertMany([
{
product_id: 1,
product_name: "Laptop",
category: "Electronics",
price: 75000,
stock_quantity: 10
},
{
product_id: 2,
product_name: "Phone",
category: "Electronics",
price: 30000,
stock_quantity: 20
},
{
product_id: 3,
product_name: "Keyboard",
category: "Accessories",
price: 1500,
stock_quantity: 50
},
{
product_id: 4,
product_name: "Mouse",
category: "Accessories",
price: 800,
stock_quantity: 100
},
{
product_id: 5,
product_name: "Monitor",
category: "Electronics",
price: 12000,
stock_quantity: 15
}
])

// =========================================
// ORDERS COLLECTION
// =========================================

db.orders.insertMany([
{
order_id: 1,
customer_id: 1,
order_date: new Date("2025-01-10"),
total_amount: 75800,
items: [
{
product_id: 1,
product_name: "Laptop",
quantity: 1,
subtotal: 75000
},
{
product_id: 4,
product_name: "Mouse",
quantity: 1,
subtotal: 800
}
],
payment: {
payment_method: "Credit Card",
payment_date: new Date("2025-01-10"),
amount: 75800
}
},
{
order_id: 2,
customer_id: 2,
order_date: new Date("2025-01-12"),
total_amount: 30000,
items: [
{
product_id: 2,
product_name: "Phone",
quantity: 1,
subtotal: 30000
}
],
payment: {
payment_method: "UPI",
payment_date: new Date("2025-01-12"),
amount: 30000
}
},
{
order_id: 3,
customer_id: 3,
order_date: new Date("2025-01-15"),
total_amount: 13500,
items: [
{
product_id: 5,
product_name: "Monitor",
quantity: 1,
subtotal: 12000
},
{
product_id: 3,
product_name: "Keyboard",
quantity: 1,
subtotal: 1500
}
],
payment: {
payment_method: "Net Banking",
payment_date: new Date("2025-01-15"),
amount: 13500
}
}
])

// =========================================
// EMPLOYEES COLLECTION
// =========================================

db.employees.insertMany([
{
employee_id: 1,
first_name: "John",
last_name: "Smith",
email: "[john@gmail.com](mailto:john@gmail.com)",
salary: 60000,
hire_date: new Date("2023-01-10"),
department: {
department_id: 2,
department_name: "IT"
}
},
{
employee_id: 2,
first_name: "Alice",
last_name: "Brown",
email: "[alice@gmail.com](mailto:alice@gmail.com)",
salary: 55000,
hire_date: new Date("2022-06-15"),
department: {
department_id: 1,
department_name: "HR"
}
},
{
employee_id: 3,
first_name: "David",
last_name: "Wilson",
email: "[david@gmail.com](mailto:david@gmail.com)",
salary: 75000,
hire_date: new Date("2021-03-20"),
department: {
department_id: 3,
department_name: "Finance"
}
}
])

// =========================================
// BASIC QUERIES
// =========================================

// FIND ALL CUSTOMERS

db.customers.find()

// FIND PRODUCTS PRICE > 10000

db.products.find({
price: { $gt: 10000 }
})

// FIND CUSTOMERS FROM INDIA

db.customers.find({
country: "India"
})

// SORT PRODUCTS BY PRICE DESC

db.products.find().sort({
price: -1
})

// LIMIT RESULTS

db.products.find().limit(3)

// =========================================
// UPDATE QUERIES
// =========================================

// UPDATE STOCK

db.products.updateOne(
{
product_id: 1
},
{
$set: {
stock_quantity: 8
}
}
)

// INCREASE PRICE

db.products.updateMany(
{},
{
$inc: {
price: 500
}
}
)

// =========================================
// DELETE QUERIES
// =========================================

// DELETE ONE CUSTOMER

db.customers.deleteOne({
customer_id: 5
})

// DELETE MANY PRODUCTS

db.products.deleteMany({
category: "Accessories"
})

// =========================================
// AGGREGATION QUERIES
// =========================================

// TOTAL SALES

db.orders.aggregate([
{
$group: {
_id: null,
total_sales: {
$sum: "$total_amount"
}
}
}
])

// TOTAL SALES BY CUSTOMER

db.orders.aggregate([
{
$group: {
_id: "$customer_id",
total_spent: {
$sum: "$total_amount"
}
}
}
])

// AVERAGE PRODUCT PRICE

db.products.aggregate([
{
$group: {
_id: null,
avg_price: {
$avg: "$price"
}
}
}
])

// MAX EMPLOYEE SALARY

db.employees.aggregate([
{
$group: {
_id: null,
max_salary: {
$max: "$salary"
}
}
}
])

// =========================================
// UNWIND ARRAY
// =========================================

// SHOW ORDER ITEMS

db.orders.aggregate([
{
$unwind: "$items"
},
{
$project: {
order_id: 1,
product_name: "$items.product_name",
quantity: "$items.quantity",
subtotal: "$items.subtotal"
}
}
])

// =========================================
// LOOKUP (JOIN)
// =========================================

db.orders.aggregate([
{
$lookup: {
from: "customers",
localField: "customer_id",
foreignField: "customer_id",
as: "customer_details"
}
}
])

// =========================================
// INDEXES
// =========================================

db.customers.createIndex({
email: 1
})

db.products.createIndex({
product_name: 1
})

// =========================================
// TEXT SEARCH
// =========================================

db.products.createIndex({
product_name: "text"
})

db.products.find({
$text: {
$search: "Laptop"
}
})

// =========================================
// REGEX SEARCH
// =========================================

db.customers.find({
customer_name: /Raj/i
})

// =========================================
// COUNT DOCUMENTS
// =========================================

db.customers.countDocuments()

db.orders.countDocuments()

// =========================================
// DISTINCT VALUES
// =========================================

db.customers.distinct("country")

// =========================================
// EMBEDDED DOCUMENT QUERY
// =========================================

db.orders.find({
"payment.payment_method": "UPI"
})

// =========================================
// ARRAY QUERY
// =========================================

db.orders.find({
"items.product_name": "Laptop"
})

// =========================================
// PROJECTION
// =========================================

db.customers.find(
{},
{
customer_name: 1,
country: 1,
_id: 0
}
)
