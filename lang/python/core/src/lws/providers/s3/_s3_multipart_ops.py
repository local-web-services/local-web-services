"""S3 multipart upload operation handlers."""

from __future__ import annotations

from fastapi import Request, Response

from lws.providers.s3.provider import S3Provider

from ._s3_xml_helpers import _error_xml, _xml_escape, _xml_response


async def _create_multipart_upload(bucket: str, key: str, provider: S3Provider) -> Response:
    """Handle CreateMultipartUpload (POST /{bucket}/{key}?uploads)."""
    try:
        upload_id = provider.create_multipart_upload(bucket, key)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
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
    except ValueError as exc:
        return _error_xml("InvalidRequest", str(exc), 400)
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


async def _list_multipart_uploads(bucket: str, provider: S3Provider) -> Response:
    """Handle ListMultipartUploads (GET /{bucket}?uploads)."""
    try:
        await provider.head_bucket(bucket)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)

    body = (
        '<?xml version="1.0" encoding="UTF-8"?>'
        "<ListMultipartUploadsResult>"
        f"<Bucket>{_xml_escape(bucket)}</Bucket>"
        "</ListMultipartUploadsResult>"
    )
    return _xml_response(body)
