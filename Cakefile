fs = require 'fs'
uglify = require 'uglify-js'
task 'build', "Build all source files", ->
    coffee = require('coffee-script').compile
    fs.readFile './src/sixpack.coffee', 'utf8', (err, data) ->
        throw err if err
        coffeeData = coffee data
        fs.writeFileSync './bin/sixpack', '#!/usr/bin/env node\n' + coffeeData
        {exec} = require 'child_process'
        exec 'chmod +x ./bin/sixpack'
    fs.readFile './src/lemon-soda.coffee', 'utf8', (err, data) ->
        throw err if err
        fs.writeFileSync './js/lemon-soda.js', 
            uglify.minify(coffee(data), fromString: yes).code
