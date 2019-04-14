
SELECT SQL_CALC_FOUND_ROWS
  u.ID AS id,
  i.n_sender_id,
  i.n_reciever_id,
  u.display_name AS NAME,
  UNIX_TIMESTAMP(i.n_created_date) AS n_created_date,
  i.n_params AS msg
FROM
  wpjs_notifications AS i
INNER JOIN
  wpjs_users AS u ON u.ID = IF(
    i.n_sender_id = 17,
    i.n_reciever_id,
    i.n_sender_id
  )
WHERE
  n_id IN(
  SELECT
    MAX(n_id) AS id
  FROM
    (
    SELECT
      n_id,
      n_sender_id AS id_with
    FROM
      wpjs_notifications
    WHERE
      n_reciever_id = 17
    UNION ALL
  SELECT
    n_id,
    n_reciever_id AS id_with
  FROM
    wpjs_notifications
  WHERE
    n_sender_id = 17
  ) AS t
GROUP BY
  id_with
)
ORDER BY
  i.n_id DESC
