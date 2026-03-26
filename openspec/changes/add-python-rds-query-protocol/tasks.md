# Tasks: add-python-rds-query-protocol

## 1. cluster_db_service in-memory engine

- [ ] 1.1 Add `execute_sql(cluster_id, sql, parameters)` method to cluster_db_service using SQLite in-memory per cluster
- [ ] 1.2 Add `execute_document_op(cluster_id, collection, operation, query, update)` for document stores
- [ ] 1.3 Add `execute_graph_op(cluster_id, query_language, query)` for graph stores (returns stub responses)
- [ ] 1.4 Add `execute_kv_op(cluster_id, command, args)` for Redis-compatible key-value stores
- [ ] 1.5 Add `execute_search_op(cluster_id, index, operation, body)` for search engines

## 2. RDS Data API

- [ ] 2.1 Implement `execute_statement` route: parse SQL, execute against in-memory SQLite, return records
- [ ] 2.2 Implement `batch_execute_statement`
- [ ] 2.3 Implement `begin_transaction` / `commit_transaction` / `rollback_transaction`
- [ ] 2.4 Unit tests with SQL SELECT, INSERT, UPDATE, DELETE

## 3. DocumentDB data operations

- [ ] 3.1 Implement document insert (maps to `insert_one` / `insert_many` semantics)
- [ ] 3.2 Implement document find / filter query
- [ ] 3.3 Implement document update
- [ ] 3.4 Implement document delete
- [ ] 3.5 Unit tests

## 4. Neptune graph operations

- [ ] 4.1 Implement openCypher query stub (returns plausible empty/node responses)
- [ ] 4.2 Implement Gremlin query stub
- [ ] 4.3 Unit tests

## 5. ElastiCache / MemoryDB Redis protocol

- [ ] 5.1 Implement GET, SET, DEL, EXPIRE via cluster_db_service
- [ ] 5.2 Implement LPUSH, LRANGE, LLEN
- [ ] 5.3 Implement HSET, HGET, HGETALL, HDEL
- [ ] 5.4 Implement SADD, SMEMBERS, SREM
- [ ] 5.5 Expose via the ElastiCache and MemoryDB connection endpoints
- [ ] 5.6 Unit tests

## 6. Elasticsearch / OpenSearch search operations

- [ ] 6.1 Implement `index` document (PUT /{index}/_doc/{id})
- [ ] 6.2 Implement `search` (GET /{index}/_search) with simple match_all and term queries
- [ ] 6.3 Implement `delete` document
- [ ] 6.4 Implement `create_index` / `delete_index`
- [ ] 6.5 Unit tests

## 7. Quality checks

- [ ] 7.1 `make check` passes for `lang/python/core`
- [ ] 7.2 All formerly-skipped RDS query protocol steps now pass
