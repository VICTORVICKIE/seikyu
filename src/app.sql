SELECT * FROM sqlite_master WHERE TYPE IN ('table', 'trigger', 'index');
/* Shop Table

model Shop {
    id              String    @id @default(autoincrement())
    phone           String    @unique
    name            String
    area            String
    created_at      DateTime
    updated_at      DateTime
}
*/

/*
INSERT INTO Area (name)
VALUES
    ('Madhavaram'),
    ('Moolachatram'),
    ('Shakthivel Nagar'),
    ('Vichoor'),
    ('Vilangadu');
*/

CREATE TABLE Area (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    name       TEXT UNIQUE
);


CREATE TABLE Shop (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    phone      TEXT UNIQUE,
    name       TEXT UNIQUE,
    area_id       INTEGER,
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (area_id) REFERENCES Area (id) ON DELETE CASCADE
);

CREATE TRIGGER on_shop_insert
AFTER INSERT ON Shop
FOR EACH ROW
BEGIN
    UPDATE Shop
    SET created_at = DATETIME('now', 'localtime'), updated_at = DATETIME('now', 'localtime')
    WHERE id = NEW.id;
END;

CREATE TRIGGER on_shop_update
AFTER UPDATE ON Shop
FOR EACH ROW
BEGIN
    UPDATE Shop
    SET updated_at = DATETIME('now', 'localtime')
    WHERE id = NEW.id;
END;

/* Bill Table --

model Bill {
    id         Int      @id @default(autoincrement())
    shop_id    Int      @foreign_key
    amount     Double   
    count      Int
    created_at DateTime

    @@index([shop_id])

}
*/
CREATE TABLE Bill (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    shop_id     INTEGER,
    amount      REAL,
    count       INTEGER,
    bill_date   DATE,
    created_at  DATETIME,
    FOREIGN KEY (shop_id) REFERENCES Shop (id) ON DELETE CASCADE
);

CREATE INDEX bill_shop_id ON Bill (shop_id);

CREATE TRIGGER on_bill_insert
AFTER INSERT ON Bill
FOR EACH ROW
BEGIN
    UPDATE Bill
    SET created_at = DATETIME('now', 'localtime'), bill_date = DATE('now', 'localtime')
    WHERE id = NEW.id;
END;

/* Product Table --

model Product {
    id         Int      @id @default(autoincrement())
    bill_id    Int      @foreign_key
    name       String
    qty        Int
    rate       Double
}
*/
CREATE TABLE Product (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    bill_id     INTEGER,
    name        TEXT,
    qty         INTEGER,
    rate        REAL,
    amount      REAL,
    FOREIGN KEY (bill_id) REFERENCES Bill (id) ON DELETE CASCADE
);

CREATE INDEX product_bill_id ON Product (bill_id);


/* Installment Table

model Installment {
    id         Int      @id @default(autoincrement())
    bill_id    Int      @foreign_key
    amount     Double
    created_at DateTime
}
*/
CREATE TABLE Installment (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    shop_id     INTEGER,
    bill_id     INTEGER,
    amount      REAL,
    created_at  DATETIME,
    FOREIGN KEY (shop_id) REFERENCES Shop (id) ON DELETE CASCADE
    FOREIGN KEY (bill_id) REFERENCES Bill (id) ON DELETE CASCADE
);

CREATE INDEX installment_shop_id ON Installment (shop_id);
CREATE INDEX installment_bill_id ON Installment (bill_id);

CREATE TRIGGER on_installment_insert
AFTER INSERT ON Installment
FOR EACH ROW
BEGIN
    UPDATE Installment
    SET created_at = DATETIME('now', 'localtime')
    WHERE id = NEW.id;
END;



DROP TABLE Shop;DROP TABLE Bill;DROP TABLE Product;DROP TABLE Installment;

DROP TRIGGER on_bill_insert;
DROP TRIGGER on_shop_insert;
DROP TRIGGER on_shop_update;
