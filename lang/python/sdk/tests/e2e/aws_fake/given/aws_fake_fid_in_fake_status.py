"""Given: fid in fake_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given("fid in fake_status")
def aws_fake_fid_in_fake_status(lws_session):
    AwsFakeTestClient(lws_session).create()
