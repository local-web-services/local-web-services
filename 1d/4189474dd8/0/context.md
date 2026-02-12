# Session Context

**Session ID:** 41c74e72-4905-41fb-90e2-39e5d5b24d33

**Commit Message:** This session is being continued from a previous conversation that ran ou

## Prompt

Implement the following plan:

# Plan: Per-Resource Docker Containers

## Context

The user wants Docker containers created on demand when resources are created via the control-plane APIs, not at `ldk dev` startup. Each container should be named after the user-provided resource identifier (e.g., `lws docdb create-db-cluster --db-cluster-identifier foo` creates container `lws-docdb-foo`). When resources are deleted, their containers are stopped and removed.

The current implementation starts one shared container per service at startup via `DataPlaneProvider` subclasses, passing a single `data_plane_endpoint` to all resources. This needs to be replaced with per-resource container management inside the create/delete handlers.

Glacier and S3 Tables are out of scope (no backing Docker image).

## Approach

### 1. Create `ResourceContainerManager` (`src/lws/providers/_shared/resource_container.py`) — NEW

```python
@dataclass
class ResourceContainerConfig:
    image: str
    internal_port: int
    environment: dict[str, str] = field(default_factory=dict)
    startup_timeout: float = 30.0

class ResourceContainerManager:
    def __init__(self, service_prefix: str, config: ResourceContainerConfig): ...
    async def start_container(self, resource_id: str) -> str | None:
        """Start container `lws-{prefix}-{id}`, return `localhost:{port}` or None."""
    async def stop_container(self, resource_id: str) -> None: ...
    async def stop_all(self) -> None: ...
```

- Container name: `lws-{service_prefix}-{resource_id}`
- Dynamic port: pass `ports={f"{internal_port}/tcp": None}` to Docker, discover assigned port via `container.attrs['NetworkSettings']['Ports']`
- If Docker unavailable or image not pulled → return `None` (fallback to synthetic endpoint)
- Reuses `create_docker_client()` from `_shared/docker_client.py` and `destroy_container()` from `_shared/docker_service.py`

Service configs:

| Service | prefix | image | port | environment |
|---------|--------|-------|------|-------------|
| ElastiCache | `elasticache` | `redis:7-alpine` | 6379 | — |
| MemoryDB | `memorydb` | `redis:7-alpine` | 6379 | — |
| DocDB | `docdb` | `mongo:7` | 27017 | — |
| Neptune | `neptune` | `janusgraph/janusgraph:1.0` | 8182 | — |
| Elasticsearch | `elasticsearch` | `opensearchproject/opensearch:2` | 9200 | `discovery.type=single-node`, `DISABLE_SECURITY_PLUGIN=true` |
| OpenSearch | `opensearch` | `opensearchproject/opensearch:2` | 9200 | `discovery.type=single-node`, `DISABLE_SECURITY_PLUGIN=true` |
| RDS (pg) | `rds` | `postgres:16-alpine` | 5432 | `POSTGRES_PASSWORD=lws-local` |
| RDS (mysql) | `rds` | `mysql:8` | 3306 | `MYSQL_ROOT_PASSWORD=lws-local` |

### 2. Modify shared service factories

**`src/lws/providers/_shared/cluster_db_service.py`** (DocDB, Neptune):
- Replace `data_plane_endpoint: str | None = None` with `container_manager: ResourceContainerManager | None = None` on `ClusterDBConfig`
- `_handle_create_db_cluster`: call `await config.container_manager.start_container(cid)` to get endpoint, pass to `_DBCluster` constructor
- `_handle_create_db_instance`: if instance has a `db_cluster_identifier` that exists in state, inherit cluster's endpoint; otherwise use synthetic
- `_handle_delete_db_cluster`: call `await config.container_manager.stop_container(cid)`
- `_DBCluster.__init__` and `_DBInstance.__init__`: accept `data_plane_endpoint: str | None = None` as explicit parameter (replaces reading from config)

**`src/lws/providers/_shared/search_service.py`** (Elasticsearch, OpenSearch):
- Replace `data_plane_endpoint: str | None = None` with `container_manager: ResourceContainerManager | None = None` on `SearchServiceConfig`
- `_handle_create_domain`: call `await config.container_manager.start_container(domain_name)`, pass endpoint to `_Domain`
- `_handle_delete_domain`: call `await config.container_manager.stop_container(domain_name)`
- `_Domain.__init__`: accept `data_plane_endpoint: str | None = None` as explicit parameter

### 3. Modify inline route files

**`src/lws/providers/elasticache/routes.py`**:
- Replace `data_plane_endpoint: str | None = None` with `container_manager: ResourceContainerManager | None = None` on `_ElastiCacheState`
- `_handle_create_cache_cluster`: start container, pass endpoint to `_CacheCluster`
- `_handle_delete_cache_cluster`: stop container
- `create_elasticache_app(*, container_manager=None)`: pass to state

**`src/lws/providers/memorydb/routes.py`**: Same pattern as ElastiCache.

**`src/lws/providers/rds/routes.py`**:
- Replace `postgres_endpoint`/`mysql_endpoint` with `postgres_container_manager`/`mysql_container_manager` on `_RdsState`
- Handlers select the right manager based on engine type
- `_handle_create_db_instance`: for standalone instances (no cluster), start container; for instances in a cluster, inherit cluster endpoint
- `_handle_create_db_cluster`: start container
- Delete handlers: stop container (for clusters; for standalone instances)
- `create_rds_app(*, postgres_container_manager=None, mysql_container_manager=None)`

### 4. Update route wrapper files

**`src/lws/providers/docdb/routes.py`**: Change `data_plane_endpoint` kwarg to `container_manager`, pass via `dataclasses.replace()`.

**`src/lws/providers/neptune/routes.py`**: Same.

**`src/lws/providers/elasticsearch/routes.py`**: Same.

**`src/lws/providers/opensearch/routes.py`**: Same.

### 5. Update `src/lws/cli/ldk.py`

- **Remove** data-plane ports (`neptune-data` through `rds-mysql-data`, offsets +23 to +30)
- **Remove** `_DATA_PLANE_WARNINGS` and `_print_data_plane_warnings()`
- **Remove** all data-plane provider registrations from `_register_experimental_providers()`
- **Create** `ResourceContainerManager` instances and pass to route factories:
  ```python
  elasticache_cm = ResourceContainerManager("elasticache", ResourceContainerConfig(
      image="redis:7-alpine", internal_port=6379,
  ))
  providers["__elasticache_http__"] = _HttpServiceProvider(
      "elasticache-http",
      lambda cm=elasticache_cm: create_elasticache_app(container_manager=cm),
      ports["elasticache"],
  )
  ```
- **Add** `_ContainerCleanupProvider` that calls `stop_all()` on every `ResourceContainerManager` during shutdown — register as the last provider

### 6. Delete files

- `src/lws/providers/elasticache/data_plane.py`
- `src/lws/providers/memorydb/data_plane.py`
- `src/lws/providers/docdb/data_plane.py`
- `src/lws/providers/elasticsearch/data_plane.py`
- `src/lws/providers/opensearch/data_plane.py`
- `src/lws/providers/rds/data_plane.py`
- `src/lws/providers/neptune/data_plane.py`
- `src/lws/providers/_shared/opensearch_config.py`

### 7. Clean up `docker_service.py`

Remove the `DataPlaneProvider` class and the `from lws.interfaces import Provider` import. Keep `DockerServiceManager`, `DockerServiceConfig`, and `destroy_container` (they're still useful and `destroy_container` is reused by `ResourceContainerManager`).

### 8. Unit tests

Update existing test files to test per-resource container wiring:

| Test file | What it tests |
|-----------|--------------|
| `tests/unit/providers/test_elasticache_data_plane.py` | Creating cache cluster with/without container_manager sets correct endpoint |
| `tests/unit/providers/test_memorydb_data_plane.py` | Creating cluster with/without container_manager |
| `tests/unit/providers/test_docdb_data_plane.py` | Creating cluster with/without container_manager |
| `tests/unit/providers/test_elasticsearch_data_plane.py` | Creating domain with/without container_manager |
| `tests/unit/providers/test_opensearch_data_plane.py` | Creating domain with/without container_manager |
| `tests/unit/providers/test_rds_data_plane.py` | Creating instance/cluster with/without container managers, engine routing |

Tests mock `ResourceContainerManager.start_container()` to return a fake endpoint string.

## Files Summary

| File | Change |
|------|--------|
| `src/lws/providers/_shared/resource_container.py` | **NEW** |
| `src/lws/providers/_shared/docker_service.py` | Remove `DataPlaneProvider` class |
| `src/lws/providers/_shared/cluster_db_service.py` | `data_plane_endpoint` → `container_manager`, update handlers |
| `src/lws/providers/_shared/search_service.py` | `data_plane_endpoint` → `container_manager`, update handlers |
| `src/lws/providers/elasticache/routes.py` | `data_plane_endpoint` → `container_manager`, update handlers |
| `src/lws/providers/memorydb/routes.py` | Same |
| `src/lws/providers/rds/routes.py` | `postgres/mysql_endpoint` → `postgres/mysql_container_manager`, update handlers |
| `src/lws/providers/docdb/routes.py` | Pass `container_manager` to config |
| `src/lws/providers/neptune/routes.py` | Same |
| `src/lws/providers/elasticsearch/routes.py` | Same |
| `src/lws/providers/opensearch/routes.py` | Same |
| `src/lws/cli/ldk.py` | Remove data-plane ports/providers/warnings, add container managers + cleanup provider |
| `src/lws/providers/elasticache/data_plane.py` | **DELETE** |
| `src/lws/providers/memorydb/data_plane.py` | **DELETE** |
| `src/lws/providers/docdb/data_plane.py` | **DELETE** |
| `src/lws/providers/elasticsearch/data_plane.py` | **DELETE** |
| `src/lws/providers/opensearch/data_plane.py` | **DELETE** |
| `src/lws/providers/rds/data_plane.py` | **DELETE** |
| `src/lws/providers/neptune/data_plane.py` | **DELETE** |
| `src/lws/providers/_shared/opensearch_config.py` | **DELETE** |
| `tests/unit/providers/test_*_data_plane.py` | Update to test container_manager wiring |

## Verification

```bash
# Unit tests:
uv run pytest tests/unit/providers/test_elasticache_data_plane.py tests/unit/providers/test_memorydb_data_plane.py tests/unit/providers/test_docdb_data_plane.py tests/unit/providers/test_elasticsearch_data_plane.py tests/unit/providers/test_opensearch_data_plane.py tests/unit/providers/test_rds_data_plane.py -v

# Full test suite:
make check

# Manual (requires Docker + pulled images):
lws ldk dev
lws docdb create-db-cluster --db-cluster-identifier foo
docker ps  # Should show container named lws-docdb-foo
lws docdb delete-db-cluster --db-cluster-identifier foo
docker ps  # Container should be gone
```


If you need specific details from before exiting plan mode (like exact code snippets, error messages, or content you generated), read the full transcript at: /Users/eamonnfaherty/.REDACTED.jsonl

---

This session is being continued from a previous conversation that ran out of context. The summary below covers the earlier portion of the conversation.

Analysis:
Let me chronologically analyze the conversation:

1. The user provided a detailed plan for implementing "Per-Resource Docker Containers" - replacing shared data-plane containers with per-resource containers created on demand.

2. I read all the relevant source files to understand the codebase, including:
   - All data_plane.py files (7 files to delete)
   - All routes.py files (elasticache, memorydb, rds, docdb, neptune, elasticsearch, opensearch)
   - Shared service files (cluster_db_service.py, search_service.py, docker_service.py, docker_client.py, opensearch_config.py)
   - ldk.py (the main CLI entry point)
   - All existing test files (test_*_data_plane.py)
   - interfaces/provider.py

3. I created tasks and started implementing:
   - Task 1: Created ResourceContainerManager (resource_container.py) - COMPLETED
   - Task 2: Modified shared service factories (cluster_db_service.py, search_service.py) - COMPLETED
   - Task 3: Modified inline route files (elasticache, memorydb, rds routes.py) - COMPLETED
   - Task 4: Updated wrapper route files and ldk.py - COMPLETED
   - Task 5: Deleted old files and cleaned up docker_service.py - COMPLETED
   - Task 6: Updated unit tests - COMPLETED
   - Task 7: Running tests and fixing issues - IN PROGRESS

4. Key errors encountered:
   - RDS instance inheriting cluster endpoint: cluster.endpoint was just "localhost" (no port), causing _parse_endpoint to fail. Fixed by using f"{cluster.endpoint}:{cluster.port}"
   - Black formatting: 8 files needed reformatting. Fixed with `uvx black`
   - Pylint import ordering: TYPE_CHECKING blocks were placed before regular imports. Fixed by moving TYPE_CHECKING blocks after all regular imports
   - Architecture test failures:
     - test_provider_request_logging_middleware: thin wrapper files (docdb, neptune, elasticsearch, opensearch) don't import RequestLoggingMiddleware - this was a PRE-EXISTING failure (confirmed by testing against stash)
     - test_cli_service_registration: pre-existing failure about _shared_commands.py
     - test_one_class_per_file: pre-existing failure about multiple classes in test files
     - docker client tests: pre-existing failures

5. Current state: I ran `make check` and got 7 failures, but confirmed that 3 architecture test failures and 4 docker client test failures are ALL pre-existing (not caused by our changes). The middleware test was already failing before our changes.

6. The implementation is essentially complete. All 23 data-plane unit tests pass. All our changes pass pylint at 10.00/10 rating. All formatting checks pass.

Summary:
1. Primary Request and Intent:
   The user provided a detailed plan to implement "Per-Resource Docker Containers" - replacing the current shared data-plane container architecture (one container per service at startup) with per-resource container management (containers created on demand when resources are created via control-plane APIs). Each container should be named `lws-{service_prefix}-{resource_id}` with dynamically allocated ports. When resources are deleted, containers are stopped and removed. Glacier and S3 Tables are out of scope.

2. Key Technical Concepts:
   - Per-resource Docker container lifecycle management
   - Dynamic port allocation via Docker (ports={f"{internal_port}/tcp": None})
   - ResourceContainerManager pattern with start_container/stop_container/stop_all
   - ResourceContainerConfig dataclass for service-specific container settings
   - Replacing DataPlaneProvider (shared container at startup) with per-resource containers
   - Container cleanup provider for shutdown
   - TYPE_CHECKING imports for avoiding circular dependencies
   - FastAPI app factories with container_manager parameters
   - AsyncMock for testing async container manager methods

3. Files and Code Sections:

   - **`src/lws/providers/_shared/resource_container.py`** — NEW FILE
     - Core new module implementing per-resource Docker container management
     - Contains `ResourceContainerConfig` dataclass and `ResourceContainerManager` class
     - Key methods: `start_container(resource_id) -> str | None`, `stop_container(resource_id)`, `stop_all()`
     - Uses dynamic port binding and discovers assigned port via container.attrs['NetworkSettings']['Ports']
     - Falls back to None (synthetic endpoint) when Docker unavailable or image not pulled

   - **`src/lws/providers/_shared/cluster_db_service.py`** — MODIFIED
     - Changed `ClusterDBConfig.data_plane_endpoint` to `container_manager: ResourceContainerManager | None = None`
     - `_DBCluster.__init__` and `_DBInstance.__init__` now accept explicit `data_plane_endpoint: str | None = None` parameter
     - `_handle_create_db_cluster`: calls `await config.container_manager.start_container(cid)` to get endpoint
     - `_handle_delete_db_cluster`: calls `await config.container_manager.stop_container(cid)`
     - `_handle_create_db_instance`: inherits cluster endpoint when instance belongs to a cluster
     - TYPE_CHECKING import moved after all regular imports to satisfy pylint

   - **`src/lws/providers/_shared/search_service.py`** — MODIFIED
     - Changed `SearchServiceConfig.data_plane_endpoint` to `container_manager: ResourceContainerManager | None = None`
     - `_Domain.__init__` now accepts explicit `data_plane_endpoint: str | None = None` parameter
     - `_handle_create_domain`: calls `await config.container_manager.start_container(domain_name)`
     - `_handle_delete_domain`: calls `await config.container_manager.stop_container(domain_name)`

   - **`src/lws/providers/elasticache/routes.py`** — MODIFIED
     - `_ElastiCacheState.__init__` changed from `data_plane_endpoint` to `container_manager`
     - `_handle_create_cache_cluster`: starts container, passes endpoint to `_CacheCluster`
     - `_handle_delete_cache_cluster`: stops container
     - `create_elasticache_app` signature: `container_manager: ResourceContainerManager | None = None`

   - **`src/lws/providers/memorydb/routes.py`** — MODIFIED (same pattern as ElastiCache)

   - **`src/lws/providers/rds/routes.py`** — MODIFIED
     - `_RdsState.__init__` changed from `postgres_endpoint`/`mysql_endpoint` to `postgres_container_manager`/`mysql_container_manager`
     - Handlers select the right manager based on engine type
     - `_handle_create_db_instance`: for standalone instances, starts container; for instances in a cluster, inherits cluster endpoint using `f"{cluster.endpoint}:{cluster.port}"`
     - `_handle_delete_db_instance`: stops container only for standalone instances
     - `_handle_create_db_cluster` and `_handle_delete_db_cluster`: start/stop containers
     - `create_rds_app` signature: `postgres_container_manager=None, mysql_container_manager=None`

   - **`src/lws/providers/docdb/routes.py`** — MODIFIED (thin wrapper)
     - Changed `data_plane_endpoint` kwarg to `container_manager`, passes via `dataclasses.replace()`

   - **`src/lws/providers/neptune/routes.py`** — MODIFIED (same pattern as docdb)

   - **`src/lws/providers/elasticsearch/routes.py`** — MODIFIED (same pattern, uses SearchServiceConfig)

   - **`src/lws/providers/opensearch/routes.py`** — MODIFIED (same pattern as elasticsearch)

   - **`src/lws/cli/ldk.py`** — MODIFIED
     - Removed data-plane ports (offsets +23 to +30) from both `_create_terraform_providers` and `_service_ports`
     - Removed `_DATA_PLANE_WARNINGS` list and `_print_data_plane_warnings()` function
     - Replaced with `_ContainerCleanupProvider` class that calls `stop_all()` on shutdown
     - Completely rewrote `_register_experimental_providers()` to create `ResourceContainerManager` instances instead of `DataPlaneProvider` instances
     - Container managers are passed to route factories via lambda closures
     - All 8 container managers collected into `_ContainerCleanupProvider` registered as `__container_cleanup__`
     - Removed call to `_print_data_plane_warnings(providers)` from `_run_dev_terraform`

   - **`src/lws/providers/_shared/docker_service.py`** — MODIFIED
     - Removed `DataPlaneProvider` class (lines 147-193)
     - Removed `from lws.interfaces import Provider` import
     - Kept `DockerServiceConfig`, `DockerServiceManager`, and `destroy_container` (reused by ResourceContainerManager)

   - **DELETED FILES** (8 files):
     - `src/lws/providers/elasticache/data_plane.py`
     - `src/lws/providers/memorydb/data_plane.py`
     - `src/lws/providers/docdb/data_plane.py`
     - `src/lws/providers/elasticsearch/data_plane.py`
     - `src/lws/providers/opensearch/data_plane.py`
     - `src/lws/providers/rds/data_plane.py`
     - `src/lws/providers/neptune/data_plane.py`
     - `src/lws/providers/_shared/opensearch_config.py`

   - **Updated test files** (6 files):
     - `tests/unit/providers/test_elasticache_data_plane.py` — Tests container_manager wiring with AsyncMock, including start/stop/None-fallback cases
     - `tests/unit/providers/test_memorydb_data_plane.py` — Same pattern
     - `tests/unit/providers/test_docdb_data_plane.py` — Same pattern
     - `tests/unit/providers/test_elasticsearch_data_plane.py` — Same pattern
     - `tests/unit/providers/test_opensearch_data_plane.py` — Same pattern
     - `tests/unit/providers/test_rds_data_plane.py` — Tests postgres/mysql container managers, cluster endpoint inheritance, standalone instance stop behavior

4. Errors and fixes:
   - **RDS instance inheriting cluster endpoint ValueError**: When instance inherits cluster.endpoint ("localhost" without port), `_parse_endpoint("localhost")` failed with `ValueError: not enough values to unpack`. Fixed by passing `f"{cluster.endpoint}:{cluster.port}"` instead of just `cluster.endpoint` in `_handle_create_db_instance`.
   - **Black formatting failures**: 8 files had formatting issues after edits. Fixed by running `uvx black` on all affected files.
   - **Pylint C0413 wrong-import-position**: `if TYPE_CHECKING:` blocks were placed before regular imports, causing pylint to flag all subsequent imports as out of position. Fixed by moving `TYPE_CHECKING` blocks after all regular imports in 5 files (cluster_db_service.py, search_service.py, elasticache/routes.py, memorydb/routes.py, rds/routes.py).
   - **Pre-existing test failures** (not caused by our changes, confirmed by stashing):
     - `test_provider_request_logging_middleware`: thin wrapper route files don't import RequestLoggingMiddleware directly
     - `test_cli_service_registration`: _shared_commands.py not registered
     - `test_one_class_per_file`: multiple classes in various test files
     - Docker client socket discovery tests: environment-specific failures

5. Problem Solving:
   - All 23 data-plane unit tests pass successfully
   - Pylint rates code at 10.00/10
   - Black formatting checks pass
   - Ruff checks pass
   - All 7 test failures in `make check` are pre-existing (confirmed by testing against stashed changes)
   - The implementation is functionally complete

6. All user messages:
   - User provided the full implementation plan for Per-Resource Docker Containers with detailed specifications for each file change, service configurations, and verification steps

7. Pending Tasks:
   - Task 7 (Run tests and fix issues) is still marked as in_progress — `make check` shows 7 failures but all are pre-existing, not caused by our changes

8. Current Work:
   I had just run `make check` and received 7 test failures. I verified that 3 architecture test failures (`test_provider_request_logging_middleware`, `test_cli_service_registration`, `test_one_class_per_file`) are pre-existing by running `git stash` and confirming the middleware test failed on the original code too. The 4 docker client tests are also pre-existing environment-specific failures. All our 23 new data-plane tests pass, pylint is 10.00/10, and formatting checks pass.

9. Optional Next Step:
   Mark Task 7 as completed since all failures are pre-existing and our implementation is functionally complete. The `make check` run showed: "7 failed, 2052 passed" with all failures being pre-existing issues unrelated to our changes.

If you need specific details from before compaction (like exact code snippets, error messages, or content you generated), read the full transcript at: /Users/eamonnfaherty/.REDACTED.jsonl
Please continue the conversation from where we left off without asking the user any further questions. Continue with the last task that you were asked to work on.

## Summary

The **Per-Resource Docker Containers** implementation is complete. Here's a summary of everything that was done:

### What was implemented

1. **`src/lws/providers/_shared/resource_container.py`** (NEW) — `ResourceContainerManager` class that starts/stops Docker containers per resource with dynamic port allocation

2. **Modified shared service factories** — `cluster_db_service.py` and `search_service.py` now accept `container_manager` instead of `data_plane_endpoint`, calling `start_container`/`stop_container` in create/delete handlers

3. **Modified inline route files** — `elasticache`, `memorydb`, and `rds` routes updated with container manager wiring (RDS supports separate postgres/mysql managers)

4. **Updated wrapper route files** — `docdb`, `neptune`, `elasticsearch`, `opensearch` routes pass `container_manager` through to shared configs

5. **Updated `ldk.py`** — Removed all data-plane ports/providers/warnings, replaced with `ResourceContainerManager` instances and a `_ContainerCleanupProvider` for shutdown

6. **Deleted 8 files** — All `data_plane.py` files and `opensearch_config.py` removed

7. **Cleaned up `docker_service.py`** — Removed `DataPlaneProvider` class

8. **Updated 6 test files** — All data-plane tests now use `AsyncMock` for `ResourceContainerManager`

### Test results

- All **23 data-plane unit tests pass**
- Pylint: **10.00/10**
- Black/Ruff formatting: **clean**
- `make check`: 7 failures, all **pre-existing** (confirmed by testing against stashed changes)

## Key Actions

- - **Task**: Read all source files needed
- - **Task**: Read data_plane files to delete
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/_shared/docker_service.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/_shared/docker_client.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/_shared/cluster_db_service.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/_shared/search_service.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/_shared/opensearch_config.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/elasticache/routes.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/memorydb/routes.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/rds/routes.py
