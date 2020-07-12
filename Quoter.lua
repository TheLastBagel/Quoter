Quoter = {};

Quoter.panel = CreateFrame( "Frame", "QuoterPanel", UIParent )

SLASH_QADD1 = "/qadd"
SLASH_QDELETE1 = "/qdelete"
SLASH_QCHECK1 = "/qcheck"
function SlashCmdList.QADD(msg)
	tinsert(QuoterDB['Quotes'], msg);
end
function SlashCmdList.QDELETE(msg)
	table.remove(QuoterDB['Quotes'], msg);
	print("Quote Deleted");
end
function SlashCmdList.QCHECK()
	table.foreach(QuoterDB['Quotes'], print);
end
local buttonAdd = CreateFrame("Button", "only_for_testing", QuoterPanel)
buttonAdd:SetPoint("CENTER", QuoterPanel, "CENTER", 0, 0)
buttonAdd:SetWidth(100)
buttonAdd:SetHeight(50)
        
buttonAdd:SetText("New Quote")
buttonAdd:SetNormalFontObject("GameFontNormal")
	
local ntex = buttonAdd:CreateTexture()
ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
ntex:SetTexCoord(0, 0.625, 0, 0.6875)
ntex:SetAllPoints()	
buttonAdd:SetNormalTexture(ntex)
	
local htex = buttonAdd:CreateTexture()
htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
htex:SetTexCoord(0, 0.625, 0, 0.6875)
htex:SetAllPoints()
buttonAdd:SetHighlightTexture(htex)
	
local ptex = buttonAdd:CreateTexture()
ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
ptex:SetTexCoord(0, 0.625, 0, 0.6875)
ptex:SetAllPoints()
buttonAdd:SetPushedTexture(ptex)

function addQuote()
	if(QuoterDB == nil) then
		QuoterDB = {};
		QuoterDB["Quotes"] = { "AHHH", "AHHHH"};
	else
		tinsert(QuoterDB['Quotes'], "This is a quote");
	end
end
buttonAdd:SetScript("OnClick", addQuote)

-- Register in the Interface Addon Options GUI
-- Set the name for the Category for the Options Panel
Quoter.panel.name = "Quoter";
-- Add the panel to the Interface Options
InterfaceOptions_AddCategory(Quoter.panel);

local EventFrame = CreateFrame("frame", "EventFrame")

local function MessageReceived(self, event, msg, sender)
	if(msg == "!quote") then
		val = math.random(#QuoterDB['Quotes']);
		SendChatMessage(QuoterDB['Quotes'][val], "WHISPER", nil, sender);
	end
end



EventFrame:RegisterEvent("CHAT_MSG_WHISPER")
EventFrame:SetScript("OnEvent", MessageReceived)