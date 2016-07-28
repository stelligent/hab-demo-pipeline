'use strict';

var fs = require('fs');
var CFNRunner = require('cfn-runner');

var baseConfig = './awsConfig.json';
var localConfig = './awsConfig.local.json';

try {
    fs.accessSync(localConfig, fs.F_OK);
    console.log("using local config file: " + localConfig);
    baseConfig = localConfig;
} catch (e) {
    console.log("using default config file: " + baseConfig);
}

var config = JSON.parse(fs.readFileSync(baseConfig));
config.config = baseConfig;
config.template = './cfn/pipeline.json';
var runner = new CFNRunner(config);

var callback = function(err) {
    if (err) {
        console.log(err);
    } else {
        console.log('success');
    }
};

if (process.argv[2] === 'delete') {
    // Delete the stack
    runner.deleteStack(callback);
} else if (process.argv[2] === 'deploy') {
    // Create or update the stack.
    runner.deployStack(callback);
} else {
    console.log("command '" + process.argv[2] + "' is not supported.");
}
