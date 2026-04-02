"""Then: every session token maps to a valid account id"""

from __future__ import annotations

import re

from pytest_bdd import then

_TOKEN_RE = re.compile(r"^lws-acct-(\d{12})-")


@then("every session token maps to a valid account id")
def every_session_token_maps_to_a_valid_account_id(world):
    actual_token = world.get("session_token", "")
    if actual_token:
        actual_match = _TOKEN_RE.match(actual_token)
        assert actual_match is not None, (
            f"Expected session token to match lws-acct-{{account_id}}-* pattern "
            f"but got {actual_token!r}"
        )
