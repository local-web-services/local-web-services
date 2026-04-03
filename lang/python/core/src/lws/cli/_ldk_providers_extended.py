"""Extended-service provider registration helpers for the LDK dev server.

Contains ``_register_*`` functions for services that are either
pre-seeded from CloudFormation (SSM, Secrets Manager) or experimental
(ElastiCache, MemoryDB, DocumentDB, Neptune, Elasticsearch, OpenSearch,
RDS, Glacier, S3 Tables).
"""

from __future__ import annotations

from typing import TYPE_CHECKING

from lws.interfaces import Provider
from lws.parser.assembly import AppModel
from lws.providers._shared.aws_iam_auth import IamAuthBundle
from lws.providers._shared.aws_lifecycle import TrackerRegistry

if TYPE_CHECKING:
    from lws.providers.cloudtrail.provider import CloudTrailProvider


def _register_ssm_secretsmanager_providers(
    providers: dict,
    *,
    app_model: AppModel,
    chaos_configs: dict,
    aws_fake_configs: dict,
    iam_auth_bundle: IamAuthBundle | None,
    ssm_port: int,
    secretsmanager_port: int,
) -> tuple:
    """Register SSM and Secrets Manager HTTP providers.

    Returns a tuple of ``(ssm_state, secretsmanager_state)`` so callers can
    wire the state objects directly into the StepFunctions service task bridge
    without going through the HTTP layer.
    """
    from lws.cli._ldk_http_registry import (  # pylint: disable=import-outside-toplevel
        _HttpServiceProvider,
    )
    from lws.providers.secretsmanager._secretsmanager_state import (  # pylint: disable=import-outside-toplevel
        _SecretsState,
    )
    from lws.providers.secretsmanager.routes import (  # pylint: disable=import-outside-toplevel
        create_secretsmanager_app,
    )
    from lws.providers.ssm._ssm_state import _SsmState  # pylint: disable=import-outside-toplevel
    from lws.providers.ssm.routes import create_ssm_app  # pylint: disable=import-outside-toplevel

    ssm_params = [
        {"name": p.name, "type": p.type, "value": p.value, "description": p.description}
        for p in app_model.ssm_parameters
    ]
    sm_secrets = [
        {"name": s.name, "description": s.description, "secret_string": s.secret_string}
        for s in app_model.secrets
    ]

    ssm_state = _SsmState()
    sm_state = _SecretsState()

    providers["__ssm_http__"] = _HttpServiceProvider(
        "ssm-http",
        lambda ia=iam_auth_bundle, st=ssm_state: create_ssm_app(
            ssm_params,
            chaos=chaos_configs.get("ssm"),
            aws_fake=aws_fake_configs.get("ssm"),
            iam_auth=ia,
            state=st,
        ),
        ssm_port,
    )
    providers["__secretsmanager_http__"] = _HttpServiceProvider(
        "secretsmanager-http",
        lambda ia=iam_auth_bundle, st=sm_state: create_secretsmanager_app(
            sm_secrets,
            chaos=chaos_configs.get("secretsmanager"),
            aws_fake=aws_fake_configs.get("secretsmanager"),
            iam_auth=ia,
            state=st,
        ),
        secretsmanager_port,
    )
    return ssm_state, sm_state


def _register_organizations_provider(
    providers: dict,
    *,
    chaos_configs: dict,
    aws_fake_configs: dict,
    organizations_port: int,
    organizations_seed: str | None = None,
) -> None:
    """Register the Organizations HTTP provider."""
    from lws.cli._ldk_http_registry import (  # pylint: disable=import-outside-toplevel
        _HttpServiceProvider,
    )
    from lws.providers.organizations.routes import (  # pylint: disable=import-outside-toplevel
        create_organizations_app,
    )
    from lws.seeds._resolver import resolve_seed_path  # pylint: disable=import-outside-toplevel

    config_path = resolve_seed_path(organizations_seed) if organizations_seed else None

    providers["__organizations_http__"] = _HttpServiceProvider(
        "organizations-http",
        lambda c=chaos_configs.get("organizations"), m=aws_fake_configs.get(
            "organizations"
        ), p=config_path: create_organizations_app(chaos=c, aws_fake=m, config_path=p),
        organizations_port,
    )


def _register_cloudtrail_provider(
    providers: dict,
    *,
    cloudtrail_port: int,
    chaos_configs: dict,
    aws_fake_configs: dict,
    iam_auth_bundle: IamAuthBundle | None = None,
    s3_provider: object | None = None,
    eb_provider: object | None = None,
) -> CloudTrailProvider:
    """Register the CloudTrail HTTP provider and return the provider instance.

    Wires S3 and EventBridge dependencies if provided so event delivery and
    EventBridge forwarding work without requiring further caller configuration.
    """
    from lws.cli._ldk_http_registry import (  # pylint: disable=import-outside-toplevel
        _HttpServiceProvider,
    )
    from lws.providers.cloudtrail.provider import (  # pylint: disable=import-outside-toplevel
        CloudTrailProvider,
    )
    from lws.providers.cloudtrail.routes import (  # pylint: disable=import-outside-toplevel
        create_cloudtrail_app,
    )

    ct_provider = CloudTrailProvider()
    if s3_provider is not None:
        ct_provider.set_s3_provider(s3_provider)  # type: ignore[arg-type]
    if eb_provider is not None:
        ct_provider.set_eventbridge_provider(eb_provider)  # type: ignore[arg-type]

    providers["__cloudtrail__"] = ct_provider
    providers["__cloudtrail_http__"] = _HttpServiceProvider(
        "cloudtrail-http",
        lambda p=ct_provider, c=chaos_configs.get("cloudtrail"), m=aws_fake_configs.get(
            "cloudtrail"
        ), ia=iam_auth_bundle: create_cloudtrail_app(p, chaos=c, aws_fake=m, iam_auth=ia),
        cloudtrail_port,
    )
    return ct_provider


def _register_simple_providers(
    providers: dict,
    *,
    chaos_configs: dict,
    aws_fake_configs: dict,
    ports: dict[str, int],
) -> None:
    """Register all auto-discovered simple-service providers."""
    from lws.cli._ldk_http_registry import (  # pylint: disable=import-outside-toplevel
        _HttpServiceProvider,
    )
    from lws.providers._shared.service_descriptor import (  # pylint: disable=import-outside-toplevel
        discover_simple_services,
    )

    for desc in discover_simple_services():
        if desc.name not in ports:
            continue
        c = chaos_configs.get(desc.name)
        m = aws_fake_configs.get(desc.name)
        providers[f"__{desc.name}_http__"] = _HttpServiceProvider(
            f"{desc.name}-http",
            lambda chaos=c, fake=m, factory=desc.factory: factory(chaos=chaos, aws_fake=fake),
            ports[desc.name],
        )


def _register_experimental_providers(
    providers: dict[str, Provider],
    ports: dict[str, int],
    registry: TrackerRegistry | None = None,
) -> None:
    """Register all experimental-service providers (HTTP with per-resource containers)."""
    from lws.cli._ldk_http_registry import (  # pylint: disable=import-outside-toplevel
        _ContainerCleanupProvider,
        _HttpServiceProvider,
    )
    from lws.providers._shared.resource_container import (  # pylint: disable=import-outside-toplevel
        ResourceContainerConfig,
        ResourceContainerManager,
    )
    from lws.providers.docdb.routes import (  # pylint: disable=import-outside-toplevel
        create_docdb_app,
    )
    from lws.providers.elasticache.routes import (  # pylint: disable=import-outside-toplevel
        create_elasticache_app,
    )
    from lws.providers.elasticsearch.routes import (  # pylint: disable=import-outside-toplevel
        create_elasticsearch_app,
    )
    from lws.providers.glacier.routes import (  # pylint: disable=import-outside-toplevel
        create_glacier_app,
    )
    from lws.providers.memorydb.routes import (  # pylint: disable=import-outside-toplevel
        create_memorydb_app,
    )
    from lws.providers.neptune.routes import (  # pylint: disable=import-outside-toplevel
        create_neptune_app,
    )
    from lws.providers.opensearch.routes import (  # pylint: disable=import-outside-toplevel
        create_opensearch_app,
    )
    from lws.providers.rds.routes import (  # pylint: disable=import-outside-toplevel
        create_rds_app,
    )
    from lws.providers.s3tables.routes import (  # pylint: disable=import-outside-toplevel
        create_s3tables_app,
    )

    # Per-resource container managers
    elasticache_cm = ResourceContainerManager(
        "elasticache", ResourceContainerConfig(image="redis:7-alpine", internal_port=6379)
    )
    memorydb_cm = ResourceContainerManager(
        "memorydb", ResourceContainerConfig(image="redis:7-alpine", internal_port=6379)
    )
    docdb_cm = ResourceContainerManager(
        "docdb", ResourceContainerConfig(image="mongo:7", internal_port=27017)
    )
    neptune_cm = ResourceContainerManager(
        "neptune",
        ResourceContainerConfig(image="janusgraph/janusgraph:1.0", internal_port=8182),
    )
    opensearch_env = {
        "discovery.type": "single-node",
        "DISABLE_SECURITY_PLUGIN": "true",
    }
    es_cm = ResourceContainerManager(
        "elasticsearch",
        ResourceContainerConfig(
            image="opensearchproject/opensearch:2",
            internal_port=9200,
            environment=opensearch_env,
        ),
    )
    opensearch_cm = ResourceContainerManager(
        "opensearch",
        ResourceContainerConfig(
            image="opensearchproject/opensearch:2",
            internal_port=9200,
            environment=opensearch_env,
        ),
    )
    rds_pg_cm = ResourceContainerManager(
        "rds",
        ResourceContainerConfig(
            image="postgres:16-alpine",
            internal_port=5432,
            environment={"POSTGRES_PASSWORD": "lws-local"},
        ),
    )
    rds_mysql_cm = ResourceContainerManager(
        "rds",
        ResourceContainerConfig(
            image="mysql:8",
            internal_port=3306,
            environment={"MYSQL_ROOT_PASSWORD": "lws-local"},
        ),
    )

    # ElastiCache
    providers["__elasticache_http__"] = _HttpServiceProvider(
        "elasticache-http",
        lambda cm=elasticache_cm, reg=registry: create_elasticache_app(
            container_manager=cm, registry=reg
        ),
        ports["elasticache"],
    )

    # MemoryDB
    providers["__memorydb_http__"] = _HttpServiceProvider(
        "memorydb-http",
        lambda cm=memorydb_cm, reg=registry: create_memorydb_app(
            container_manager=cm, registry=reg
        ),
        ports["memorydb"],
    )

    # DocumentDB
    providers["__docdb_http__"] = _HttpServiceProvider(
        "docdb-http",
        lambda cm=docdb_cm, reg=registry: create_docdb_app(container_manager=cm, registry=reg),
        ports["docdb"],
    )

    # Neptune
    providers["__neptune_http__"] = _HttpServiceProvider(
        "neptune-http",
        lambda cm=neptune_cm, reg=registry: create_neptune_app(container_manager=cm, registry=reg),
        ports["neptune"],
    )

    # Elasticsearch
    providers["__es_http__"] = _HttpServiceProvider(
        "es-http",
        lambda cm=es_cm, reg=registry: create_elasticsearch_app(container_manager=cm, registry=reg),
        ports["es"],
    )

    # OpenSearch
    providers["__opensearch_http__"] = _HttpServiceProvider(
        "opensearch-http",
        lambda cm=opensearch_cm, reg=registry: create_opensearch_app(
            container_manager=cm, registry=reg
        ),
        ports["opensearch"],
    )

    # RDS
    providers["__rds_http__"] = _HttpServiceProvider(
        "rds-http",
        lambda pg=rds_pg_cm, my=rds_mysql_cm, reg=registry: create_rds_app(
            postgres_container_manager=pg, mysql_container_manager=my, registry=reg
        ),
        ports["rds"],
    )

    # Glacier
    providers["__glacier_http__"] = _HttpServiceProvider(
        "glacier-http", create_glacier_app, ports["glacier"]
    )

    # S3 Tables
    providers["__s3tables_http__"] = _HttpServiceProvider(
        "s3tables-http",
        lambda reg=registry: create_s3tables_app(registry=reg),
        ports["s3tables"],
    )

    # Container cleanup provider for graceful shutdown
    all_managers = [
        elasticache_cm,
        memorydb_cm,
        docdb_cm,
        neptune_cm,
        es_cm,
        opensearch_cm,
        rds_pg_cm,
        rds_mysql_cm,
    ]
    providers["__container_cleanup__"] = _ContainerCleanupProvider(all_managers)
