"""CloudTrail wire-protocol HTTP server (JSON / X-Amz-Target)."""

from __future__ import annotations

import json
from typing import Any

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
from lws.providers.cloudtrail.provider import CloudTrailProvider

_logger = get_logger("ldk.cloudtrail")

_TARGET_SUFFIX = "CloudTrail_20131101."

_EXCEPTION_CODES = {
    "TrailAlreadyExistsException": 400,
    "MaximumNumberOfTrailsExceededException": 400,
    "TrailNotFoundException": 404,
}


def _ok(body: Any) -> Response:
    return Response(content=json.dumps(body), media_type="application/json", status_code=200)


def _error(code: str, message: str) -> Response:
    status = _EXCEPTION_CODES.get(code, 400)
    body = {"__type": code, "message": message}
    return Response(content=json.dumps(body), media_type="application/json", status_code=status)


class CloudTrailRouter:
    """Route CloudTrail wire-protocol requests to a ``CloudTrailProvider``."""

    def __init__(self, provider: CloudTrailProvider) -> None:
        self.provider = provider

    async def dispatch(self, request: Request) -> Response:
        """Dispatch an incoming CloudTrail request to the appropriate handler."""
        target = request.headers.get("x-amz-target", "")
        if _TARGET_SUFFIX not in target:
            return _error("InvalidAction", f"Unknown target: {target}")
        action = target.split(_TARGET_SUFFIX, 1)[1]
        try:
            body = await request.json()
        except Exception:  # pylint: disable=broad-except
            body = {}
        handler = self._handlers().get(action)
        if handler is None:
            return _error("InvalidAction", f"CloudTrail operation '{action}' not implemented")
        return await handler(body)

    def _handlers(self) -> dict:
        return {
            "CreateTrail": self._create_trail,
            "UpdateTrail": self._update_trail,
            "DeleteTrail": self._delete_trail,
            "GetTrail": self._get_trail,
            "GetTrailStatus": self._get_trail_status,
            "ListTrails": self._list_trails,
            "StartLogging": self._start_logging,
            "StopLogging": self._stop_logging,
            "LookupEvents": self._lookup_events,
        }

    async def _create_trail(self, body: dict) -> Response:
        name = body.get("Name", "")
        bucket = body.get("S3BucketName", "")
        prefix = body.get("S3KeyPrefix", "")
        if not name or not bucket:
            return _error(
                "InvalidParameterCombinationException", "Name and S3BucketName are required"
            )
        try:
            trail = self.provider.create_trail(name, bucket, prefix)
        except ValueError as exc:
            code = str(exc).split(":", maxsplit=1)[0].strip()
            return _error(code, str(exc))
        return _ok(trail.to_api_dict())

    async def _update_trail(self, body: dict) -> Response:
        name = body.get("Name", "")
        try:
            trail = self.provider.update_trail(
                name,
                s3_bucket=body.get("S3BucketName"),
                s3_key_prefix=body.get("S3KeyPrefix"),
                eventbridge_bus_arn=body.get("CloudWatchLogsLogGroupArn"),
            )
        except KeyError as exc:
            return _error("TrailNotFoundException", str(exc))
        return _ok(trail.to_api_dict())

    async def _delete_trail(self, body: dict) -> Response:
        name = body.get("Name", "")
        try:
            self.provider.delete_trail(name)
        except KeyError as exc:
            return _error("TrailNotFoundException", str(exc))
        return _ok({})

    async def _get_trail(self, body: dict) -> Response:
        name = body.get("Name", "")
        try:
            trail = self.provider.get_trail(name)
        except KeyError as exc:
            return _error("TrailNotFoundException", str(exc))
        return _ok({"Trail": trail.to_api_dict()})

    async def _get_trail_status(self, body: dict) -> Response:
        name = body.get("Name", "")
        try:
            trail = self.provider.get_trail(name)
        except KeyError as exc:
            return _error("TrailNotFoundException", str(exc))
        return _ok(trail.to_status_dict())

    async def _list_trails(self, _body: dict) -> Response:
        trails = self.provider.list_trails()
        trail_list = [
            {"TrailARN": t.arn, "Name": t.name, "HomeRegion": "us-east-1"} for t in trails
        ]
        return _ok({"Trails": trail_list})

    async def _start_logging(self, body: dict) -> Response:
        name = body.get("Name", "")
        try:
            self.provider.start_logging(name)
        except KeyError as exc:
            return _error("TrailNotFoundException", str(exc))
        return _ok({})

    async def _stop_logging(self, body: dict) -> Response:
        name = body.get("Name", "")
        try:
            self.provider.stop_logging(name)
        except KeyError as exc:
            return _error("TrailNotFoundException", str(exc))
        return _ok({})

    async def _lookup_events(self, body: dict) -> Response:
        result = await self.provider.lookup_events(
            lookup_attributes=body.get("LookupAttributes"),
            start_time=body.get("StartTime"),
            end_time=body.get("EndTime"),
            max_results=int(body.get("MaxResults", 50)),
            next_token=body.get("NextToken"),
        )
        return _ok(result)


def create_cloudtrail_app(
    provider: CloudTrailProvider,
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the CloudTrail wire protocol."""
    app = FastAPI()
    if aws_fake is not None:
        app.add_middleware(AwsOperationFakeMiddleware, fake_config=aws_fake, service="cloudtrail")
    add_iam_auth_middleware(app, "cloudtrail", iam_auth, ErrorFormat.JSON)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="cloudtrail")

    router = CloudTrailRouter(provider)
    app.add_api_route("/", router.dispatch, methods=["POST"])
    app.add_api_route("/{path:path}", router.dispatch, methods=["POST"])
    return app
