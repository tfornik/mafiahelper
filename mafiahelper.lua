script_name('Exstyle clan dlya Yakuza') -- название скрипта
script_author('tfornik.') -- автор скрипта
script_description('Boje, zachem ya eto sozdal') -- описание скрипта

require "lib.moonloader"
local dlstatus = require('moonloader').download_status
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local inicfg = require 'inicfg'
local SE = require 'lib.samp.events'
local directIni = "moonloader\\Settings.ini"
local keys = require 'vkeys'

local mainini = inicfg.load(nil, directIni)
local mhTimer = 0
local warTimer = 0
local main_window_state = imgui.ImBool(false)
local one_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)
local text_buffer_rang = imgui.ImBuffer(256)

local sampev = require 'lib.samp.events'
local gg = require 'lib.samp.events'

local checked_radio = imgui.ImInt(1)


local sw, sh = getScreenResolution()

update_state = false

local script_vers = 2
local script_vers_text = "1.05"

local update_url = "https://raw.githubusercontent.com/tfornik/mafiahelper/main/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://github.com/tfornik/mafiahelper/raw/main/mafiahelper.lua"
local script_path = thisScript().path

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end


  sampRegisterChatCommand('savelv', savelv)
	sampRegisterChatCommand('savels', savels)
	sampRegisterChatCommand('savesf', savesf)
	sampRegisterChatCommand('sls', sls)
	sampRegisterChatCommand('slv', slv)
	sampRegisterChatCommand('ssf', ssf)
	sampRegisterChatCommand('mmenu', cmd_mmenu)
  sampRegisterChatCommand('uuisj', uuisj)
	sampRegisterChatCommand('uuivis', uuivis)
	sampRegisterChatCommand('go', cmd_go)
	sampRegisterChatCommand('ammochat', ammochat)
	sampRegisterChatCommand('clearall', clearall)
	sampRegisterChatCommand('command', cmd_command)
	sampRegisterChatCommand('ammomenu', cmd_ammomenu)
	sampRegisterChatCommand('adoff', adoff)
	sampRegisterChatCommand('functions', functions)
	sampRegisterChatCommand('adon', adon)
	sampRegisterChatCommand('adminoff', adminoff)
  sampRegisterChatCommand('adminon', adminon)



	sampAddChatMessage('[MafiaHelper] Авторы - tfornik, N.Pechenkov', 0xFF0000)
	sampAddChatMessage('[MafiaHelper] Скрипт строго для проектов Samp-RP.', 0xFF0000)
  sampAddChatMessage('[MafiaHelper] Основные команды - /command, /mmenu, /ammomenu', 0xFF0000)
  sampAddChatMessage('[MafiaHelper] Основные функции скрипта - /functions', 0xFF0000)

	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
		nick = sampGetPlayerNickname(id)

	downloadUrlToFile(update_url, update_path, function(id, status)
     if status == dlstatus.STATUS_ENDDOWNLOADDATA then
        updateIni = inicfg.load(nil, update_path)
				if tonumber(updateIni.info.vers) > script_vers then
           sampAddChatMessage('[MafiaHelper] Доступно обновление скрипта - ' .. updateIni.info.vers_text, 0xFF0000)
					 update_state = true
				end
		 end
	end)

	imgui.Process = false


	while true do
		wait(0)

    function adoff(arg)
		if string.find(text, 'Объявление:', 1, true) then
			return false
		end
		end

       function sampev.onServerMessage(color, text)


       if mainini.config.ad == 10 and
			    text:find("Объявление:") then return false

			 end
			 if mainini.config.ad == 10 and text:find("Отредактировал сотрудник") then
				 return false
			 end
			 if mainini.config.admin == 10 and text:find("Администратор:") then
				 return false
			 end
			 if mainini.config.admin == 10 and text:find("от администратора") then
				 return false
			 end

			 if text:find('Следующее ограбление будет доступно в (%d+):(%d+):(%d+)') then
 	     st, st2, st3 = text:match('(%d+):(%d+):(%d+)')
       sampAddChatMessage('Сохранено ' .. st .. ':' .. st2 .. ':' .. st3, 0xFF0000)





    end
	end

 local result, button, list, input = sampHasDialogRespond(10) -- /dialog0 (MsgBox)

 if result then -- если диалог открыт
 		if button == 1 then -- если нажата первая кнопка (Выбрать)
 				sampAddChatMessage("[MafiaHelper] Спасибо ", 0xFF0000)
 		else -- если нажата вторая кнопка (Закрыть)
 				sampAddChatMessage("[MafiaHelper] Не понял? Ну и ладна", 0xFF0000)
 end
 end
  if isKeyJustPressed(VK_B) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() then
		sampSendChat('/grib eat')
		wait(500)
		sampSendChat('/grib heal')
		wait(100)
		sampSendChat('1')
		wait(500)
		sampSendChat('/gribeat')
	end
	renderFont = renderCreateFont("Arial", 9, FCR_BORDER + FCR_BOLD)
 lua_thread.create(drawMhTimer)



end
end

function functions(arg)

sampShowDialog(10, "Команды MafiaHelper", '1. AmmoTimer(/ammomenu) - при наведении на NPC в Ammo LV вводите /savelv, в Ammo LS - /savels, в Ammo SF - /savesf.\n2. MhTimer для 9+ рангов\n3. Сбив психохилла - при нажатии кнопки B вы съедаете одну порцию грибов, сразу же принимаете психохилл и сбиваете его.', "Ясно", "Не ясно", 0)
end

function adminoff(arg)
	mainini.config.admin = 10
	if inicfg.save(mainini, directIni) then
	 sampAddChatMessage('[MafiaHelper] Админ действия отключены!', 0xFF0000)
 end
end
function adminon(arg)
mainini.config.admin = 0
if inicfg.save(mainini, directIni) then
 sampAddChatMessage('[MafiaHelper] Админ действия включены!', 0xFF0000)
end
end
function sls(arg)
  if #arg == 0 then
		sampAddChatMessage('[MafiaHelper] Введите /sls time:time:time', 0xFF0000)
  else
  mainini.config.vremyals = arg
	if inicfg.save(mainini, directIni) then
	 sampAddChatMessage('[MafiaHelper] Сохранено!', 0xFF0000)
 end
end
end
function adoff(arg)
	mainini.config.ad = 10
	if inicfg.save(mainini, directIni) then
	 sampAddChatMessage('[MafiaHelper] Объявления выключены!', 0xFF0000)
 end
end
function adon(arg)
	mainini.config.ad = 0
	if inicfg.save(mainini, directIni) then
	 sampAddChatMessage('[MafiaHelper] Объявления включены!', 0xFF0000)
 end
end
function slv(arg)
  if #arg == 0 then
		sampAddChatMessage('[MafiaHelper] Введите /slv time:time:time', 0xFF0000)
  else
  mainini.config.vremyalv = arg
	if inicfg.save(mainini, directIni) then
	 sampAddChatMessage('[MafiaHelper] Сохранено!', 0xFF0000)
 end
end
end

function ssf(arg)
  if #arg == 0 then
		sampAddChatMessage('[MafiaHelper] Введите /ssf time:time:time', 0xFF0000)
  else
  mainini.config.vremyasf = arg
	if inicfg.save(mainini, directIni) then
	 sampAddChatMessage('[MafiaHelper] Сохранено!', 0xFF0000)
 end
end
end
function cmd_command(arg)

        sampShowDialog(10, "Команды MafiaHelper", '/mmenu - открывает основное меню\n/uuisj id - уволит игрока с причиной sj\n/uuivis id - уволит игрока с причиной выселен\nПри нажатии клавиши B - примете психохил\n/ammomenu - данные по аммо(команды и тайминги)\n/adoff - оффает объявления в чате\n/adon - включает объявления в чате\n/adminoff - отключает админ действия в чате\n/adminon - включает показ админ действий', "Понял", "Не понял", 0)

end




function savelv(arg)
   sampAddChatMessage('[MafiaHelper] AMMO LV = ' .. st .. ':' .. st2 .. ':' .. st3, 0xFF0000)
   ammolv = (st .. ':' .. st2 .. ':' .. st3)
	 mainini.config.vremyalv = ammolv
	 if inicfg.save(mainini, directIni) then
 		sampAddChatMessage('[MafiaHelper] Сохранено!', 0xFF0000)
 	end

end

function savels(arg)
	sampAddChatMessage('[MafiaHelper] AMMO LS = ' .. st .. ':' .. st2 .. ':' .. st3, 0xFF0000)
	ammols = (st .. ':' .. st2 .. ':' .. st3)
	mainini.config.vremyals = ammols
	if inicfg.save(mainini, directIni) then
	 sampAddChatMessage('[MafiaHelper] Сохранено!', 0xFF0000)
 end

end
function savesf(arg)
	sampAddChatMessage('[MafiaHelper] AMMO SF = ' .. st .. ':' .. st2 .. ':' .. st3, 0xFF0000)
	ammosf = (st .. ':' .. st2 .. ':' .. st3)
	mainini.config.vremyasf = ammosf
	if inicfg.save(mainini, directIni) then
	 sampAddChatMessage('[MafiaHelper] Сохранено!', 0xFF0000)
 end

end
function clearall(arg)
	mainini.config.vremyasf = 0
	mainini.config.vremyals = 0
	mainini.config.vremyalv = 0
	if inicfg.save(mainini, directIni) then
	 sampAddChatMessage('[MafiaHelper] Сохранено!', 0xFF0000)
 end
end

function ammochat(arg)
  	mainini = inicfg.load(nil, directIni)
	sampSendChat('/f AMMO LV = ' .. mainini.config.vremyalv .. ' | AMMO LS = ' .. mainini.config.vremyals .. ' | AMMO SF = ' .. mainini.config.vremyasf)
end

function cmd_mmenu(arg)
  main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v
end

function cmd_ammomenu(arg)
  one_window_state.v = not one_window_state.v
	imgui.Process = one_window_state.v
end

function uuisj(arg, argv)
  if checked_radio.v == 6 then
		sampAddChatMessage('[MafiaHelper] Ранг мал!', 0xFF0000)
	end
	if checked_radio.v == 7 then
		sampAddChatMessage('[MafiaHelper] Ранг мал!', 0xFF0000)
	end
	if checked_radio.v == 8 then
		if #arg == 0 then
			sampAddChatMessage('[MafiaHelper] Введите /uui {ID}', 0xFF0000)
		else
			sampSendChat('/uninvite ' .. arg .. ' sj')
		end
	end
	if checked_radio.v == 9 then
		if #arg == 0 then
			sampAddChatMessage('[MafiaHelper] Введите /uui {id}', 0xFF0000)
		else
			sampSendChat('/uninvite ' .. arg .. ' sj')
		end
	end
	if checked_radio.v == 10 then
		if #arg == 0 then
			sampAddChatMessage('[MafiaHelper] Введите /uui {id}', 0xFF0000)
		else
			sampSendChat('/uninvite ' .. arg .. ' sj')
		end
	end





function uuivis(arg)
	if checked_radio.v == 6 then
		sampAddChatMessage('[MafiaHelper] Ранг мал!', 0xFF0000)
	end
	if checked_radio.v == 7 then
		sampAddChatMessage('[MafiaHelper] Ранг мал!', 0xFF0000)
	end
	if checked_radio.v == 8 then
		if #arg == 0 then
			sampAddChatMessage('[MafiaHelper] Введите /uui {ID}', 0xFF0000)
		else
			sampSendChat('/uninvite ' .. arg .. ' выселен')
		end
	end
	if checked_radio.v == 9 then
		if #arg == 0 then
			sampAddChatMessage('[MafiaHelper] Введите /uui {id}', 0xFF0000)
		else
			sampSendChat('/uninvite ' .. arg .. ' выселен')
		end
	end
	if checked_radio.v == 10 then
		if #arg == 0 then
			sampAddChatMessage('[MafiaHelper] Введите /uui {id}', 0xFF0000)
		else
			sampSendChat('/uninvite ' .. arg .. ' выселен')
		end
end
end
end




function cmd_go(arg)
  sampAddChatMessage('1 ' .. st .. st2 .. st3, 0xFF0000)
end



function imgui.OnDrawFrame()
   if not main_window_state.v and not one_window_state.v then
		 imgui.Process = false
	 end

	if main_window_state.v then
	imgui.SetNextWindowSize(imgui.ImVec2(350, 100), imgui.Cond.FirstUseEver)
	imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

	imgui.Begin('MafiaHelper for SRP', main_window_state)
  imgui.PushItemWidth(120)

	imgui.Separator()
  imgui.Text(u8'Выбери ранг специально для команд /uuisj, /uuivis')
	imgui.RadioButton(u8"6 ранг", checked_radio, 6)
	imgui.SameLine()
	imgui.RadioButton(u8"7 ранг", checked_radio, 7)
	imgui.SameLine()
	imgui.RadioButton(u8"8 ранг", checked_radio, 8)
	imgui.SameLine()
	imgui.RadioButton(u8"9 ранг", checked_radio, 9)
	imgui.SameLine()
	imgui.RadioButton(u8"10 ранг", checked_radio, 10)
	imgui.SameLine()
	imgui.Separator()


	imgui.End()
end
if one_window_state.v then
	imgui.SetNextWindowSize(imgui.ImVec2(335, 225), imgui.Cond.FirstUseEver)
	imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

	imgui.Begin('AmmoMenu', one_window_state)
	imgui.Text('Ammo LV = ' .. mainini.config.vremyalv)
	imgui.Text('Ammo LS = ' .. mainini.config.vremyals)
	imgui.Text('Ammo SF = ' .. mainini.config.vremyasf)
  imgui.Text(u8'Основные команды:\n/savelv - сохраняет время Ammo LV\n/savels - сохраняет время Ammo LS\n/savesf - сохраняет время Ammo SF\n/sls - самостоятельное изменение тайминга Ammo LS\n/slv - самостоятельное изменение тайминга Ammo LV\n/ssf - самостоятельное изменение тайминга Ammo SF\n/clearall - очистить данные тайминга')
	imgui.End()

end
end

function SE.onServerMessage(color, text)
	if(string.find(text, " У вас есть.* 2 минуты чтобы решить с.+")) then
		warTimer = os.time() + 130
		return true
	end
	local p1, p2, p3 = string.match(text, "^ Задание будет доступно через: (%d+):(%d+):(%d+)")
	if(p3 == nil)then
		p1, p2 = string.match(text, "^ Задание будет доступно через: (%d+):(%d+)")
	end
	if(p1 ~= nil and p2 ~= nil)then
		mhTimer = 0
		if(p3 ~= nil)then
			mhTimer = tonumber(p1) * 3600
			mhTimer = mhTimer + (tonumber(p2) * 60)
			mhTimer = mhTimer + tonumber(p3)
		else
			mhTimer = mhTimer + (tonumber(p1) * 60)
			mhTimer = mhTimer + tonumber(p2)
		end
		mhTimer = os.time() + mhTimer
		return true
	end
end

function drawMhTimer()
	while true do
		wait(0)
		local curTime = tonumber(os.time())
		local text  = tostring("")
		mhTimer = tonumber(mhTimer)
		if(mhTimer >= curTime)then
			local timer = mhTimer - os.time()
			local hour, minute, second = timer / 3600, math.floor(timer / 60), timer % 60
			if(hour >= 1)then
				text = string.format("Перегон: %02d:%02d:%02d", math.floor(hour) ,  minute- (math.floor(hour) * 60), second)
			else
				text = string.format("Перегон: %02d:%02d", minute, second)
			end
			if(hour < 1 and minute < 1 and second <= 15 and second % 2 > 0) then
				text = "{f4b800}" .. text
			end
		end
		warTimer = tonumber(warTimer)
		if(warTimer >= curTime)then
			local timer = warTimer - os.time()
			local minute, second = math.floor(timer / 60), timer % 60
			text = text .. (mhTimer >= os.time() and "{FFFFFF} | " or "") .. ((minute < 1 and second <= 15 and second % 2 > 0) and "{f4b800}" or "") .. string.format("Конец стрелы: %02d:%02d", minute, second)
		end
		if(warTimer >= os.time() or mhTimer >= os.time())then
			renderFontDrawText(renderFont, text, sw * 0.01, sh * 0.975, 0xFFFFFFFF)
		end
	end
end
