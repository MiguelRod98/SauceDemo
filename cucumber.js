module.exports = {
  default: {
    paths: ['tests/features/**/*.feature'],
    requireModule: ['ts-node/register'],
    require: ['tests/support/**/*.ts', 'tests/steps/**/*.ts'],
    format: ['progress', 'html:reports/cucumber-report.html', 'json:reports/cucumber-report.json'],
    formatOptions: { snippetInterface: 'async-await' },
    parallel: 5
  },
  chromium: {
    paths: ['tests/features/**/*.feature'],
    requireModule: ['ts-node/register'],
    require: ['tests/support/**/*.ts', 'tests/steps/**/*.ts'],
    format: ['progress', 'html:reports/chromium-report.html', 'json:reports/chromium-report.json'],
    formatOptions: { snippetInterface: 'async-await' },
    parallel: 5
  },
  firefox: {
    paths: ['tests/features/**/*.feature'],
    requireModule: ['ts-node/register'],
    require: ['tests/support/**/*.ts', 'tests/steps/**/*.ts'],
    format: ['progress', 'html:reports/firefox-report.html', 'json:reports/firefox-report.json'],
    formatOptions: { snippetInterface: 'async-await' },
    parallel: 5
  },
  msedge: {
    paths: ['tests/features/**/*.feature'],
    requireModule: ['ts-node/register'],
    require: ['tests/support/**/*.ts', 'tests/steps/**/*.ts'],
    format: ['progress', 'html:reports/msedge-report.html', 'json:reports/msedge-report.json'],
    formatOptions: { snippetInterface: 'async-await' },
    parallel: 5
  }
};
