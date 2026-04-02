"""Given: the "aws fake" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given('the "aws fake" existed')
def aws_fake_exists(lws_session):
    AwsFakeTestClient(lws_session).create()
