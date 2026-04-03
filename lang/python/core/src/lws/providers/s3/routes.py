"""FastAPI routes implementing the S3 wire protocol for local development."""

from __future__ import annotations

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
from lws.providers._shared.provider_context import ProviderContext
from lws.providers.s3._s3_bucket_ops import (
    _create_bucket,
    _delete_bucket,
    _delete_bucket_tagging,
    _delete_bucket_website,
    _get_bucket_location,
    _get_bucket_notification_configuration,
    _get_bucket_policy,
    _get_bucket_tagging,
    _get_bucket_versioning,
    _get_bucket_website,
    _head_bucket,
    _list_all_buckets,
    _put_bucket_notification_configuration,
    _put_bucket_policy,
    _put_bucket_tagging,
    _put_bucket_versioning,
    _put_bucket_website,
    _s3_bucket_lifecycle_error,
)
from lws.providers.s3._s3_multipart_ops import (
    _abort_multipart_upload,
    _complete_multipart_upload,
    _create_multipart_upload,
    _list_parts_handler,
    _upload_part,
)
from lws.providers.s3._s3_object_ops import (
    _copy_object,
    _delete_object,
    _delete_objects,
    _get_object,
    _head_object,
    _list_objects_v2,
    _put_object,
)
from lws.providers.s3._s3_xml_helpers import _error_xml, _xml_response
from lws.providers.s3.provider import S3Provider
from lws.providers.sns.provider import SnsProvider
from lws.providers.sqs.provider import SqsProvider

_logger = get_logger("ldk.s3")


# ------------------------------------------------------------------
# Virtual-hosted-style middleware
# ------------------------------------------------------------------


class _VirtualHostRewriteMiddleware:
    """Rewrite virtual-hosted-style S3 requests to path-style.

    When the Host header contains a bucket subdomain (e.g.
    ``my-bucket.host.docker.internal``), the bucket name is prepended
    to the request path so the existing path-style routes handle it.
    """

    _BASE_HOSTS = frozenset({"localhost", "127.0.0.1", "host.docker.internal"})

    def __init__(self, app):  # type: ignore[no-untyped-def]
        self._app = app

    async def __call__(self, scope, receive, send):  # type: ignore[no-untyped-def]
        if scope["type"] != "http":
            await self._app(scope, receive, send)
            return

        host_value = ""
        for header_name, header_val in scope.get("headers", []):
            if header_name == b"host":
                host_value = header_val.decode("latin-1")
                break

        # Strip port to get bare hostname
        hostname = host_value.split(":")[0].lower()

        bucket: str | None = None
        for base in self._BASE_HOSTS:
            suffix = f".{base}"
            if hostname.endswith(suffix):
                bucket = hostname[: -len(suffix)]
                break

        if bucket:
            path = scope.get("path", "/")
            new_path = f"/{bucket}{path}"
            scope = dict(scope)
            scope["path"] = new_path
            raw = scope.get("raw_path")
            if raw is not None:
                scope["raw_path"] = new_path.encode("latin-1")

        await self._app(scope, receive, send)


# ------------------------------------------------------------------
# Bucket-level dispatch helpers
# ------------------------------------------------------------------


async def _get_bucket(bucket: str, request: Request, provider: S3Provider) -> Response:
    """Handle GET /{bucket} — dispatches based on query params."""
    if "website" in request.query_params:
        return await _get_bucket_website(bucket, provider)
    if "policy" in request.query_params:
        return await _get_bucket_policy(bucket, provider)
    if "tagging" in request.query_params:
        return await _get_bucket_tagging(bucket, provider)
    if "location" in request.query_params:
        return await _get_bucket_location(bucket, provider)
    if "notification" in request.query_params:
        return await _get_bucket_notification_configuration(bucket, provider)
    if "versioning" in request.query_params:
        return await _get_bucket_versioning(bucket, provider)
    if "acl" in request.query_params:
        return _xml_response(
            '<?xml version="1.0" encoding="UTF-8"?>'
            "<AccessControlPolicy>"
            "<Owner><ID>000000000000</ID></Owner>"
            "<AccessControlList>"
            "<Grant><Grantee><ID>000000000000</ID></Grantee>"
            "<Permission>FULL_CONTROL</Permission></Grant>"
            "</AccessControlList>"
            "</AccessControlPolicy>"
        )
    return await _list_objects_v2(bucket, request, provider)


async def _dispatch_put_object(
    bucket: str, key: str, request: Request, provider: S3Provider
) -> Response:
    """Dispatch PUT /{bucket}/{key} based on query params and headers."""
    if "partNumber" in request.query_params and "uploadId" in request.query_params:
        return await _upload_part(bucket, key, request, provider)
    if "x-amz-copy-source" in request.headers:
        return await _copy_object(bucket, key, request, provider)
    return await _put_object(bucket, key, request, provider)


async def _dispatch_post_object(
    bucket: str, key: str, request: Request, provider: S3Provider
) -> Response:
    """Dispatch POST /{bucket}/{key} based on query params."""
    if "uploads" in request.query_params:
        return await _create_multipart_upload(bucket, key, provider)
    if "uploadId" in request.query_params:
        return await _complete_multipart_upload(bucket, key, request, provider)
    return _error_xml("InvalidRequest", "Unsupported POST operation", 400)


async def _s3_delete_bucket_route(
    bucket: str,
    request: Request,
    provider: S3Provider,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle DELETE /{bucket} with lifecycle awareness."""
    if "website" in request.query_params or "tagging" in request.query_params:
        err = _s3_bucket_lifecycle_error(bucket, lc, tracker)
        if err is not None:
            return err
        if "website" in request.query_params:
            return await _delete_bucket_website(bucket, provider)
        return await _delete_bucket_tagging(bucket, provider)
    if lc.enabled:
        state = tracker.get_state(bucket)
        if state == "CREATING":
            return _error_xml(
                "BucketNotReady",
                f"Bucket {bucket} is still being created",
                400,
            )
    resp = await _delete_bucket(bucket, provider)
    if resp.status_code == 204 and lc.enabled:
        if lc.delete_dwell_ms > 0:
            tracker.set_state(bucket, "DELETING")
            tracker.schedule_transition(bucket, None, lc.delete_dwell_ms)
        else:
            tracker.remove(bucket)
    return resp


async def _s3_get_object_route(
    bucket: str,
    key: str,
    request: Request,
    provider: S3Provider,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    err = _s3_bucket_lifecycle_error(bucket, lc, tracker)
    if err is not None:
        return err
    if "uploadId" in request.query_params:
        return await _list_parts_handler(bucket, key, request, provider)
    return await _get_object(bucket, key, provider)


async def _s3_delete_object_route(
    bucket: str,
    key: str,
    request: Request,
    provider: S3Provider,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    err = _s3_bucket_lifecycle_error(bucket, lc, tracker)
    if err is not None:
        return err
    if "uploadId" in request.query_params:
        return await _abort_multipart_upload(bucket, key, request, provider)
    return await _delete_object(bucket, key, provider)


_S3_BUCKET_MODIFY_PARAMS = ("versioning", "website", "tagging", "policy", "notification")


async def _s3_put_bucket_route(
    bucket: str,
    request: Request,
    provider: S3Provider,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
    sns_provider: SnsProvider | None = None,
    sqs_provider: SqsProvider | None = None,
    compute_providers: dict | None = None,
) -> Response:
    if not any(k in request.query_params for k in _S3_BUCKET_MODIFY_PARAMS):
        resp = await _dispatch_put_bucket(
            bucket, request, provider, sns_provider, sqs_provider, compute_providers
        )
        if resp.status_code == 200 and lc.enabled and lc.create_dwell_ms > 0:
            tracker.set_state(bucket, "CREATING")
            tracker.schedule_transition(bucket, "ACTIVE", lc.create_dwell_ms)
        return resp
    err = _s3_bucket_lifecycle_error(bucket, lc, tracker)
    if err is not None:
        return err
    return await _dispatch_put_bucket(
        bucket, request, provider, sns_provider, sqs_provider, compute_providers
    )


async def _dispatch_put_bucket(
    bucket: str,
    request: Request,
    provider: S3Provider,
    sns_provider: SnsProvider | None = None,
    sqs_provider: SqsProvider | None = None,
    compute_providers: dict | None = None,
) -> Response:
    """Dispatch PUT /{bucket} based on query parameters."""
    if "versioning" in request.query_params:
        return await _put_bucket_versioning(bucket, request, provider)
    if "website" in request.query_params:
        return await _put_bucket_website(bucket, request, provider)
    if "tagging" in request.query_params:
        return await _put_bucket_tagging(bucket, request, provider)
    if "policy" in request.query_params:
        return await _put_bucket_policy(bucket, request, provider)
    if "notification" in request.query_params:
        return await _put_bucket_notification_configuration(
            bucket, request, provider, sns_provider, sqs_provider, compute_providers
        )
    return await _create_bucket(bucket, provider)


# ------------------------------------------------------------------
# Route registration
# ------------------------------------------------------------------


def _register_object_routes(
    app: FastAPI,
    provider: S3Provider,
    lc: ResourceLifecycleConfig | None = None,
    tracker: ResourceStateTracker | None = None,
    capacity: AwsCapacityConfig | None = None,
) -> None:
    """Register object-level S3 routes on *app*."""
    _lc = lc or ResourceLifecycleConfig()
    _tracker = tracker or ResourceStateTracker(_lc)
    _capacity = capacity or AwsCapacityConfig()

    @app.api_route("/{bucket}/{key:path}", methods=["POST"])
    async def post_object(bucket: str, key: str, request: Request) -> Response:
        err = _s3_bucket_lifecycle_error(bucket, _lc, _tracker)
        if err is not None:
            return err
        return await _dispatch_post_object(bucket, key, request, provider)

    @app.api_route("/{bucket}/{key:path}", methods=["PUT"])
    async def put_object(bucket: str, key: str, request: Request) -> Response:
        if _capacity.is_exhausted:
            return _error_xml("ServiceUnavailableException", "lws: no object slots available", 503)
        err = _s3_bucket_lifecycle_error(bucket, _lc, _tracker)
        if err is not None:
            return err
        return await _dispatch_put_object(bucket, key, request, provider)

    @app.api_route("/{bucket}/{key:path}", methods=["GET"])
    async def get_object(bucket: str, key: str, request: Request) -> Response:
        return await _s3_get_object_route(bucket, key, request, provider, _lc, _tracker)

    @app.api_route("/{bucket}/{key:path}", methods=["DELETE"])
    async def delete_object(bucket: str, key: str, request: Request) -> Response:
        return await _s3_delete_object_route(bucket, key, request, provider, _lc, _tracker)

    @app.api_route("/{bucket}/{key:path}", methods=["HEAD"])
    async def head_object(bucket: str, key: str) -> Response:
        err = _s3_bucket_lifecycle_error(bucket, _lc, _tracker)
        if err is not None:
            return err
        return await _head_object(bucket, key, provider)


def _register_bucket_routes(
    app: FastAPI,
    provider: S3Provider,
    lc: ResourceLifecycleConfig | None = None,
    tracker: ResourceStateTracker | None = None,
    sns_provider: SnsProvider | None = None,
    sqs_provider: SqsProvider | None = None,
    compute_providers: dict | None = None,
) -> None:
    """Register bucket-level S3 routes on *app*."""
    _lc = lc or ResourceLifecycleConfig()
    _tracker = tracker or ResourceStateTracker(_lc)

    @app.api_route("/{bucket}", methods=["POST"])
    async def post_bucket(bucket: str, request: Request) -> Response:
        if "delete" in request.query_params:
            err = _s3_bucket_lifecycle_error(bucket, _lc, _tracker)
            if err is not None:
                return err
            return await _delete_objects(bucket, request, provider)
        return _error_xml("InvalidRequest", "Unsupported POST operation", 400)

    @app.api_route("/{bucket}", methods=["PUT"])
    async def create_bucket(bucket: str, request: Request) -> Response:
        return await _s3_put_bucket_route(
            bucket, request, provider, _lc, _tracker, sns_provider, sqs_provider, compute_providers
        )

    @app.api_route("/{bucket}", methods=["DELETE"])
    async def delete_bucket(bucket: str, request: Request) -> Response:
        return await _s3_delete_bucket_route(bucket, request, provider, _lc, _tracker)

    @app.api_route("/{bucket}", methods=["HEAD"])
    async def head_bucket_route(bucket: str) -> Response:
        err = _s3_bucket_lifecycle_error(bucket, _lc, _tracker)
        if err is not None:
            return Response(status_code=404)
        return await _head_bucket(bucket, provider)

    @app.api_route("/{bucket}", methods=["GET"])
    async def get_bucket_route(bucket: str, request: Request) -> Response:
        err = _s3_bucket_lifecycle_error(bucket, _lc, _tracker)
        if err is not None:
            return err
        return await _get_bucket(bucket, request, provider)


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_s3_app(
    provider: S3Provider,
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
    capacity: AwsCapacityConfig | None = None,
    sns_provider: SnsProvider | None = None,
    sqs_provider: SqsProvider | None = None,
    compute_providers: dict | None = None,
    tracker_ref: list | None = None,
    context: ProviderContext | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks a subset of the S3 wire protocol."""
    _lc = lifecycle or ResourceLifecycleConfig()
    _tracker = ResourceStateTracker(_lc)
    if tracker_ref is not None:
        tracker_ref.append(_tracker)

    app = FastAPI()
    if aws_fake is not None:
        app.add_middleware(AwsOperationFakeMiddleware, fake_config=aws_fake, service="s3")
    add_iam_auth_middleware(app, "s3", iam_auth, ErrorFormat.XML_S3)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.XML_S3)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="s3")

    @app.api_route("/", methods=["GET"])
    async def list_buckets() -> Response:
        return await _list_all_buckets(provider)

    _register_object_routes(app, provider, _lc, _tracker, capacity)
    _register_bucket_routes(
        app, provider, _lc, _tracker, sns_provider, sqs_provider, compute_providers
    )

    apply_cloudtrail_middleware(app, context.cloudtrail if context else None, "s3")
    # Wrap the ASGI app with virtual-hosted-style rewriting so requests
    # like ``Host: my-bucket.host.docker.internal`` are handled transparently.
    return _VirtualHostRewriteMiddleware(app)  # type: ignore[return-value]
