"""Given: the "AWS" fake exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given('the "AWS" fake exists')
def aws_fake_exists(lws_session):
    AwsFakeTestClient(lws_session).create()
