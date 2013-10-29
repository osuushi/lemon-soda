###
Pack a directory of sprites into a JSON file of data URIs.
###

fs = require 'fs'
path = require 'path'
dir = require 'node-dir'
opt = require 'optimist'
gm = require('gm').subClass imageMagick: true
opt = opt.usage """
Pack a directory full of images into a json file.

Usage:
    $0 inputDirectory outputPath [-p class prefix]
"""
argv = opt.demand(2)
.describe('p', "Prefix for generated CSS classes")
.default('p', "sprite")
.argv
[inPath, outPath] = argv._
prefix = argv.p

getMimeType = (name) ->
    extension = name.substring name.lastIndexOf('.') + 1
    switch extension.toLowerCase()
        when 'png'
            'image/png'
        when 'jpg'
            'image/jpeg'
        when 'jpeg'
            'image/jpeg'
        when 'gif'
            'image/gif'

#Read all files from the directory
result = {}
count = 0
waitCount = 0
wait = -> waitCount++
done = -> 
    waitCount--
    finishUp() unless waitCount

wait()
dir.readFiles inPath, {
        match: /\.(?:png|jpg|jpeg|gif)$/i
        encoding: 'base64'
    }, (err, content, filename, next) ->
        throw err if err
        #Generate the class name
        #get the relative path
        name = path.relative inPath, filename
        #remove extension
        name = name.substring 0, name.lastIndexOf '.'
        #replace non-word characters with dashes
        name = "#{prefix}-#{name.replace /\W/g, '-'}"
        name = name.replace /-*$/, '' #strip trailing hyphens
        name = name.replace /-+/, '-' #condense multiple hyphens
        sprite = {}
        #Create the data URI
        sprite.uri = "data:#{getMimeType filename};base64," + content

        #Get the size
        wait()
        gm(filename).size (err, size) ->
            throw err if err
            sprite.w = size.width
            sprite.h = size.height
            done()
        result[name] = sprite
        count++
        next()
    , (err) ->
        throw err if err
        done()

finishUp = ->
    #JSON the result and write it
    fs.writeFile outPath, JSON.stringify result
    console.log "Finished packing #{count} images into #{outPath}"
