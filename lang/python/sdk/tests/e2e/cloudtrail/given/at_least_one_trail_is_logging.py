"""Given: at least one "cloudtrail" "trail" is logging"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given('at least one "cloudtrail" "trail" is logging')
def at_least_one_trail_is_logging(lws_session):
    CloudtrailTestClient(lws_session).create_trail()
    CloudtrailTestClient(lws_session).start_logging()
