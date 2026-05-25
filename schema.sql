-- Açma Tablosu
CREATE TABLE acma (
    id SERIAL PRIMARY KEY,
    acma_adi VARCHAR(50) NOT NULL,
    lokasyon VARCHAR(100),
    baslangic_tarihi DATE,
    sorumlu_arkeolog VARCHAR(100)
);

-- Tabaka Tablosu
CREATE TABLE tabaka (
    id SERIAL PRIMARY KEY,
    acma_id INTEGER REFERENCES acma(id),
    tabaka_no VARCHAR(20) NOT NULL,
    derinlik_cm INTEGER,
    donem VARCHAR(50),
    aciklama TEXT
);

-- Eser Tablosu
CREATE TABLE eser (
    id SERIAL PRIMARY KEY,
    tabaka_id INTEGER REFERENCES tabaka(id),
    eser_tipi VARCHAR(100),
    malzeme VARCHAR(100),
    durum VARCHAR(50),
    muhurlu BOOLEAN DEFAULT FALSE,
    buluntu_tarihi DATE,
    aciklama TEXT
);
