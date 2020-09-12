DROP DATABASE IF EXISTS isuumo;
CREATE DATABASE isuumo;

DROP TABLE IF EXISTS isuumo.estate;
DROP TABLE IF EXISTS isuumo.chair;

CREATE TABLE isuumo.estate
(
    id          INTEGER             NOT NULL PRIMARY KEY,
    name        VARCHAR(64)         NOT NULL,
    description VARCHAR(4096)       NOT NULL,
    thumbnail   VARCHAR(128)        NOT NULL,
    address     VARCHAR(128)        NOT NULL,
    latitude    DOUBLE PRECISION    NOT NULL,
    longitude   DOUBLE PRECISION    NOT NULL,
    latlon      POINT GENERATED ALWAYS AS (ST_GeomFromText(concat('POINT(', latitude, ' ', longitude, ')'))) VIRTUAL,
    rent        INTEGER             NOT NULL,
    door_height INTEGER             NOT NULL,
    door_width  INTEGER             NOT NULL,
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL,
    KEY idx_1(door_height, door_width),
    KEY idx_2(latitude),
    KEY idx_3(rent),
    KEY idx_4(popularity)
);

CREATE TABLE isuumo.chair
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    name        VARCHAR(64)     NOT NULL,
    description VARCHAR(4096)   NOT NULL,
    thumbnail   VARCHAR(128)    NOT NULL,
    price       INTEGER         NOT NULL,
    height      INTEGER         NOT NULL,
    width       INTEGER         NOT NULL,
    depth       INTEGER         NOT NULL,
    color       VARCHAR(64)     NOT NULL,
    features    VARCHAR(64)     NOT NULL,
    kind        VARCHAR(64)     NOT NULL,
    popularity  INTEGER         NOT NULL,
    stock       INTEGER         NOT NULL,
    KEY idx_1(price, height, width, depth, kind, color),
    KEY idx_2(stock),
    KEY idx_3(price),
    KEY idx_4(popularity)
);

CREATE TABLE isuumo.chair_color
(
    chair_id          INTEGER         NOT NULL PRIMARY KEY,
    color_id          INTEGER         NOT NULL PRIMARY KEY
);

CREATE TABLE isuumo.chair_features
(
    chair_id          INTEGER         NOT NULL PRIMARY KEY,
    feature_id        INTEGER         NOT NULL PRIMARY KEY
);

CREATE TABLE isuumo.chair_kinds
(
    chair_id          INTEGER         NOT NULL PRIMARY KEY,
    kind_id           INTEGER         NOT NULL PRIMARY KEY
);

CREATE TABLE isuumo.estate_features
(
    estate_id          INTEGER         NOT NULL PRIMARY KEY,
    feature_id         INTEGER         NOT NULL PRIMARY KEY
);
