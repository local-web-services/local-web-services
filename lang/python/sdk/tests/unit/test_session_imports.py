"""Smoke tests: verify all public SDK classes can be imported."""

from __future__ import annotations


def test_lws_session_importable():
    from lws_testing import LwsSession  # noqa: F401


def test_lws_session_has_expected_class_methods():
    from lws_testing import LwsSession

    assert callable(LwsSession.from_cdk), "Expected value to be truthy"
    assert callable(LwsSession.from_hcl), "Expected value to be truthy"


def test_lws_session_spec_defaults():
    from lws_testing.session import LwsSession

    # Arrange / Act
    session = LwsSession()

    # Assert — private spec is initialised with empty lists
    assert session._spec["tables"] == [], f'Expected {[]!r} but got {session._spec["tables"]!r}'
    assert session._spec["queues"] == [], f'Expected {[]!r} but got {session._spec["queues"]!r}'
    assert session._spec["buckets"] == [], f'Expected {[]!r} but got {session._spec["buckets"]!r}'
    assert session._spec["topics"] == [], f'Expected {[]!r} but got {session._spec["topics"]!r}'
    assert (
        session._spec["state_machines"] == []
    ), f'Expected {[]!r} but got {session._spec["state_machines"]!r}'
    assert session._spec["secrets"] == [], f'Expected {[]!r} but got {session._spec["secrets"]!r}'
    assert (
        session._spec["parameters"] == []
    ), f'Expected {[]!r} but got {session._spec["parameters"]!r}'


def test_log_capture_importable():
    from lws_testing._logs import LogCapture  # noqa: F401


def test_resource_helpers_importable():
    from lws_testing._resources.dynamodb import DynamoDBHelper  # noqa: F401
    from lws_testing._resources.s3 import S3Helper  # noqa: F401
    from lws_testing._resources.sqs import SQSHelper  # noqa: F401


def test_builders_importable():
    from lws_testing._builders.chaos import ChaosBuilder  # noqa: F401
    from lws_testing._builders.fake import FakeBuilder  # noqa: F401
    from lws_testing._builders.iam import IamBuilder  # noqa: F401


def test_discovery_importable():
    from lws_testing._discovery import cdk, hcl  # noqa: F401
