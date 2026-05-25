-- Açma Verileri
INSERT INTO acma (acma_adi, lokasyon, baslangic_tarihi, sorumlu_arkeolog) VALUES
('Açma-1', 'Kuzey Sektör', '2021-06-01', 'Dr. Ayşe Kaya'),
('Açma-2', 'Güney Sektör', '2021-06-15', 'Dr. Mehmet Demir'),
('Açma-3', 'Doğu Sektör', '2022-05-10', 'Dr. Ayşe Kaya'),
('Açma-4', 'Batı Sektör', '2022-07-01', 'Dr. Fatma Çelik');

-- Tabaka Verileri
INSERT INTO tabaka (acma_id, tabaka_no, derinlik_cm, donem, aciklama) VALUES
(1, 'I', 30, 'Osmanlı', 'Yüzey tabakası'),
(1, 'II', 80, 'Bizans', 'Yapı kalıntıları'),
(1, 'III', 150, 'Roma', 'Mozaik parçaları'),
(2, 'I', 25, 'Osmanlı', 'Yüzey tabakası'),
(2, 'II', 70, 'Bizans', 'Seramik yoğunluğu'),
(2, 'III', 140, 'Helenistik', 'Sikke buluntuları'),
(3, 'I', 20, 'Osmanlı', 'Yüzey tabakası'),
(3, 'II', 60, 'Bizans', 'Duvar izleri'),
(3, 'III', 120, 'Roma', 'Mozaik parçaları'),
(3, 'IV', 180, 'Helenistik', 'Yoğun keramik tabakası'),
(3, 'V', 240, 'Demir Çağı', 'Ana kaya üzeri'),
(4, 'I', 35, 'Osmanlı', 'Yüzey tabakası'),
(4, 'II', 90, 'Bizans', 'Pişmiş toprak buluntular'),
(4, 'III', 160, 'Roma', 'Amphora parçaları');

-- Eser Verileri
INSERT INTO eser (tabaka_id, eser_tipi, malzeme, durum, muhurlu, buluntu_tarihi, aciklama) VALUES
-- Açma-1 eserleri
(1, 'Keramik', 'Pişmiş Toprak', 'Kırık', FALSE, '2021-06-05', 'Osmanlı dönemi sofra keramiği'),
(2, 'Sikke', 'Bronz', 'İyi', FALSE, '2021-06-20', 'Bizans dönemi bronz sikkesi'),
(3, 'Heykelcik', 'Mermer', 'Parçalı', FALSE, '2021-07-10', 'Roma dönemi mermer heykelciği'),
-- Açma-2 eserleri
(4, 'Keramik', 'Pişmiş Toprak', 'Tam', FALSE, '2021-06-18', 'Osmanlı dönemi çömlek'),
(5, 'Keramik', 'Pişmiş Toprak', 'Kırık', FALSE, '2021-07-02', 'Bizans dönemi kap parçası'),
(6, 'Sikke', 'Gümüş', 'İyi', FALSE, '2021-07-15', 'Helenistik dönem gümüş sikkesi'),
-- Açma-3 eserleri (asıl test verimiz)
(7, 'Keramik', 'Pişmiş Toprak', 'Kırık', FALSE, '2022-05-15', 'Osmanlı dönemi kap parçası'),
(8, 'Kandil', 'Pişmiş Toprak', 'Tam', FALSE, '2022-05-28', 'Bizans dönemi kandili'),
(9, 'Keramik', 'Pişmiş Toprak', 'Tam', TRUE, '2022-06-10', 'Roma dönemi mühürlü keramik'),
(10, 'Amphora', 'Pişmiş Toprak', 'Parçalı', FALSE, '2022-06-15', 'Helenistik dönem amphora'),
(10, 'Keramik', 'Pişmiş Toprak', 'Tam', TRUE, '2022-06-18', 'Helenistik mühürlü keramik I'),
(10, 'Keramik', 'Pişmiş Toprak', 'Kırık', TRUE, '2022-06-22', 'Helenistik mühürlü keramik II'),
(10, 'Figürin', 'Pişmiş Toprak', 'Parçalı', FALSE, '2022-06-25', 'Helenistik dönem figürin'),
(11, 'Keramik', 'Pişmiş Toprak', 'Tam', TRUE, '2022-07-01', 'Demir Çağı mühürlü keramik'),
-- Açma-4 eserleri
(12, 'Keramik', 'Pişmiş Toprak', 'Kırık', FALSE, '2022-07-05', 'Osmanlı dönemi parça'),
(13, 'Pişmiş Toprak', 'Kil', 'Parçalı', FALSE, '2022-07-20', 'Bizans dönemi nesne'),
(14, 'Amphora', 'Pişmiş Toprak', 'Kırık', FALSE, '2022-08-01', 'Roma dönemi amphora parçası');
