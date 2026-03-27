"""Given: the "AWS" fake already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given('the "AWS" fake already exists')
def aws_fake_already_exists(lws_session):
    AwsFakeTestClient(lws_session).create()
