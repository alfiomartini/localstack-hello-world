const { transform } = require("esbuild");

module.exports = {
  testEnvironment: 'node',
  collectCoverage: true,
  coverageDirectory: 'coverage',
  testMatch: ['**/src/**/*.test.js'],
  verbose: true,
  transform: {
    '^.+\\.js$': 'babel-jest', // Use Babel to transform ES modules
  },
}