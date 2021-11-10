-- SQLite
.headers on


--1
SELECT maker 
FROM Product, Printer
WHERE Product.type = 'printer' AND Product.model = Printer.model AND Printer.color = '1' AND Printer.price < 120;

--2
Select maker
FROM Product
WHERE Product.type = 'pc'
AND maker NOT IN (SELECT maker 
    FROM Product 
    WHERE product.type = 'laptop')
AND maker NOT IN (SELECT maker 
    FROM Product 
    WHERE product.type = 'printer');

--3
SELECT maker, PC.model, Laptop.model, MAX(PC.price + Laptop.price) 
FROM Product, PC, Laptop 
WHERE maker IN(SELECT maker
    FROM Product
    WHERE Product.type = 'pc'
    AND Product.model = PC.model)
AND maker IN(SELECT maker
    FROM Product
    WHERE Product.type = 'laptop'
    AND Product.model = Laptop.model);

--4
SELECT model, screen
FROM Laptop
WHERE screen IN(SELECT screen
    FROM Laptop
    GROUP by screen
    HAVING count(screen) > 1)
ORDER by screen;

--5
SELECT Laptop.model, Laptop.price
FROM Laptop, PC
WHERE PC.price = (SELECT MAX(price) FROM PC)
AND Laptop.price > PC.price;

--6
SELECT maker 
FROM Product
WHERE maker IN(SELECT maker
    FROM Product
    WHERE Product.type = 'pc' OR Product.type = 'laptop')
AND maker IN(SELECT maker
    FROM Product  
    WHERE Product.type = 'printer'  
    GROUP by maker
    HAVING count(type) > 1)
GROUP by maker;

