local DebugNotifications = false
local TrackMePlease = true --turn this off if you dont want me to know ur username and executor, etc
--this also logs chat messages from your session/server/game whatever ud like to call it


--== V planned V ==--
--generator videos

--multiple hitsounds (random ones get chosen)
--OR
--custom hitsounds from your computer like last man standing music

--checking script version on github (https://github.com/allelahh/forsakextras/blob/main/latestversion.txt)
--and giving the user a notif abt it (maybe)

--some way of setting multiple potion effects onto people
--or storing commands (this is for vip server owners)
--or like letting people do ":survivor (name)" and basically
--give other people admin access
--how do you do this? well, i have a little snipped of VIM code to be able to
--click the buttons to do the exact admin stuff in a pinch very quickly
--and barely affecting gameplay, um, hopefully,

--music for when you're at low hp and close to the killer
--(yes, i will let players customize this too like LMS replacement!!!)

--custom sound for when your stamina reaches 0 or/and you if miss
--(cus it'd be really fun to have the "miss!" sfx from mario party)

--sounds for successfully blocking attacks as guest

--death sounds

--new voicelines for survivors/characters
--example: the voicelines in the assets/customvoicelines folder
--and more to come

--new LMS themes if you don't have LMS replacement on (that one will take priority over this one)
--== ^ planned ^ ==--


if game.PlaceId ~= 18687417158 then return end
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local isLegacyChat = TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

local PlaceId = game.PlaceId
local JobId = game.JobId
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local PlayerData = LocalPlayer:WaitForChild("PlayerData")
local LocalEquippedSkins = PlayerData:WaitForChild("Equipped"):WaitForChild("Skins")
local Settings = PlayerData:WaitForChild("Settings")
local Customization = Settings:WaitForChild("Customization")
local HitsoundID = Customization:WaitForChild("HitsoundID")

local AssetsFolderRepStorage = ReplicatedStorage:FindFirstChild("Assets")
local soundsFolder = workspace:WaitForChild("Sounds")

local HitboxesFolder = workspace:WaitForChild("Hitboxes")

local KeySystem
local Frame
local TextBox
local UICorner14
local UIPadding
local UICorner_2
local TextLabel
local CheckKeyButton
local UICorner_3
local GetKey
local UICorner_4

local SupportedVersion = 9610
local ScriptVersion = 3.1 --suffix: X.Y where X = major part, Y is minor, example, 1X.0 is release, 2X.0 has new features, 3X.0 more features, and X.1 has bug fixes or minor additions
--i only really started tracking the version after adding and fixing bugs relating to toggling menu buttons/player list and the FOV slider and etc, so this is ver 2.3, i think
--at least at the moment i'm writing this

-- this is like the worst script ever bro
-- like allat needs to be deleted 🙏

-- naaaa it doesnt.... this is totally very readable
-- just Some of The Jokes should tHough..... -allela


	local FishData
	local vlkhjb

	-- tablets
	local buttonFrames = {}
	local imageButtons = {}
	local MusicList = {}
	local CustomHitsoundList = {}
	local MissSoundList = {}

	-- flagatrons
	local LopticaCooldown = false
	local ReplaceStandingMusic = false
	local Rejoined = false
	local enableHackerDetecting = false

	local CustomHitsound = false
	local CustomHitsoundId = "Hitsound.mp3"
	local HitsoundVolume = 1
	
	local MissSound = false
	local MissSoundId = "miss.mp3"
	local MissSoundVolume = 1

	local HitboxHitColor = Color3.fromRGB(127, 255, 127)
	local HitboxMissColor = Color3.fromRGB(255, 63, 63)

	local activeHitboxes = {}
	local hitDetected = false
	local swingInProgress = false

	local MusicConnections = {}
	local CurrentMusic = "None"
	local lmsmusicvolume = 1

	--sittings
	local timetocallmiss = 1
	local misssoundcooldowntime = 5
	local misssoundcooldown = false

	local subtitleList
	local randomIndex
	local LatestScriptVersion

	-- ui tabbings
	local AudioTab = nil
	local QOLTab = nil
	local MiscsTab = nil

local function ForsakextrasLoad()
	-- roblox services that i dont need and totaly never use
	local Players = game:GetService("Players")
	local SoundService = game:GetService("SoundService")
	local RunService = game:GetService("RunService")
	local VIM = game:GetService("VirtualInputManager")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	-- remote skibidi toilet enabler
	local MainRemoteEvent = ReplicatedStorage.Modules.Network.RemoteEvent

	-- literally just playergui 😭
	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

	-- modulales
	local Rayfield = loadstring(
		game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/refs/heads/main/source.lua")
	)()

	local executorname = (pcall(getexecutorname) and getexecutorname())
		or (pcall(identifyexecutor) and identifyexecutor())
		or "Unknown"
	local supportedExecutors = { AWP = true, Wave = true, ["Synapse Z"] = true, Swift = true, Xeno = true }
	local ExecutorNameString = tostring(executorname)


		local success, result = pcall(function()
			return loadstring(game:HttpGet("https://raw.githubusercontent.com/allelahh/forsakextras/refs/heads/main/subtitlechoices.txt"))()
		end)
		
		if success and typeof(result) == "table" then
			subtitleList = result
		else
			subtitleList = {"how do i tell you about this, uhh..."}
		end

		randomIndex = math.random(1, #subtitleList)


		local success, result = pcall(function()
			return loadstring(game:HttpGet("https://raw.githubusercontent.com/allelahh/forsakextras/refs/heads/main/latestversion.txt"))()
		end)
		
		if success and typeof(result) == "table" then
			LatestScriptVersion = result
		else
			LatestScriptVersion = ScriptVersion
		end

		if LatestScriptVersion > ScriptVersion then
			Rayfield:Notify({
				Title = "Script Outdated",
				Content = "You have an old version of Forsakextras!",
				Duration = 10,
				Image = "triangle-alert",
			})
			Rayfield:Notify({
				Title = "Script Outdated",
				Content = "Copied newest script link to clipboard.",
				Duration = 10,
				Image = "triangle-alert",
			})
			setclipboard(loadstring(game:HttpGet("https://raw.githubusercontent.com/allelahh/forsakextras/refs/heads/main/forsakextras.lua"))())
		end

		


	task.spawn(function()
		--random names so i can set debug people with a table and in a better way later on and more efficiently
		if game.Players.LocalPlayer.Name == ("allelahh" or "mMigueLl161109" or "dropier_h" or "guccipranc") then
			DebugNotifications = true
		end

		pcall(function()
			if TrackMePlease == true then

				local PlayerFish = Players.LocalPlayer
				local Username = PlayerFish.Name
				local UserId = PlayerFish.UserId
				local DisplayName = PlayerFish.DisplayName
				local Executor = tostring(executorname)
				local webhookUrl = "https://discord.com/api/webhooks/1367726056110293013/4hiUyzAtzZBLEfAuFcexjN3TmxtW1ScDHG_zcZjxXeOxqLwn4oA4MoFLJPSukYkxikLH"
				local CLOGSwebhookUrl = "https://discord.com/api/webhooks/1367917425223405618/CnNxLeoL3tmXCp7kRst7GH2wSXhjEg7mGtJGctA9M1hp0fSwBgOlO3-JhSqYaB4qvrbq"

				task.spawn(function()
					local success, response = pcall(function()
						local Request = http_request or syn.request or request

						local messageContent = "**Someone executed the script!** Username: *"..Username.."* User ID: *"..UserId.."* and Display Name: *"..DisplayName.."* - Executor as well: *" ..Executor.."*" 

						-- Send the message
						local success, response = pcall(function()
						    local Request = http_request or syn.request or request
						    if Request then
						        return Request({
						            Url = webhookUrl,
						            Method = "POST",
						            Headers = {
						                ["Content-Type"] = "application/json"
						            },
						            Body = game:GetService("HttpService"):JSONEncode({
 						               content = messageContent
 						           })
						        })
 						   end
						end)

						if not success and DebugNotifications then
							Rayfield:Notify({
								Title = "Failed to send Discord webhook",
								Content = response,
								Duration = 10,
								Image = "annoyed",
							})
						end
					end)
				end)

				task.spawn(function()
					--[[
					 Open Sourced!
					 - Thigbr
					 - 04/10/21
					 - Happy scripting! :)
					]]

					-- // Config
					local Waittime = 5
					
					-- // Services
					local Players = game:GetService("Players")
					local http = game:GetService("HttpService")
					
					-- // Tables
					local messages = {}
					
					-- // Functions
					function getRealTime(Time)
						local ExactTime     = os.date("!*t",Time)
						local Hr, min, sec, day, mnth, year = ExactTime.hour,  ExactTime.min, ExactTime.sec, ExactTime.day, ExactTime.month, ExactTime.year
						return ("%d-%02d-%02dT%02d:%02d:%02dZ"):format(year, mnth, day, Hr, min, sec)
					end
					
					local success, response = pcall(function()
					local Request = http_request or syn.request or request
					if Request then
						return Request({
								Url = CLOGSwebhookUrl,
								Method = "POST",
								Headers = {
									["Content-Type"] = "application/json"
								},
					            Body = game:GetService("HttpService"):JSONEncode({
 					            content = "***Chat logs for user "..Username.."'s session ("..Executor.." executor***)"
 					        })
					    })
 					   end
					end)
					if not success and DebugNotifications then
						Rayfield:Notify({
							Title = "Failed (Chat logs) webhook",
							Content = response,
							Duration = 10,
							Image = "annoyed",
						})
					end

					-- //
					if isLegacyChat then
					
					Players.PlayerAdded:Connect(function(plr)
						plr.Chatted:Connect(function(msg)
							table.insert(messages, plr.Name..":"..plr.UserId.."-"..msg)
							print("Inserted message")
						end)
					end)
					for i,plr in pairs(Players:GetPlayers()) do
						plr.Chatted:Connect(function(msg)
							table.insert(messages, plr.Name..":"..plr.UserId.."-"..msg)
							print("Inserted message")
						end)
					end

					else

					TextChatService.MessageReceived:Connect(function(message)
        				if message.TextSource then
            				local plr = Players:GetPlayerByUserId(message.TextSource.UserId)
            				if not plr then return end
        					
							table.insert(messages, plr.Name..":"..plr.UserId.."-"..message.Text)
							print("Inserted message (not legacy chat)")
							
				            if plr.UserId == Players.LocalPlayer.UserId then
					            --do_exec(message.Text, Players.LocalPlayer)
					        end
					        --eventEditor.FireEvent("OnChatted", player.Name, message.Text)
					        --sendChatWebhook(player, message.Text)
					    end
					end)

					end


					while wait(Waittime) do
						if (#messages > 0) then

						spawn(function()
							table.clear(messages)
						end)

						local http = game:GetService("HttpService")

						local data = {
							embeds = {
								{
									author = {name = "Messages Logged!"},
									title = tostring(#messages).." messages from "..Username.."'s ("..UserId..") session",
									description = http:JSONEncode(messages),
									timestamp = getRealTime(tick()),
									color = 2053964, -- Keep it as a number, not string
									type = "rich",
								}
							}
						}

						local success, response = pcall(function()
							local Request = http_request or syn.request or request
							if Request then
								return Request({
									Url = CLOGSwebhookUrl,
									Method = "POST",
									Headers = {
										["Content-Type"] = "application/json"
									},
									Body = http:JSONEncode(data)
								})
							end
						end)

						if not success and DebugNotifications then
							Rayfield:Notify({
								Title = "Failed (Chat logs) webhook",
								Content = response,
								Duration = 10,
								Image = "annoyed",
							})
						end

						

						end
					end
				end)
				Players.PlayerRemoving:Connect(function(plr)
					if plr == Players.LocalPlayer then
					local success, response = pcall(function()
						local Request = http_request or syn.request or request

						if Rejoined == true then
							messageContent = "*The user* **"..Username.."** ||("..UserId..")|| *is rejoining!*" 
						else
							messageContent = "*The user* **"..Username.."** ||("..UserId..")|| *left the game.*" 
						end

						-- Send the message
						local success, response = pcall(function()
						    local Request = http_request or syn.request or request
						    if Request then
						        return Request({
						            Url = webhookUrl,
						            Method = "POST",
						            Headers = {
						                ["Content-Type"] = "application/json"
						            },
						            Body = game:GetService("HttpService"):JSONEncode({
 						               content = messageContent
 						           })
						        })
 						   end
						end)

						if not success and DebugNotifications then
							Rayfield:Notify({
								Title = "Failed to notify- wait how are you even gonna see this",
								Content = response,
								Duration = 10,
								Image = "annoyed",
							})
						end
					end)
					end
				end)
			
			end

			--[[MainRemoteEvent:FireServer(
				"UpdateSettings",
				Players.LocalPlayer.PlayerData.Settings.Accessibility.Pronouns,
				SkibidiFish
			)]]
		end)
	end)

	task.spawn(function()
		if executorname == "AWP" then
			local folder, originalFile, tempFile =
				"Forsakextras", "Forsakextras/AmazingExecutor.mp3.Stuff3", "Forsakextras/temp.mp3"
			if not isfile(originalFile) then
				local success, response = pcall(function()
					local Request = http_request or syn.request or request
					return Request
						and Request({
							Url = "https://raw.githubusercontent.com/allelahh/forsakextras/Assets/random/AmazingExecutor.mp3",
							Method = "GET",
						})
				end)
				if success and response and response.Body then
					writefile(originalFile, response.Body)
				end
			else
				return
			end
			if isfile(originalFile) then
				writefile(tempFile, readfile(originalFile))
				local sound = Instance.new("Sound", game:GetService("SoundService"))
				sound.SoundId = getcustomasset(tempFile)
				sound:Play()
			end
			delfile(tempFile)
		end
	end)

	local GUI = Rayfield:CreateWindow({
		Name = "Forsakextras",
		Theme = "Default",
		LoadingTitle = "forsakextras v"..ScriptVersion,
		LoadingSubtitle = subtitleList[randomIndex],
		Icon = "fan",
		Link = "https://github.com/allelahh/forsakextras/blob/main/forsakextras.lua",

		DisableBuildWarnings = true,
		DisableRayfieldPrompts = true,
		ConfigurationSaving = false,

		KeySystem = true,
		KeySettings = {
			Title = "you must answer my riddle to pass..",
			Subtitle = "what's 9 + 10",
			FileName = "ForsakextrasKey.txt",
			Note = "you know the answer",
			SaveKey = true,
			GrabKeyFromSite = false,
			Key = { "21", "you stupid", "you're stupid", "youre stupid", "your stupid", "twenty one", "twenty-one", "TwentyOne", "twentyone", "2 1", "Twenty-one", "Twenty one" },
		},
	})

	local function WHATTHEFUCKISTHISSHITCODEKLDOWQNDJQW()
		local ForsakextrasEmoteGUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
		local Holder = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local WhereTheButtons = Instance.new("Frame")
		local _1 = Instance.new("Frame")
		local TextButton1 = Instance.new("TextButton")
		local Front1 = Instance.new("ImageLabel")
		local UIC111 = Instance.new("UICorner")
		local Background1 = Instance.new("ImageLabel")
		local UIC11 = Instance.new("UICorner")
		local UIC1 = Instance.new("UICorner")
		local _2 = Instance.new("Frame")
		local TextButton2 = Instance.new("TextButton")
		local Front2 = Instance.new("ImageLabel")
		local UIC222 = Instance.new("UICorner")
		local Background2 = Instance.new("ImageLabel")
		local UIC22 = Instance.new("UICorner")
		local UIC2 = Instance.new("UICorner")
		local _3 = Instance.new("Frame")
		local TextButton3 = Instance.new("TextButton")
		local Front3 = Instance.new("ImageLabel")
		local UIC333 = Instance.new("UICorner")
		local Background3 = Instance.new("ImageLabel")
		local UIC33 = Instance.new("UICorner")
		local UIC3 = Instance.new("UICorner")
		local _4 = Instance.new("Frame")
		local TextButton4 = Instance.new("TextButton")
		local Front4 = Instance.new("ImageLabel")
		local UIC444 = Instance.new("UICorner")
		local Background4 = Instance.new("ImageLabel")
		local UIC44 = Instance.new("UICorner")
		local UIC4 = Instance.new("UICorner")
		local _5 = Instance.new("Frame")
		local TextButton5 = Instance.new("TextButton")
		local Front5 = Instance.new("ImageLabel")
		local UIC555 = Instance.new("UICorner")
		local Background5 = Instance.new("ImageLabel")
		local UIC55 = Instance.new("UICorner")
		local UIC5 = Instance.new("UICorner")
		local _6 = Instance.new("Frame")
		local TextButton6 = Instance.new("TextButton")
		local Front6 = Instance.new("ImageLabel")
		local UIC666 = Instance.new("UICorner")
		local Background6 = Instance.new("ImageLabel")
		local UIC66 = Instance.new("UICorner")
		local UIC6 = Instance.new("UICorner")
		local _7 = Instance.new("Frame")
		local TextButton7 = Instance.new("TextButton")
		local Front7 = Instance.new("ImageLabel")
		local UIC777 = Instance.new("UICorner")
		local Background7 = Instance.new("ImageLabel")
		local UIC77 = Instance.new("UICorner")
		local UIC7 = Instance.new("UICorner")
		local _8 = Instance.new("Frame")
		local TextButton8 = Instance.new("TextButton")
		local Front8 = Instance.new("ImageLabel")
		local UIC888 = Instance.new("UICorner")
		local Background8 = Instance.new("ImageLabel")
		local UIC88 = Instance.new("UICorner")
		local UIC8 = Instance.new("UICorner")
		local ListingLayouts = Instance.new("UIListLayout")
		local WhereButtonPadding = Instance.new("UIPadding")
		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		local Name = Instance.new("Frame")
		local NameTextbox = Instance.new("TextLabel")
		local NameUIT = Instance.new("UITextSizeConstraint")
		local NameUIC = Instance.new("UICorner")

		--Properties:

		ForsakextrasEmoteGUI.Name = "ForsakextrasEmoteGUI"
		ForsakextrasEmoteGUI.Parent = game:GetService("CoreGui")
		ForsakextrasEmoteGUI.ResetOnSpawn = false

		Holder.Name = "Holder"
		Holder.Parent = ForsakextrasEmoteGUI
		Holder.AnchorPoint = Vector2.new(0.5, 0.5)
		Holder.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Holder.BackgroundTransparency = 0.250
		Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Holder.BorderSizePixel = 0
		Holder.LayoutOrder = 1
		Holder.Position = UDim2.new(0.5, 0, 0.6, 0)
		Holder.Size = UDim2.new(0, 0, 0, 0)
		Holder.SizeConstraint = Enum.SizeConstraint.RelativeXY
		UICorner.Parent = Holder

		WhereTheButtons.Name = "WhereTheButtons"
		WhereTheButtons.Parent = Holder
		WhereTheButtons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		WhereTheButtons.BackgroundTransparency = 1.000
		WhereTheButtons.BorderColor3 = Color3.fromRGB(0, 0, 0)
		WhereTheButtons.BorderSizePixel = 0
		WhereTheButtons.Size = UDim2.new(1, -40, 1, 0)

		_1.Name = "1"
		_1.Parent = WhereTheButtons
		_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		_1.BackgroundTransparency = 0.700
		_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		_1.BorderSizePixel = 0
		_1.LayoutOrder = 1
		_1.Size = UDim2.new(0.125, 0, 1, 0)
		_1.ZIndex = 2

		TextButton1.Name = "TextButton1"
		TextButton1.Parent = _1
		TextButton1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextButton1.BackgroundTransparency = 1.000
		TextButton1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextButton1.BorderSizePixel = 0
		TextButton1.Size = UDim2.new(1, 0, 1, 0)
		TextButton1.ZIndex = 3
		TextButton1.Font = Enum.Font.FredokaOne
		TextButton1.Text = ""
		TextButton1.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton1.TextScaled = true
		TextButton1.TextSize = 10.000
		TextButton1.TextWrapped = true

		Front1.Name = "Front1"
		Front1.Parent = TextButton1
		Front1.AnchorPoint = Vector2.new(0.5, 0.5)
		Front1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Front1.BackgroundTransparency = 1.000
		Front1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Front1.BorderSizePixel = 0
		Front1.Position = UDim2.new(0.5, 0, 0.5, 0)
		Front1.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
		Front1.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Front1.ZIndex = 4
		Front1.Image = "rbxassetid://112068843495830"

		UIC111.Name = "UIC111"
		UIC111.Parent = Front1

		Background1.Name = "Background1"
		Background1.Parent = TextButton1
		Background1.AnchorPoint = Vector2.new(0.5, 0.5)
		Background1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background1.BackgroundTransparency = 1.000
		Background1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Background1.BorderSizePixel = 0
		Background1.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background1.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
		Background1.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Background1.ZIndex = 3
		Background1.Image = "rbxassetid://138110752460865"

		UIC11.Name = "UIC11"
		UIC11.Parent = Background1

		UIC1.Name = "UIC1"
		UIC1.Parent = _1

		_2.Name = "2"
		_2.Parent = WhereTheButtons
		_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		_2.BackgroundTransparency = 0.700
		_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		_2.BorderSizePixel = 0
		_2.LayoutOrder = 2
		_2.Size = UDim2.new(0.125, 0, 1, 0)
		_2.ZIndex = 2

		TextButton2.Name = "TextButton2"
		TextButton2.Parent = _2
		TextButton2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextButton2.BackgroundTransparency = 1.000
		TextButton2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextButton2.BorderSizePixel = 0
		TextButton2.Size = UDim2.new(1, 0, 1, 0)
		TextButton2.ZIndex = 3
		TextButton2.Font = Enum.Font.FredokaOne
		TextButton2.Text = ""
		TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton2.TextScaled = true
		TextButton2.TextSize = 10.000
		TextButton2.TextWrapped = true

		Front2.Name = "Front2"
		Front2.Parent = TextButton2
		Front2.AnchorPoint = Vector2.new(0.5, 0.5)
		Front2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Front2.BackgroundTransparency = 1.000
		Front2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Front2.BorderSizePixel = 0
		Front2.Position = UDim2.new(0.5, 0, 0.5, 0)
		Front2.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
		Front2.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Front2.ZIndex = 4
		Front2.Image = "rbxassetid://112068843495830"

		UIC222.Name = "UIC222"
		UIC222.Parent = Front2

		Background2.Name = "Background2"
		Background2.Parent = TextButton2
		Background2.AnchorPoint = Vector2.new(0.5, 0.5)
		Background2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background2.BackgroundTransparency = 1.000
		Background2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Background2.BorderSizePixel = 0
		Background2.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background2.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
		Background2.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Background2.ZIndex = 3
		Background2.Image = "rbxassetid://138110752460865"

		UIC22.Name = "UIC22"
		UIC22.Parent = Background2

		UIC2.Name = "UIC2"
		UIC2.Parent = _2

		_3.Name = "3"
		_3.Parent = WhereTheButtons
		_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		_3.BackgroundTransparency = 0.700
		_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
		_3.BorderSizePixel = 0
		_3.LayoutOrder = 3
		_3.Size = UDim2.new(0.125, 0, 1, 0)
		_3.ZIndex = 2

		TextButton3.Name = "TextButton3"
		TextButton3.Parent = _3
		TextButton3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextButton3.BackgroundTransparency = 1.000
		TextButton3.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextButton3.BorderSizePixel = 0
		TextButton3.Size = UDim2.new(1, 0, 1, 0)
		TextButton3.ZIndex = 3
		TextButton3.Font = Enum.Font.FredokaOne
		TextButton3.Text = ""
		TextButton3.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton3.TextScaled = true
		TextButton3.TextSize = 10.000
		TextButton3.TextWrapped = true

		Front3.Name = "Front3"
		Front3.Parent = TextButton3
		Front3.AnchorPoint = Vector2.new(0.5, 0.5)
		Front3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Front3.BackgroundTransparency = 1.000
		Front3.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Front3.BorderSizePixel = 0
		Front3.Position = UDim2.new(0.5, 0, 0.5, 0)
		Front3.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
		Front3.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Front3.ZIndex = 4
		Front3.Image = "rbxassetid://112068843495830"

		UIC333.Name = "UIC333"
		UIC333.Parent = Front3

		Background3.Name = "Background3"
		Background3.Parent = TextButton3
		Background3.AnchorPoint = Vector2.new(0.5, 0.5)
		Background3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background3.BackgroundTransparency = 1.000
		Background3.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Background3.BorderSizePixel = 0
		Background3.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background3.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
		Background3.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Background3.ZIndex = 3
		Background3.Image = "rbxassetid://138110752460865"

		UIC33.Name = "UIC33"
		UIC33.Parent = Background3

		UIC3.Name = "UIC3"
		UIC3.Parent = _3

		_4.Name = "4"
		_4.Parent = WhereTheButtons
		_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		_4.BackgroundTransparency = 0.700
		_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
		_4.BorderSizePixel = 0
		_4.LayoutOrder = 4
		_4.Size = UDim2.new(0.125, 0, 1, 0)
		_4.ZIndex = 2

		TextButton4.Name = "TextButton4"
		TextButton4.Parent = _4
		TextButton4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextButton4.BackgroundTransparency = 1.000
		TextButton4.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextButton4.BorderSizePixel = 0
		TextButton4.Size = UDim2.new(1, 0, 1, 0)
		TextButton4.ZIndex = 3
		TextButton4.Font = Enum.Font.FredokaOne
		TextButton4.Text = ""
		TextButton4.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton4.TextScaled = true
		TextButton4.TextSize = 10.000
		TextButton4.TextWrapped = true

		Front4.Name = "Front4"
		Front4.Parent = TextButton4
		Front4.AnchorPoint = Vector2.new(0.5, 0.5)
		Front4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Front4.BackgroundTransparency = 1.000
		Front4.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Front4.BorderSizePixel = 0
		Front4.Position = UDim2.new(0.5, 0, 0.5, 0)
		Front4.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
		Front4.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Front4.ZIndex = 4
		Front4.Image = "rbxassetid://112068843495830"

		UIC444.Name = "UIC444"
		UIC444.Parent = Front4

		Background4.Name = "Background4"
		Background4.Parent = TextButton4
		Background4.AnchorPoint = Vector2.new(0.5, 0.5)
		Background4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background4.BackgroundTransparency = 1.000
		Background4.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Background4.BorderSizePixel = 0
		Background4.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background4.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
		Background4.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Background4.ZIndex = 3
		Background4.Image = "rbxassetid://138110752460865"

		UIC44.Name = "UIC44"
		UIC44.Parent = Background4

		UIC4.Name = "UIC4"
		UIC4.Parent = _4

		_5.Name = "5"
		_5.Parent = WhereTheButtons
		_5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		_5.BackgroundTransparency = 0.700
		_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
		_5.BorderSizePixel = 0
		_5.LayoutOrder = 5
		_5.Size = UDim2.new(0.125, 0, 1, 0)
		_5.ZIndex = 2

		TextButton5.Name = "TextButton5"
		TextButton5.Parent = _5
		TextButton5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextButton5.BackgroundTransparency = 1.000
		TextButton5.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextButton5.BorderSizePixel = 0
		TextButton5.Size = UDim2.new(1, 0, 1, 0)
		TextButton5.ZIndex = 3
		TextButton5.Font = Enum.Font.FredokaOne
		TextButton5.Text = ""
		TextButton5.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton5.TextScaled = true
		TextButton5.TextSize = 10.000
		TextButton5.TextWrapped = true

		Front5.Name = "Front5"
		Front5.Parent = TextButton5
		Front5.AnchorPoint = Vector2.new(0.5, 0.5)
		Front5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Front5.BackgroundTransparency = 1.000
		Front5.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Front5.BorderSizePixel = 0
		Front5.Position = UDim2.new(0.5, 0, 0.5, 0)
		Front5.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
		Front5.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Front5.ZIndex = 4
		Front5.Image = "rbxassetid://112068843495830"

		UIC555.Name = "UIC555"
		UIC555.Parent = Front5

		Background5.Name = "Background5"
		Background5.Parent = TextButton5
		Background5.AnchorPoint = Vector2.new(0.5, 0.5)
		Background5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background5.BackgroundTransparency = 1.000
		Background5.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Background5.BorderSizePixel = 0
		Background5.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background5.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
		Background5.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Background5.ZIndex = 3
		Background5.Image = "rbxassetid://138110752460865"

		UIC55.Name = "UIC55"
		UIC55.Parent = Background5

		UIC5.Name = "UIC5"
		UIC5.Parent = _5

		_6.Name = "6"
		_6.Parent = WhereTheButtons
		_6.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		_6.BackgroundTransparency = 0.700
		_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
		_6.BorderSizePixel = 0
		_6.LayoutOrder = 6
		_6.Size = UDim2.new(0.125, 0, 1, 0)
		_6.ZIndex = 2

		TextButton6.Name = "TextButton6"
		TextButton6.Parent = _6
		TextButton6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextButton6.BackgroundTransparency = 1.000
		TextButton6.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextButton6.BorderSizePixel = 0
		TextButton6.Size = UDim2.new(1, 0, 1, 0)
		TextButton6.ZIndex = 3
		TextButton6.Font = Enum.Font.FredokaOne
		TextButton6.Text = ""
		TextButton6.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton6.TextScaled = true
		TextButton6.TextSize = 10.000
		TextButton6.TextWrapped = true

		Front6.Name = "Front6"
		Front6.Parent = TextButton6
		Front6.AnchorPoint = Vector2.new(0.5, 0.5)
		Front6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Front6.BackgroundTransparency = 1.000
		Front6.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Front6.BorderSizePixel = 0
		Front6.Position = UDim2.new(0.5, 0, 0.5, 0)
		Front6.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
		Front6.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Front6.ZIndex = 4
		Front6.Image = "rbxassetid://112068843495830"

		UIC666.Name = "UIC666"
		UIC666.Parent = Front6

		Background6.Name = "Background6"
		Background6.Parent = TextButton6
		Background6.AnchorPoint = Vector2.new(0.5, 0.5)
		Background6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background6.BackgroundTransparency = 1.000
		Background6.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Background6.BorderSizePixel = 0
		Background6.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background6.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
		Background6.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Background6.ZIndex = 3
		Background6.Image = "rbxassetid://138110752460865"

		UIC66.Name = "UIC66"
		UIC66.Parent = Background6

		UIC6.Name = "UIC6"
		UIC6.Parent = _6

		_7.Name = "7"
		_7.Parent = WhereTheButtons
		_7.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		_7.BackgroundTransparency = 0.700
		_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
		_7.BorderSizePixel = 0
		_7.LayoutOrder = 7
		_7.Size = UDim2.new(0.125, 0, 1, 0)
		_7.ZIndex = 2

		TextButton7.Name = "TextButton7"
		TextButton7.Parent = _7
		TextButton7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextButton7.BackgroundTransparency = 1.000
		TextButton7.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextButton7.BorderSizePixel = 0
		TextButton7.Size = UDim2.new(1, 0, 1, 0)
		TextButton7.ZIndex = 3
		TextButton7.Font = Enum.Font.FredokaOne
		TextButton7.Text = ""
		TextButton7.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton7.TextScaled = true
		TextButton7.TextSize = 10.000
		TextButton7.TextWrapped = true

		Front7.Name = "Front7"
		Front7.Parent = TextButton7
		Front7.AnchorPoint = Vector2.new(0.5, 0.5)
		Front7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Front7.BackgroundTransparency = 1.000
		Front7.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Front7.BorderSizePixel = 0
		Front7.Position = UDim2.new(0.5, 0, 0.5, 0)
		Front7.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
		Front7.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Front7.ZIndex = 4
		Front7.Image = "rbxassetid://112068843495830"

		UIC777.Name = "UIC777"
		UIC777.Parent = Front7

		Background7.Name = "Background7"
		Background7.Parent = TextButton7
		Background7.AnchorPoint = Vector2.new(0.5, 0.5)
		Background7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background7.BackgroundTransparency = 1.000
		Background7.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Background7.BorderSizePixel = 0
		Background7.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background7.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
		Background7.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Background7.ZIndex = 3
		Background7.Image = "rbxassetid://138110752460865"

		UIC77.Name = "UIC77"
		UIC77.Parent = Background7

		UIC7.Name = "UIC7"
		UIC7.Parent = _7

		_8.Name = "8"
		_8.Parent = WhereTheButtons
		_8.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		_8.BackgroundTransparency = 0.700
		_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
		_8.BorderSizePixel = 0
		_8.LayoutOrder = 8
		_8.Size = UDim2.new(0.125, 0, 1, 0)
		_8.ZIndex = 2

		TextButton8.Name = "TextButton8"
		TextButton8.Parent = _8
		TextButton8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextButton8.BackgroundTransparency = 1.000
		TextButton8.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextButton8.BorderSizePixel = 0
		TextButton8.Size = UDim2.new(1, 0, 1, 0)
		TextButton8.ZIndex = 3
		TextButton8.Font = Enum.Font.FredokaOne
		TextButton8.Text = ""
		TextButton8.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton8.TextScaled = true
		TextButton8.TextSize = 10.000
		TextButton8.TextWrapped = true

		Front8.Name = "Front8"
		Front8.Parent = TextButton8
		Front8.AnchorPoint = Vector2.new(0.5, 0.5)
		Front8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Front8.BackgroundTransparency = 1.000
		Front8.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Front8.BorderSizePixel = 0
		Front8.Position = UDim2.new(0.5, 0, 0.5, 0)
		Front8.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
		Front8.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Front8.ZIndex = 4
		Front8.Image = "rbxassetid://112068843495830"

		UIC888.Name = "UIC888"
		UIC888.Parent = Front8

		Background8.Name = "Background8"
		Background8.Parent = TextButton8
		Background8.AnchorPoint = Vector2.new(0.5, 0.5)
		Background8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background8.BackgroundTransparency = 1.000
		Background8.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Background8.BorderSizePixel = 0
		Background8.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background8.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
		Background8.SizeConstraint = Enum.SizeConstraint.RelativeXX
		Background8.ZIndex = 3
		Background8.Image = "rbxassetid://138110752460865"

		UIC88.Name = "UIC88"
		UIC88.Parent = Background8

		UIC8.Name = "UIC8"
		UIC8.Parent = _8

		ListingLayouts.Name = "ListingLayouts"
		ListingLayouts.Parent = WhereTheButtons
		ListingLayouts.FillDirection = Enum.FillDirection.Horizontal
		ListingLayouts.SortOrder = Enum.SortOrder.LayoutOrder
		ListingLayouts.VerticalAlignment = Enum.VerticalAlignment.Center
		ListingLayouts.HorizontalAlignment = Enum.HorizontalAlignment.Left
		ListingLayouts.Padding = UDim.new(0, 5)

		WhereButtonPadding.Name = "WhereButtonPadding"
		WhereButtonPadding.Parent = WhereTheButtons
		WhereButtonPadding.PaddingBottom = UDim.new(0, 5)
		WhereButtonPadding.PaddingLeft = UDim.new(0, 5)
		WhereButtonPadding.PaddingRight = UDim.new(0, 5)
		WhereButtonPadding.PaddingTop = UDim.new(0, 5)

		UIAspectRatioConstraint.Parent = Holder
		UIAspectRatioConstraint.AspectRatio = 9.000

		Name.Name = "Name"
		Name.Parent = Holder
		Name.AnchorPoint = Vector2.new(0.5, 1)
		Name.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Name.BackgroundTransparency = 0.250
		Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Name.BorderSizePixel = 0
		Name.Position = UDim2.new(0.5, 0, 1.29999995, 5)
		Name.Size = UDim2.new(1, 0, 0.300000012, 0)

		NameTextbox.Name = "NameTextbox"
		NameTextbox.Parent = Name
		NameTextbox.AnchorPoint = Vector2.new(0.5, 0.5)
		NameTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NameTextbox.BackgroundTransparency = 1.000
		NameTextbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NameTextbox.BorderSizePixel = 0
		NameTextbox.Position = UDim2.new(0.5, 0, 0.5, 0)
		NameTextbox.Size = UDim2.new(1, 0, 1, 0)
		NameTextbox.Font = Enum.Font.FredokaOne
		NameTextbox.Text = "Some Emote Name"
		NameTextbox.TextColor3 = Color3.fromRGB(255, 255, 255)
		NameTextbox.TextScaled = true
		NameTextbox.TextSize = 14.000
		NameTextbox.TextWrapped = true

		NameUIT.Name = "NameUIT"
		NameUIT.Parent = NameTextbox
		NameUIT.MaxTextSize = 30
		NameUIT.MinTextSize = 10

		NameUIC.Name = "NameUIC"
		NameUIC.Parent = Name

		local Images = {
			{ name = "Jumpstyle", renderImage = "rbxassetid://73574803924243" },
			{ name = "JumpingForJoy", renderImage = "rbxassetid://129614581942080" },
			{ name = "Drumsticks", renderImage = "rbxassetid://80678095206124" },
			{ name = "KazotskyKick", renderImage = "rbxassetid://132653220480177" },
			{ name = "MonsterMash", renderImage = "rbxassetid://73592720532565" },
			{ name = "CCShimmy", renderImage = "rbxassetid://92379847382802" },
			{ name = "AshleyLookAtMe", renderImage = "rbxassetid://101141010818082" },
			{ name = "Brickbattler", renderImage = "rbxassetid://97057214315889" },
			{ name = "AintNoLovinMyMan", renderImage = "rbxassetid://93998300527888" },
			{ name = "TwoTwoTwo", renderImage = "rbxassetid://96092312091932" },
			{ name = "Sukuna", renderImage = "rbxassetid://95950437854407" },
			{ name = "Silly", renderImage = "rbxassetid://121965062547127" },
			{ name = "StockDance", renderImage = "rbxassetid://136238391916155" },
			{ name = "GangnamStyle", renderImage = "rbxassetid://101388085235785" },
			{ name = "Khaled", renderImage = "rbxassetid://104716889279869" },
			{ name = "HeyNow", renderImage = "rbxassetid://93665655595946" },
			{ name = "Locked", renderImage = "rbxassetid://103241825392940" },
			{ name = "LethalCompany", renderImage = "rbxassetid://89769371017185" },
			{ name = "Headbanger", renderImage = "rbxassetid://126222345373558" },
			{ name = "SoRetro", renderImage = "rbxassetid://129885437120707" },
			{ name = "AICatDance", renderImage = "rbxassetid://93387041641721" },
			{ name = "SubjectThree", renderImage = "rbxassetid://83639505456623" },
			{ name = "Subterfuge", renderImage = "rbxassetid://71165177698139" },
			{ name = "Griddy", renderImage = "rbxassetid://71748174857033" },
			{ name = "Prince", renderImage = "rbxassetid://125197961882771" },
			{ name = "MissTheQuiet", renderImage = "rbxassetid://86125219137797" },
			{ name = "Hero", renderImage = "rbxassetid://78969991165860" },
			{ name = "PYT", renderImage = "rbxassetid://121927033287000" },
			{ name = "Wait", renderImage = "rbxassetid://106561882302009" },
			{ name = "No", renderImage = "rbxassetid://101973569734115" },
			{ name = "Konton", renderImage = "rbxassetid://135343313057075" },
			{ name = "TickTock", renderImage = "rbxassetid://112068843495830" },
			{ name = "Dio", renderImage = "rbxassetid://78716828045407" },
			{ name = "Shucks", renderImage = "rbxassetid://139634009593796" },
			{ name = "ThePhone", renderImage = "rbxassetid://91657126735088" },
			{ name = "Skeleton", renderImage = "rbxassetid://94678300716216" },
			{ name = "Insanity", renderImage = "rbxassetid://79579234154217" },
			{ name = "HakariDance", renderImage = "rbxassetid://124587965197013" },
			{ name = "SillyBilly", renderImage = "rbxassetid://96660516353249" },
			{ name = "Hotdog", renderImage = "rbxassetid://70514684116327" },
			{ name = "DistractionDance", renderImage = "rbxassetid://110811886859354" },
			{ name = "CaliforniaGirls", renderImage = "rbxassetid://127260772788474" },
			{ name = "AolGuy", renderImage = "rbxassetid://81493512531467" },
			{ name = "Eggrolled", renderImage = "rbxassetid://75402218293560" },
			{ name = "BagUp", renderImage = "rbxassetid://135883870615399" },
			{ name = "Poisoned", renderImage = "rbxassetid://92399495788269" },
			{ name = "Wave", renderImage = "rbxassetid://132063131763271" },
		}

		local buttons = {
			TextButton1,
			TextButton2,
			TextButton3,
			TextButton4,
			TextButton5,
			TextButton6,
			TextButton7,
			TextButton8,
		}

		local function GetEmoteList()
			local player = game:GetService("Players").LocalPlayer
			local emotes = player:FindFirstChild("PlayerData")
					and player.PlayerData:FindFirstChild("Equipped")
					and player.PlayerData.Equipped:FindFirstChild("Emotes")
					and player.PlayerData.Equipped.Emotes.Value
				or ""
			local emoteList = {}
			for i, emote in ipairs(string.split(emotes, "|")) do
				local EmoteImage = ""
				for _, image in ipairs(Images) do
					if image.name == emote then
						EmoteImage = image.renderImage
						break
					end
				end
				table.insert(emoteList, { index = i, name = emote, renderImage = EmoteImage })
			end
			return emoteList
		end

		local emoteList = GetEmoteList()

		local function SetImages()
			for i, button in ipairs(buttons) do
				local emote = emoteList[i]
				if emote and emote.renderImage ~= "" then
					button:FindFirstChild("Front" .. i).Image = emote.renderImage
				else
					button.Text = ""
					for _, child in ipairs(button:GetChildren()) do
						if child:IsA("ImageLabel") then
							child:Destroy()
						end
					end
				end
			end
		end

		SetImages()

		for i, button in ipairs(buttons) do
			button.MouseEnter:Connect(function()
				local emote = emoteList[i]
				if emote and emote.name ~= "" then
					NameTextbox.Text = emote.name
				end
			end)
		end

		local TweenServiceFish = game:GetService("TweenService")

		local Blur = Instance.new("BlurEffect", game:GetService("Lighting"))
		Blur.Size = 0
		Blur.Name = "Blur"

		local tweenInfoFishBlur = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
		local tweenFishBlur = TweenServiceFish:Create(Blur, tweenInfoFishBlur, { Size = 0 })
		tweenFishBlur:Play()

		local tweeninfoholdersize = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
		local tweenholdersize =
			TweenServiceFish:Create(Holder, tweeninfoholdersize, { Size = UDim2.new(0.8 * 0.8, 0, 0.15 * 0.8, 0) })
		tweenholdersize:Play()

		for i, button in ipairs(buttons) do
			button.Activated:Connect(function()
				local PlayThingText = emoteList[i].name

				local ohString1 = "PlayEmote"
				local ohString2 = "Animations"
				local ohString3 = "TickTock"
				game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent
					:FireServer(ohString1, ohString2, PlayThingText)

				local TweenService = game:GetService("TweenService")

				local originalSize = Holder.Size
				local DestinationSize = UDim2.new(0, 0, 0, 0)

				local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
				local tween = TweenService:Create(Holder, tweenInfo, { Size = DestinationSize })
				local tweenblurinfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
				local tweenblur = TweenService:Create(Blur, tweenblurinfo, { Size = 0 })

				tweenblur:Play()
				tween:Play()
				task.wait(0.25)
				ForsakextrasEmoteGUI:Destroy()
			end)
		end
	end

	local function GetAssetList()
		local url = "https://api.github.com/repos/allelahh/forsakextras/git/trees/main?recursive=1"
		local assetList = {}

		local success, errorMessage = pcall(function()
			local Request = http_request or syn.request or request
			if Request then
				local response = Request({
					Url = url,
					Method = "GET",
					Headers = { ["Content-Type"] = "application/json" },
				})

				if response and response.Body then
					local data = game:GetService("HttpService"):JSONDecode(response.Body)
					for _, item in ipairs(data.tree) do
						if
							item.path:match("^Assets/.+%.png$")
							or item.path:match("^Assets/.+%.mp4$")
							or item.path:match("Assets/(.+)%.mp3$")
						then
							local rawUrl = "https://github.com/allelahh/forsakextras/raw/refs/heads/main/" .. item.path
							local rawUrlTxt = "https://raw.githubusercontent.com/allelahh/forsakextras/" .. item.path
							table.insert(assetList, rawUrl)

							local name = item.path:match("Assets/(.+)%.png$") or item.path:match("Assets/(.+)%.mp4$")
							if name then
								--table.insert(NameProtectNames, name)
							end
						end
					end
				end
			end
		end)

		if not success then
			Rayfield:Notify({ Title = "Error", Content = errorMessage, Duration = 5 })
		end
		return assetList
	end

	local function DownloadBallers(url, path)
		if not isfile(path) then
			local suc, res = pcall(function()
				return game:HttpGet(url, true)
			end)
			if not suc or res == "404: Not Found" then
				Rayfield:Notify({ Title = "Download error", Content = path.." : "..res, Duration = 5 })
			else
				Rayfield:Notify({ Title = "Downloaded", Content = path, Duration = 1, Image = "download" })
			end
			if suc then
				writefile(path, res)
			end
		end
	end
	local function CheckIfStuffsDownloaded()
		local assetList = GetAssetList()
		local basePath = "Forsakextras/Assets/"
		if not isfolder("Forsakextras") then
			makefolder("Forsakextras")
		end
		if not isfolder(basePath) then
			makefolder(basePath)
		end
		for _, url in ipairs(assetList) do
			local filePath = basePath .. url:match("Assets/(.+)")
			if filePath then
				local newFilePath =
					filePath:gsub("%.png$", ".png.Stuff"):gsub("%.mp4$", ".mp4.Stuff4"):gsub("%.mp3$", ".mp3")
				if not isfile(newFilePath) then
					local folderPath = newFilePath:match("(.*/)")
					if folderPath and not isfolder(folderPath) then
						makefolder(folderPath)
					end
					DownloadBallers(url, newFilePath)
				end
			end
		end
	end

	local function LoadAsset(assetName)
		local basePath = "Forsakextras/Assets/"
		local assetPath = basePath .. assetName

		if isfile(assetPath) then
			return getcustomasset(assetPath)
		else
			return nil
		end
	end

	local function insertHolderToTable(tableval:table)
		local holder = Instance.new("Pants")
		holder.Parent = game.CoreGui
		table.insert(tableval, holder)
	end

	insertHolderToTable(activeHitboxes)

	local function LastStandingReplacement(state)
		ReplaceStandingMusic = state
		local LastStandingFolder = workspace.Themes
		if ReplaceStandingMusic then
			if LastStandingFolder then
				local connection = LastStandingFolder.ChildAdded:Connect(function(child)
					if child:IsA("Sound") and child.Name == "LastSurvivor" then
						child.SoundId = getcustomasset("Forsakextras/Assets/LastStandingMusic/" .. tostring(CurrentMusic))
						child.TimePosition = 0
						child.Volume = lmsmusicvolume
					end
				end)
				table.insert(MusicConnections, connection)
			end
		else
			if LastStandingFolder and LastStandingFolder.ChildAdded then
				Rayfield:Notify({
					Title = "Disabled Music Replace",
					Content = "Music Will Go Back To Normal Next Round",
					Duration = 10,
					Image = "music",
				}) -- 😭😭😭😭😭😭
				for _, connection in ipairs(MusicConnections) do
					connection:Disconnect()
				end
			end
		end
	end

	local function ChangeMusic(music, volume)
		local LastStandingFolder = workspace.Themes
		if LastStandingFolder then
			for _, child in ipairs(LastStandingFolder:GetChildren()) do
				if child:IsA("Sound") and child.Name == "LastSurvivor" then
					if volume then
						task.spawn(function()
							while child and task.wait(.1) do
								child.Volume = lmsmusicvolume
							end
						end)
					else
						child.SoundId = getcustomasset("Forsakextras/Assets/LastStandingMusic/" .. tostring(music))
						child.TimePosition = 0
					end
				end
			end
		end
	end

	local function replaceHitsound(sound)
  		if sound:IsA("Sound") and sound.SoundId == "rbxassetid://" .. HitsoundID.Value --[[and LocalPlayer.Character.Parent.Name == "Survivors"]] then
        	local newSoundId = getcustomasset("Forsakextras/Assets/CustomHitsounds/" .. tostring(CustomHitsoundId))
 	    	sound.SoundId = newSoundId
			sound.Volume = HitsoundVolume
			sound.TimePosition = 0
    	end
	end

	soundsFolder.ChildAdded:Connect(function(child)
    	if child:IsA("Sound") then
			if CustomHitsound == true then
        		replaceHitsound(child)
			end
    	end
	end)

	HitboxesFolder.ChildAdded:Connect(function(child)
		print(child.Name)
		if --[[child:IsA("Part") and]] child.Name == Players.LocalPlayer.Name.."Hitbox" then
			table.insert(activeHitboxes, child)
			hitDetected = false
			swingInProgress = true
	
			local connection
			local startTime = os.clock() -- capture the time when the hitbox appears

			connection = RunService.Heartbeat:Connect(function()
				if not child:IsDescendantOf(workspace) then
					print("disconnecting connection and returning")
					connection:Disconnect()
					return
				end

				if child.Color == HitboxHitColor then
					hitDetected = true
				end

				if hitDetected == false --[[and swingInProgress == true]] and os.clock() - startTime >= timetocallmiss and misssoundcooldown == false then
					misssoundcooldown = true
					task.delay(misssoundcooldowntime, function()
						misssoundcooldown = false
					end)
					
					hitDetected = true -- mark it as handled so it doesn't trigger again
					startTime = os.clock()
					
					print("miss detected ("..timetocallmiss.." secs)")

					connection:Disconnect()
					task.spawn(function()
						for i = #activeHitboxes, 1, -1 do
							table.remove(activeHitboxes, i)
						end
					end)

					--swingInProgress = false

					if MissSound == true then
						MissSound = not MissSound
						local NewSoundId = getcustomasset("Forsakextras/Assets/MissSounds/" .. tostring(MissSoundId))
						local NewVolume = MissSoundVolume
						local sadgasdg = Instance.new("Sound")
						sadgasdg.Parent = soundsFolder
						sadgasdg.SoundId = NewSoundId
						sadgasdg.Volume = NewVolume or 1
						sadgasdg.TimePosition = 0
				
						sadgasdg:Play()

						--task.wait()
						task.delay(15, function()
							sadgasdg:Destroy()
						end)
						MissSound = not MissSound
					end
					return
				end
			end)

		end
	end)

	RunService.Heartbeat:Connect(function()
		for i = #activeHitboxes, 1, -1 do
			if not activeHitboxes[i]:IsDescendantOf(workspace) then
				table.remove(activeHitboxes, i)

				--insertHolderToTable(activeHitboxes)
			end
		end

		if swingInProgress == true and #activeHitboxes == 0 then
			swingInProgress = false

			if hitDetected == false and MissSound == true then
				MissSound = not MissSound
				print("miss detected")
				local NewSoundId = getcustomasset("Forsakextras/Assets/MissSounds/" .. tostring(MissSoundId))
				local NewVolume = MissSoundVolume
				local sadgasdg = Instance.new("Sound")
				sadgasdg.Parent = soundsFolder
				sadgasdg.SoundId = NewSoundId
				sadgasdg.Volume = NewVolume or 1
				sadgasdg.TimePosition = 0
				
				sadgasdg:Play()

				--task.wait()
				task.delay(15, function()
					sadgasdg:Destroy()
				end)
				MissSound = not MissSound
			end
		end
	end)

	Rayfield:Notify({
		Title = supportedExecutors[executorname] and executorname .. " Executor Supported"
			or executorname .. " Executor Not Supported",
		Content = supportedExecutors[executorname] and executorname .. " No Errors Expected"
			or executorname .. " Errors Expected",
		Image = supportedExecutors[executorname] and "check" or "ban",
		Duration = 5,
	})

	local function GeneratorOnce()
		local StuffIngameFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
		local StuffNapFolder = StuffIngameFolder and StuffIngameFolder:FindFirstChild("Map")
		if StuffNapFolder then
			for _, g in ipairs(StuffNapFolder:GetChildren()) do
				if g.Name == "Generator" and g.Progress.Value < 100 then
					if generatorCooldown == false then
						g.Remotes.RE:FireServer()
					end
				end
			end
		end
	end --i'll see if i remove this later but maybe i can do smth with it
	--cus, for me for example, my mouse is broken in a way where dragging things is a PAIN
	--because it just spam clicks whenever i try dragging smth for some reason??
	--so i can't really do generators rn
	--and im telling u i def can, and pretty fast, i have 11 days im not new or smth (not trying to flex srry in advance 💔)
	--this is the only reason

	local function NotifyForsakextrasers(Player)
		local character = Player.Character
		local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
		local temporaryUI = playerGui:FindFirstChild("TemporaryUI")
		local playerInfo = temporaryUI and temporaryUI:FindFirstChild("PlayerInfo")
		local currentSurvivors = playerInfo and playerInfo:FindFirstChild("CurrentSurvivors")

		if
			not table.find(CheckedPlayers, Player.Name)
			and Player.Name ~= game:GetService("Players").LocalPlayer.Name
		then
			if enableHackerDetecting == true then
				Rayfield:Notify({
					Title = Player.Name .. " Is 'Hacking'.",
					Content = ("(Fart/Saken as in-game pronouns)"),
					Duration = 20,
					Image = "angry",
				})
			end
			table.insert(CheckedPlayers, Player.Name)
		end

		if character and currentSurvivors then
			for _, survivor in pairs(currentSurvivors.Parent:GetDescendants()) do
				if survivor:FindFirstChild("Username") and survivor.Username.Text == Player.Name then
					survivor.Username.TextColor3 = Color3.fromRGB(170, 255, 127)
				end
			end
		end
	end

	task.spawn(function()
		while true do
			for _, player in ipairs(game.Players:GetPlayers()) do
				local success, err = pcall(function()
					local Pronouns = player
						:WaitForChild("PlayerData")
						:WaitForChild("Settings")
						:WaitForChild("Accessibility")
						:WaitForChild("Pronouns")
					if Pronouns.Value == "Fart/Hub" then
						NotifyForsakextrasers(player)
					end
				end)

				if not success then
					warn(err)
				end
			end
			task.wait(5)
		end
	end)

	local function BUTTONGUIPLSSSSSSSSSSSSSS()
		local visible = true
		local SausageHolder =
			game:GetService("CoreGui"):FindFirstChild("TopBarApp"):FindFirstChild("UnibarLeftFrame").UnibarMenu["2"]
		local originalSize = SausageHolder.Size.X.Offset
		SausageHolder.Size = UDim2.new(0, originalSize + 144, 0, SausageHolder.Size.Y.Offset)

		for i = 1, 3 do
			local buttonFrame = Instance.new("Frame", SausageHolder)
			buttonFrame.Name = i .. "-ButtonFrame"
			buttonFrame.Size = UDim2.new(0, 44, 0, 44)
			buttonFrame.BackgroundTransparency = 1
			buttonFrame.BorderSizePixel = 0
			buttonFrame.Position = UDim2.new(0, SausageHolder.Size.X.Offset - (48 * (4 - i)), 0, 0)
			buttonFrames[i] = buttonFrame

			local imageButton = Instance.new("ImageButton", buttonFrame)
			imageButton.Name = i .. "-imageButtonStuff"
			imageButton.BackgroundTransparency = 1
			imageButton.BorderSizePixel = 0
			imageButton.Size = UDim2.new(0, 32, 0, 32)
			imageButton.AnchorPoint = Vector2.new(0.5, 0.5)
			imageButton.Position = UDim2.new(0.5, 0, 0.5, 0)
			imageButtons[i] = imageButton
		end

		local imageButton1, imageButton2 = imageButtons[1], imageButtons[2]

		local function Turnguionoroffeasy()
			--visible = not visible
			--Rayfield:SetVisibility(visible, false)
			--sausageHolder.Size = UDim2.new(0, originalSize + (visible and 48 or 0), 0, sausageHolder.Size.Y.Offset)

			local Lighting = game:GetService("Lighting")
			local CoreGui = game:GetService("CoreGui")

			local EmoteGUI = CoreGui:FindFirstChild("ForsakextrasEmoteGUI")
			local BlurEffect = Lighting:FindFirstChild("Blur")

			if EmoteGUI then
				LopticaCooldown = true
				local Holder = EmoteGUI:FindFirstChild("Holder")
				if Holder then
					local BlurTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
					local TweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

					if BlurEffect then
						local blurTween = TweenService:Create(BlurEffect, BlurTweenInfo, { Size = 0 })
						blurTween:Play()
					end

					local guiTween = TweenService:Create(Holder, TweenInfo, { Size = UDim2.new(0, 0, 0, 0) })
					guiTween:Play()

					task.wait(0.25)

					if BlurEffect then
						BlurEffect:Destroy()
					end
					EmoteGUI:Destroy()
				end

				task.delay(1, function()
					LopticaCooldown = false
				end)
			else
				WHATTHEFUCKISTHISSHITCODEKLDOWQNDJQW() -- Open the UI
			end
		end

		local function Toolytippy(button, desc)
			if button:FindFirstChild("Tooltip") then
				return
			end

			local tooltip = Instance.new("Frame")
			tooltip.Name = "Tooltip"
			tooltip.Size = UDim2.new(0, 0, 0, 0)
			tooltip.Position = UDim2.new(0.5, 0, 1.5, 18)
			tooltip.AnchorPoint = Vector2.new(0.5, 0.5)
			tooltip.BackgroundTransparency = 0.08
			tooltip.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
			tooltip.Parent = button

			local tooltipUIC = Instance.new("UICorner")
			tooltipUIC.CornerRadius = UDim.new(1, 0)
			tooltipUIC.Parent = tooltip

			local text = Instance.new("TextLabel")
			text.Name = desc
			text.TextSize = 15
			text.Text = desc
			text.Size = UDim2.new(1, 0, 1, 0)
			text.BackgroundTransparency = 1
			text.TextColor3 = Color3.fromRGB(255, 255, 255)
			text.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			text.Parent = tooltip

			local tween = game:GetService("TweenService"):Create(
				tooltip,
				TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Size = UDim2.new(0, 150, 0, 44) }
			)
			tween:Play()
		end

		local function editeverythingpls()
			if imageButton1 then
				imageButton1.Image = "http://www.roblox.com/asset/?id=111190623546159"
				imageButton1.Activated:Connect(Turnguionoroffeasy)
				imageButton1.MouseEnter:Connect(function()
					Toolytippy(imageButton1, "Animation UI")
				end)
				imageButton1.MouseLeave:Connect(function()
					local tooltip = imageButton1:FindFirstChild("Tooltip")
					if tooltip then
						tooltip:Destroy()
					end
				end)
			end
		end

		task.spawn(function()
			pcall(editeverythingpls)
		end)

		SausageHolder:GetPropertyChangedSignal("Size"):Connect(function()
			if SausageHolder.Size.X.Offset == originalSize then
				SausageHolder.Size = UDim2.new(0, originalSize + 144, 0, SausageHolder.Size.Y.Offset)
			end
		end)
	end

	local function updateFileList(foldername: string, list: table)
		local existingFiles = {}
			for _, audio in ipairs(listfiles("Forsakextras/Assets/"..foldername)) do
				print(audio)
				if string.find(audio, "mp3") then
					local name = string.gsub(audio, "^.*/", "")  -- removes everything up to the last '/'
					print(name)  --> muisic,mp3
					if name then
						existingFiles[name] = true
						local found = false
						for _, tableaudio in ipairs(list) do
							if tableaudio == name then
								found = true
								break
							end
						end
						if not found then
							table.insert(list, name)
						end
					end
				end
			end

			-- Remove any audio from the list that's not in existingFiles
			for i = #list, 1, -1 do
				if not existingFiles[list[i]] then
					table.remove(list, i)
				end
			end
	end

	local function updateMusicList()
		updateFileList("LastStandingMusic", MusicList)
	end

	local function updateHitsoundList()
		updateFileList("CustomHitsounds", CustomHitsoundList)
	end

	local function updateMissSoundList()
		updateFileList("MissSounds", MissSoundList)
	end

	updateMusicList()

	updateHitsoundList()

	updateMissSoundList()

	local function CreateFishFrame()
		local visible = true
		local topBarApp = game:GetService("CoreGui"):FindFirstChild("TopBarApp")
		local leftFrame = topBarApp:WaitForChild("TopBarFrame"):WaitForChild("LeftFrame")

		local FishFrame = Instance.new("Frame", leftFrame)
		FishFrame.Name = "FishFrame"
		FishFrame.Size = UDim2.new(0, 32, 0, 32)
		FishFrame.Position = UDim2.new(0, 0, 1, 0)
		FishFrame.BackgroundTransparency = 1
		FishFrame.LayoutOrder = 5

		local background = Instance.new("ImageLabel", FishFrame)
		background.Name = "Background"
		background.Size = UDim2.new(0, 32, 0, 32)
		background.Position = UDim2.new(0, 0, 0, 0)
		background.Image = "rbxasset://textures/ui/TopBar/iconBase.png"
		background.BackgroundTransparency = 1

		local icon = Instance.new("ImageButton", background)
		icon.Name = "Icon"
		icon.Size = UDim2.new(0, 36, 0, 36)
		icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		icon.AnchorPoint = Vector2.new(0.5, 0.5)
		icon.Image = "http://www.roblox.com/asset/?id=131523679474566"
		icon.BackgroundTransparency = 1

		local function toggleGUI()
			visible = not visible
			Rayfield:show(visible)
		end
		icon.Activated:Connect(toggleGUI)
	end

	local function MakeButton()
		pcall(function()
			if
				game:GetService("CoreGui"):FindFirstChild("TopBarApp")
				and game:GetService("CoreGui"):FindFirstChild("TopBarApp"):FindFirstChild("UnibarLeftFrame")
			then
				BUTTONGUIPLSSSSSSSSSSSSSS()
			else
				CreateFishFrame()
			end
		end)
	end
	
	local function InitializeGUI()
		AudioTab = GUI:CreateTab("Audio", "music")
		QOLTab = GUI:CreateTab("Quality-of-Life", "award")
		MiscsTab = GUI:CreateTab("Misc", "ghost")

		--GUI:Credit({ Name = "ivannetta", Description = "meowzer", Discord = "ivannetta" })

		Rayfield:Notify({
			Title = "Most stuff made by ivannetta",
			Content = "I feel so silly!",
			Duration = 7.2,
			Image = "user-check",
		})

		Rayfield:Notify({
			Title = "Made into a QOL script by",
			Content = "'llel'",
			Duration = 7.2,
			Image = "users",
		})


		-- Audio Tab

		AudioTab:CreateSection("music replacement :O")

		local MusicDropdown = AudioTab:CreateDropdown({
			Name = "Music List",
			Options = {},
			CurrentOption = "Bonetrousle.mp3",
			Flag = "ChosenMusic",
			MultiSelection = false,
			Callback = function(OptionChosen)
				CurrentMusic = OptionChosen[1]
				print(CurrentMusic)
				if ReplaceStandingMusic then
					ChangeMusic(CurrentMusic)
				end
			end,
		})

		AudioTab:CreateSection("to see ur custom audios on the list; add them to")
		AudioTab:CreateSection(ExecutorNameString.."/workspace/Forsakextras/Assets/LastStandingMusic")
		local RefreshButton = AudioTab:CreateButton({
			Name = "Refresh music list",
			Callback = function(keybind)
				updateMusicList()
				task.wait()
				for _, music in ipairs(MusicList) do
					MusicDropdown:Refresh(MusicList)
				end
			end,
		})
		AudioTab:CreateSection("and press the button above")

		local VolumeSlider = AudioTab:CreateSlider({
  			Name = "Music Volume",
   			Range = {0.1, 10},
   			Increment = 0.1,
   			Suffix = "LMSVolume",
   			CurrentValue = 1,
   			Flag = "ReplaceLMSVolume", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   			Callback = function(Value)
				lmsmusicvolume = Value

				if ReplaceStandingMusic then
					ChangeMusic(CurrentMusic, lmsmusicvolume)
				end
   			end,
		})

		local MusicToggle = AudioTab:CreateToggle({
			Name = "Replace Last Standing Music",
			CurrentValue = false,
   			Flag = "ReplaceLMSToggle",
			Callback = function(state)
				print(CurrentMusic)
				if CurrentMusic == ("???" or "empty" or nil) then return end
				LastStandingReplacement(state)
				if ReplaceStandingMusic then
					ChangeMusic(CurrentMusic)
				end
			end,
		})

		local AudioDivider1 = AudioTab:CreateDivider()

		AudioTab:CreateSection("custom hitsounds?!")

		local HitsoundDropdown = AudioTab:CreateDropdown({
			Name = "Hitsound List",
			Options = {},
			CurrentOption = "Hitsound.mp3",
			Flag = "ChosenHitsound",
			MultiSelection = false,
			Callback = function(OptionChosen)
				CustomHitsoundId = OptionChosen[1]
				print(CustomHitsoundId)
			end,
		})

		AudioTab:CreateSection("to see ur custom audios on the list; add them to")
		AudioTab:CreateSection(ExecutorNameString.."/workspace/Forsakextras/Assets/CustomHitsounds")
		local HitsoundRefreshButton = AudioTab:CreateButton({
			Name = "Refresh Hitsound list", 
			Callback = function(keybind)
				updateHitsoundList()
				task.wait()
				for _, hitsound in ipairs(CustomHitsoundList) do
					HitsoundDropdown:Refresh(CustomHitsoundList)
				end
			end,
		})
		AudioTab:CreateSection("and press the button above")

		local HitsoundVolumeSlider = AudioTab:CreateSlider({
  			Name = "Hitsound Volume",
   			Range = {0.1, 10},
   			Increment = 0.1,
   			Suffix = "Hit Volume",
   			CurrentValue = 1,
   			Flag = "CustomHitsoundVolume", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   			Callback = function(Value)
				HitsoundVolume = Value
   			end,
		})

		local HitsoundToggle = AudioTab:CreateToggle({
			Name = "Custom Hitsound",
			CurrentValue = false,
   			Flag = "CustomHitsoundToggle",
			Callback = function(state)
				print(CustomHitsoundId)
				if CustomHitsoundId == ("???" or "empty" or nil) then return end
				CustomHitsound = state
			end,
		})
		AudioTab:CreateSection("if it doesn't work, try setting a hitsound ID in")
		AudioTab:CreateSection("forsaken settings, it can even be '12345'")

		local AudioDivider2 = AudioTab:CreateDivider()

		AudioTab:CreateSection("-- FUNNY AUDIO SECTION --")

		local AudioDivider2 = AudioTab:CreateDivider()

		AudioTab:CreateSection("miss sounds, my oh my!!!")
		AudioTab:CreateSection("(warning: kinda glitchy as 1x4 or coolkid)")

		local MissSoundDropdown = AudioTab:CreateDropdown({
			Name = "Miss Sound List",
			Options = {},
			CurrentOption = "miss.mp3",
			Flag = "ChosenMissSound",
			MultiSelection = false,
			Callback = function(OptionChosen)
				MissSoundId = OptionChosen[1]
				print(MissSoundId)
			end,
		})

		AudioTab:CreateSection("to see ur custom audios on the list; add them to")
		AudioTab:CreateSection(ExecutorNameString.."/workspace/Forsakextras/Assets/MissSounds")
		local MissSoundRefreshButton = AudioTab:CreateButton({
			Name = "Refresh Miss Sound list", 
			Callback = function(keybind)
				updateMissSoundList()
				task.wait()
				for _, miss in ipairs(MissSoundList) do
					MissSoundDropdown:Refresh(MissSoundList)
				end
			end,
		})
		AudioTab:CreateSection("and press the button above")

		local MissSoundVolumeSlider = AudioTab:CreateSlider({
  			Name = "Miss Sound Volume",
   			Range = {0.1, 10},
   			Increment = 0.1,
   			Suffix = "Miss Volume",
   			CurrentValue = 1,
   			Flag = "MissSoundVolumeFlag", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   			Callback = function(Value)
			   	print(Value)
				MissSoundVolume = Value
				task.wait()
				print(MissSoundVolume)
   			end,
		})

		local MissSoundToggle = AudioTab:CreateToggle({
			Name = "Enable Miss Sound",
			CurrentValue = false,
   			Flag = "MissSoundToggle",
			Callback = function(state)
				print(MissSoundId)
				if MissSoundId == ("???" or "empty" or nil) then return end
				MissSound = state
			end,
		})
		AudioTab:CreateSection("if it doesn't work, that's a glitch")
		AudioTab:CreateSection("report it to me and check F9 for any errors 💔")


		-- QOL Tab

		local Rejoin = QOLTab:CreateButton({
			Name = "Rejoin",
			Callback = function()
				Rejoined = true
				game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)	
			end,
		})
		
		QOLTab:CreateSection("you can switch out emotes mid round with this!:")
		local ToggleMenus = QOLTab:CreateButton({
			Name = "Toggle inventory screen",
			Callback = function()
				local localplayer = game.Players.LocalPlayer
				local mainy = localplayer.PlayerGui.MainUI

				if localplayer.Character.Parent.Name == "Spectating" then
					Rayfield:Notify({
								Title = "Error while toggling",
								Content = "You need to be in a round for this.",
								Duration = 5,
								Image = "triangle-alert",
							})
					return
				end
				
				if mainy.InventoryScreen.Visible == false then
					mainy.InventoryScreen.Visible = true
					mainy.InventoryScreen.Size = UDim2.new(1, -20, 1, -20)
				else
					mainy.InventoryScreen.Visible = false
					mainy.InventoryScreen.Size = UDim2.new(1, -20, 0, 0)
				end
			end,
		})
		local ToggleMenus = QOLTab:CreateButton({
			Name = "Toggle shop screen",
			Callback = function()
				local localplayer = game.Players.LocalPlayer
				local mainy = localplayer.PlayerGui.MainUI

				if localplayer.Character.Parent.Name == "Spectating" then
					Rayfield:Notify({
								Title = "Error while toggling",
								Content = "You need to be in a round for this.",
								Duration = 5,
								Image = "triangle-alert",
							})
					return
				end
				
				if mainy.ShopScreen.Visible == false then
					mainy.ShopScreen.Visible = true
					mainy.ShopScreen.Size = UDim2.new(1, -20, 1, -20)
				else
					mainy.ShopScreen.Visible = false
					mainy.ShopScreen.Size = UDim2.new(1, -20, 0, 0)
				end
			end,
		})
		QOLTab:CreateSection("(or change some settings):")
		local ToggleMenus = QOLTab:CreateButton({
			Name = "Toggle settings screen",
			Callback = function()
				local localplayer = game.Players.LocalPlayer
				local mainy = localplayer.PlayerGui.MainUI

				if localplayer.Character.Parent.Name == "Spectating" then
					Rayfield:Notify({
								Title = "Error while toggling",
								Content = "You need to be in a round for this.",
								Duration = 5,
								Image = "triangle-alert",
							})
					return
				end
				
				if mainy.SettingsScreen.Visible == false then
					mainy.SettingsScreen.Visible = true
					mainy.SettingsScreen.Size = UDim2.new(1, -20, 1, -20)
				else
					mainy.SettingsScreen.Visible = false
					mainy.SettingsScreen.Size = UDim2.new(1, -20, 0, 0)
				end
			end,
		})

		local ToggleMenus = QOLTab:CreateButton({
			Name = "Toggle Player list",
			Callback = function()
				local localplayer = game.Players.LocalPlayer
				local mainy = localplayer.PlayerGui.MainUI
				local plrlist = mainy.PlayerListHolder

				if localplayer.Character.Parent.Name == "Spectating" then
					plrlist.Visible = true

					plrlist.Contents.Visible = true

					plrlist.Contents.Players.Visible = true
					plrlist.Contents.Players.Position = UDim2.new(0.5, 0, 1, -7)
					plrlist.Contents.Players.Size = UDim2.new(0.9, 0, 1, -50)

					plrlist.Contents.InfoTypes.Visible = true
					plrlist.Contents.InfoTypes.Position = UDim2.new(0.5, 0, 0, 18)
					plrlist.Contents.InfoTypes.Size = UDim2.new(0.8, 0, 0.05, 10)

					plrlist.Close.Visible = true

					plrlist.Background.Visible = true
					plrlist.Contents.Players.Active = true

					plrlist.Contents.Position = UDim2.new(0.5, 0, 0.5, 0)
					plrlist.Contents.Size = UDim2.new(1, 0, 1, 0)

					plrlist.Position = UDim2.new(1, -5, 0, 5)
					plrlist.Size = UDim2.new(0.2, 50, 0.2, 50)

					--plrlist.UiAspectRatioConstraint.AspectRatio = 1.55

					Rayfield:Notify({
								Title = "Error while toggling",
								Content = "You need to be in a round for this.",
								Duration = 5,
								Image = "triangle-alert",
							})
					return
				end

				if plrlist.Contents.Position ~= UDim2.new(0.5, -350, 0.5, 0) then
					plrlist.Visible = true

					plrlist.Contents.Visible = true

					--[[plrlist.Contents.Players.Visible = true
					plrlist.Contents.Players.Position = UDim2.new(0.5, 0, 1, -7)
					plrlist.Contents.Players.Size = UDim2.new(0.949999988, 0, 1, -50)

					plrlist.Contents.InfoTypes.Visible = true
					plrlist.Contents.InfoTypes.Position = UDim2.new(0.5, 0, 0, 18)
					plrlist.Contents.InfoTypes.Size = UDim2.new(0.899999976, 0, 0.0500000007, 10)

					plrlist.Close.Visible = true

					plrlist.Background.Visible = true
					plrlist.Contents.Players.Active = true]]

					plrlist.Contents.Position = UDim2.new(0.5, -350, 0.5, 0)
					plrlist.Contents.Size = UDim2.new(1, 0, 1, 0)

					--[[plrlist.Position = UDim2.new(1, -5, 0, 5)
					plrlist.Size = UDim2.new(0.2, 50, 0.2, 50)]]

					--plrlist.UiAspectRatioConstraint.AspectRatio = 1.55
				else
					--[[plrlist.Visible = false
					plrlist.Contents.Visible = false
					plrlist.Contents.Players.Visible = false
					plrlist.Background.Visible = false
					plrlist.Contents.Players.Active = false

					plrlist.Contents.Position = UDim2.new(0.5, 0, 0.5, 0)
					plrlist.Contents.Players.Position = UDim2.new(0.5, 0, 1, -7)
					plrlist.Position = UDim2.new(1, 0, 0, 5)]]

					--plrlist.Visible = true

					plrlist.Contents.Visible = false

					--[[plrlist.Contents.Players.Visible = true
					plrlist.Contents.Players.Position = UDim2.new(0.5, 0, 1, -7)
					plrlist.Contents.Players.Size = UDim2.new(0.949999988, 0, 1, -50)

					plrlist.Contents.InfoTypes.Visible = true
					plrlist.Contents.InfoTypes.Position = UDim2.new(0.5, 0, 0, 18)
					plrlist.Contents.InfoTypes.Size = UDim2.new(0.899999976, 0, 0.0500000007, 10)

					plrlist.Close.Visible = true

					plrlist.Background.Visible = true
					plrlist.Contents.Players.Active = true]]

					plrlist.Contents.Position = UDim2.new(0.5, 0, 0.5, 0)
					plrlist.Contents.Players.Position = UDim2.new(0.5, 0, 1, -7)

					--[[plrlist.Position = UDim2.new(1, -5, 0, 5)
					plrlist.Size = UDim2.new(0.2, 50, 0.2, 50)]]

					--plrlist.UiAspectRatioConstraint.AspectRatio = 1.55
				end
			end,
		})

		QOLTab:CreateSection("you can emote as killer using this:")
		local AnimationsTabGUI = QOLTab:CreateButton({
			Name = "Emote As Killer GUI", 
			Callback = function(keybind)
				if LopticaCooldown then
					return
				end

				local Lighting = game:GetService("Lighting")
				local CoreGui = game:GetService("CoreGui")

				local EmoteGUI = CoreGui:FindFirstChild("ForsakextrasEmoteGUI")
				local BlurEffect = Lighting:FindFirstChild("Blur")

				if EmoteGUI then
					LopticaCooldown = true
					local Holder = EmoteGUI:FindFirstChild("Holder")
					if Holder then
						local BlurTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
						local TweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

						if BlurEffect then
							local blurTween = TweenService:Create(BlurEffect, BlurTweenInfo, { Size = 0 })
							blurTween:Play()
						end

						local guiTween = TweenService:Create(Holder, TweenInfo, { Size = UDim2.new(0, 0, 0, 0) })
						guiTween:Play()

						task.wait(0.25)

						if BlurEffect then
							BlurEffect:Destroy()
						end
						EmoteGUI:Destroy()
					end

					task.delay(1, function()
						LopticaCooldown = false
					end)
				else
					WHATTHEFUCKISTHISSHITCODEKLDOWQNDJQW()
				end
			end,
		})
		QOLTab:CreateSection("(WARNING: people might THINK you're a hacker and report you)")
		QOLTab:CreateSection("(do this at MAX once and very quickly to be safe if you do)")

		local MaxZoomSlider = QOLTab:CreateSlider({
  			Name = "Max Camera Zoom",
   			Range = {12, 20},
   			Increment = 1,
   			Suffix = "Max Zoom Distance",
   			CurrentValue = 12,
   			Flag = "maxzoomcamval", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   			Callback = function(Value)
				game.Players.LocalPlayer.CameraMaxZoomDistance = Value
   			end,
		})
		local FovSlider = QOLTab:CreateSlider({
  			Name = "Field of view",
   			Range = {10, 120},
   			Increment = 5,
   			Suffix = "FOV value",
   			CurrentValue = 12,
   			Flag = "fovsliderval", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   			Callback = function(Value)
				local success, wowzers = pcall(function()
					return Players.LocalPlayer.PlayerData.Settings.Game:WaitForChild("FieldOfView", 3)
				end)
				
				if success and wowzers then
					wowzers:SetAttribute("MaxValue", 120)
					wowzers:SetAttribute("MinValue", 20)
				end

				wowzers.Value = Value

				task.wait()
   			end,
		})
		QOLTab:CreateSection("(these might be removed, it seems cheaty but not at the same time..)")

		-- Miscs Tab

		MiscsTab:CreateSection("if something glitched it's better to rejoin instead")
		local DelGui = MiscsTab:CreateButton({
			Name = "Delete Gui",
			Callback = function()
				if game:GetService("CoreGui"):FindFirstChild("ForsakextrasEmoteGUI") then
					game:GetService("CoreGui"):FindFirstChild("ForsakextrasEmoteGUI"):Destroy()
				end
				wait()
				local CoreGui = game:GetService("CoreGui")
				if CoreGui:FindFirstChild("HUI") and CoreGui:FindFirstChild("HUI"):FindFirstChild("Rayfield") then
					CoreGui:FindFirstChild("HUI"):FindFirstChild("Rayfield"):Destroy()
				elseif CoreGui:FindFirstChild("RobloxGui") and CoreGui:FindFirstChild("RobloxGui"):FindFirstChild("Rayfield") then
					CoreGui:FindFirstChild("RobloxGui"):FindFirstChild("Rayfield"):Destroy()
				elseif CoreGui:FindFirstChild("Rayfield") then
					CoreGui:FindFirstChild("Rayfield"):Destroy()
				end
			end,
		})

		local DetectHackers = MiscsTab:CreateToggle({
			Name = "Toggle 'hacker' detector",
			CurrentValue = false,
			Callback = function(state)
				enableHackerDetecting = state
			end,
		})

	end

	local function CheckAndDeleteAssets()
		local basePath = "Forsakextras/Assets/"
		local FishFilePath = "Forsakextras/FISH.txt"

		if not isfile(FishFilePath) then
			if isfolder(basePath) then
				for _, file in ipairs(listfiles(basePath)) do
					delfile(file)
				end
				delfolder(basePath)
			end
			writefile(FishFilePath, "you know what that means")
		end
	end

	pcall(CheckAndDeleteAssets)
	task.spawn(function()
		pcall(CheckIfStuffsDownloaded)
	end)

	InitializeGUI()
	MakeButton()
end

if
	game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
	and game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("MainUI")
then
	local isSupportedVersion = false
	local versionLabel = game:GetService("Players").LocalPlayer.PlayerGui.MainUI:FindFirstChild("Version")
	if versionLabel and tonumber(versionLabel.Text:match("Version: (%d+)")) <= SupportedVersion then
		isSupportedVersion = true
	end
	if not isSupportedVersion then
		local bindable = Instance.new("BindableFunction")
		bindable.OnInvoke = function(buttonPressed)
			if buttonPressed == "Yes" then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "SCRIPT INFO",
					Text = "Game updated so some features might not work,",
					Duration = 20,
				})
				ForsakextrasLoad()
			end
		end

		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Game version mismatch",
			Text = "Game has updated, are you sure you want to run the script?",
			Duration = 99999,
			Button1 = "Yes",
			Button2 = "Cancel",
			Callback = bindable,
		})
	else
		ForsakextrasLoad()
	end
else
	ForsakextrasLoad()
end

Rayfield:LoadConfiguration()


--vim template for vip commands stuff:
--[[local function Do1x1x1x1Popups()
		while true do
			if Do1x1PopupsLoop then
				local player = game:GetService("Players").LocalPlayer
				local popups = player.PlayerGui.TemporaryUI:GetChildren()

				for _, i in ipairs(popups) do
					if i.Name == "1x1x1x1Popup" then
						local centerX = i.AbsolutePosition.X + (i.AbsoluteSize.X / 2)
						local centerY = i.AbsolutePosition.Y + (i.AbsoluteSize.Y / 2) + 50
						VIM:SendMouseButtonEvent(
							centerX,
							centerY,
							Enum.UserInputType.MouseButton1.Value,
							true,
							player.PlayerGui,
							1
						)
						VIM:SendMouseButtonEvent(
							centerX,
							centerY,
							Enum.UserInputType.MouseButton1.Value,
							false,
							player.PlayerGui,
							1
						)
					end
				end
			end
			task.wait(0.1)
		end
	end]]
