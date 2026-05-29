

DROP FUNCTION IF EXISTS CALCULATE_ROOM_PRICE;
DELIMITER //
CREATE FUNCTION CALCULATE_ROOM_PRICE(check_in DATE,check_out DATE,no_of_rooms INT,h_id INT,r_type VARCHAR(20))
RETURNS FLOAT
BEGIN
    DECLARE total_price  FLOAT;
    DECLARE room_price_per_Day FLOAT;
    DECLARE days INT;
    SET total_price= 0.0;
    SET room_price_per_day= 0.0;
    SET days=0;
    SELECT ABS(DATEDIFF(check_in,check_out)) INTO days;
    IF days=0 THEN
        RETURN -1;
    ELSE
        SELECT ROOM_PRICE INTO room_price_per_day FROM HOTEL_ROOM_DETAILS WHERE HOTEL_ID=h_id AND ROOM_TYPE=r_type;
        SET total_price=room_price_per_day*days*no_of_rooms;
    END IF;
RETURN total_price;
END;
//
DELIMITER ;