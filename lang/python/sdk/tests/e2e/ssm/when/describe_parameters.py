"""When: parameters are described"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SsmTestClient


@when("parameters are described")
def describe_parameters(lws_session, world):
    try:
        resp = SsmTestClient(lws_session).describe_parameters()
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
