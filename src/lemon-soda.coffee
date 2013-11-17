# Unpack json files created by sixpack.coffee and create css classes for them automatically

@LemonSoda = new class
    load: (spritesURL) => getJSON spritesURL, (sprites) ->
        defer -> LemonSoda.processSprites sprites

    #Process sprites incrementally, blocking only for short periods
    processSprites: (sprites) ->
        maxBlockTime = 50 #don't block for more than 50ms at a time
        #Time when started
        start = new Date
        for name, sprite of sprites
            addRule ".#{name}", "
            background: url(#{sprite.uri}) no-repeat;
            width:#{sprite.w}px;
            height:#{sprite.h}px;"
            delete sprites[name]
            #Defer if time limit exceeded
            if (new Date) - start >= maxBlockTime
                #Defer continued execution
                defer -> LemonSoda.processSprites sprites
                break
        

defer = (cb) -> setTimeout cb, 1

#ajax helper
getJSON = (url, cb) ->
    req = new XMLHttpRequest
    req.onload = -> cb JSON.parse @responseText
    req.open 'get', url, yes
    req.send()

styleRoot = document.head ? document.body
styleRoot.appendChild style = document.createElement 'style'
sheet = style.sheet
if sheet?
    if sheet.addRule
        addRule = (sel, rule) -> sheet.addRule sel, rule
    else if sheet.insertRule
        addRule = (sel, rule) -> sheet.insertRule "#{sel} { #{rule} }", 0
#Final fallback for no css options
unless addRule?
    addRule = (sel, rule) -> style.innerText += "#{sel} { #{rule} }"