from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteObject:
    def test_delete_object(self, e2e_port, tmp_path, lws_invoke, assert_invoke):
        # Arrange
        bucket_name = "e2e-del-obj"
        key = "f.txt"
        lws_invoke(["s3api", "create-bucket", "--bucket", bucket_name, "--port", str(e2e_port)])
        body_file = tmp_path / "f.txt"
        body_file.write_text("content")
        lws_invoke(
            [
                "s3api",
                "put-object",
                "--bucket",
                bucket_name,
                "--key",
                key,
                "--body",
                str(body_file),
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "s3api",
                "delete-object",
                "--bucket",
                bucket_name,
                "--key",
                key,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            ["s3api", "list-objects-v2", "--bucket", bucket_name, "--port", str(e2e_port)]
        )
        actual_count = verify.get("KeyCount", 0)
        assert actual_count == 0
