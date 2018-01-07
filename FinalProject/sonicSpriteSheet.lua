--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:bc9e8ca7070d0d94c1150db6f9875c6a:bdf5682c5d240e0720e20ae6cddfdf8a:a18483c3277a27c72fb444cce6c78d20$
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
            -- sonic-1
            x=1,
            y=247,
            width=98,
            height=128,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 102,
            sourceHeight = 132
        },
        {
            -- sonic-2
            x=1,
            y=1,
            width=103,
            height=126,

            sourceX = 1,
            sourceY = 6,
            sourceWidth = 115,
            sourceHeight = 132
        },
        {
            -- sonic-3
            x=1,
            y=377,
            width=94,
            height=128,

            sourceX = 4,
            sourceY = 4,
            sourceWidth = 104,
            sourceHeight = 132
        },
        {
            -- sonic-4
            x=1,
            y=627,
            width=83,
            height=128,

            sourceX = 1,
            sourceY = 4,
            sourceWidth = 93,
            sourceHeight = 132
        },
        {
            -- sonic-5
            x=1,
            y=507,
            width=92,
            height=118,

            sourceX = 0,
            sourceY = 4,
            sourceWidth = 96,
            sourceHeight = 132
        },
        {
            -- sonic-6
            x=1,
            y=129,
            width=103,
            height=116,

            sourceX = 1,
            sourceY = 6,
            sourceWidth = 105,
            sourceHeight = 132
        },
        {
            -- sonic-7
            x=1,
            y=757,
            width=82,
            height=130,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 90,
            sourceHeight = 132
        },
    },
    
    sheetContentWidth = 105,
    sheetContentHeight = 888
}

SheetInfo.frameIndex =
{

    ["sonic-1"] = 1,
    ["sonic-2"] = 2,
    ["sonic-3"] = 3,
    ["sonic-4"] = 4,
    ["sonic-5"] = 5,
    ["sonic-6"] = 6,
    ["sonic-7"] = 7,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
