"""Given: the tag association is not active"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient
from ..constants import TEST_PARAM


@given("the tag association is not active")
def tag_association_not_active(lws_session, world):
    try:
        SsmTestClient(lws_session).delete_parameter(Name=TEST_PARAM)
    except Exception:
        pass
    lws_session.lifecycle("ssm").create_dwell_ms(5000).apply()
    SsmTestClient(lws_session).create_param()
    world["result"] = None
    world["error"] = None
