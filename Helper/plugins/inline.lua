--[[
     **************************
     *  BlackPlus Plugins...  *
     *                        *
     *     By @SubProcess     *
     *                        *
     *  Channel > @SubCreator *
     **************************
	 
]]
function getTime(sec)
    local T
    if sec >= 86400 then
	    T = math.floor(sec / 86400) + 1 .. " روز"
	elseif sec >= 3600 then
	    T = math.floor(sec / 3600) + 1 .. " ساعت"
	elseif sec >= 60 then
	    T = math.floor(sec / 60) + 1 .. " دقیقه"
	elseif sec < 60 then
	    T = (sec) + 1 .. " ثانیه"
	end
	return T
end

local function iaction(msg)
-----------------------------------* Locals *-----------------------------------
      local HTTP = require('socket.http')
      local qresult = {}
      local result = {}
      local keyboard = {}
      local inline = result
      local gPanel = { string.match(msg.query, "^(BPPanel):(.*)/(.*)/(.*)") }
      local gClean = { string.match(msg.query, "^(BPDALL):(.*)/(.*)/(.*)") }
      local gPing = { string.match(msg.query, "^(BPPing):(.*)/(.*)/(.*)") }
      local gJoin = { string.match(msg.query, "^(BPJoinCH):(.*)/(.*)") }
      local gRules = { string.match(msg.query, "^(BPgetRules):(.*)/(.*)/(.*)") }
--------------------------------------------------------------------------------
---------------------------------* BP Panel *----------------------------------
if gPanel[1] == "BPPanel" then
 local result = {}
 local keyboard = {}
    result.id = tostring(#qresult + 1)
    result.type = 'article'
    result.title = ('Panel For : C:'..gPanel[2]..'|U:'..gPanel[3]..'|B:'..gPanel[4])
	local ex = db:ttl("bot:"..gPanel[4]..":charge:"..gPanel[2])
	local expire_time
    if ex == -1 or ex == "-1" then
      expire_time = "*نوع پنل* : `نامحدود`"
	elseif ex == -2 or ex == "-2" then
	  expire_time = "*نوع پنل* : `به پایان رسیده⚠️`"
    else
      local d = getTime(ex)
      expire_time = "*نوع پنل* : `محدود (تا "..d.." دیگر ربات در گروه فعال میماند)`"
    end
    result.message_text = '*به پنل مدیریتی گروه خوش آمدید.🌹*\n_برای مدیریت گروه میتونید از دکمه های زیر استفاده کنید..._\n[برای اطلاعات بیشتر با کلیک کردن روی این متن در کانال ما عضو شوید!](https://telegram.me/'..config.channel..')\n\n*آیدی گروه *: `'..gPanel[2]..'`\n'..expire_time
    result.reply_markup = load_home(gPanel[2], gPanel[3], gPanel[4])
	result.parse_mode = 'Markdown'
    qresult[#qresult + 1] = result
       api.sendInlinemd(msg.id, qresult,0)
end
---------------------------------* BP Ping *----------------------------------
if gClean[1] == "BPDALL" then
 local result = {}
 local keyboard = {}
    result.id = tostring(#qresult + 1)
    result.type = 'article'
    result.title = ('Ping For : C:'..gClean[2]..'|U:'..gClean[3]..'|B:'..gClean[4])
    result.message_text = '*آیا مایلید تمامی پیام های شما از این گروه حذف شود؟*\n\n_💡توجه داشته باشید که هر 1 ساعت فقط یکبار میتونید از این دستور استفاده کنید..._'
    keyboard.inline_keyboard = {
	    {
			{text = ("خیر❌"), callback_data = ('clb:'..gClean[2]..':'..gClean[3]..':'..gClean[4]..":n")},
    		{text = ("بله✅"), callback_data = ('clb:'..gClean[2]..':'..gClean[3]..':'..gClean[4]..":y")},
        },
	}
    result.reply_markup = keyboard
    result.disable_web_page_preview = true
	result.parse_mode = 'Markdown'
    qresult[#qresult + 1] = result
       api.sendInlinemd(msg.id, qresult,0)
end
---------------------------------* BP Ping *----------------------------------
if gPing[1] == "BPPing" then
 local result = {}
 local keyboard = {}
    result.id = tostring(#qresult + 1)
    result.type = 'article'
    result.title = ('Ping For : C:'..gPing[2]..'|U:'..gPing[3])
    result.message_text = '[API](https://telegram.me/) : `Pong!`\n[CLI](https://telegram.me/) : `Pong!`'
    keyboard.inline_keyboard = {
	    {
    		{text = ("Bots Running."), callback_data = ('NULLs')},
        },
	}
    result.reply_markup = keyboard
    result.disable_web_page_preview = true
	result.parse_mode = 'Markdown'
    qresult[#qresult + 1] = result
       api.sendInlinemd(msg.id, qresult,0)
end
---------------------------------* BP JoinCh *----------------------------------
if gJoin[1] == "BPJoinCH" then
 local result = {}
 local keyboard = {}
    result.id = tostring(#qresult + 1)
    result.type = 'article'
    result.title = ('Join Panel For : C:'..gJoin[2]..'|U:'..gJoin[3])
    result.message_text = '*کاربر گرامی:*\n_شما برای استفاده از این ربات حتما باید در کانال ما عضو باشید تا ربات دستور های شما رو اجرا کند!_\n`لطفا در کانال عضو شوید و دوباره این دستور رو وارد کنید🌹`'
    keyboard.inline_keyboard = {
	    {
    		{text = ("ورود به کانال📣"), url = ('https://t.me/'..config.channel)},
        },
	}
    result.reply_markup = keyboard
    result.disable_web_page_preview = true
	result.parse_mode = 'Markdown'
    qresult[#qresult + 1] = result
       api.sendInlinemd(msg.id, qresult,0)
end
---------------------------------* BP Rules *----------------------------------
if gRules[1] == "BPgetRules" then
 local result = {}
 local keyboard = {}
    result.id = tostring(#qresult + 1)
    result.type = 'article'
    result.title = ('Rules For : C:'..gRules[2]..'|U:'..gRules[3])
    result.message_text = '*کاربر گرامی:*\n_قوانین از طریق_ `ربات هلپر` _برای شما ارسال میگردد و باید ابتدا ربات رو استارت یا آنبلاک کنید..._'
    keyboard.inline_keyboard = {
	    {
    		{text = ("ورود به  بات🤖"), url = ('https://telegram.me/bot')},
        },
	}
    result.reply_markup = keyboard
    result.disable_web_page_preview = true
	result.parse_mode = 'Markdown'
    qresult[#qresult + 1] = result
       api.sendInlinemd(msg.id, qresult,0)
end
end
return {
	admin_not_needed = true,
	triggers = {
    },
	iaction = iaction,
}
--[[
     **************************
     *  BlackPlus Plugins...  *
     *                        *
     *     By @SubProcess     *
     *                        *
     *  Channel > @SubCreator *
     **************************
	 
]]