"""FastAPI app builders for services beyond the original core set."""

from __future__ import annotations

from typing import Any


def build_extended_service_apps(
    providers: dict[str, Any],
    lifecycle_configs: dict[str, Any],
    capacity_configs: dict[str, Any] | None = None,
    dynamodb_tracker_ref: list | None = None,
    tracker_registry: dict | None = None,
    cloudtrail_provider: Any | None = None,
) -> tuple[list[tuple[str, Any]], dict[str, Any]]:
    """Build FastAPI apps for cognito, docdb, neptune, rds, elasticache, memorydb,
    elasticsearch, opensearch, glacier, s3tables, and lambda services.

    Args:
        providers: Provider dict that must contain a ``"cognito-idp"`` entry.
        lifecycle_configs: Lifecycle config dict keyed by service name.
        capacity_configs: Optional capacity config dict keyed by service name.

    Returns:
        Tuple of:
        - List of ``(service_name, FastAPI_app)`` tuples ready for uvicorn.
        - Dict of extra resettable provider wrappers (e.g. ``"lambda"``).
    """
    from lws.providers.cognito.routes import create_cognito_app
    from lws.providers.docdb.routes import create_docdb_app
    from lws.providers.dynamodb.streams import StreamDispatcher
    from lws.providers.elasticache.routes import create_elasticache_app
    from lws.providers.elasticsearch.routes import create_elasticsearch_app
    from lws.providers.glacier.routes import create_glacier_app
    from lws.providers.lambda_runtime._lambda_registry import LambdaRegistry
    from lws.providers.lambda_runtime.event_source_manager import EventSourceManager
    from lws.providers.lambda_runtime.routes import create_lambda_management_app
    from lws.providers.memorydb.routes import create_memorydb_app
    from lws.providers.neptune.routes import create_neptune_app
    from lws.providers.opensearch.routes import create_opensearch_app
    from lws.providers.rds.routes import create_rds_app
    from lws.providers.s3tables.routes import create_s3tables_app

    _cap = capacity_configs or {}
    lambda_registry = LambdaRegistry()

    # Wire DynamoDB stream dispatcher into the DynamoDB provider and the Lambda
    # EventSourceManager so that DynamoDB→Lambda event source mappings work.
    dynamo_provider = providers.get("dynamodb")
    stream_dispatcher = StreamDispatcher()
    if dynamo_provider is not None and dynamo_provider._stream_dispatcher is None:
        dynamo_provider._stream_dispatcher = stream_dispatcher  # pylint: disable=protected-access

    event_source_manager = EventSourceManager(
        queue_providers={},
        stream_dispatchers={},
        compute_providers=lambda_registry.compute,
        shared_stream_dispatcher=stream_dispatcher,
    )

    _lambda_tracker_ref: list = []
    lambda_app = create_lambda_management_app(
        registry=lambda_registry,
        lifecycle=lifecycle_configs["lambda"],
        capacity=_cap.get("lambda"),
        async_capacity=_cap.get("lambda-async"),
        event_source_manager=event_source_manager,
        dynamodb_provider=dynamo_provider,
        dynamodb_tracker_ref=dynamodb_tracker_ref,
        tracker_ref=_lambda_tracker_ref,
    )

    glacier_app, glacier_state = create_glacier_app(
        lifecycle=lifecycle_configs["glacier"],
        capacity=_cap.get("glacier"),
        cloudtrail_provider=cloudtrail_provider,
    )
    s3tables_app, s3tables_state = create_s3tables_app(
        lifecycle=lifecycle_configs["s3tables"],
        registry=tracker_registry,
        cloudtrail_provider=cloudtrail_provider,
    )
    elasticsearch_app, elasticsearch_state = create_elasticsearch_app(
        lifecycle=lifecycle_configs["es"],
        registry=tracker_registry,
        cloudtrail_provider=cloudtrail_provider,
    )
    opensearch_app, opensearch_state = create_opensearch_app(
        lifecycle=lifecycle_configs["opensearch"],
        registry=tracker_registry,
        cloudtrail_provider=cloudtrail_provider,
    )

    docdb_app, docdb_state = create_docdb_app(
        lifecycle=lifecycle_configs["docdb"],
        capacity=_cap.get("docdb"),
        registry=tracker_registry,
        cloudtrail_provider=cloudtrail_provider,
    )
    neptune_app, neptune_state = create_neptune_app(
        lifecycle=lifecycle_configs["neptune"],
        capacity=_cap.get("neptune"),
        registry=tracker_registry,
        cloudtrail_provider=cloudtrail_provider,
    )

    apps = [
        (
            "cognito-idp",
            create_cognito_app(
                providers["cognito-idp"],
                lifecycle=lifecycle_configs["cognito-idp"],
                capacity=_cap.get("cognito-idp"),
                cloudtrail_provider=cloudtrail_provider,
            ),
        ),
        ("docdb", docdb_app),
        ("neptune", neptune_app),
        (
            "rds",
            create_rds_app(
                lifecycle=lifecycle_configs["rds"],
                registry=tracker_registry,
                cloudtrail_provider=cloudtrail_provider,
            ),
        ),
        (
            "elasticache",
            create_elasticache_app(
                lifecycle=lifecycle_configs["elasticache"],
                registry=tracker_registry,
                cloudtrail_provider=cloudtrail_provider,
            ),
        ),
        (
            "memorydb",
            create_memorydb_app(
                lifecycle=lifecycle_configs["memorydb"],
                registry=tracker_registry,
                cloudtrail_provider=cloudtrail_provider,
            ),
        ),
        ("es", elasticsearch_app),
        ("opensearch", opensearch_app),
        ("glacier", glacier_app),
        ("s3tables", s3tables_app),
        ("lambda", lambda_app),
    ]
    return apps, {
        "lambda_registry": lambda_registry,
        "lambda_tracker": _lambda_tracker_ref[0] if _lambda_tracker_ref else None,
        "glacier_state": glacier_state,
        "s3tables_state": s3tables_state,
        "elasticsearch_state": elasticsearch_state,
        "opensearch_state": opensearch_state,
        "docdb_state": docdb_state,
        "neptune_state": neptune_state,
    }
