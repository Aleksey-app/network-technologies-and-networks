USE *****;

SELECT 
    object_name(IXOS.object_id) AS TableName,
    IX.name AS IndexName,
    IX.type_desc AS IndexType,
    IXOS.avg_fragmentation_in_percent AS Fragmentation
FROM 
    sys.dm_db_index_physical_stats (NULL, NULL, NULL, NULL, 'SAMPLED') AS IXOS
JOIN 
    sys.indexes AS IX
    ON IX.object_id = IXOS.object_id
    AND IX.index_id = IXOS.index_id
WHERE 
    IXOS.avg_fragmentation_in_percent > 10 -- Порог фрагментации, выше которого можно подумать о реиндексации
ORDER BY 
    IXOS.avg_fragmentation_in_percent DESC;
