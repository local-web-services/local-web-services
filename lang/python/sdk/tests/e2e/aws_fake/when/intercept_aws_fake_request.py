"""When: a request matching an "aws fake" "operation" is intercepted"""

from __future__ import annotations

from pytest_bdd import when


@when('a request matching an "aws fake" "operation" is intercepted')
def intercept_aws_fake_request(lws_session, world):
    try:
        world["result"] = lws_session.client("dynamodb").list_tables()
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
