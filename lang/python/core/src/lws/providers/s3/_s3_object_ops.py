"""S3 object-level operation handlers (GetObject, PutObject, etc.)."""

from __future__ import annotations

import xml.etree.ElementTree as ET  # used for DeleteObjects parsing

from fastapi import Request, Response
from fastapi.responses import StreamingResponse

from lws.providers.s3.provider import S3Provider

from ._s3_xml_helpers import _error_xml, _xml_escape, _xml_response

# ------------------------------------------------------------------
# Object CRUD
# ------------------------------------------------------------------


async def _put_object(bucket: str, key: str, request: Request, provider: S3Provider) -> Response:
    """Handle PutObject requests."""
    buckets = await provider.list_buckets()
    if bucket not in buckets:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    body = await request.body()
    content_type = request.headers.get("content-type")
    result = await provider.storage.put_object(bucket, key, body, content_type=content_type)
    provider.dispatcher.dispatch(bucket, "ObjectCreated:Put", key)
    return Response(
        status_code=200,
        headers={"ETag": result["ETag"]},
    )


def _streaming_object_response(result: dict) -> StreamingResponse:
    """Build a StreamingResponse from a storage result dict."""
    return StreamingResponse(
        iter([result["body"]]),
        media_type=result["content_type"],
        headers={
            "ETag": f'"{result["etag"]}"',
            "Content-Length": str(result["size"]),
            "Last-Modified": result["last_modified"],
        },
    )


def _website_index_candidates(key: str, index_doc: str) -> list[str]:
    """Return candidate index keys to try for website resolution."""
    candidates: list[str] = []
    if not index_doc:
        return candidates
    if key.endswith("/") or key == "":
        candidates.append(f"{key}{index_doc}" if key else index_doc)
    elif "." not in key.split("/")[-1]:
        candidates.append(f"{key}/{index_doc}")
    return candidates


async def _serve_website_fallback(
    bucket: str, key: str, website: dict[str, str], provider: S3Provider
) -> Response:
    """Try index document and error document resolution for website-enabled buckets."""
    candidates = _website_index_candidates(key, website.get("index_document", ""))
    for candidate_key in candidates:
        result = await provider.storage.get_object(bucket, candidate_key)
        if result is not None:
            return _streaming_object_response(result)

    # Serve error document with 404 status
    error_doc = website.get("error_document", "")
    if error_doc:
        result = await provider.storage.get_object(bucket, error_doc)
        if result is not None:
            return Response(
                content=result["body"],
                status_code=404,
                media_type=result["content_type"],
            )

    return _error_xml("NoSuchKey", f"The specified key does not exist: {key}", 404)


async def _get_object(bucket: str, key: str, provider: S3Provider) -> Response:
    """Handle GetObject requests."""
    try:
        result = await provider.storage.get_object(bucket, key)
    except IsADirectoryError:
        result = None
    if result is None:
        # Try website-aware resolution
        buckets = await provider.list_buckets()
        website = provider.get_bucket_website(bucket) if bucket in buckets else None
        if website:
            return await _serve_website_fallback(bucket, key, website, provider)
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
    buckets = await provider.list_buckets()
    if bucket not in buckets:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    meta = await provider.storage.head_object(bucket, key)
    if meta is None:
        return _error_xml("NoSuchKey", f"The specified key does not exist: {key}", 404)
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
# ListObjectsV2
# ------------------------------------------------------------------


async def _list_objects_v2(bucket: str, request: Request, provider: S3Provider) -> Response:
    """Handle ListObjectsV2 requests."""
    buckets = await provider.list_buckets()
    if bucket not in buckets:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
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
