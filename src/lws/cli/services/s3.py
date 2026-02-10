"""``lws s3api`` sub-commands."""

from __future__ import annotations

import asyncio
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
