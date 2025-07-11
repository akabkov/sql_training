SELECT
    t.user_id,
    t.spend,
    t.transaction_date
FROM
    (
        SELECT
            t.*,
            ROW_NUMBER() OVER (
                PARTITION BY
                    t.user_id
                ORDER BY
                    t.transaction_date
            ) AS transaction_num
        FROM
            TRANSACTIONS t
    ) t
WHERE
    t.transaction_num = 3;