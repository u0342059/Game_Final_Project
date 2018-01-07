--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:9633afbdcfd2c5c1691499e2cf37fd35:8c402299ce4b4dacbba62a20428519a1:52aaea71f2f642d668be74808599cf4f$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- monster-1
            x=2,
            y=2,
            width=91,
            height=97,

            sourceX = 5,
            sourceY = 2,
            sourceWidth = 101,
            sourceHeight = 101
        },
        {
            -- monster-2
            x=178,
            y=2,
            width=81,
            height=97,

            sourceX = 10,
            sourceY = 1,
            sourceWidth = 101,
            sourceHeight = 101
        },
        {
            -- monster-3
            x=407,
            y=2,
            width=57,
            height=97,

            sourceX = 21,
            sourceY = 1,
            sourceWidth = 101,
            sourceHeight = 101
        },
        {
            -- monster-4
            x=338,
            y=2,
            width=67,
            height=97,

            sourceX = 16,
            sourceY = 2,
            sourceWidth = 101,
            sourceHeight = 101
        },
        {
            -- monster-5
            x=466,
            y=2,
            width=51,
            height=97,

            sourceX = 25,
            sourceY = 2,
            sourceWidth = 101,
            sourceHeight = 101
        },
        {
            -- monster-6
            x=261,
            y=2,
            width=75,
            height=97,

            sourceX = 13,
            sourceY = 1,
            sourceWidth = 101,
            sourceHeight = 101
        },
        {
            -- monster-7
            x=95,
            y=2,
            width=81,
            height=97,

            sourceX = 10,
            sourceY = 2,
            sourceWidth = 101,
            sourceHeight = 101
        },
    },
    
    sheetContentWidth = 519,
    sheetContentHeight = 101
}

SheetInfo.frameIndex =
{

    ["monster-1"] = 1,
    ["monster-2"] = 2,
    ["monster-3"] = 3,
    ["monster-4"] = 4,
    ["monster-5"] = 5,
    ["monster-6"] = 6,
    ["monster-7"] = 7,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
