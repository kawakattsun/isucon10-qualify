DROP DATABASE IF EXISTS isuumo;
CREATE DATABASE isuumo;

DROP TABLE IF EXISTS isuumo.estate;
DROP TABLE IF EXISTS isuumo.chair;
DROP TABLE IF EXISTS isuumo.chair_features;
DROP TABLE IF EXISTS isuumo.estate_features;

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
    rent_id     INTEGER GENERATED ALWAYS AS (
        (case
            when (`rent` < 50000) then 0
            when (`rent` >= 50000 and `rent` < 100000) then 1
            when (`rent` >= 100000 and `rent` < 150000) then 2
            when (`rent` >= 150000) then 3
        end)
    ) VIRTUAL,
    door_height INTEGER             NOT NULL,
    door_height_id     INTEGER GENERATED ALWAYS AS (
        (case
            when (`door_height` < 80) then 0
            when (`door_height` >= 80 and `door_height` < 110) then 1
            when (`door_height` >= 110 and `door_height` < 150) then 2
            when (`door_height` >= 150) then 3
        end)
    ) VIRTUAL,
    door_width  INTEGER             NOT NULL,
    door_width_id     INTEGER GENERATED ALWAYS AS (
        (case
            when (`door_width` < 80) then 0
            when (`door_width` >= 80 and `door_width` < 110) then 1
            when (`door_width` >= 110 and `door_width` < 150) then 2
            when (`door_width` >= 150) then 3
        end)
    ) VIRTUAL,
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL,
    KEY idx_1(door_height, door_width),
    KEY idx_2(latitude),
    KEY idx_3(rent),
    KEY idx_4(popularity)
    -- KEY idx_5(door_height_id),
    -- KEY idx_6(door_width_id),
    -- KEY idx_7(rent_id),
    -- KEY idx_8(latlon)
);

CREATE TABLE isuumo.chair
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    name        VARCHAR(64)     NOT NULL,
    description VARCHAR(4096)   NOT NULL,
    thumbnail   VARCHAR(128)    NOT NULL,
    price       INTEGER         NOT NULL,
    price_id     INTEGER GENERATED ALWAYS AS (
        (case
            when (`price` < 3000) then 0
            when (`price` >= 3000 and `price` < 6000) then 1
            when (`price` >= 6000 and `price` < 9000) then 2
            when (`price` >= 9000 and `price` < 12000) then 3
            when (`price` >= 12000 and `price` < 15000) then 4
            when (`price` >= 15000) then 5
        end)
    ) VIRTUAL,
    height      INTEGER         NOT NULL,
    height_id     INTEGER GENERATED ALWAYS AS (
        (case
            when (`height` < 80) then 0
            when (`height` >= 80 and `height` < 110) then 1
            when (`height` >= 110 and `height` < 150) then 2
            when (`height` >= 150) then 3
        end)
    ) VIRTUAL,
    width       INTEGER         NOT NULL,
    width_id     INTEGER GENERATED ALWAYS AS (
        (case
            when (`width` < 80) then 0
            when (`width` >= 80 and `width` < 110) then 1
            when (`width` >= 110 and `width` < 150) then 2
            when (`width` >= 150) then 3
        end)
    ) VIRTUAL,
    depth       INTEGER         NOT NULL,
    depth_id     INTEGER GENERATED ALWAYS AS (
        (case
            when (`depth` < 80) then 0
            when (`depth` >= 80 and `depth` < 110) then 1
            when (`depth` >= 110 and `depth` < 150) then 2
            when (`depth` >= 150) then 3
        end)
    ) VIRTUAL,
    color       VARCHAR(64)     NOT NULL,
    features    VARCHAR(64)     NOT NULL,
    kind        VARCHAR(64)     NOT NULL,
    popularity  INTEGER         NOT NULL,
    stock       INTEGER         NOT NULL,
    KEY idx_1(price, height, width, depth, kind, color),
    KEY idx_2(stock),
    KEY idx_3(price),
    KEY idx_4(popularity)
    -- KEY idx_5(height_id),
    -- KEY idx_6(width_id),
    -- KEY idx_7(depth_id),
    -- KEY idx_8(price_id)
);

CREATE TABLE isuumo.chair_features
(
    chair_id          INTEGER         NOT NULL,
    feature_id        INTEGER         NOT NULL,
    PRIMARY KEY(chair_id, feature_id)
);

CREATE TABLE isuumo.estate_features
(
    estate_id          INTEGER         NOT NULL,
    feature_id         INTEGER         NOT NULL,
    PRIMARY KEY(estate_id, feature_id)
);
