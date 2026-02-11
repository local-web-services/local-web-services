from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestPutObject:
    def test_put_object(self, e2e_port, tmp_path, lws_invoke, assert_invoke):
        # Arrange
        bucket_name = "e2e-put-obj"
        key = "file.txt"
        expected_content = "upload content"
        lws_invoke(["s3api", "create-bucket", "--bucket", bucket_name, "--port", str(e2e_port)])
        body_file = tmp_path / "upload.txt"
        body_file.write_text(expected_content)

        # Act
        result = runner.invoke(
            app,
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
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        outfile = tmp_path / "verify.txt"
        verify_result = runner.invoke(
            app,
            [
                "s3api",
                "get-object",
                "--bucket",
                bucket_name,
                "--key",
                key,
                str(outfile),
                "--port",
                str(e2e_port),
            ],
        )
        assert verify_result.exit_code == 0, verify_result.output
        actual_content = outfile.read_text()
        assert actual_content == expected_content
