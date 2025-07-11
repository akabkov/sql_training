-- u.event_date BETWEEN '2022-07-01' AND '2022-07-31' работает медленнее и включает только '2022-07-31 00:00:00'.
-- Т.е. не учитывает весь последний день, а только его начало. Либо указывать '2022-07-31 23:59:59.999', что неудобно,
-- либо использовать AND u.event_date < '2022-08-01', что и проще и работает быстрее чем BETWEEN.
WITH
    users_active_june AS (
        SELECT DISTINCT
            u.user_id
        FROM
            user_actions u
        WHERE
            u.event_type IN ('sign-in', 'like', 'comment')
            AND u.event_date >= '2022-06-01'
            AND u.event_date < '2022-07-01'
    ),
    users_active_july AS (
        SELECT DISTINCT
            u.user_id
        FROM
            user_actions u
        WHERE
            u.event_type IN ('sign-in', 'like', 'comment')
            AND u.event_date >= '2022-07-01'
            AND u.event_date < '2022-08-01'
    )
SELECT
    7 AS MONTH,
    COUNT(*) AS monthly_active_users
FROM
    users_active_june n
    INNER JOIN users_active_july l ON n.user_id = l.user_id;