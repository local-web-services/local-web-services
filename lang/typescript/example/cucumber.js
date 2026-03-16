module.exports = {
  default: {
    require: ['tests/acceptance-tests/support/world.ts', 'tests/acceptance-tests/steps/**/*.ts'],
    requireModule: ['ts-node/register'],
    paths: ['../../../lang/specification/example/features/**/*.feature'],
    format: ['progress'],
    timeout: 60000,
  }
};
