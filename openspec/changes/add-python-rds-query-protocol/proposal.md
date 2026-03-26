# Change: Add Python RDS query protocol — implement boto3 Data API for cluster_db_service

## Why

~245 e2e step definitions are skipped with "lws cluster_db_service does not implement boto3 RDS query protocol". The `cluster_db_service` abstraction covers Neptune, MemoryDB, RDS, DocumentDB, Elasticsearch, and OpenSearch — but while CRUD lifecycle operations (create cluster, describe, delete) work, none of the data-plane query operations are implemented. This means tests that write data, execute queries, or verify data existence cannot run. This is the second largest skip category.

## What Changes

- **RDS Data API**: Implement `execute_statement`, `batch_execute_statement`, `begin_transaction`, `commit_transaction`, `rollback_transaction` on the RDS provider using an in-memory SQL engine (e.g. SQLite via the existing cluster_db_service abstraction).
- **DocumentDB**: Implement document query operations (find, insert, update, delete) accessible via the cluster_db_service using an in-memory document store.
- **Neptune**: Implement graph query operations (openCypher / Gremlin stubs) returning structured responses compatible with the Neptune boto3 client.
- **ElastiCache (Redis)**: Implement Redis protocol commands (GET, SET, DEL, EXPIRE, LPUSH, LRANGE, HSET, HGET, etc.) via the cluster_db_service.
- **MemoryDB**: Implement the MemoryDB data API (compatible with Redis commands) via the cluster_db_service.
- **Elasticsearch / OpenSearch**: Implement index, search, and delete document operations via the cluster_db_service REST API.

## Impact

- Affected specs: `python-rds-query-protocol` (new), `rds-data-api` (existing — extend)
- Affected code: `lang/python/core/src/lws/providers/_shared/cluster_db_service.py`, `lang/python/core/src/lws/providers/rds/routes.py`, `lang/python/core/src/lws/providers/docdb/routes.py`, `lang/python/core/src/lws/providers/neptune/routes.py`, `lang/python/core/src/lws/providers/elasticache/routes.py`, `lang/python/core/src/lws/providers/memorydb/routes.py`, `lang/python/core/src/lws/providers/elasticsearch/routes.py`, `lang/python/core/src/lws/providers/opensearch/routes.py`
- No external database dependency — all data is in-memory.
- No breaking changes to passing tests.
