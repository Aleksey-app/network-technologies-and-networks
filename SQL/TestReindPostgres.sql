DO $$
DECLARE
    index_record RECORD;
    index_stats JSON;
BEGIN
    -- Перебираем все индексы, доступные пользователю
    FOR index_record IN
        SELECT
            schemaname,
            relname AS tablename,
            indexrelname AS indexname
        FROM
            pg_stat_user_indexes
    LOOP
        -- Получаем статистику для каждого индекса
        EXECUTE FORMAT('SELECT * FROM pgstatindex(''%I.%I'')', index_record.schemaname, index_record.indexname)
        INTO index_stats;

        -- Выводим информацию о фрагментации
        RAISE NOTICE 'Schema: %, Table: %, Index: %, Fragmentation: %',
            index_record.schemaname || ', ' || 
            index_record.tablename || ', ' || 
            index_record.indexname || ', ' || 
            COALESCE(index_stats->>'fragmentation', 'N/A');
    END LOOP;
END $$;


