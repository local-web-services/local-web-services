"""FastAPI routes implementing the S3 wire protocol for local development."""

from __future__ import annotations

import xml.etree.ElementTree as ET

from fastapi import FastAPI, Request, Response
from fastapi.responses import StreamingResponse

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers.s3.provider import S3Provider

_logger = get_logger("ldk.s3")

# ------------------------------------------------------------------
# XML helpers
# ------------------------------------------------------------------


def _xml_response(body: str, status_code: int = 200) -> Response:
    """Return an XML response with the standard S3 content type."""
    return Response(
        content=body,
        status_code=status_code,
        media_type="application/xml",
    )


def _json_s3_response(body: str, status_code: int = 200) -> Response:
    """Return a JSON response (used for GetBucketPolicy etc.)."""
    return Response(
        content=body,
        status_code=status_code,
        media_type="application/json",
    )


def _xml_escape(text: str) -> str:
    """Escape special XML characters."""
    return (
        text.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
        .replace('"', "&quot;")
        .replace("'", "&apos;")
    )


def _error_xml(code: str, message: str, status_code: int = 400) -> Response:
    """Return an S3-style XML error response."""
    body = (
        '<?xml version="1.0" encoding="UTF-8"?>'
        "<Error>"
        f"<Code>{_xml_escape(code)}</Code>"
        f"<Message>{_xml_escape(message)}</Message>"
        "</Error>"
    )
    return _xml_response(body, status_code=status_code)


# ------------------------------------------------------------------
# Route handlers
# ------------------------------------------------------------------


async def _put_object(bucket: str, key: str, request: Request, provider: S3Provider) -> Response:
    """Handle PutObject requests."""
    body = await request.body()
    content_type = request.headers.get("content-type")
    result = await provider.storage.put_object(bucket, key, body, content_type=content_type)
    provider.dispatcher.dispatch(bucket, "ObjectCreated:Put", key)
    return Response(
        status_code=200,
        headers={"ETag": result["ETag"]},
    )


async def _get_object(bucket: str, key: str, provider: S3Provider) -> Response:
    """Handle GetObject requests."""
    result = await provider.storage.get_object(bucket, key)
    if result is None:
        return _error_xml("NoSuchKey", f"The specified key does not exist: {key}", 404)

    return StreamingResponse(
        iter([result["body"]]),
        media_type=result["content_type"],
        headers={
            "ETag": f'"{result["etag"]}"',
            "Content-Length": str(result["size"]),
            "Last-Modified": result["last_modified"],
        },
    )


async def _delete_object(bucket: str, key: str, provider: S3Provider) -> Response:
    """Handle DeleteObject requests."""
    await provider.storage.delete_object(bucket, key)
    provider.dispatcher.dispatch(bucket, "ObjectRemoved:Delete", key)
    return Response(status_code=204)


async def _head_object(bucket: str, key: str, provider: S3Provider) -> Response:
    """Handle HeadObject requests."""
    meta = await provider.storage.head_object(bucket, key)
    if meta is None:
        return Response(status_code=404)

    return Response(
        status_code=200,
        headers={
            "ETag": f'"{meta["etag"]}"',
            "Content-Length": str(meta["size"]),
            "Content-Type": meta["content_type"],
            "Last-Modified": meta["last_modified"],
        },
    )


async def _list_objects_v2(bucket: str, request: Request, provider: S3Provider) -> Response:
    """Handle ListObjectsV2 requests."""
    prefix = request.query_params.get("prefix", "")
    max_keys_str = request.query_params.get("max-keys", "1000")
    continuation_token = request.query_params.get("continuation-token")

    try:
        max_keys = int(max_keys_str)
    except ValueError:
        max_keys = 1000

    result = await provider.storage.list_objects(
        bucket,
        prefix=prefix,
        max_keys=max_keys,
        continuation_token=continuation_token,
    )

    contents_xml = ""
    for item in result["contents"]:
        contents_xml += (
            "<Contents>"
            f"<Key>{_xml_escape(item['key'])}</Key>"
            f"<Size>{item['size']}</Size>"
            f"<ETag>{_xml_escape(item['etag'])}</ETag>"
            f"<LastModified>{_xml_escape(item['last_modified'])}</LastModified>"
            "</Contents>"
        )

    is_truncated = "true" if result["is_truncated"] else "false"
    token_xml = ""
    if result["next_token"]:
        token_xml = (
            f"<NextContinuationToken>{_xml_escape(result['next_token'])}</NextContinuationToken>"
        )

    body = (
        '<?xml version="1.0" encoding="UTF-8"?>'
        '<ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">'
        f"<Name>{_xml_escape(bucket)}</Name>"
        f"<Prefix>{_xml_escape(prefix)}</Prefix>"
        f"<KeyCount>{len(result['contents'])}</KeyCount>"
        f"<MaxKeys>{max_keys}</MaxKeys>"
        f"<IsTruncated>{is_truncated}</IsTruncated>"
        f"{token_xml}"
        f"{contents_xml}"
        "</ListBucketResult>"
    )

    return _xml_response(body)


# ------------------------------------------------------------------
# CopyObject
# ------------------------------------------------------------------


async def _copy_object(bucket: str, key: str, request: Request, provider: S3Provider) -> Response:
    """Handle CopyObject (PUT /{bucket}/{key} with x-amz-copy-source header)."""
    copy_source = request.headers.get("x-amz-copy-source", "")
    # The header value is /source-bucket/source-key (with leading slash)
    copy_source = copy_source.lstrip("/")
    if "/" not in copy_source:
        return _error_xml("InvalidArgument", "Invalid x-amz-copy-source header", 400)

    src_bucket, src_key = copy_source.split("/", 1)
    result = await provider.storage.get_object(src_bucket, src_key)
    if result is None:
        return _error_xml("NoSuchKey", f"The specified key does not exist: {src_key}", 404)

    put_result = await provider.storage.put_object(
        bucket, key, result["body"], content_type=result["content_type"]
    )
    provider.dispatcher.dispatch(bucket, "ObjectCreated:Copy", key)

    # Return a CopyObjectResult XML
    body = (
        '<?xml version="1.0" encoding="UTF-8"?>'
        "<CopyObjectResult>"
        f"<ETag>{_xml_escape(put_result['ETag'])}</ETag>"
        f"<LastModified>{_xml_escape(result['last_modified'])}</LastModified>"
        "</CopyObjectResult>"
    )
    return _xml_response(body)


# ------------------------------------------------------------------
# DeleteObjects (multi-object delete)
# ------------------------------------------------------------------


async def _delete_objects(bucket: str, request: Request, provider: S3Provider) -> Response:
    """Handle DeleteObjects (POST /{bucket}?delete)."""
    body = await request.body()
    try:
        root = ET.fromstring(body)  # noqa: S314
    except ET.ParseError:
        return _error_xml("MalformedXML", "The XML you provided was not well-formed.", 400)

    # Parse keys from the XML - handle both namespaced and non-namespaced
    ns = ""
    if root.tag.startswith("{"):
        ns = root.tag.split("}")[0] + "}"

    deleted_keys: list[str] = []
    error_keys: list[dict] = []

    for obj_elem in root.findall(f"{ns}Object"):
        key_elem = obj_elem.find(f"{ns}Key")
        if key_elem is None or key_elem.text is None:
            continue
        key = key_elem.text
        try:
            await provider.storage.delete_object(bucket, key)
            provider.dispatcher.dispatch(bucket, "ObjectRemoved:Delete", key)
            deleted_keys.append(key)
        except Exception as exc:
            error_keys.append({"key": key, "code": "InternalError", "message": str(exc)})

    deleted_xml = ""
    for k in deleted_keys:
        deleted_xml += f"<Deleted><Key>{_xml_escape(k)}</Key></Deleted>"
    error_xml = ""
    for e in error_keys:
        error_xml += (
            "<Error>"
            f"<Key>{_xml_escape(e['key'])}</Key>"
            f"<Code>{_xml_escape(e['code'])}</Code>"
            f"<Message>{_xml_escape(e['message'])}</Message>"
            "</Error>"
        )

    result_body = (
        '<?xml version="1.0" encoding="UTF-8"?>'
        "<DeleteResult>"
        f"{deleted_xml}"
        f"{error_xml}"
        "</DeleteResult>"
    )
    return _xml_response(result_body)


# ------------------------------------------------------------------
# Bucket tagging
# ------------------------------------------------------------------


async def _put_bucket_tagging(bucket: str, request: Request, provider: S3Provider) -> Response:
    """Handle PutBucketTagging (PUT /{bucket}?tagging)."""
    body = await request.body()
    try:
        root = ET.fromstring(body)  # noqa: S314
    except ET.ParseError:
        return _error_xml("MalformedXML", "The XML you provided was not well-formed.", 400)

    ns = ""
    if root.tag.startswith("{"):
        ns = root.tag.split("}")[0] + "}"

    tags: dict[str, str] = {}
    tag_set = root.find(f"{ns}TagSet")
    if tag_set is not None:
        for tag_elem in tag_set.findall(f"{ns}Tag"):
            key_elem = tag_elem.find(f"{ns}Key")
            val_elem = tag_elem.find(f"{ns}Value")
            if key_elem is not None and key_elem.text is not None:
                val = val_elem.text if val_elem is not None and val_elem.text else ""
                tags[key_elem.text] = val

    try:
        provider.put_bucket_tagging(bucket, tags)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    return Response(status_code=204)


async def _delete_bucket_tagging(bucket: str, provider: S3Provider) -> Response:
    """Handle DeleteBucketTagging (DELETE /{bucket}?tagging)."""
    try:
        provider.delete_bucket_tagging(bucket)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    return Response(status_code=204)


async def _get_bucket_tagging(bucket: str, provider: S3Provider) -> Response:
    """Handle GetBucketTagging (GET /{bucket}?tagging)."""
    try:
        tags = provider.get_bucket_tagging(bucket)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)

    tag_set_xml = ""
    for k, v in tags.items():
        tag_set_xml += f"<Tag><Key>{_xml_escape(k)}</Key><Value>{_xml_escape(v)}</Value></Tag>"

    body = (
        f'<?xml version="1.0" encoding="UTF-8"?><Tagging><TagSet>{tag_set_xml}</TagSet></Tagging>'
    )
    return _xml_response(body)


# ------------------------------------------------------------------
# Bucket location
# ------------------------------------------------------------------


async def _get_bucket_location(bucket: str, provider: S3Provider) -> Response:
    """Handle GetBucketLocation (GET /{bucket}?location)."""
    try:
        await provider.head_bucket(bucket)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)

    body = (
        '<?xml version="1.0" encoding="UTF-8"?><LocationConstraint>us-east-1</LocationConstraint>'
    )
    return _xml_response(body)


# ------------------------------------------------------------------
# Bucket policy
# ------------------------------------------------------------------


async def _put_bucket_policy(bucket: str, request: Request, provider: S3Provider) -> Response:
    """Handle PutBucketPolicy (PUT /{bucket}?policy)."""
    body = await request.body()
    try:
        provider.put_bucket_policy(bucket, body.decode("utf-8"))
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    return Response(status_code=204)


async def _get_bucket_policy(bucket: str, provider: S3Provider) -> Response:
    """Handle GetBucketPolicy (GET /{bucket}?policy)."""
    try:
        policy = provider.get_bucket_policy(bucket)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    return _json_s3_response(policy)


# ------------------------------------------------------------------
# Bucket notification configuration
# ------------------------------------------------------------------


async def _put_bucket_notification_configuration(
    bucket: str, request: Request, provider: S3Provider
) -> Response:
    """Handle PutBucketNotificationConfiguration (PUT /{bucket}?notification)."""
    body = await request.body()
    try:
        provider.put_bucket_notification_configuration(bucket, body.decode("utf-8"))
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    return Response(status_code=200)


async def _get_bucket_notification_configuration(bucket: str, provider: S3Provider) -> Response:
    """Handle GetBucketNotificationConfiguration (GET /{bucket}?notification)."""
    try:
        config = provider.get_bucket_notification_configuration(bucket)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    return _xml_response(config)


# ------------------------------------------------------------------
# Multipart upload
# ------------------------------------------------------------------


async def _create_multipart_upload(bucket: str, key: str, provider: S3Provider) -> Response:
    """Handle CreateMultipartUpload (POST /{bucket}/{key}?uploads)."""
    upload_id = provider.create_multipart_upload(bucket, key)
    body = (
        '<?xml version="1.0" encoding="UTF-8"?>'
        "<InitiateMultipartUploadResult>"
        f"<Bucket>{_xml_escape(bucket)}</Bucket>"
        f"<Key>{_xml_escape(key)}</Key>"
        f"<UploadId>{_xml_escape(upload_id)}</UploadId>"
        "</InitiateMultipartUploadResult>"
    )
    return _xml_response(body)


async def _upload_part(bucket: str, key: str, request: Request, provider: S3Provider) -> Response:
    """Handle UploadPart (PUT /{bucket}/{key}?partNumber=N&uploadId=X)."""
    part_number = int(request.query_params.get("partNumber", "0"))
    upload_id = request.query_params.get("uploadId", "")
    data = await request.body()
    try:
        etag = provider.upload_part(bucket, key, upload_id, part_number, data)
    except KeyError:
        return _error_xml("NoSuchUpload", f"Upload not found: {upload_id}", 404)
    return Response(status_code=200, headers={"ETag": f'"{etag}"'})


async def _complete_multipart_upload(
    bucket: str, key: str, request: Request, provider: S3Provider
) -> Response:
    """Handle CompleteMultipartUpload (POST /{bucket}/{key}?uploadId=X)."""
    upload_id = request.query_params.get("uploadId", "")
    try:
        result = await provider.complete_multipart_upload(bucket, key, upload_id)
    except KeyError:
        return _error_xml("NoSuchUpload", f"Upload not found: {upload_id}", 404)
    body = (
        '<?xml version="1.0" encoding="UTF-8"?>'
        "<CompleteMultipartUploadResult>"
        f"<Location>{_xml_escape(result['Location'])}</Location>"
        f"<Bucket>{_xml_escape(result['Bucket'])}</Bucket>"
        f"<Key>{_xml_escape(result['Key'])}</Key>"
        f"<ETag>{_xml_escape(result['ETag'])}</ETag>"
        "</CompleteMultipartUploadResult>"
    )
    return _xml_response(body)


async def _abort_multipart_upload(
    _bucket: str, _key: str, request: Request, provider: S3Provider
) -> Response:
    """Handle AbortMultipartUpload (DELETE /{bucket}/{key}?uploadId=X)."""
    upload_id = request.query_params.get("uploadId", "")
    provider.abort_multipart_upload(upload_id)
    return Response(status_code=204)


async def _list_parts_handler(
    bucket: str, key: str, request: Request, provider: S3Provider
) -> Response:
    """Handle ListParts (GET /{bucket}/{key}?uploadId=X)."""
    upload_id = request.query_params.get("uploadId", "")
    try:
        parts = provider.list_parts(upload_id)
    except KeyError:
        return _error_xml("NoSuchUpload", f"Upload not found: {upload_id}", 404)

    parts_xml = ""
    for part in parts:
        parts_xml += (
            "<Part>"
            f"<PartNumber>{part['PartNumber']}</PartNumber>"
            f"<Size>{part['Size']}</Size>"
            f"<ETag>{_xml_escape(part['ETag'])}</ETag>"
            "</Part>"
        )
    body = (
        '<?xml version="1.0" encoding="UTF-8"?>'
        "<ListPartsResult>"
        f"<Bucket>{_xml_escape(bucket)}</Bucket>"
        f"<Key>{_xml_escape(key)}</Key>"
        f"<UploadId>{_xml_escape(upload_id)}</UploadId>"
        f"{parts_xml}"
        "</ListPartsResult>"
    )
    return _xml_response(body)


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
# App factory
# ------------------------------------------------------------------


async def _get_bucket(bucket: str, request: Request, provider: S3Provider) -> Response:
    """Handle GET /{bucket} — dispatches based on query params."""
    if "policy" in request.query_params:
        return await _get_bucket_policy(bucket, provider)
    if "tagging" in request.query_params:
        return await _get_bucket_tagging(bucket, provider)
    if "location" in request.query_params:
        return await _get_bucket_location(bucket, provider)
    if "notification" in request.query_params:
        return await _get_bucket_notification_configuration(bucket, provider)
    if "versioning" in request.query_params:
        return _xml_response('<?xml version="1.0" encoding="UTF-8"?><VersioningConfiguration/>')
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


async def _create_bucket(bucket: str, provider: S3Provider) -> Response:
    """Handle CreateBucket (PUT /{bucket} with no key). Idempotent."""
    try:
        await provider.create_bucket(bucket)
    except ValueError:
        pass  # Bucket already exists — treat as success (idempotent)
    return Response(status_code=200)


async def _delete_bucket(bucket: str, provider: S3Provider) -> Response:
    """Handle DeleteBucket (DELETE /{bucket})."""
    try:
        await provider.delete_bucket(bucket)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    return Response(status_code=204)


async def _head_bucket(bucket: str, provider: S3Provider) -> Response:
    """Handle HeadBucket (HEAD /{bucket})."""
    try:
        await provider.head_bucket(bucket)
    except KeyError:
        return Response(status_code=404)
    return Response(
        status_code=200,
        headers={
            "x-amz-bucket-region": "us-east-1",
        },
    )


async def _list_all_buckets(provider: S3Provider) -> Response:
    """Handle ListBuckets (GET /)."""
    bucket_names = await provider.list_buckets()
    buckets_xml = ""
    for name in bucket_names:
        try:
            meta = await provider.head_bucket(name)
            creation_date = meta["CreationDate"]
        except KeyError:
            creation_date = ""
        buckets_xml += (
            "<Bucket>"
            f"<Name>{_xml_escape(name)}</Name>"
            f"<CreationDate>{creation_date}</CreationDate>"
            "</Bucket>"
        )

    body = (
        '<?xml version="1.0" encoding="UTF-8"?>'
        "<ListAllMyBucketsResult>"
        f"<Buckets>{buckets_xml}</Buckets>"
        "<Owner>"
        "<ID>000000000000</ID>"
        "<DisplayName>local</DisplayName>"
        "</Owner>"
        "</ListAllMyBucketsResult>"
    )
    return _xml_response(body)


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


def _register_object_routes(app: FastAPI, provider: S3Provider) -> None:
    """Register object-level S3 routes on *app*."""

    @app.api_route("/{bucket}/{key:path}", methods=["POST"])
    async def post_object(bucket: str, key: str, request: Request) -> Response:
        return await _dispatch_post_object(bucket, key, request, provider)

    @app.api_route("/{bucket}/{key:path}", methods=["PUT"])
    async def put_object(bucket: str, key: str, request: Request) -> Response:
        return await _dispatch_put_object(bucket, key, request, provider)

    @app.api_route("/{bucket}/{key:path}", methods=["GET"])
    async def get_object(bucket: str, key: str, request: Request) -> Response:
        if "uploadId" in request.query_params:
            return await _list_parts_handler(bucket, key, request, provider)
        return await _get_object(bucket, key, provider)

    @app.api_route("/{bucket}/{key:path}", methods=["DELETE"])
    async def delete_object(bucket: str, key: str, request: Request) -> Response:
        if "uploadId" in request.query_params:
            return await _abort_multipart_upload(bucket, key, request, provider)
        return await _delete_object(bucket, key, provider)

    @app.api_route("/{bucket}/{key:path}", methods=["HEAD"])
    async def head_object(bucket: str, key: str) -> Response:
        return await _head_object(bucket, key, provider)


async def _dispatch_put_bucket(bucket: str, request: Request, provider: S3Provider) -> Response:
    """Dispatch PUT /{bucket} based on query parameters."""
    if "tagging" in request.query_params:
        return await _put_bucket_tagging(bucket, request, provider)
    if "policy" in request.query_params:
        return await _put_bucket_policy(bucket, request, provider)
    if "notification" in request.query_params:
        return await _put_bucket_notification_configuration(bucket, request, provider)
    return await _create_bucket(bucket, provider)


def _register_bucket_routes(app: FastAPI, provider: S3Provider) -> None:
    """Register bucket-level S3 routes on *app*."""

    @app.api_route("/{bucket}", methods=["POST"])
    async def post_bucket(bucket: str, request: Request) -> Response:
        if "delete" in request.query_params:
            return await _delete_objects(bucket, request, provider)
        return _error_xml("InvalidRequest", "Unsupported POST operation", 400)

    @app.api_route("/{bucket}", methods=["PUT"])
    async def create_bucket(bucket: str, request: Request) -> Response:
        return await _dispatch_put_bucket(bucket, request, provider)

    @app.api_route("/{bucket}", methods=["DELETE"])
    async def delete_bucket(bucket: str, request: Request) -> Response:
        if "tagging" in request.query_params:
            return await _delete_bucket_tagging(bucket, provider)
        return await _delete_bucket(bucket, provider)

    @app.api_route("/{bucket}", methods=["HEAD"])
    async def head_bucket_route(bucket: str) -> Response:
        return await _head_bucket(bucket, provider)

    @app.api_route("/{bucket}", methods=["GET"])
    async def get_bucket_route(bucket: str, request: Request) -> Response:
        return await _get_bucket(bucket, request, provider)


def create_s3_app(
    provider: S3Provider,
    chaos: AwsChaosConfig | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks a subset of the S3 wire protocol."""
    app = FastAPI()
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.XML_S3)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="s3")

    @app.api_route("/", methods=["GET"])
    async def list_buckets() -> Response:
        return await _list_all_buckets(provider)

    _register_object_routes(app, provider)
    _register_bucket_routes(app, provider)

    # Wrap the ASGI app with virtual-hosted-style rewriting so requests
    # like ``Host: my-bucket.host.docker.internal`` are handled transparently.
    return _VirtualHostRewriteMiddleware(app)  # type: ignore[return-value]
