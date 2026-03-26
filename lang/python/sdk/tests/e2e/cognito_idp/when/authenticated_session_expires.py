"""When: an authenticated session expires"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import _skip_if_not_implemented


@when("an authenticated session expires")
def authenticated_session_expires(lws_session, world):
    try:
        world["result"] = None
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        _skip_if_not_implemented(exc)
        world["result"] = None
        world["error"] = exc
