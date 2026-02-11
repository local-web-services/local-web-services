// Node.js invoker script for LDK Lambda runtime
// Reads event from stdin, loads handler, invokes, writes result to stdout

const fs = require('fs');

async function main() {
    const handlerSpec = process.env.LDK_HANDLER; // e.g., "index.handler"
    const codePath = process.env.LDK_CODE_PATH;

    // Read event from stdin
    const input = fs.readFileSync('/dev/stdin', 'utf8');
    const event = JSON.parse(input);

    // Parse handler spec: "file.function"
    const lastDot = handlerSpec.lastIndexOf('.');
    const modulePath = handlerSpec.substring(0, lastDot);
    const functionName = handlerSpec.substring(lastDot + 1);

    // Build context from env
    const context = {
        functionName: process.env.AWS_LAMBDA_FUNCTION_NAME || 'local-function',
        functionVersion: '$LATEST',
        memoryLimitInMB: process.env.AWS_LAMBDA_FUNCTION_MEMORY_SIZE || '128',
        logGroupName: `/aws/lambda/${process.env.AWS_LAMBDA_FUNCTION_NAME || 'local-function'}`,
        logStreamName: 'local',
        awsRequestId: process.env.LDK_REQUEST_ID || 'local-request-id',
        invokedFunctionArn: process.env.LDK_FUNCTION_ARN || 'arn:ldk:lambda:local:000000000000:function:local',
        getRemainingTimeInMillis: () => 30000,
    };

    // Load and invoke handler
    const fullPath = require('path').resolve(codePath, modulePath);
    const handler = require(fullPath)[functionName];

    if (!handler) {
        throw new Error(`Handler function '${functionName}' not found in '${modulePath}'`);
    }

    const result = await handler(event, context);

    // Write result to stdout then exit. Explicit exit is required because
    // AWS SDK clients keep connections alive which prevents Node from exiting.
    process.stdout.write(JSON.stringify({result: result}), () => process.exit(0));
}

main().catch(err => {
    process.stdout.write(JSON.stringify({
        error: {
            errorMessage: err.message,
            errorType: err.constructor.name,
            stackTrace: err.stack ? err.stack.split('\n') : []
        }
    }));
    process.exit(1);
});
