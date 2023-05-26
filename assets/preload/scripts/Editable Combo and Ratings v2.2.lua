-- Settings (Player) --
    
    -- you angered him. | Swords 8/24/2022

    local visible = true  -- Show it?

    local pixel = false   -- Pixel check


    -- I'm not supporting this here anymore, if you like this style then go install the standalone version:
    -- https://gamebanana.com/tools/10174
    local unholyStyle = false  
    -- Ratings and numbers will be under the notes (Swapped for downscroll) !WILL FORCE TO HUD AND DISABLE onPlayerCombo! 


    local directNums = false   -- For unholyStyle | Combo numbers appear under ratings 

    local showComboThing = true           -- Show the "unused" combo thing

    local foreverComboCount = true       -- Shows combo number like forever engine 
    local countMisses = true              -- forever engine is pretty cool

    local missSprite = true               -- Show a thing when you fuck up

    local imagePath = ''
    -- path to images | Will be used for all proceeding images 
          
    local ratingGrab = {'sick', 'good', 'bad', 'shit'} -- What it'll grab
    local numPrefix  = 'num'               
    local numSuffix  = ''
    local ratingTime = ''

    local combType   = 'combo'             -- For swappin with pixel 'n such
    local missType   = 'miss'

    local constantGameCam = true               -- Keeps things hooked onto characters

    local defaultPosRating   = {450, 280}      -- Positions for ratings when not on player combo | HUD 'n Other cam | default numbers: 450, 280
    local defaultPosNum      = {450, 400}                                                                     --| default numbers: 450, 400

    local defaultPosRateGame = {nil, nil}      -- Position for game cam | Defaults to my preset if untouched 
    local defaultPosNumGame  = {nil, nil}

    local comboThngPos       = {nil, nil}      -- You alreaady know
    local comboThngPosGame   = {nil, nil} 
    local cSpriteOffsets     = {470, 390}      -- For onPlayerCombo shit

    local ratingScale        = {0.69, 0.69}    -- DEFAULT: rating = 0.69, 0.69 | num = 0.5, 0.5
    local numScale           = {0.5, 0.5}      -- IF you mess with this, be sure to adjust it's spacing down below as they might overlap
    local combThingScale     = {0.58, 0.58}
    local missScale          = {0.69, 0.69}    -- fuck it

    local onPlayerCombo = true  -- If it'll show on where the player has the ratings offsets 
    --| Make sure RATINGS is tied to HUD

    local camSet = 'game'       -- Should it be on the Hud or Game or Other?  Hud | Game | Other  
    -- (NOTICE: for game cam, I have its default set to rely on bfs/opponents position)

-- Settings (Opponent) --

    local visibleOp = false   -- Show it?

    local pixelOp = false

    local foreverComboCountOp = true

    local imagePathOp  = ''
    local ratingGrabOp = {'sick', 'good', 'bad', 'shit'}
    local numPrefixOp  = 'num'
    local numSuffixOp  = ''

    local defaultPosRatingOp   = {350, 440}   -- Positions it'll use | default numbers: 350, 440
    local defaultPosNumOp      = {380, 535}                           --| default numbers: 380, 535

    local defaultPosRateGameOp = {nil, nil} -- Position for game cam
    local defaultPosNumGameOp  = {nil, nil}

    local ratingScaleOp        = {0.69, 0.69} -- DEFAULT: rating = 0.69, 0.69 | num = 0.5, 0.5
    local numScaleOp           = {0.5, 0.5}

    local onPlayerComboOp = false

    local camSetOp = 'game'  -- Hud | Game | Other

    local randGoods = false -- Makes some goods occasionally appear 
    local randBads  = false -- Makes some bads occasionally appear         | Should you turn all these on? Probably not
    local randShits = false -- Makes some shits occasionally appear 
    local chanceGood
    local chanceBad 
    local chanceShit

-- Modes (Player) --

    local simpleMode     = false -- Only 1 set of numbers and ratings are shown at a time | Helps prevent lag

    local stationaryMode = false -- Prevent the Rating hop | Simple mode recommended

    local hideRating     = false  -- Hides rating, not numbers (who coulda guessed)
    local hideNums       = false  -- Hides numbers, not ratings (who coulda guessed)

    local colorRatings   = false  -- Color the ratings based on which you get, Sick is blue, good is green, etc
    local colorSyncing   = false -- Rating takes color of direction pressed | Overwrites colorRatings
    local colorFade      = false  -- Fades color back to baseColor's value
    local fcColorRating  = false -- Colors Ratings based of FC level, like andromeda!!! (Turn off others, they overide this)

    local colorNumbers   = false -- Same as above, but for numbers
    local colorSyncNums  = false
    local colorFadeNums  = false
    local fcColorNums    = false -- Colors numbers based of FC level, like andromeda!!! (Turn off others, they overide this)

    local combColor      = false
    local combColorFade  = false

    local COLORSWAP      = false -- color swap shader (6.1 and above) | color swap yo sick ratin (bit weird)

-- Modes (Opponent) --

    local simpleModeOp     = false

    local stationaryModeOp = false

    local hideRatingOp     = false 
    local hideNumsOp       = false 

    local colorRatingsOp   = true -- Ratings based on which you get
    local colorSyncingOp   = false -- Rating takes color of direction pressed 
    local colorFadeOp      = true  -- Fade to base

    local colorNumbersOp   = false -- Same as above, but for numbers
    local colorSyncNumsOp  = false
    local colorFadeNumsOp  = true

-- Colors --

    -- Best with base ratings --
    local ratingColors = {'68fafc', '48f048', 'fffecb', 'ffffff'} 

    local colorSync = {'c24b99', '68fafc', '12fa05', 'f9393f'} 

    local combUse -- Uses rating colors, no unique value

    -- Opponent --

    local ratingColorsOp = {'68fafc', '48f048', 'fffecb', 'ffffff'}     

    local colorSyncOp = {'c24b99', '68fafc', '12fa05', 'f9393f'} 

-- ANIMATED RATINGS Settings --
    local ANIMATED = false        -- Uses rating settings from up there
    local ANIMATEDOP = false

        -- If your ratings are all seperate. if not, just name them all the same
        local fileNames = {'ratings/testRating', 'ratings/testRating', 'ratings/testRating', 'ratings/testRating'}         
        local animNames = {'sick_', 'good_', 'bad_', 'shit_'}  -- Names of animations on .xml
        local animFrameRate = 60

        local animRatePos = {450, 280}
        local animRatePosGame = {nil, nil}
        local animRateOffsts = {490, 260}   -- If "onPlayerCombo" and its not quite where you want
        local animRatScale = {4, 4}

        local veloctitty = true             -- Should it hop like the regular ratings
        local ratPixl = true                -- Is the rating pixelly
        local colorAnim = false             -- Color it like regular
        local singleAnim = false            -- Only one rating at a time
        local animFade = true               -- Should it fade like regular ratings
            local initDelay = 0.2           -- Incase your rating fades before it completes the animation (How long it shows before the fade)
        --------------------------------------------------------------------------------------------------------------------------------------
        local fileNamesOp = {'ratings/testRating', 'ratings/testRating', 'ratings/testRating', 'ratings/testRating'}         
        local animNamesOp = {'sick_', 'good_', 'bad_', 'shit_'}
        local animFrameRateOp = 60

        local animRatePosOp = {350, 440}
        local animRatePosGameOp = {nil, nil}
        local animRateOffstsOp = {490, 260}
        local animRatScaleOp = {4, 4}

        local veloctittyOp = true          
        local ratPixlOp = true             
        local colorAnimOp = false          
        local singleAnimOp = false         
        local animFadeOp = true            
            local initDelayOp = 0.2

-- Dont touch these unless you know what you're doing | I don't sadly :(
    local thous = false
    local eh = 0         -- Make the sprites load in the way it does
    local notePositions = {}
    local hmm = ''
    ---
    local fakeCombo = 0
    local thousOp = false
    local ehOp = 0
    local hmmOp = ''
    --
    local once = false -- for said option
    local onceOp = false
    local brokeCombo = nil -- only one set of 0's will appear if you miss more than 1 time in a row

--------------------------------------------------------------------------|The Code Shit|---------------------------------------------------------------------------------------------
-----------------------------------------------------------------------|By Unholywanderer04|------------------------------------------------------------------------------------------

function onDestroy()
    --setPropertyFromClass('ClientPrefs', 'hideHud', false) -- So the stupid thing actually (hopefully) unhides once you complete a song >:(
end

function onCreatePost()
    if COLORSWAP then
        addHaxeLibrary('OverlayShader')
        addHaxeLibrary('ColorSwap')
        
        runHaxeCode('lol = new ColorSwap();')
        if not lowQuality and not simpleMode then
            for i = 0, 100 do -- makes all 100 sicks to add color swap onto | stupid, very really extremely stupid
                makeLuaSprite('sickly' .. i, imagePath .. ratingGrab[1], 0, 0)
            end
        end
    end

    if getPropertyFromClass('PlayState', 'isPixelStage') then
        pixel = true
        pixelOp = true

        cSpriteOffsets[2] = 400
    end
   
    -- Pixel shit, move this if you're gonna do sumthin wacky --
    -- But if it's for setting a stage, like the school, just keep it here --

    if pixel then 
        imagePath = 'pixelUI/'

        ratingGrab = {'sick-pixel', 'good-pixel', 'bad-pixel', 'shit-pixel'}
        ratingScale = {5, 5}

        numSuffix = '-pixel'
        numScale = {5.5, 5.5}

        defaultPosRateGame = {getProperty('gf.x') + 300, getProperty('gf.y') + 50}
        defaultPosNumGame = {getProperty('gf.x') + 300, getProperty('gf.y') + 150}
    
        combType = 'combo-pixel'
        missType = 'miss-pixel'
        combThingScale = {4, 4}

        colorSync = {'e276ff', '3dcaff', '71e300', 'ff884e'}

        ratingColors[1] = '3dcaff'
        ratingColors[2] = '71e300'
    end

    if pixelOp then
        imagePathOp = 'pixelUI/'

        ratingGrabOp = {'sick-pixel', 'good-pixel', 'bad-pixel', 'shit-pixel'}
        ratingScaleOp = {5, 5}

        numSuffixOp = '-pixel'
        numScaleOp = {5.5, 5.5}

        defaultPosRateGameOp = {getProperty('gf.x') - 150, getProperty('gf.y') + 150}
        defaultPosNumGameOp = {getProperty('gf.x') - 150, getProperty('gf.y') + 250}

        colorSyncOp = {'e276ff', '3dcaff', '71e300', 'ff884e'}

        ratingColorsOp[1] = '3dcaff'
        ratingColorsOp[2] = '71e300'
    end

    -- Rating check --
    if defaultPosRateGame[1] == nil and defaultPosRateGame[2] == nil then
        defaultPosRateGame = {getProperty('boyfriend.x') - 100, getProperty('boyfriend.y') - 100} end
         
    if defaultPosRateGameOp[1] == nil and defaultPosRateGameOp[2] == nil then
        defaultPosRateGameOp = {getProperty('dad.x') + 370, getProperty('dad.y') + 150} end


    -- Number check --
    if defaultPosNumGame[1] == nil and defaultPosNumGame[2] == nil then
        defaultPosNumGame = {defaultPosRateGame[1] + 30, defaultPosRateGame[2] + 100} end

    if defaultPosNumGameOp[1] == nil and defaultPosNumGameOp[2] == nil then
        defaultPosNumGameOp = {defaultPosRateGameOp[1] + 30, defaultPosRateGameOp[2] + 100} end

    -- Animated --
    if animRatePosGame[1] == nil and animRatePosGame[2] == nil then
        animRatePosGame = {getProperty('boyfriend.x') - 100, getProperty('boyfriend.y') - 100} end

    if animRatePosGameOp[1] == nil and animRatePosGameOp[2] == nil then
        animRatePosGameOp = {getProperty('dad.x') + 370, getProperty('dad.y') + 150} end


    if showComboThing then
        if comboThngPos[1] == nil and comboThngPos[2] == nil then
            comboThngPos = {defaultPosNum[1] + 30, defaultPosNum[2]} end

        if comboThngPosGame[1] == nil and comboThngPosGame[2] == nil then
            comboThngPosGame = {defaultPosNumGame[1] + 30, defaultPosNumGame[2]} end
    end

    if unholyStyle then
        onPlayerCombo = false
        camSet = 'hud'

        if pixel then
            ratingScale = {2.35, 2.35}
            numScale = {2.7, 2.7}
        else
            ratingScale = {0.35, 0.35}
            numScale = {0.3, 0.3}
        end
        combThingScale = {0, 0}
    end

    if visible == true then -- getting rid of this crashes the game??? alright????
        --setPropertyFromClass('ClientPrefs', 'hideHud', true)
    end
end

local begin = false
function onUpdate(elapsed)
    if visible then
        --setPropertyFromClass('ClientPrefs', 'hideHud', true)
    elseif not visible then
        --setPropertyFromClass('ClientPrefs', 'hideHud', false)
    end

    if not begin then -- initial note thing, constantly gets note pos until you hit a note
        for i = 0, 3 do
           lolX = getPropertyFromGroup('playerStrums', i, 'x')
           lolY = getPropertyFromGroup('playerStrums', i, 'y')
           notePositions[i] = {x = lolX, y = lolY}
        end
    end

    if unholyStyle then
       defaultPosRating[1] = notePositions[0].x -- why not?
       defaultPosNum[1] = notePositions[0].x
        
        if downscroll then
            if not directNums then
                defaultPosNum[1] = (getPropertyFromGroup('playerStrums', 1, 'x' ) + 45)
                defaultPosNum[2] = (getPropertyFromGroup('playerStrums', 0, 'y') - 120)
            end
        else
            if not directNums then
                defaultPosNum[1] = (getPropertyFromGroup('playerStrums', 1, 'x') + 45)
                defaultPosNum[2] = (getPropertyFromGroup('playerStrums', 0, 'y') + 180) 
            end
        end
    end

    if constantGameCam then
        if camSet == 'game' then -- no point in doing it if not on game cam
            bfPos = getProperty('boyfriend.positionArray')

            if not pixel then -- idk man
                bf1 = bfPos[1] + (getProperty('boyfriend.x') - 100)
                bf2 = getMidpointY('boyfriend') - 300
            else
                bf1 =  bfPos[1] + (getMidpointX('boyfriend') - 220)
                bf2 = -bfPos[2] + (getMidpointY('boyfriend') - 50)
            end

            defaultPosRateGame   = {bf1, bf2}
            defaultPosNumGame    = {defaultPosRateGame[1] + 30, defaultPosRateGame[2] + 100}
            if not thous then
                comboThngPosGame = {defaultPosNumGame[1] + 30, defaultPosNumGame[2]}
            else
                comboThngPosGame = {defaultPosNumGame[1] + 70, defaultPosNumGame[2]}
            end
            animRatePosGame      = {bf1, bf2}
        end

        if camSetOp == 'game' then
            dadPos = getProperty('dad.positionArray')

            if not pixelOp then
                dad1 = dadPos[1] + (getProperty('dad.x') + 320)
                dad2 = getMidpointY('dad') - 150
            else
                dad1 = dadPos[1] + (getMidpointX('dad') - 330)
                dad2 = dadPos[2] + 150
            end

            defaultPosRateGameOp = {dad1, dad2}
            defaultPosNumGameOp  = {defaultPosRateGameOp[1] + 30, defaultPosRateGameOp[2] + 100}
            animRatePosGameOp    = {dad1, dad2}
        end
    end

    if getProperty('combo') >= 999 and thous == false then thous = true end

    -- This is for the combo sprite thing
    if showComboThing then
        if thous and once == false then -- shoves the combo sprite to the right a bit once 1000 is reached --
            once = true
            comboThngPosGame[1] = defaultPosNumGame[1] + 60 -- combo gets covered, so move it a bit
            comboThngPos[1] = defaultPosNum[1] + 60
            cSpriteOffsets[1] = cSpriteOffsets[1] + 45

        elseif thous == false and once then -- missed with 1000+ combo
            once = false
            comboThngPosGame[1] = defaultPosNumGame[1] + 30
            comboThngPos[1] = defaultPosNum[1] - 60
            cSpriteOffsets[1] = cSpriteOffsets[1] - 45
        end
    end
    

    if (getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') or 
        getPropertyFromClass('flixel.FlxG', 'keys.justPressed.EIGHT')) then
        --setPropertyFromClass('ClientPrefs', 'hideHud', false)
    end

    -- These are here for more randomness --
    chanceGood = math.random(1, 50)
    chanceBad = math.random(1, 65)
    chanceShit = math.random(1, 74)
end

function onUpdatePost(elapsed) -- stupid stupid dum dum
    if simpleMode then 
        runHaxeCode([[ if (lol.hue > 0) lol.hue -= 0.01;
            if (lol.saturation > 0) lol.saturation -= 0.01;

            for (i in 0...1){
                game.getLuaObject('rating').shader = lol.shader;
                game.getLuaObject('combThing' + i).shader = lol.shader;
            }
        ]])
    else
        runHaxeCode([[ if (lol.hue > 0) lol.hue -= 0.01;
            if (lol.saturation > 0) lol.saturation -= 0.01;

            for (i in 0...101){ // kinda weird
                game.getLuaObject('sickly' + i).shader = lol.shader;
            }
        ]])
    end
    if showComboThing then
        if simpleMode then -- ooohhh I hate this, ooohh but fuck it
            runHaxeCode([[for (i in 0...1){ // stupid but I don't care right now
            game.getLuaObject('combThing' + i).shader = lol.shader;}]])
        else
            runHaxeCode([[for (i in 0...101){ // stupid but I don't care right now
            game.getLuaObject('combThing' + i).shader = lol.shader;}]])
        end
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote) 
    if visible then
        comboOffset = getPropertyFromClass('ClientPrefs', 'comboOffset') -- rating offsets 
        -- ( [1] Rating X | [2] Rating Y | [3] Number X | [4] Number Y ) 
        if not isSustainNote then
            brokeCombo = false

            if simpleMode then eh = 0 end -- Keep at 0 so it can't spawn more than one

            if unholyStyle then
                begin = true
                updateNotePos('player', direction)
            end

            -- Took from Whitty mod >:)
            strumTime = getPropertyFromGroup('notes', id, 'strumTime')
            hmm = getRating(strumTime - getSongPosition() + getPropertyFromClass('ClientPrefs','ratingOffset'), 'bf')
            ratingTime = ''
            
            -- small thing, checks rating color
            useColor = ''
            ratiNum = 0
             
            if  hmm == 'sick' then ratiNum = 1 elseif 
                hmm == 'good' then ratiNum = 2 elseif
                hmm == 'bad'  then ratiNum = 3 elseif
                hmm == 'shit' then ratiNum = 4
            else
                ratiNum = nil
            end

            if ratiNum ~= nil then
                useColor = ratingColors[ratiNum]
            else
                useColor = ratingColors[4]
            end
            
            -- so the color gets set based on rating, THEN it removes the rating
            if hideRating then hmm = '' ratiNum = nil end

            if fcColorRating or fcColorNums then
                levelNum = 0
                if getProperty('ratingFC') == 'SFC' then levelNum = 1 elseif 
                   getProperty('ratingFC') == 'GFC' then levelNum = 2 elseif
                   getProperty('ratingFC') == 'FC'  then levelNum = 3 else levelNum = 4 end
            end

            thisOne = nil
            numUse = nil

            if colorRatings and not colorSyncing then
                thisOne = useColor
            elseif colorSyncing then
                if hmm ~= 'shit' then thisOne = colorSync[direction+1] else thisOne = ratingColors[4] end
            elseif fcColorRating then
                thisOne = ratingColors[levelNum]
            else
                thisOne = ratingColors[4]
            end
            combUse = thisOne

            if combColor == false then
                combUse = ratingColors[4]
            end

            if colorNumbers and not colorSyncNums then numUse = useColor
            elseif colorSyncNums then numUse = colorSync[direction+1]
            elseif fcColorNums then numUse = ratingColors[levelNum]
            else numUse = ratingColors[4] end

            if COLORSWAP then
                if direction % 2 == 0 then
                    runHaxeCode([[
                        lol.hue -= 0.05;
                        lol.saturation -= 0.1;
                    ]])
                else
                    runHaxeCode([[
                        lol.hue += ]]..direction..[[;
                        lol.saturation += 0.3;
                    ]])
                end
            end

            -------------------------------Ratings---------------------------------------            

            -- This grabs the default Rating images in either assets/shared/images or mods/images depending on if you're using a mod AND if there are Rating images in there.
            -- I recommend making a folder for ratings if you do some wacky things, specifially for ease of access.
            if ANIMATED then
                animatedAss('bf')
            else
                if not simpleMode then ratingSpawn = hmm ..'ly' .. eh else ratingSpawn = 'rating' end

                if ratiNum ~= nil then
                    if onPlayerCombo and camSet == 'hud' then
                        makeLuaSprite(ratingSpawn, imagePath .. ratingGrab[ratiNum], 405 + comboOffset[1], 230 - comboOffset[2])
                    elseif camSet == 'game' then 
                        makeLuaSprite(ratingSpawn, imagePath .. ratingGrab[ratiNum], defaultPosRateGame[1], defaultPosRateGame[2]) -- default pos game cam
                    else
                        if unholyStyle then
                            makeLuaSprite(ratingSpawn, imagePath .. ratingGrab[ratiNum], notePositions[direction].noteX - 10, notePositions[direction].noteY)
                        else
                            makeLuaSprite(ratingSpawn, imagePath .. ratingGrab[ratiNum], defaultPosRating[1], defaultPosRating[2]) -- Default position for any other cam
                        end
                    end
                end
                setProperty(ratingSpawn .. '.color', getColorFromHex(thisOne))
                setObjectCamera(ratingSpawn, camSet)
                setObjectOrder(ratingSpawn, getObjectOrder('strumLineNotes')-1)
                scaleObject(ratingSpawn, ratingScale[1], ratingScale[2])
                if pixel then
                    setProperty(ratingSpawn .. '.antialiasing', false)
                end
                addLuaSprite(ratingSpawn, true)
                if stationaryMode == false then
                    setProperty(ratingSpawn .. '.acceleration.y', 550)
                    setProperty(ratingSpawn ..'.velocity.x', math.random(0,10))
                    setProperty(ratingSpawn ..'.velocity.y', -180)
                end
                doTweenAlpha('nachotweenRatn' .. eh .. hmm, ratingSpawn, 0, 0.2 + (stepCrochet * 0.004), 'quartIn')
                if colorFade then
                    doTweenColor('coolRatn' .. eh, ratingSpawn, ratingColors[4], 0.2 + (stepCrochet * 0.002), 'quartIn')
                end
            end

            if showComboThing then
                if onPlayerCombo and camSet == 'hud' then
                    makeLuaSprite('combThing' .. eh, imagePath .. combType, cSpriteOffsets[1] + comboOffset[3], cSpriteOffsets[2] - comboOffset[4])
                elseif camSet == 'game' then
                    makeLuaSprite('combThing' .. eh, imagePath .. combType, comboThngPosGame[1], comboThngPosGame[2])
                else
                    makeLuaSprite('combThing' .. eh, imagePath .. combType, comboThngPos[1], comboThngPos[2])
                end
                setObjectCamera('combThing' .. eh, camSet)
                if pixel then
                   setProperty('combThing' .. eh .. '.antialiasing', false)
                end
                setObjectOrder('combThing' .. eh, getObjectOrder('strumLineNotes')-1)
                scaleObject('combThing' .. eh, combThingScale[1], combThingScale[2])
                setProperty('combThing' .. eh .. '.color', getColorFromHex(combUse))
                addLuaSprite('combThing' .. eh, true)
                if not stationaryMode then
                    setProperty('combThing' .. eh .. '.acceleration.y', 550)
                    setProperty('combThing' .. eh .. '.velocity.x', math.random(0,10))
                    setProperty('combThing' .. eh .. '.velocity.y', -180)
                end
                doTweenAlpha('nachotweenComb' .. eh, 'combThing' .. eh, 0, 0.2 + (stepCrochet * 0.004), 'quartIn')
                if combColorFade then
                    doTweenColor('coolCom' .. eh, 'combThing' .. eh, ratingColors[4], 0.2 + (stepCrochet * 0.002), 'quartIn')
                end
            end

            eh = eh + 1 -- makes the sprites spawn the way they do

            if eh > 100 then
                eh = 0 -- So it begins to overwrite inital sprites (stops lag)
            end

            -------------------------------Counter---------------------------------------
            bruh = getProperty('combo')
            lol = {} -- like the source heheheheheahah
            uno = table.insert(lol, (math.floor(bruh % 10)))
            dos = table.insert(lol, (math.floor((bruh / 10) % 10)))
            thr = table.insert(lol, (math.floor((bruh / 100) % 10)))
            if bruh >= 1000 then
                fuo = table.insert(lol, (math.floor(bruh / 1000) % 10))
            end
            --------------------------------Numbers----------------------------------------
                               
            if not hideNums then
                numCount = 1 -- 1 | Lua starts at 1 soooo
                if bruh >= 10 then numCount = 2 end -- 01
                if bruh >= 100 or not foreverComboCount then numCount = 3 end -- 001
                if bruh >= 1000 then numCount = 4 end -- 0001

                sequence = nil
                for i = 1, numCount do
                    multBy = (((i + 2) - numCount) * 43) -- spacing and spawning
                    if unholyStyle then multBy = (((i - 1) - numCount) * 25) end

                    sequence = numPrefix .. lol[i] .. numSuffix  
                    numSpawn = 'num' .. eh .. i

                    if onPlayerCombo and camSet == 'hud' then
                        makeLuaSprite(numSpawn, imagePath .. sequence, 444 + comboOffset[3] - multBy, 385 - comboOffset[4])
                    elseif camSet == 'game' then
                        makeLuaSprite(numSpawn, imagePath .. sequence, defaultPosNumGame[1] - multBy, defaultPosNumGame[2])
                    else
                        if unholyStyle and directNums then
                            numSpawn = 'num' .. i
                            makeLuaSprite(numSpawn, imagePath .. sequence, (notePositions[direction].numX - multBy), notePositions[direction].numY)
                        else
                            makeLuaSprite(numSpawn, imagePath .. sequence, defaultPosNum[1] - multBy, defaultPosNum[2])
                        end
                    end
                    setObjectCamera(numSpawn, camSet)
                    setProperty(numSpawn .. '.color', getColorFromHex(numUse))
                    setObjectOrder(numSpawn, getObjectOrder('strumLineNotes')-1)
                    if pixel then
                        setProperty(numSpawn .. '.antialiasing', false)
                    end
                    scaleObject(numSpawn, numScale[1], numScale[2])
                    addLuaSprite(numSpawn, true)
                    if not stationaryMode then
                        if (unholyStyle and directNums) or not unholyStyle then
                        setProperty(numSpawn .. '.velocity.x', math.random(-5, 5))
                        setProperty(numSpawn .. '.velocity.y', math.random(-140, -160))
                        setProperty(numSpawn .. '.acceleration.y', math.random(200, 400)) end
                    end
                    doTweenAlpha('nachotweenNumGo' .. numSpawn, numSpawn, 0, 0.2 + (stepCrochet * 0.008), 'quartIn')
                    if colorFadeNums then
                        doTweenColor('itsjustafad' .. numSpawn, numSpawn, ratingColors[4], 0.2 + (stepCrochet * 0.005), 'quartIn')
                    end
                end
            end
        end
    end
end

local missMAX = false
function noteMiss(id, direction, noteType, isSustainNote)
    eh = eh + 1
    
    if eh > 100 then
        eh = 0
    end

    if missSprite then
        if unholyStyle then
            begin = true
            updateNotePos('player', direction)
        end

        if onPlayerCombo and camSet == 'hud' then
            if simpleMode then id = 0 end
            makeLuaSprite('looser' .. eh, imagePath .. missType, 410 + comboOffset[1], 230 - comboOffset[2])
        elseif camSet == 'game' then
            if simpleMode then eh = 0 end
            makeLuaSprite('looser' .. eh, imagePath .. missType, defaultPosRateGame[1], defaultPosRateGame[2])
        else
            if simpleMode then eh = 0 end
            if unholyStyle then
                makeLuaSprite('looser' .. eh, imagePath .. missType, notePositions[direction].noteX - 10, notePositions[direction].noteY)
            else
                makeLuaSprite('looser' .. eh, imagePath .. missType, defaultPosRating[1], defaultPosRating[2]) 
            end
        end
        setObjectCamera('looser' .. eh, camSet)
        if pixel then setProperty('looser' .. eh .. '.antialiasing', false) end
        scaleObject('looser' .. eh, missScale[1], missScale[2])

        setObjectOrder('looser' .. eh, getObjectOrder('strumLineNotes')-1)
        addLuaSprite('looser' .. eh, true)
        if not stationaryMode then
            setProperty('looser' .. eh .. '.acceleration.y', 550)
            setProperty('looser' .. eh .. '.velocity.x', math.random(0,10))
            setProperty('looser' .. eh .. '.velocity.y', -200)
        end
        doTweenAlpha('nachotweenBru' .. eh, 'looser' .. eh, 0, 0.2 + (stepCrochet * 0.004), 'quartIn')
    end

    blap = getProperty('songMisses')

    if not missMAX then
        missCount = {} 
        unoMis = table.insert(missCount, math.floor((blap % 10)))
        if blap >= 10 then
            dosMis = table.insert(missCount, math.floor((blap / 10) % 10))
            if blap >= 100 then
                thrMis = table.insert(missCount, math.floor((blap / 100) % 10))
                if blap >= 999 then missMAX = true end
            end
        end
        miSysmbol = table.insert(missCount, 'minus') -- always at the end for consistency 
    else
        missCount = {9, 9, 9, 'minus'} 
    end

    if not hideNums then
        if countMisses then
            numCount = 2 -- one extra to account for the minus sign
            if blap >= 10 then numCount = 3 end
            if blap >= 100 then numCount = 4 end
        else
            missCount = {0, 0, 0} -- doesn't really matter, just to make three nums appear
            numCount = 3
        end

        if pixel then mPrefi = 'pixelUI/' else mPrefi = '' end
        
        sequence = nil
        for i = 1, numCount do
            multBy = countMisses and (((i + 3) - numCount) * 43) or (((i + 2) - numCount) * 43) -- spacing and spawning
            if unholyStyle then multBy = (((i - 1) - numCount) * 25) end

            if type(missCount[i]) ~= 'number' then
                sequence =  missCount[i] .. numSuffix
            else
                sequence = numPrefix .. missCount[i] .. numSuffix
            end

            if not countMisses then sequence = numPrefix .. '0' .. numSuffix end

            if not brokeCombo or countMisses then
                missNum = 'fuke' .. eh .. i
                if onPlayerCombo and camSet == 'hud' then
                    makeLuaSprite(missNum, imagePath .. sequence, 444 + comboOffset[3] - multBy, 390 - comboOffset[4])
                elseif camSet == 'game' then
                    makeLuaSprite(missNum, imagePath .. sequence, defaultPosNumGame[1] - multBy, defaultPosNumGame[2])
                else
                    if unholyStyle and directNums then
                        makeLuaSprite(missNum, imagePath .. sequence, (notePositions[direction].numX - multBy), notePositions[direction].numY)
                    else
                        makeLuaSprite(missNum, imagePath .. sequence, defaultPosNum[1] - multBy, defaultPosNum[2])
                    end
                end
                setObjectCamera(missNum, camSet)
                setProperty(missNum .. '.color', getColorFromHex('bc0000'))
                setObjectOrder(missNum, getObjectOrder('strumLineNotes')-1)
                if pixel then
                    setProperty(missNum .. '.antialiasing', false)
                end
                scaleObject(missNum, numScale[1], numScale[2])
                addLuaSprite(missNum, true)
                if not stationaryMode then
                    if (unholyStyle and directNums) or not unholyStyle then
                    setProperty(missNum .. '.acceleration.y', math.random(200, 400))
                    setProperty(missNum .. '.velocity.x', math.random(-5, 5))
                    setProperty(missNum .. '.velocity.y', math.random(-140, -160)) end
                end
                doTweenAlpha('nachotweenMissNum' .. eh .. i, missNum, 0, 0.2 + (stepCrochet * 0.008), 'quartIn')
            end
        end
    end

    thous = false -- forgot this
    brokeCombo = true
end

function animatedAss(char)
    if char == 'bf' then
        if singleAnim then eh = 0 end
        weep = hmm ..'ly'.. eh

        if onPlayerCombo and camSet == 'hud' then
            if ratiNum ~= nil then
                makeAnimatedLuaSprite(weep, fileNames[ratiNum], animRateOffsts[1] + comboOffset[1], animRateOffsts[2] - comboOffset[2])
                addAnimationByPrefix(weep, 'yeah', animNames[ratiNum], animFrameRate, false)
            end
        elseif camSet == 'game' then
            if ratiNum ~= nil then
                makeAnimatedLuaSprite(weep, fileNames[ratiNum], animRatePosGame[1], animRatePosGame[2])
                addAnimationByPrefix(weep, 'yeah', animNames[ratiNum], animFrameRate, false)
            end
        else
            if ratiNum ~= nil then
                makeAnimatedLuaSprite(weep, fileNames[ratiNum], animRatePos[1], animRatePos[2])
                addAnimationByPrefix(weep, 'yeah', animNames[ratiNum], animFrameRate, false)
            end
        end
        if colorAnim then
            setProperty(weep .. '.color', getColorFromHex(thisOne))
        end

        setObjectCamera(weep, camSet)
        setObjectOrder(weep, getObjectOrder('strumLineNotes')-1)
        scaleObject(weep, animRatScale[1], animRatScale[2])

        objectPlayAnimation(weep, 'yeah', false)

        if ratPixl then setProperty(weep ..'.antialiasing', false) end

        addLuaSprite(weep, true)
        if veloctitty then
            setProperty(weep ..'.acceleration.y', 550)
            setProperty(weep ..'.velocity.x', math.random(0,10))
            setProperty(weep ..'.velocity.y', -180)
        end
        if animFade then
            doTweenAlpha('nachotweenAnim' .. hmm .. eh, weep, 0, initDelay + (stepCrochet * 0.004), 'quartIn')
        end
        if colorFade and colorAnim then
            doTweenColor('coolAnim', weep, ratingColors[4], 0.2 + (stepCrochet * 0.002), 'quartIn')
        end
    end
    if char == 'dad' then
        if singleAnimOp then ehOp = 0 end
        sob = hmmOp ..'lyOp'.. ehOp

        if onPlayerComboOp and camSetOp == 'hud' then
            if ratiNumOp ~= nil then
                makeAnimatedLuaSprite(sob, fileNamesOp[ratiNumOp], animRateOffstsOp[1] + comboOffset[1], animRateOffstsOp[2] - comboOffset[2])
                addAnimationByPrefix(sob, 'yeah', animNamesOp[ratiNumOp], animFrameRateOp, false)
            end
        elseif camSetOp == 'game' then
            if ratiNumOp ~= nil then
                makeAnimatedLuaSprite(sob, fileNamesOp[ratiNumOp], animRatePosGameOp[1], animRatePosGameOp[2])
                addAnimationByPrefix(sob, 'yeah', animNamesOp[ratiNumOp], animFrameRateOp, false)
            end
        else
            if ratiNumOp ~= nil then
                makeAnimatedLuaSprite(sob, fileNamesOp[ratiNumOp], animRatePosOp[1], animRatePosOp[2])
                addAnimationByPrefix(sob, 'yeah', animNamesOp[ratiNumOp], animFrameRateOp, false)
            end
        end
        if colorAnimOp then
            setProperty(sob .. '.color', getColorFromHex(thisOneOp))
        end
        setObjectCamera(sob, camSetOp)
        setObjectOrder(sob, getObjectOrder('strumLineNotes')-1)
        scaleObject(sob, animRatScaleOp[1], animRatScaleOp[2])
        
        objectPlayAnimation(sob, 'yeah', false)

        if ratPixlOp then setProperty(sob ..'.antialiasing', false) end
        addLuaSprite(sob, true)
        
        if veloctittyOp then
            setProperty(sob ..'.acceleration.y', 550)
            setProperty(sob ..'.velocity.x', math.random(0,10))
            setProperty(sob ..'.velocity.y', -180)
        end
        if animFadeOp then
            doTweenAlpha('nachotweenAnimOpp' .. anHmmOp .. fakeEhOp, sob, 0, initDelayOp + (stepCrochet * 0.004), 'quartIn')
        end
        if colorFadeOp and colorAnimOp then
            doTweenColor('coolAnimOp', sob, ratingColorsOp[4], 0.2 + (stepCrochet * 0.002), 'quartIn')
        end
    end
end
---------------------------- Daddy Dearest <3 (Opponent) ---------------------------------

function opponentNoteHit(id, direction, noteType, isSustainNote) 
    if visibleOp then
        comboOffset = getPropertyFromClass('ClientPrefs', 'comboOffset') -- rating offsets
        if not isSustainNote then

            if simpleModeOp then ehOp = 0 end
            -- Keep at 0 so it can't spawn more than one

            strumTime = getPropertyFromGroup('notes', id, 'strumTime')
            hmmOp = getRating(strumTime - getSongPosition() + getPropertyFromClass('ClientPrefs','ratingOffset'), 'dad')
            if hideRatingOp then
                hmmOp = ''
            end

            anHmmOp = hmmOp
            ratingColoOp = ''
            ratiNumOp = 0

            if  hmmOp == 'sick' then ratiNumOp = 1 elseif 
                hmmOp == 'good' then ratiNumOp = 2 elseif
                hmmOp == 'bad'  then ratiNumOp = 3 elseif
                hmmOp == 'shit' then ratiNumOp = 4
            else
                ratiNumOp = nil
            end

            if ratiNumOp ~= nil then
                ratingColoOp = ratingColorsOp[ratiNumOp]
            else
                ratingColoOp = ratingColorsOp[4]
            end

            thisOneOp = nil

            if colorRatingsOp and not colorSyncingOp then
                thisOneOp = ratingColoOp
            elseif colorSyncingOp then
                if hmmOp ~= 'shit' then thisOneOp = colorSyncOp[direction+1] else thisOneOp = ratingColorsOp[4] end
            else
                thisOneOp = ratingColorsOp[4]
            end

            if colorNumbersOp and not colorSyncNumsOp then numUseOp = ratingColoOp
            elseif colorSyncNumsOp then numUseOp = colorSyncOp[direction+1]
            else numUseOp = ratingColorsOp[4] end

            -------------------------------Ratings---------------------------------------
            if ANIMATEDOP then
                animatedAss('dad')
            else
                ratingSpawnOp = hmmOp ..'lyOp' .. ehOp
                if onPlayerComboOp and camSetOp == 'hud' then
                    if ratiNumOp ~= nil then
                        makeLuaSprite(ratingSpawnOp, imagePathOp .. ratingGrabOp[ratiNumOp], 400 + comboOffset[1], 230 - comboOffset[2])
                    end
                elseif camSetOp == 'game' then
                    if ratiNumOp ~= nil then
                        makeLuaSprite(ratingSpawnOp, imagePathOp .. ratingGrabOp[ratiNumOp], defaultPosRateGameOp[1], defaultPosRateGameOp[2])
                    end
                else
                    if ratiNumOp ~= nil then
                        makeLuaSprite(ratingSpawnOp, imagePathOp .. ratingGrabOp[ratiNumOp], defaultPosRatingOp[1], defaultPosRatingOp[2])
                    end
                end
                setProperty(ratingSpawnOp .. '.color', getColorFromHex(thisOneOp))
                setObjectCamera(ratingSpawnOp, camSetOp)
                setObjectOrder(ratingSpawnOp, getObjectOrder('strumLineNotes')-1)
                scaleObject(ratingSpawnOp, ratingScaleOp[1], ratingScaleOp[2])
                if pixelOp then
                    setProperty(ratingSpawnOp .. '.antialiasing', false)
                end
                addLuaSprite(ratingSpawnOp, true)
                if not stationaryModeOp then
                    setProperty(ratingSpawnOp .. '.acceleration.y', 550)
                    setProperty(ratingSpawnOp ..'.velocity.x', math.random(0,10))
                    setProperty(ratingSpawnOp ..'.velocity.y', -180)
                end
                doTweenAlpha('nachotweenSickO' .. ehOp, ratingSpawnOp, 0, 0.2 + (stepCrochet * 0.004), 'quartIn')
                if colorFadeOp then
                    doTweenColor('coolSOp' .. ehOp, ratingSpawnOp, ratingColorsOp[4], 0.2 + (stepCrochet * 0.002), 'quartIn')
                end
                if getProperty(ratingSpawnOp ..'.alpha') == 0 then
                    removeLuaSprite(ratingSpawnOp, false)
                end 
            end

            ehOp = ehOp + 1 -- makes it look right
            if ehOp > 100 then
                ehOp = 0 
            end

            -------------------------------Counter---------------------------------------
            fakeCombo = fakeCombo + 1
            if fakeCombo > 9999 then
                fakeCombo = 9999 -- finally, fixed max value
            end

            fakeAssComboAss = {}

            unoOp = table.insert(fakeAssComboAss, ((fakeCombo % 10)))
            dosOp = table.insert(fakeAssComboAss, math.floor((fakeCombo / 10) % 10))
            thrOp = table.insert(fakeAssComboAss, math.floor((fakeCombo / 100) % 10))
            if fakeCombo >= 1000 then
                fuoOp = table.insert(fakeAssComboAss, math.floor((fakeCombo / 1000) % 10))
            end
            --------------------------------Numbers----------------------------------------

            if not hideNumsOp then                    
                numCount = 1 -- 1
                if fakeCombo >= 10 then numCount = 2 end -- 01
                if fakeCombo >= 100 or not foreverComboCountOp then numCount = 3 end -- 001
                if fakeCombo >= 1000 then numCount = 4 end -- 0001

                sequence = nil
                for i = 1, numCount do
                    if foreverComboCountOp then multBy = (((i + 2) - numCount) * 43) else multBy = ((i - 1) * 43) end

                    sequence = numPrefixOp .. fakeAssComboAss[i] .. numSuffixOp
                    spawnOp = ehOp .. i
                
                    if onPlayerComboOp and camSetOp == 'hud' then
                        makeLuaSprite('numOp' .. spawnOp, imagePathOp .. sequence, 444 + comboOffset[3] - multBy, 390 - comboOffset[4])
                    elseif camSetOp == 'game' then
                        makeLuaSprite('numOp' .. spawnOp, imagePathOp .. sequence, defaultPosNumGameOp[1] - multBy, defaultPosNumGameOp[2])
                    else
                        makeLuaSprite('numOp' .. spawnOp, imagePathOp .. sequence, defaultPosNumOp[1] - multBy, defaultPosNumOp[2])
                    end
                    setObjectCamera('numOp' .. spawnOp, camSetOp)
                    setProperty('numOp' .. spawnOp .. '.color', getColorFromHex(numUseOp))
                    setObjectOrder('numOp' .. spawnOp, getObjectOrder('strumLineNotes')-1)
                    if pixelOp then
                        setProperty('numOp' .. spawnOp .. '.antialiasing', false)
                    end
                    scaleObject('numOp' .. spawnOp, numScaleOp[1], numScaleOp[2])
                    addLuaSprite('numOp' .. spawnOp, true)
                    if not stationaryModeOp then
                        setProperty('numOp' .. spawnOp .. '.acceleration.y', math.random(200, 400))
                        setProperty('numOp' .. spawnOp ..'.velocity.x', math.random(-5, 5))
                        setProperty('numOp' .. spawnOp ..'.velocity.y', math.random(-140, -160))
                    end
                    doTweenAlpha('nachotweenNumOpGo' .. ehOp .. i, 'numOp' .. spawnOp, 0, 0.2 + (stepCrochet * 0.008), 'quartIn')
                    if colorFadeNumsOp then
                        doTweenColor('itsjustafadOp' .. ehOp .. i, 'numOp' .. spawnOp, ratingColorsOp[4], 0.2 + (stepCrochet * 0.005), 'quartIn')
                    end
                end
            end
        end
    end
end

----- BbPanzu >:) ----------

function getRating(diff, char) -- fused them, cuz they basically did the same thing
    if char == 'dad' then
        if chanceGood >= 48 and randGoods then return 'good' elseif 
           chanceBad  >= 63 and randBads  then return 'bad'  elseif 
           chanceShit >= 72 and randShits then return 'shit' else
           return 'sick'
        end
    end

	diff = math.abs(diff)
    
	if diff <= getPropertyFromClass('ClientPrefs', 'badWindow') then
		if diff <= getPropertyFromClass('ClientPrefs', 'goodWindow') then
			if diff <= getPropertyFromClass('ClientPrefs', 'sickWindow') then
				return 'sick'
			end
			return 'good'
		end
		return 'bad'
	end
	return 'shit'
end


function updateNotePos(noteGroup, direction) -- so a for loop isn't just mashed into functions
    if direction == nil then direction = 3 end
    for i = 0, direction do
        lolX = getPropertyFromGroup(noteGroup .. 'Strums', i, 'x')
        if directNums then 
            lulX = getPropertyFromGroup(noteGroup .. 'Strums', i, 'x') - 12 else
            lulX = getPropertyFromGroup(noteGroup .. 'Strums', 1, 'x') + 45 end
        if downscroll then
            if directNums then
                lolY = getPropertyFromGroup(noteGroup .. 'Strums', i, 'y') - 60                    
                lulY = getPropertyFromGroup(noteGroup .. 'Strums', i, 'y') - 10
            else
                lolY = getPropertyFromGroup(noteGroup .. 'Strums', i, 'y') - 35                    
            end
        else
            lolY = getPropertyFromGroup(noteGroup .. 'Strums', i, 'y') + 130 
            if directNums then
                lulY = getPropertyFromGroup(noteGroup .. 'Strums', i, 'y') + 180 
            end
        end

        if noteGroup == 'player' then
            notePositions[i] = {noteX = lolX, noteY = lolY, numX = lulX, numY = lulY} end
    end
end