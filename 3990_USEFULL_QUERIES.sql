--nested select--
SELECT room.book_times 
FROM room 
WHERE room.room_number =( 
    SELECT facilities.room_number 
    FROM facilities 
    WHERE facilities.category_name='DIKLINO'
);

SELECT customer.last_name 
FROM customer
WHERE customer.at =(
    SELECT booking.at
    FROM booking
    WHERE booking.bill>=68
);

--join--
SELECT customer.first_name, customer.last_name, booking.room_number
FROM customer
FULL OUTER JOIN booking
ON customer.at = booking.at;

SELECT *
FROM room
INNER JOIN category 
ON category.name = room.category_name;

--group by--
SELECT COUNT(country)
FROM customer
WHERE COUNTRY='ITALY'
GROUP BY country;

SELECT name, sum(roomprice*roomcount)
FROM category
GROUP BY name;

