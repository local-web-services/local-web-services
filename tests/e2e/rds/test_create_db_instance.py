from __future__ import annotations

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateDBInstance:
    def test_create_db_instance(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        db_id = "e2e-rds-create-instance"
        expected_db_id = db_id

        # Act
        result = runner.invoke(
            app,
            [
                "rds",
                "create-db-instance",
                "--db-instance-identifier",
                db_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["rds", "describe-db-instances", "--port", str(e2e_port)])
        ids = [i["DBInstanceIdentifier"] for i in verify["DBInstances"]]
        assert expected_db_id in ids

    def test_create_and_delete_db_instance(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        db_id = "e2e-rds-create-del"
        lws_invoke(
            [
                "rds",
                "create-db-instance",
                "--db-instance-identifier",
                db_id,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "rds",
                "delete-db-instance",
                "--db-instance-identifier",
                db_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["rds", "describe-db-instances", "--port", str(e2e_port)])
        ids = [i["DBInstanceIdentifier"] for i in verify["DBInstances"]]
        assert db_id not in ids

    def test_describe_db_instances(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        db_id = "e2e-rds-describe"
        lws_invoke(
            [
                "rds",
                "create-db-instance",
                "--db-instance-identifier",
                db_id,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "rds",
                "describe-db-instances",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["rds", "describe-db-instances", "--port", str(e2e_port)])
        ids = [i["DBInstanceIdentifier"] for i in verify["DBInstances"]]
        assert db_id in ids
