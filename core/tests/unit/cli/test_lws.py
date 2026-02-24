"""Unit tests for the lws CLI entry point."""

from __future__ import annotations


class TestLwsApp:
    """Tests for the lws Typer app."""

    def test_app_has_service_commands(self):
        from typer.testing import CliRunner

        from lws.cli.lws import app

        runner = CliRunner()
        result = runner.invoke(app, ["--help"])
        assert "apigateway" in result.output
        assert "stepfunctions" in result.output
        assert "sqs" in result.output
        assert "sns" in result.output
        assert "s3api" in result.output
        assert "dynamodb" in result.output
        assert "events" in result.output
        assert "cognito-idp" in result.output

    def test_apigateway_subcommands(self):
        from typer.testing import CliRunner

        from lws.cli.lws import app

        runner = CliRunner()
        result = runner.invoke(app, ["apigateway", "--help"])
        assert "test-invoke-method" in result.output

    def test_stepfunctions_subcommands(self):
        from typer.testing import CliRunner

        from lws.cli.lws import app

        runner = CliRunner()
        result = runner.invoke(app, ["stepfunctions", "--help"])
        assert "start-execution" in result.output
        assert "describe-execution" in result.output
        assert "list-executions" in result.output
        assert "list-state-machines" in result.output
        assert "create-state-machine" in result.output
        assert "delete-state-machine" in result.output
        assert "describe-state-machine" in result.output

    def test_sqs_subcommands(self):
        from typer.testing import CliRunner

        from lws.cli.lws import app

        runner = CliRunner()
        result = runner.invoke(app, ["sqs", "--help"])
        assert "send-message" in result.output
        assert "receive-message" in result.output
        assert "delete-message" in result.output
        assert "get-queue-attributes" in result.output
        assert "create-queue" in result.output
        assert "delete-queue" in result.output
        assert "list-queues" in result.output
        assert "purge-queue" in result.output

    def test_dynamodb_subcommands(self):
        from typer.testing import CliRunner

        from lws.cli.lws import app

        runner = CliRunner()
        result = runner.invoke(app, ["dynamodb", "--help"])
        assert "put-item" in result.output
        assert "get-item" in result.output
        assert "delete-item" in result.output
        assert "scan" in result.output
        assert "query" in result.output
        assert "create-table" in result.output
        assert "delete-table" in result.output
        assert "describe-table" in result.output
        assert "list-tables" in result.output

    def test_s3api_subcommands(self):
        from typer.testing import CliRunner

        from lws.cli.lws import app

        runner = CliRunner()
        result = runner.invoke(app, ["s3api", "--help"])
        assert "put-object" in result.output
        assert "get-object" in result.output
        assert "delete-object" in result.output
        assert "list-objects-v2" in result.output
        assert "head-object" in result.output
        assert "create-bucket" in result.output
        assert "delete-bucket" in result.output
        assert "head-bucket" in result.output
        assert "list-buckets" in result.output

    def test_sns_subcommands(self):
        from typer.testing import CliRunner

        from lws.cli.lws import app

        runner = CliRunner()
        result = runner.invoke(app, ["sns", "--help"])
        assert "publish" in result.output
        assert "list-topics" in result.output
        assert "list-subscriptions" in result.output
        assert "create-topic" in result.output
        assert "delete-topic" in result.output
        assert "subscribe" in result.output

    def test_events_subcommands(self):
        from typer.testing import CliRunner

        from lws.cli.lws import app

        runner = CliRunner()
        result = runner.invoke(app, ["events", "--help"])
        assert "put-events" in result.output
        assert "list-rules" in result.output
        assert "create-event-bus" in result.output
        assert "delete-event-bus" in result.output
        assert "list-event-buses" in result.output
        assert "put-rule" in result.output
        assert "delete-rule" in result.output

    def test_cognito_subcommands(self):
        from typer.testing import CliRunner

        from lws.cli.lws import app

        runner = CliRunner()
        result = runner.invoke(app, ["cognito-idp", "--help"])
        assert "sign-up" in result.output
        assert "confirm-sign-up" in result.output
        assert "initiate-auth" in result.output
        assert "create-user-pool" in result.output
        assert "delete-user-pool" in result.output
        assert "list-user-pools" in result.output
        assert "describe-user-pool" in result.output
