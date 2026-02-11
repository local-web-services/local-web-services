# Session Context

**Session ID:** b29a3983-d0af-449c-9a5a-884983143c3b

**Commit Message:** Implement the following plan:

# Plan: Deduplicate New Provider Code

##

## Prompt

Implement the following plan:

# Plan: Deduplicate New Provider Code

## Context

The 9 new providers (DocDB, ElastiCache, Elasticsearch, Glacier, MemoryDB, Neptune, OpenSearch, RDS, S3 Tables) are implemented but have significant code duplication (444 duplicate lines). The CPD check (`make check`) requires `duplicates=0`. Several groups of providers are nearly identical — they need shared abstractions.

## Duplication Groups

| Group | Services | Duplicate Lines | Root Cause |
|-------|----------|----------------|------------|
| Search services | Elasticsearch, OpenSearch | ~120 lines | Nearly identical: domain CRUD, tags, format, response helpers |
| Cluster DB services | DocDB, Neptune | ~127 lines | Nearly identical: cluster/instance CRUD, tags, format, response helpers |
| Response helpers | All 9 new + existing providers | ~76 lines | `_json_response`, `_error_response`, `_iso_now` copy-pasted everywhere |
| CLI commands | docdb, neptune, rds, es, opensearch | ~121 lines | describe/delete/list commands identical except service name and target prefix |
| Docker cleanup | `_shared/docker_service.py`, `lambda_runtime/docker.py` | 7 lines | Container stop+remove pattern |

## Approach

### 1. Create shared response helpers module

**File:** `src/lws/providers/_shared/response_helpers.py`

```python
def json_response(data: dict, status_code: int = 200) -> Response
def error_response(code: str, message: str, *, status_code: int = 400, message_key: str = "Message") -> Response
def iso_now() -> str
```

**Update these provider routes to import from shared module (removing their local copies):**
- `glacier/routes.py` (uses `message_key="message"`)
- `rds/routes.py`
- `elasticache/routes.py` (uses `message_key="message"`)
- `memorydb/routes.py` (uses `message_key="message"`)

Skip docdb, neptune, elasticsearch, opensearch — those will be replaced by shared factory modules in steps 2-3.

### 2. Create shared search service factory

**File:** `src/lws/providers/_shared/search_service.py`

Extract the entire ES/OpenSearch pattern into a parameterized factory. The two providers differ only in:
- Service name, logger name, ARN service (`es` vs `opensearch`)
- Version field name (`ElasticsearchVersion` vs `EngineVersion`)
- Cluster config field name (`ElasticsearchClusterConfig` vs `ClusterConfig`)
- Action name prefixes (`CreateElasticsearchDomain` vs `CreateDomain`)
- Endpoint suffix (`.es.amazonaws.com` vs `.aoss.amazonaws.com`)
- Default version, default instance type
- ListDomainNames response shape (OpenSearch adds `EngineType`)

The factory accepts a config dataclass:
```python
@dataclass
class SearchServiceConfig:
    service_name: str           # "elasticsearch" or "opensearch"
    logger_name: str            # "ldk.elasticsearch" or "ldk.opensearch"
    arn_service: str            # "es" or "opensearch"
    endpoint_suffix: str        # ".es.amazonaws.com" or ".aoss.amazonaws.com"
    default_version: str        # "7.10" or "OpenSearch_2.11"
    default_instance_type: str  # "m5.large.elasticsearch" or "m5.large.search"
    version_field: str          # "ElasticsearchVersion" or "EngineVersion"
    cluster_config_field: str   # "ElasticsearchClusterConfig" or "ClusterConfig"
    action_map: dict[str, str]  # maps generic action names to service-specific names
    list_domain_extra: dict     # extra fields in ListDomainNames items (e.g., {"EngineType": "OpenSearch"})

def create_search_service_app(config: SearchServiceConfig) -> FastAPI
```

**Update:**
- `elasticsearch/routes.py` → thin wrapper calling `create_search_service_app(ES_CONFIG)`
- `opensearch/routes.py` → thin wrapper calling `create_search_service_app(OPENSEARCH_CONFIG)`

### 3. Create shared cluster DB service factory

**File:** `src/lws/providers/_shared/cluster_db_service.py`

Extract the DocDB/Neptune pattern into a parameterized factory. Differences:
- Service name, logger name
- ARN service (`rds` for both DocDB, `neptune` for Neptune)
- Default engine (`docdb` vs `neptune`)
- Default port (27017 vs 8182)
- Endpoint suffix
- Action handler set (Neptune has no `RemoveTagsFromResource`)

```python
@dataclass
class ClusterDBConfig:
    service_name: str
    logger_name: str
    arn_service: str
    default_engine: str
    default_port: int
    default_instance_class: str
    endpoint_suffix: str
    include_remove_tags: bool = True

def create_cluster_db_app(config: ClusterDBConfig) -> FastAPI
```

**Update:**
- `docdb/routes.py` → thin wrapper calling `create_cluster_db_app(DOCDB_CONFIG)`
- `neptune/routes.py` → thin wrapper calling `create_cluster_db_app(NEPTUNE_CONFIG)`

### 4. Create shared CLI command helpers

**File:** `src/lws/cli/services/_shared_commands.py`

Extract the common async helper patterns:

```python
async def describe_db_clusters_cmd(service: str, target_prefix: str, db_cluster_identifier: str | None, port: int) -> None
async def delete_db_cluster_cmd(service: str, target_prefix: str, db_cluster_identifier: str, port: int) -> None
async def describe_domain_cmd(service: str, target_prefix: str, action: str, domain_name: str, port: int) -> None
async def delete_domain_cmd(service: str, target_prefix: str, action: str, domain_name: str, port: int) -> None
async def list_domain_names_cmd(service: str, target_prefix: str, port: int) -> None
```

**Update these CLI files to call shared helpers:**
- `docdb.py` — use `describe_db_clusters_cmd`, `delete_db_cluster_cmd`
- `neptune.py` — use `describe_db_clusters_cmd`, `delete_db_cluster_cmd`
- `rds.py` — use `describe_db_clusters_cmd`, `delete_db_cluster_cmd` (RDS has additional commands that stay unique)
- `es.py` — use `describe_domain_cmd`, `delete_domain_cmd`, `list_domain_names_cmd`
- `opensearch.py` — use `describe_domain_cmd`, `delete_domain_cmd`, `list_domain_names_cmd`

### 5. Deduplicate Docker container cleanup

**File:** `src/lws/providers/_shared/docker_service.py`

Extract a standalone `destroy_container(container)` function:
```python
def destroy_container(container) -> None:
    """Stop and remove a Docker container safely."""
    try:
        container.stop(timeout=5)
    except Exception:
        pass
    try:
        container.remove(force=True)
    except Exception:
        pass
```

Update `lambda_runtime/docker.py` to call `destroy_container()` in `_destroy_container()`.

## Files Modified

| File | Change |
|------|--------|
| `src/lws/providers/_shared/response_helpers.py` | **NEW** — shared `json_response`, `error_response`, `iso_now` |
| `src/lws/providers/_shared/search_service.py` | **NEW** — search service factory for ES/OpenSearch |
| `src/lws/providers/_shared/cluster_db_service.py` | **NEW** — cluster DB factory for DocDB/Neptune |
| `src/lws/cli/services/_shared_commands.py` | **NEW** — shared CLI command helpers |
| `src/lws/providers/elasticsearch/routes.py` | Thin wrapper using search_service factory |
| `src/lws/providers/opensearch/routes.py` | Thin wrapper using search_service factory |
| `src/lws/providers/docdb/routes.py` | Thin wrapper using cluster_db factory |
| `src/lws/providers/neptune/routes.py` | Thin wrapper using cluster_db factory |
| `src/lws/providers/glacier/routes.py` | Import from response_helpers |
| `src/lws/providers/rds/routes.py` | Import from response_helpers |
| `src/lws/providers/elasticache/routes.py` | Import from response_helpers |
| `src/lws/providers/memorydb/routes.py` | Import from response_helpers |
| `src/lws/providers/_shared/docker_service.py` | Add `destroy_container()` function |
| `src/lws/providers/lambda_runtime/docker.py` | Use shared `destroy_container()` |
| `src/lws/cli/services/docdb.py` | Use shared CLI helpers |
| `src/lws/cli/services/neptune.py` | Use shared CLI helpers |
| `src/lws/cli/services/rds.py` | Use shared CLI helpers |
| `src/lws/cli/services/es.py` | Use shared CLI helpers |
| `src/lws/cli/services/opensearch.py` | Use shared CLI helpers |

## Verification

```bash
# After each step, run:
uv run pytest tests/unit/providers/ tests/integration/ -v --no-header -q

# Final full check:
make check
```

All existing tests should continue to pass unchanged — the public API (`create_*_app()` functions) stays the same, just backed by shared code now.


If you need specific details from before exiting plan mode (like exact code snippets, error messages, or content you generated), read the full transcript at: /Users/eamonnfaherty/.REDACTED.jsonl

## Summary

All done. Here's a summary of what was implemented:

## Summary

### Deduplication Results: 444 → 0 duplicate lines

### New shared modules created:
1. **`src/lws/providers/_shared/response_helpers.py`** — `json_response()`, `error_response()`, `iso_now()` with configurable `message_key`
2. **`src/lws/providers/_shared/search_service.py`** — `SearchServiceConfig` dataclass + `create_search_service_app()` factory for Elasticsearch/OpenSearch
3. **`src/lws/providers/_shared/cluster_db_service.py`** — `ClusterDBConfig` dataclass + `create_cluster_db_app()` factory for DocDB/Neptune
4. **`src/lws/cli/services/_shared_commands.py`** — Shared CLI helpers: `create_db_cluster_cmd`, `describe_db_clusters_cmd`, `delete_db_cluster_cmd`, `describe_domain_cmd`, `delete_domain_cmd`, `list_domain_names_cmd`

### Files updated:
- **elasticsearch/routes.py** & **opensearch/routes.py** — replaced with thin wrappers (36-38 lines each, down from ~290)
- **docdb/routes.py** & **neptune/routes.py** — replaced with thin wrappers (29-30 lines each, down from ~300+)
- **glacier/routes.py**, **rds/routes.py**, **elasticache/routes.py**, **memorydb/routes.py** — import from `response_helpers` instead of local copies
- **5 CLI files** (docdb, neptune, rds, es, opensearch) — use shared command helpers
- **docker_service.py** — extracted `destroy_container()` 
- **lambda_runtime/docker.py** — uses shared `destroy_container()`

### Verification:
- **1502 tests pass** (4 pre-existing Docker socket failures unrelated to changes)
- **`duplicates=0`** in CPD check
- **ruff + black** pass cleanly
- 2 pre-existing pylint warnings remain (not introduced by this change)

## Key Actions

- - **TaskCreate**: Create src/lws/providers/_shared/response_helpers.py with json_response, error_response, iso_now. Update glacier, rds, elasticache, memorydb routes to use it.
- - **TaskCreate**: Create src/lws/providers/_shared/search_service.py with SearchServiceConfig dataclass and create_search_service_app factory. Replace elasticsearch/routes.py and opensearch/routes.py with thin wrappers.
- - **TaskCreate**: Create src/lws/providers/_shared/cluster_db_service.py with ClusterDBConfig dataclass and create_cluster_db_app factory. Replace docdb/routes.py and neptune/routes.py with thin wrappers.
- - **TaskCreate**: Create src/lws/cli/services/_shared_commands.py with shared async helpers. Update docdb, neptune, rds, es, opensearch CLI files to use them.
- - **TaskCreate**: Add destroy_container() to docker_service.py, update lambda_runtime/docker.py to use it.
- - **TaskCreate**: Run all unit tests, integration tests, and make check to verify deduplication is complete and all tests pass.
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/glacier/routes.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/rds/routes.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/elasticache/routes.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/memorydb/routes.py
