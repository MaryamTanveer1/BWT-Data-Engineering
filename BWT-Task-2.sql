-- Retrieve RNA structures with length greater than 12 added after 2008
SELECT *
FROM rna
WHERE len > 12 AND timestamp > '2008-12-31'
LIMIT 100;

-- Count active precomputed RNA records with last update before 2022
SELECT count(*)
FROM rnc_rna_precomputed
WHERE is_active = 'true' AND update_date < '2022-01-01';

-- Count total precomputed RNA records for snoRNA and tRNA in certain years
SELECT EXTRACT(YEAR FROM update_date) AS year, COUNT(*) AS total_records
FROM rnc_rna_precomputed
WHERE (rna_type = 'snoRNA' OR rna_type = 'tRNA')
 AND EXTRACT(YEAR FROM update_date) IN (2011, 2014, 2016, 2020)
GROUP BY EXTRACT(YEAR FROM update_date);

-- Get names of databases for RNA with minimum length excluding specific lengths
SELECT display_name
FROM rnc_database
WHERE min_length NOT IN (100, 200, 300, 400, 15);

-- Get 500 records of sequences for active regions and filter by specific criteria
WITH ActiveRegions AS (
 SELECT region_name AS myregions
 FROM rnc_sequence_regions_active
 LIMIT 500
)
SELECT DISTINCT chromosome, exon_count, region_name
FROM rnc_sequence_regions_active
WHERE (region_name LIKE '%east%'
 OR region_name LIKE '%center%'
 OR region_name LIKE '%north%')
 AND region_name IN (SELECT myregions FROM ActiveRegions);
