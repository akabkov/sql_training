SELECT
    t.tweet_count AS tweet_bucket,
    COUNT(*) AS user_num
FROM
    (
        SELECT
            t.user_id,
            COUNT(*) AS tweet_count
        FROM
            tweets t
        WHERE
            t.tweet_date BETWEEN '2022-01-01' AND '2022-12-31'
        GROUP BY
            t.user_id
    ) t
GROUP BY
    t.tweet_count
ORDER BY
    tweet_bucket;
