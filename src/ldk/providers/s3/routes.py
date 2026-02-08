"""FastAPI routes implementing the S3 wire protocol for local development."""

from __future__ import annotations

from fastapi import FastAPI, Request, Response
from fastapi.responses import StreamingResponse

from ldk.providers.s3.provider import S3Provider

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
    provider._dispatcher.dispatch(bucket, "ObjectCreated:Put", key)
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
    provider._dispatcher.dispatch(bucket, "ObjectRemoved:Delete", key)
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
            f"<NextContinuationToken>"
            f"{_xml_escape(result['next_token'])}"
            f"</NextContinuationToken>"
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
# App factory
# ------------------------------------------------------------------


def create_s3_app(provider: S3Provider) -> FastAPI:
    """Create a FastAPI application that speaks a subset of the S3 wire protocol."""
    app = FastAPI()

    @app.api_route("/{bucket}/{key:path}", methods=["PUT"])
    async def put_object(bucket: str, key: str, request: Request) -> Response:
        return await _put_object(bucket, key, request, provider)

    @app.api_route("/{bucket}/{key:path}", methods=["GET"])
    async def get_object(bucket: str, key: str) -> Response:
        return await _get_object(bucket, key, provider)

    @app.api_route("/{bucket}/{key:path}", methods=["DELETE"])
    async def delete_object(bucket: str, key: str) -> Response:
        return await _delete_object(bucket, key, provider)

    @app.api_route("/{bucket}/{key:path}", methods=["HEAD"])
    async def head_object(bucket: str, key: str) -> Response:
        return await _head_object(bucket, key, provider)

    @app.api_route("/{bucket}", methods=["GET"])
    async def list_objects_v2(bucket: str, request: Request) -> Response:
        return await _list_objects_v2(bucket, request, provider)

    return app
