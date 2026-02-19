"""``lws s3api`` sub-commands."""

from __future__ import annotations

import asyncio
import json
from pathlib import Path

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json, xml_to_dict

app = typer.Typer(help="S3 API commands")

_SERVICE = "s3"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("put-object")
def put_object(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    key: str = typer.Option(..., "--key", help="Object key"),
    body: str = typer.Option(..., "--body", help="File path for object body"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Upload an object to a bucket."""
    asyncio.run(_put_object(bucket, key, body, port))


async def _put_object(bucket: str, key: str, body_path: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    path = Path(body_path)
    if not path.exists():
        exit_with_error(f"File not found: {body_path}")
    file_bytes = path.read_bytes()
    resp = await client.rest_request(_SERVICE, "PUT", f"{bucket}/{key}", body=file_bytes)
    result: dict = {"ETag": resp.headers.get("etag", "")}
    output_json(result)


@app.command("get-object")
def get_object(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    key: str = typer.Option(..., "--key", help="Object key"),
    outfile: str = typer.Argument(None, help="Output file path"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Download an object from a bucket."""
    asyncio.run(_get_object(bucket, key, outfile, port))


async def _get_object(bucket: str, key: str, outfile: str | None, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    resp = await client.rest_request(_SERVICE, "GET", f"{bucket}/{key}")
    if resp.status_code == 404:
        exit_with_error(f"Object not found: {key}")
    if outfile:
        Path(outfile).write_bytes(resp.content)
        output_json(
            {
                "ContentLength": len(resp.content),
                "ETag": resp.headers.get("etag", ""),
                "ContentType": resp.headers.get("content-type", ""),
            }
        )
    else:
        output_json(
            {
                "Body": resp.text,
                "ContentLength": len(resp.content),
                "ETag": resp.headers.get("etag", ""),
                "ContentType": resp.headers.get("content-type", ""),
            }
        )


@app.command("delete-object")
def delete_object(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    key: str = typer.Option(..., "--key", help="Object key"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete an object from a bucket."""
    asyncio.run(_delete_object(bucket, key, port))


async def _delete_object(bucket: str, key: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    await client.rest_request(_SERVICE, "DELETE", f"{bucket}/{key}")
    output_json({"DeleteMarker": True})


@app.command("list-objects-v2")
def list_objects_v2(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    prefix: str = typer.Option("", "--prefix", help="Key prefix filter"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List objects in a bucket."""
    asyncio.run(_list_objects_v2(bucket, prefix, port))


async def _list_objects_v2(bucket: str, prefix: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    params: dict[str, str] = {}
    if prefix:
        params["prefix"] = prefix
    resp = await client.rest_request(_SERVICE, "GET", bucket, params=params)
    output_json(xml_to_dict(resp.text))


@app.command("head-object")
def head_object(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    key: str = typer.Option(..., "--key", help="Object key"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get object metadata."""
    asyncio.run(_head_object(bucket, key, port))


async def _head_object(bucket: str, key: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    resp = await client.rest_request(_SERVICE, "HEAD", f"{bucket}/{key}")
    if resp.status_code == 404:
        exit_with_error(f"Object not found: {key}")
    output_json(
        {
            "ContentLength": resp.headers.get("content-length", "0"),
            "ContentType": resp.headers.get("content-type", ""),
            "ETag": resp.headers.get("etag", ""),
            "LastModified": resp.headers.get("last-modified", ""),
        }
    )


@app.command("create-bucket")
def create_bucket(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a bucket."""
    asyncio.run(_create_bucket(bucket, port))


async def _create_bucket(bucket: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    resp = await client.rest_request(_SERVICE, "PUT", bucket)
    if resp.status_code >= 400:
        output_json(xml_to_dict(resp.text))
    else:
        output_json({"Location": f"/{bucket}"})


@app.command("delete-bucket")
def delete_bucket(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a bucket."""
    asyncio.run(_delete_bucket(bucket, port))


async def _delete_bucket(bucket: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    resp = await client.rest_request(_SERVICE, "DELETE", bucket)
    if resp.status_code >= 400:
        output_json(xml_to_dict(resp.text))
    else:
        output_json({})


@app.command("head-bucket")
def head_bucket(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Check if a bucket exists."""
    asyncio.run(_head_bucket(bucket, port))


async def _head_bucket(bucket: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    resp = await client.rest_request(_SERVICE, "HEAD", bucket)
    if resp.status_code == 404:
        exit_with_error(f"Bucket not found: {bucket}")
    output_json(
        {
            "BucketRegion": resp.headers.get("x-amz-bucket-region", "us-east-1"),
        }
    )


@app.command("list-buckets")
def list_buckets(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all buckets."""
    asyncio.run(_list_buckets(port))


async def _list_buckets(port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    resp = await client.rest_request(_SERVICE, "GET", "")
    output_json(xml_to_dict(resp.text))


@app.command("create-multipart-upload")
def create_multipart_upload(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    key: str = typer.Option(..., "--key", help="Object key"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Initiate a multipart upload."""
    asyncio.run(_create_multipart_upload(bucket, key, port))


async def _create_multipart_upload(bucket: str, key: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    resp = await client.rest_request(_SERVICE, "POST", f"{bucket}/{key}", params={"uploads": ""})
    output_json(xml_to_dict(resp.text))


@app.command("upload-part")
def upload_part(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    key: str = typer.Option(..., "--key", help="Object key"),
    upload_id: str = typer.Option(..., "--upload-id", help="Upload ID"),
    part_number: int = typer.Option(..., "--part-number", help="Part number"),
    body: str = typer.Option(..., "--body", help="File path for part body"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Upload a part in a multipart upload."""
    asyncio.run(_upload_part(bucket, key, upload_id, part_number, body, port))


async def _upload_part(
    bucket: str, key: str, upload_id: str, part_number: int, body_path: str, port: int
) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    path = Path(body_path)
    if not path.exists():
        exit_with_error(f"File not found: {body_path}")
    file_bytes = path.read_bytes()
    resp = await client.rest_request(
        _SERVICE,
        "PUT",
        f"{bucket}/{key}",
        body=file_bytes,
        params={"partNumber": str(part_number), "uploadId": upload_id},
    )
    output_json({"ETag": resp.headers.get("etag", "")})


@app.command("complete-multipart-upload")
def complete_multipart_upload(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    key: str = typer.Option(..., "--key", help="Object key"),
    upload_id: str = typer.Option(..., "--upload-id", help="Upload ID"),
    multipart_upload: str = typer.Option(
        ..., "--multipart-upload", help='JSON with Parts array, e.g. {"Parts": [...]}'
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Complete a multipart upload."""
    asyncio.run(_complete_multipart_upload(bucket, key, upload_id, multipart_upload, port))


async def _complete_multipart_upload(
    bucket: str, key: str, upload_id: str, multipart_upload_json: str, port: int
) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    try:
        parsed = json.loads(multipart_upload_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --multipart-upload: {exc}")
    parts = parsed.get("Parts", [])
    xml_parts = "".join(
        f"<Part><PartNumber>{p['PartNumber']}</PartNumber><ETag>{p['ETag']}</ETag></Part>"
        for p in parts
    )
    xml_body = f"<CompleteMultipartUpload>{xml_parts}</CompleteMultipartUpload>"
    resp = await client.rest_request(
        _SERVICE,
        "POST",
        f"{bucket}/{key}",
        body=xml_body.encode(),
        params={"uploadId": upload_id},
    )
    output_json(xml_to_dict(resp.text))


@app.command("abort-multipart-upload")
def abort_multipart_upload(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    key: str = typer.Option(..., "--key", help="Object key"),
    upload_id: str = typer.Option(..., "--upload-id", help="Upload ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Abort a multipart upload."""
    asyncio.run(_abort_multipart_upload(bucket, key, upload_id, port))


async def _abort_multipart_upload(bucket: str, key: str, upload_id: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    await client.rest_request(
        _SERVICE,
        "DELETE",
        f"{bucket}/{key}",
        params={"uploadId": upload_id},
    )
    output_json({})


@app.command("copy-object")
def copy_object(
    bucket: str = typer.Option(..., "--bucket", help="Destination bucket name"),
    key: str = typer.Option(..., "--key", help="Destination object key"),
    copy_source: str = typer.Option(..., "--copy-source", help="Source bucket/key (bucket/key)"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Copy an object."""
    asyncio.run(_copy_object(bucket, key, copy_source, port))


async def _copy_object(bucket: str, key: str, copy_source: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    source = copy_source if copy_source.startswith("/") else f"/{copy_source}"
    resp = await client.rest_request(
        _SERVICE,
        "PUT",
        f"{bucket}/{key}",
        headers={"x-amz-copy-source": source},
    )
    output_json(xml_to_dict(resp.text))


@app.command("delete-objects")
def delete_objects(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    delete: str = typer.Option(..., "--delete", help="JSON delete specification"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete multiple objects."""
    asyncio.run(_delete_objects(bucket, delete, port))


async def _delete_objects(bucket: str, delete_json: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    try:
        parsed = json.loads(delete_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --delete: {exc}")
    objects = parsed.get("Objects", [])
    xml_objects = "".join(f"<Object><Key>{o['Key']}</Key></Object>" for o in objects)
    xml_body = f"<Delete>{xml_objects}</Delete>"
    resp = await client.rest_request(
        _SERVICE, "POST", bucket, body=xml_body.encode(), params={"delete": ""}
    )
    output_json(xml_to_dict(resp.text))


@app.command("put-bucket-tagging")
def put_bucket_tagging(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    tagging: str = typer.Option(..., "--tagging", help="JSON tagging configuration"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Set bucket tags."""
    asyncio.run(_put_bucket_tagging(bucket, tagging, port))


async def _put_bucket_tagging(bucket: str, tagging_json: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    try:
        parsed = json.loads(tagging_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --tagging: {exc}")
    tag_set = parsed.get("TagSet", [])
    xml_tags = "".join(
        f"<Tag><Key>{t['Key']}</Key><Value>{t['Value']}</Value></Tag>" for t in tag_set
    )
    xml_body = f"<Tagging><TagSet>{xml_tags}</TagSet></Tagging>"
    await client.rest_request(
        _SERVICE, "PUT", bucket, body=xml_body.encode(), params={"tagging": ""}
    )
    output_json({})


@app.command("get-bucket-tagging")
def get_bucket_tagging(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get bucket tags."""
    asyncio.run(_get_bucket_tagging(bucket, port))


async def _get_bucket_tagging(bucket: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    resp = await client.rest_request(_SERVICE, "GET", bucket, params={"tagging": ""})
    output_json(xml_to_dict(resp.text))


@app.command("delete-bucket-tagging")
def delete_bucket_tagging(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete bucket tags."""
    asyncio.run(_delete_bucket_tagging(bucket, port))


async def _delete_bucket_tagging(bucket: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    await client.rest_request(_SERVICE, "DELETE", bucket, params={"tagging": ""})
    output_json({})


@app.command("get-bucket-location")
def get_bucket_location(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get bucket location."""
    asyncio.run(_get_bucket_location(bucket, port))


async def _get_bucket_location(bucket: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    resp = await client.rest_request(_SERVICE, "GET", bucket, params={"location": ""})
    output_json(xml_to_dict(resp.text))


@app.command("put-bucket-policy")
def put_bucket_policy(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    policy: str = typer.Option(..., "--policy", help="JSON policy document"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Set bucket policy."""
    asyncio.run(_put_bucket_policy(bucket, policy, port))


async def _put_bucket_policy(bucket: str, policy_json: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    try:
        json.loads(policy_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --policy: {exc}")
    await client.rest_request(
        _SERVICE,
        "PUT",
        bucket,
        body=policy_json.encode(),
        params={"policy": ""},
        headers={"Content-Type": "application/json"},
    )
    output_json({})


@app.command("get-bucket-policy")
def get_bucket_policy(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get bucket policy."""
    asyncio.run(_get_bucket_policy(bucket, port))


async def _get_bucket_policy(bucket: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    resp = await client.rest_request(_SERVICE, "GET", bucket, params={"policy": ""})
    output_json(json.loads(resp.text))


@app.command("put-bucket-notification-configuration")
def put_bucket_notification_configuration(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    notification_configuration: str = typer.Option(
        ..., "--notification-configuration", help="JSON notification configuration"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Set bucket notification configuration."""
    asyncio.run(_put_bucket_notification_configuration(bucket, notification_configuration, port))


async def _put_bucket_notification_configuration(bucket: str, config_json: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    try:
        parsed = json.loads(config_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --notification-configuration: {exc}")
    xml_parts = ["<NotificationConfiguration>"]
    for config in parsed.get("LambdaFunctionConfigurations", []):
        xml_parts.append("<CloudFunctionConfiguration>")
        xml_parts.append(f"<CloudFunction>{config['LambdaFunctionArn']}</CloudFunction>")
        for event in config.get("Events", []):
            xml_parts.append(f"<Event>{event}</Event>")
        xml_parts.append("</CloudFunctionConfiguration>")
    for config in parsed.get("QueueConfigurations", []):
        xml_parts.append("<QueueConfiguration>")
        xml_parts.append(f"<Queue>{config['QueueArn']}</Queue>")
        for event in config.get("Events", []):
            xml_parts.append(f"<Event>{event}</Event>")
        xml_parts.append("</QueueConfiguration>")
    for config in parsed.get("TopicConfigurations", []):
        xml_parts.append("<TopicConfiguration>")
        xml_parts.append(f"<Topic>{config['TopicArn']}</Topic>")
        for event in config.get("Events", []):
            xml_parts.append(f"<Event>{event}</Event>")
        xml_parts.append("</TopicConfiguration>")
    xml_parts.append("</NotificationConfiguration>")
    xml_body = "".join(xml_parts)
    await client.rest_request(
        _SERVICE, "PUT", bucket, body=xml_body.encode(), params={"notification": ""}
    )
    output_json({})


@app.command("get-bucket-notification-configuration")
def get_bucket_notification_configuration(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get bucket notification configuration."""
    asyncio.run(_get_bucket_notification_configuration(bucket, port))


async def _get_bucket_notification_configuration(bucket: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    resp = await client.rest_request(_SERVICE, "GET", bucket, params={"notification": ""})
    output_json(xml_to_dict(resp.text))


@app.command("put-bucket-website")
def put_bucket_website(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    website_configuration: str = typer.Option(
        ..., "--website-configuration", help="JSON website configuration"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Set bucket website configuration."""
    asyncio.run(_put_bucket_website(bucket, website_configuration, port))


async def _put_bucket_website(bucket: str, config_json: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    try:
        parsed = json.loads(config_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --website-configuration: {exc}")
    xml_parts = ["<WebsiteConfiguration>"]
    index_doc = parsed.get("IndexDocument", {})
    if index_doc:
        suffix = index_doc.get("Suffix", "")
        xml_parts.append(f"<IndexDocument><Suffix>{suffix}</Suffix></IndexDocument>")
    error_doc = parsed.get("ErrorDocument", {})
    if error_doc:
        key = error_doc.get("Key", "")
        xml_parts.append(f"<ErrorDocument><Key>{key}</Key></ErrorDocument>")
    xml_parts.append("</WebsiteConfiguration>")
    xml_body = "".join(xml_parts)
    await client.rest_request(
        _SERVICE, "PUT", bucket, body=xml_body.encode(), params={"website": ""}
    )
    output_json({})


@app.command("get-bucket-website")
def get_bucket_website(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get bucket website configuration."""
    asyncio.run(_get_bucket_website(bucket, port))


async def _get_bucket_website(bucket: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    resp = await client.rest_request(_SERVICE, "GET", bucket, params={"website": ""})
    if resp.status_code == 404:
        exit_with_error("No website configuration found")
    output_json(xml_to_dict(resp.text))


@app.command("delete-bucket-website")
def delete_bucket_website(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete bucket website configuration."""
    asyncio.run(_delete_bucket_website(bucket, port))


async def _delete_bucket_website(bucket: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    await client.rest_request(_SERVICE, "DELETE", bucket, params={"website": ""})
    output_json({})


@app.command("list-parts")
def list_parts(
    bucket: str = typer.Option(..., "--bucket", help="Bucket name"),
    key: str = typer.Option(..., "--key", help="Object key"),
    upload_id: str = typer.Option(..., "--upload-id", help="Upload ID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List parts of a multipart upload."""
    asyncio.run(_list_parts(bucket, key, upload_id, port))


async def _list_parts(bucket: str, key: str, upload_id: str, port: int) -> None:
    client = _client(port)
    try:
        await client.service_port(_SERVICE)
    except Exception as exc:
        exit_with_error(str(exc))
    resp = await client.rest_request(
        _SERVICE, "GET", f"{bucket}/{key}", params={"uploadId": upload_id}
    )
    output_json(xml_to_dict(resp.text))
