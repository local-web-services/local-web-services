"""S3 bucket-level operation handlers (CreateBucket, DeleteBucket, etc.)."""

from __future__ import annotations

import xml.etree.ElementTree as ET

from fastapi import Request, Response

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers.s3.provider import S3Provider

from ._s3_xml_helpers import _error_xml, _json_s3_response, _xml_escape, _xml_response


# ------------------------------------------------------------------
# Bucket CRUD
# ------------------------------------------------------------------


async def _create_bucket(bucket: str, provider: S3Provider) -> Response:
    """Handle CreateBucket (PUT /{bucket} with no key)."""
    try:
        await provider.create_bucket(bucket)
    except ValueError:
        return _error_xml("BucketAlreadyOwnedByYou", f"Bucket already exists: {bucket}", 409)
    return Response(status_code=200)


async def _delete_bucket(bucket: str, provider: S3Provider) -> Response:
    """Handle DeleteBucket (DELETE /{bucket})."""
    try:
        await provider.delete_bucket(bucket)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    except ValueError:
        return _error_xml(
            "BucketNotEmpty",
            f"The bucket you tried to delete is not empty: {bucket}",
            409,
        )
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
# Bucket versioning
# ------------------------------------------------------------------


async def _put_bucket_versioning(bucket: str, request: Request, provider: S3Provider) -> Response:
    """Handle PutBucketVersioning (PUT /{bucket}?versioning)."""
    body = await request.body()
    try:
        root = ET.fromstring(body)  # noqa: S314
    except ET.ParseError:
        return _error_xml("MalformedXML", "The XML you provided was not well-formed.", 400)
    ns = ""
    if root.tag.startswith("{"):
        ns = root.tag.split("}")[0] + "}"
    status_elem = root.find(f"{ns}Status")
    status = status_elem.text if status_elem is not None and status_elem.text else ""
    try:
        provider.put_bucket_versioning(bucket, status)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    return Response(status_code=200)


async def _get_bucket_versioning(bucket: str, provider: S3Provider) -> Response:
    """Handle GetBucketVersioning (GET /{bucket}?versioning)."""
    try:
        status = provider.get_bucket_versioning(bucket)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    if status:
        body = (
            '<?xml version="1.0" encoding="UTF-8"?>'
            "<VersioningConfiguration>"
            f"<Status>{_xml_escape(status)}</Status>"
            "</VersioningConfiguration>"
        )
    else:
        body = '<?xml version="1.0" encoding="UTF-8"?><VersioningConfiguration/>'
    return _xml_response(body)


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
# Bucket website configuration
# ------------------------------------------------------------------


def _parse_website_config_xml(root: ET.Element) -> dict[str, str]:
    """Extract website configuration fields from a parsed XML element."""
    ns = ""
    if root.tag.startswith("{"):
        ns = root.tag.split("}")[0] + "}"

    config: dict[str, str] = {}
    _xml_nested_text(root, f"{ns}IndexDocument", f"{ns}Suffix", config, "index_document")
    _xml_nested_text(root, f"{ns}ErrorDocument", f"{ns}Key", config, "error_document")
    return config


def _xml_nested_text(
    root: ET.Element, parent_tag: str, child_tag: str, out: dict[str, str], key: str
) -> None:
    """Extract text from a nested XML element into *out* if present."""
    parent = root.find(parent_tag)
    if parent is not None:
        child = parent.find(child_tag)
        if child is not None and child.text:
            out[key] = child.text


async def _put_bucket_website(bucket: str, request: Request, provider: S3Provider) -> Response:
    """Handle PutBucketWebsite (PUT /{bucket}?website)."""
    body = await request.body()
    try:
        root = ET.fromstring(body)  # noqa: S314
    except ET.ParseError:
        return _error_xml("MalformedXML", "The XML you provided was not well-formed.", 400)

    config = _parse_website_config_xml(root)
    if "index_document" not in config:
        return _error_xml(
            "InvalidArgument",
            "A value for IndexDocument Suffix must be provided.",
            400,
        )

    try:
        provider.put_bucket_website(bucket, config)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    return Response(status_code=200)


async def _get_bucket_website(bucket: str, provider: S3Provider) -> Response:
    """Handle GetBucketWebsite (GET /{bucket}?website)."""
    try:
        config = provider.get_bucket_website(bucket)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)

    if config is None:
        return _error_xml(
            "NoSuchWebsiteConfiguration",
            "The specified bucket does not have a website configuration",
            404,
        )

    index_xml = ""
    if "index_document" in config:
        index_xml = (
            f"<IndexDocument><Suffix>{_xml_escape(config['index_document'])}</Suffix>"
            "</IndexDocument>"
        )
    error_xml = ""
    if "error_document" in config:
        error_xml = (
            f"<ErrorDocument><Key>{_xml_escape(config['error_document'])}</Key></ErrorDocument>"
        )

    body = (
        '<?xml version="1.0" encoding="UTF-8"?>'
        f"<WebsiteConfiguration>{index_xml}{error_xml}</WebsiteConfiguration>"
    )
    return _xml_response(body)


async def _delete_bucket_website(bucket: str, provider: S3Provider) -> Response:
    """Handle DeleteBucketWebsite (DELETE /{bucket}?website)."""
    try:
        provider.delete_bucket_website(bucket)
    except KeyError:
        return _error_xml("NoSuchBucket", f"The specified bucket does not exist: {bucket}", 404)
    return Response(status_code=204)


# ------------------------------------------------------------------
# Lifecycle error helper
# ------------------------------------------------------------------


def _s3_bucket_lifecycle_error(
    bucket: str,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    """Return a 404 NoSuchBucket response if bucket is in a transient lifecycle state."""
    if not lc.enabled:
        return None
    state = tracker.get_state(bucket)
    if state in ("CREATING", "DELETING"):
        return _error_xml(
            "NoSuchBucket",
            f"The specified bucket does not exist: {bucket} (status: {state})",
            404,
        )
    return None
