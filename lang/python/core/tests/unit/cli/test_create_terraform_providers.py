"""Tests for Terraform provider creation in ldk dev."""

from __future__ import annotations

from lws.config.loader import LdkConfig


class TestCreateTerraformProviders:
    def test_creates_all_http_providers(self, tmp_path) -> None:
        from lws.cli.ldk import _create_terraform_providers

        config = LdkConfig(port=3000)
        providers, ports, _chaos_configs, _, _fake_configs = _create_terraform_providers(
            config, tmp_path
        )

        assert (
            "__dynamodb_http__" in providers
        ), f'Expected {"__dynamodb_http__"!r} to be in {providers!r}'
        assert "__sqs_http__" in providers, f'Expected {"__sqs_http__"!r} to be in {providers!r}'
        assert "__s3_http__" in providers, f'Expected {"__s3_http__"!r} to be in {providers!r}'
        assert "__sns_http__" in providers, f'Expected {"__sns_http__"!r} to be in {providers!r}'
        assert (
            "__events_http__" in providers
        ), f'Expected {"__events_http__"!r} to be in {providers!r}'
        assert (
            "__stepfunctions_http__" in providers
        ), f'Expected {"__stepfunctions_http__"!r} to be in {providers!r}'
        assert (
            "__cognito-idp_http__" in providers
        ), f'Expected {"__cognito-idp_http__"!r} to be in {providers!r}'
        assert (
            "__apigateway_http__" in providers
        ), f'Expected {"__apigateway_http__"!r} to be in {providers!r}'
        assert (
            "__lambda_http__" in providers
        ), f'Expected {"__lambda_http__"!r} to be in {providers!r}'
        assert "__iam_http__" in providers, f'Expected {"__iam_http__"!r} to be in {providers!r}'
        assert "__sts_http__" in providers, f'Expected {"__sts_http__"!r} to be in {providers!r}'

    def test_port_allocation(self, tmp_path) -> None:
        from lws.cli.ldk import _create_terraform_providers

        # Arrange
        expected_dynamodb_port = 4001
        expected_sqs_port = 4002
        expected_s3_port = 4003
        expected_sns_port = 4004
        expected_eventbridge_port = 4005
        expected_stepfunctions_port = 4006
        expected_cognito_port = 4007
        expected_apigateway_port = 4008
        expected_lambda_port = 4009
        expected_iam_port = 4010
        expected_sts_port = 4011
        config = LdkConfig(port=4000)

        # Act
        _, ports, _chaos_configs, _, _fake_configs = _create_terraform_providers(config, tmp_path)

        # Assert
        assert (
            ports["dynamodb"] == expected_dynamodb_port
        ), f'Expected {expected_dynamodb_port!r} but got {ports["dynamodb"]!r}'
        assert (
            ports["sqs"] == expected_sqs_port
        ), f'Expected {expected_sqs_port!r} but got {ports["sqs"]!r}'
        assert (
            ports["s3"] == expected_s3_port
        ), f'Expected {expected_s3_port!r} but got {ports["s3"]!r}'
        assert (
            ports["sns"] == expected_sns_port
        ), f'Expected {expected_sns_port!r} but got {ports["sns"]!r}'
        assert (
            ports["events"] == expected_eventbridge_port
        ), f'Expected {expected_eventbridge_port!r} but got {ports["events"]!r}'
        assert (
            ports["stepfunctions"] == expected_stepfunctions_port
        ), f'Expected {expected_stepfunctions_port!r} but got {ports["stepfunctions"]!r}'
        assert (
            ports["cognito-idp"] == expected_cognito_port
        ), f'Expected {expected_cognito_port!r} but got {ports["cognito-idp"]!r}'
        assert (
            ports["apigateway"] == expected_apigateway_port
        ), f'Expected {expected_apigateway_port!r} but got {ports["apigateway"]!r}'
        assert (
            ports["lambda"] == expected_lambda_port
        ), f'Expected {expected_lambda_port!r} but got {ports["lambda"]!r}'
        assert (
            ports["iam"] == expected_iam_port
        ), f'Expected {expected_iam_port!r} but got {ports["iam"]!r}'
        assert (
            ports["sts"] == expected_sts_port
        ), f'Expected {expected_sts_port!r} but got {ports["sts"]!r}'
