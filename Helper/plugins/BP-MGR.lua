--[[
     **************************
     *  BlackPlus Plugins...  *
     *                        *
     *     By @SubProcess     *
     *                        *
     *  Channel > @SubCreator *
     **************************
	 
]]
-----------------------------------------------------------------------------------------------
local function settings_pOne(key, user, bot_id, all_status, link_status, webpage_status, tag_status, hashtag_status, english_status, persian_status, forward_status, edit_status, pin_status, number_status, join_status, tgservice_status, bots_status)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = (all_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:all")},
	    },
	    {
    		{text = (link_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:link")},
    		{text = (webpage_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:webpage")},
	    },
		{
    		{text = (tag_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:tag")},
    		{text = (hashtag_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:hashtag")},
	    },
		{
    		{text = (english_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:english")},
    		{text = (persian_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:persian")},
	    },
		{
    		{text = (forward_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:forward")},
    		{text = (edit_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:edit")},
	    },
		{
    		{text = (pin_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:pin")},
    		{text = (number_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:contact")},
	    },
		{
    		{text = (join_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:join")},
	    },
		{
    		{text = (tgservice_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:tgservice")},
	    },
		{
    		{text = (bots_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":1:bots")},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:settings:'..key..':'..user..':'..bot_id)},
    		{text = ("➡️صفحه بعد"), callback_data = ('bp:gosettings:2:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------
local function loadSettings_One(msg, key, bot_id)
	    text = '`تنظیمات گروه : `*'..key.."*\n\n_[برای تغییر تنظیمات روی دکمه ی مورد نظر کلیک کنید...]_"
		has_locked = "قفل{🔐}"
        has_unlocked = "آزاد{🔓}"
        has_enabled = "فعال{✅}"
        has_disabled = "غیر فعال{❎}"
		    if db:get("bot:"..bot_id..":locks:all:"..key) then
                all_status = "میوت آل: "..has_enabled
            else
                all_status = "میوت آل: "..has_disabled
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:link:"..key) then
                link_status = "لینک: "..has_locked
            else
                link_status = "لینک: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:webpage:"..key) then
                webpage_status = "لینک سایت: "..has_locked
            else
                webpage_status = "لینک سایت: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:tag:"..key) then
                tag_status = "تگ{@}: "..has_locked
            else
                tag_status = "تگ{@}: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:hashtag:"..key) then
                hashtag_status = "هشتگ{#}: "..has_locked
            else
                hashtag_status = "هشتگ{#}: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:english:"..key) then
                english_status = "انگلیسی: "..has_locked
            else
                english_status = "انگلیسی: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:arabic:"..key) then
                persian_status = "فارسی: "..has_locked
            else
                persian_status = "فارسی: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:forward:"..key) then
                forward_status = "فوروارد: "..has_locked
            else
                forward_status = "فوروارد: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:edit:"..key) then
                edit_status = "ادیت: "..has_locked
            else
                edit_status = "ادیت: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:pin:"..key) then
                pin_status = "پین کردن: "..has_locked
            else
                pin_status = "پین کردن: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:contact:"..key) then
                number_status = "کانتکت: "..has_locked
            else
                number_status = "کانتکت: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:members:"..key) then
                join_status = "ورود اعضای جدید به گروه: "..has_locked
            else
                join_status = "ورود اعضای جدید به گروه: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:tgservice:"..key) then
                tgservice_status = "نمایش پیام ورود و خروج: "..has_locked
            else
                tgservice_status = "نمایش پیام ورود و خروج: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:bot:"..key) then
                bots_status = "اضافه کردن ربات به گروه: "..has_locked
            else
                bots_status = "اضافه کردن ربات به گروه: "..has_unlocked
            end
		-------------------------------------
	    keyboard = settings_pOne(key, msg.from.id, bot_id, all_status, link_status, webpage_status, tag_status, hashtag_status, english_status, persian_status, forward_status, edit_status, pin_status, number_status, join_status, tgservice_status, bots_status)
	        api.editMessageText(false, msg.message_id, text, keyboard, true, true)
	end
-----------------------------------------------------------------------------------------------
local function settings_pTwo(key, user, bot_id, text_status, sticker_status, photo_status, game_status, inline_status, video_status, gif_status, music_status, location_status, document_status, voice_status, kickme_status, cmds_status, vm_status)
    local keyboard = {}
    keyboard.inline_keyboard = {
		{
    		{text = (sticker_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:sticker")},
    		{text = (photo_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:photo")},
	    },
		{
    		{text = (game_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:game")},
    		{text = (inline_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:inline")},
	    },
		{
    		{text = (video_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:video")},
    		{text = (gif_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:gif")},
	    },
		{
    		{text = (music_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:music")},
    		{text = (location_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:location")},
	    },
		{
		    {text = (text_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:text")},
    		{text = (document_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:document")},
	    },
		{
    		{text = (voice_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:voice")},
	    },
		{
    		{text = (vm_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:vm")},
	    },
		{
    		{text = (kickme_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:kickme")},
	    },
		{
    		{text = (cmds_status), callback_data = ('bp:lock:'..key..":"..user..':'..bot_id..":2:cmds")},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:setting:settings:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function loadSettings_Two(msg, key, bot_id)
	    text = '`تنظیمات گروه : `*'..key.."*\n\n_[برای تغییر تنظیمات روی دکمه ی مورد نظر کلیک کنید...]_"
		has_locked = "قفل{🔐}"
        has_unlocked = "آزاد{🔓}"
        has_enabled = "فعال{✅}"
        has_disabled = "غیر فعال{❎}"
            if db:get("bot:"..bot_id..":locks:text:"..key) then
                text_status = "متن: "..has_locked
            else
                text_status = "متن: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:sticker:"..key) then
                sticker_status = "استیکر: "..has_locked
            else
                sticker_status = "استیکر: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:photo:"..key) then
                photo_status = "عکس: "..has_locked
            else
                photo_status = "عکس: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:game:"..key) then
                game_status = "بازی: "..has_locked
            else
                game_status = "بازی: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:inline:"..key) then
                inline_status = "اینلاین: "..has_locked
            else
                inline_status = "اینلاین: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:video:"..key) then
                video_status = "فیلم: "..has_locked
            else
                video_status = "فیلم: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:gif:"..key) then
                gif_status = "گیف: "..has_locked
            else
                gif_status = "گیف: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:music:"..key) then
                music_status = "آهنگ: "..has_locked
            else
                music_status = "آهنگ: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:location:"..key) then
                location_status = "لوکیشن: "..has_locked
            else
                location_status = "لوکیشن: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:document:"..key) then
                document_status = "فایل: "..has_locked
            else
                document_status = "فایل: "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:voice:"..key) then
                voice_status = "پیام صوتی(Voice): "..has_locked
            else
                voice_status = "پیام صوتی(Voice): "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:vm:"..key) then
                vm_status = "پیام تصویری(Video Msg): "..has_locked
            else
                vm_status = "پیام تصویری(Video Msg): "..has_unlocked
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:kickme:"..key) then
                kickme_status = "دستور kickme/: "..has_enabled
            else
                kickme_status = "دستور kickme/: "..has_disabled
            end
			-------------------------------------
            if db:get("bot:"..bot_id..":locks:cmd:"..key) then
                cmds_status = "قفل دستورات ربات: "..has_enabled
            else
                cmds_status = "قفل دستورات ربات: "..has_disabled
            end
		-------------------------------------
	    keyboard = settings_pTwo(key, msg.from.id, bot_id, text_status, sticker_status, photo_status, game_status, inline_status, video_status, gif_status, music_status, location_status, document_status, voice_status, kickme_status, cmds_status, vm_status)
	        api.editMessageText(false, msg.message_id, text, keyboard, true, true)
	end
-----------------------------------------------------------------------------------------------
local function sup_panel(key, user, bot_id)
    local keyboard = {}
	local sup_link = db:get('bot:'..bot_id..':link:'..config.Support.id)
     if sup_link then
       support_link = db:get('bot:'..bot_id..':link:'..config.Support.id)
     else
       support_link = config.Support.group_link
     end
    keyboard.inline_keyboard = {
	    {
    		{text = ("ارتباط با پشتیبانی ربات👤"), url = ('https://telegram.me/'..config.Support.bot)},
	    },
		{
    		{text = ("گروه پشتیبانی👥"), url = (support_link)},
    		{text = ("کانال ما🗣"), url = ('https://telegram.me/'..config.channel)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
	    },
	}
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function antiFlood_panel(key, user, bot_id, antiflood_status, antispam_status, floodmax_status, floodtime_status, spam_status)
    local keyboard = {}
    keyboard.inline_keyboard = {
		{
    		{text = (antiflood_status), callback_data = ('bp:locksp:'..key..":"..user..":"..bot_id..":1:flood")},
	    },
		{
		    {text = (antispam_status), callback_data = ('bp:locksp:'..key..":"..user..":"..bot_id..":1:spam")},
	    },
		{
    		{text = ("👇 تعداد پیام های آنتی فلود 👇"), callback_data = ('bp:antiflood:help:'..key..":"..user..":"..bot_id)},
	    },
		{
    		{text = ("➖"), callback_data = ('bp:antiflood:down:'..key..":"..user..":"..bot_id)},
    		{text = (floodmax_status), callback_data = ('bp:antiflood:help:'..key..":"..user..":"..bot_id)},
    		{text = ("➕"), callback_data = ('bp:antiflood:up:'..key..":"..user..":"..bot_id)},
	    },
		{
    		{text = ("👇 زمان بررسی آنتی فلود 👇"), callback_data = ('bp:antifloodtime:help:'..key..":"..user..":"..bot_id)},
	    },
		{
    		{text = ("➖"), callback_data = ('bp:antifloodtime:down:'..key..":"..user..":"..bot_id)},
    		{text = (floodtime_status), callback_data = ('bp:antiflood:help:'..key..":"..user..":"..bot_id)},
    		{text = ("➕"), callback_data = ('bp:antifloodtime:up:'..key..":"..user..":"..bot_id)},
	    },
		{
    		{text = ("👇 تعداد حروف مجاز در جمله 👇"), callback_data = ('bp:antispam:help:'..key..":"..user..":"..bot_id)},
	    },
		{
    		{text = ("➖"), callback_data = ('bp:antispam:down:'..key..":"..user..":"..bot_id)},
    		{text = (spamMax_status), callback_data = ('bp:antispam:help:'..key..":"..user..":"..bot_id)},
    		{text = ("➕"), callback_data = ('bp:antispam:up:'..key..":"..user..":"..bot_id)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:settings:'..key..':'..user..":"..bot_id)},
	    },
	}
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function warns_panel(key, user, bot_id, warn_status, warn_num)
    local keyboard = {}
    keyboard.inline_keyboard = {
		{
    		{text = (warn_status), callback_data = ('bp:lockspd:'..key..":"..user..":"..bot_id..":1:warns")},
	    },
		{
    		{text = ("👇 تعداد اخطار های مجاز👇"), callback_data = ('bp:warns:help:'..key..":"..user..":"..bot_id)},
	    },
		{
    		{text = ("➖"), callback_data = ('bp:warns:down:'..key..":"..user..":"..bot_id)},
    		{text = (warn_num), callback_data = ('bp:warns:help:'..key..":"..user..":"..bot_id)},
    		{text = ("➕"), callback_data = ('bp:warns:up:'..key..":"..user..":"..bot_id)},
	    },
		{
    		{text = ("حذف اخطار تمامی کاربران گروه⚙️"), callback_data = ('bp:warns:clean:'..key..":"..user..":"..bot_id)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:settings:'..key..':'..user..':'..bot_id)},
	    },
	}
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function fAdd_panel(key, user, bot_id, fAdd_status, fAdd_num)
    local keyboard = {}
    keyboard.inline_keyboard = {
		{
    		{text = (fAdd_status), callback_data = ('bp:lockspds:'..key..":"..user..":"..bot_id..":1:fadd")},
	    },
		{
    		{text = ("👇 تعداد اخطار های مجاز👇"), callback_data = ('bp:fadd:help:'..key..":"..user..":"..bot_id)},
	    },
		{
    		{text = ("➖"), callback_data = ('bp:fadd:down:'..key..":"..user..":"..bot_id)},
    		{text = (fAdd_num), callback_data = ('bp:fadd:help:'..key..":"..user..":"..bot_id)},
    		{text = ("➕"), callback_data = ('bp:fadd:up:'..key..":"..user..":"..bot_id)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:settings:'..key..':'..user..':'..bot_id)},
	    },
	}
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function autodelete_panel(key, user, bot_id, autodelete_status, autodelete_time)
    local keyboard = {}
    keyboard.inline_keyboard = {
		{
    		{text = (autodelete_status), callback_data = ('bp:locksps:'..key..":"..user..":"..bot_id..":1:autodelete")},
	    },
		{
    		{text = ("👇 زمان تعیین شده برای حذف پیام های ارسالی 👇"), callback_data = ('bp:autodelete:help:'..key..":"..user..":"..bot_id)},
	    },
		{
    		{text = ("➖"), callback_data = ('bp:autodelete:down:'..key..":"..user..":"..bot_id)},
    		{text = (autodelete_time), callback_data = ('bp:autodelete:help:'..key..":"..user..":"..bot_id)},
    		{text = ("➕"), callback_data = ('bp:autodelete:up:'..key..":"..user..":"..bot_id)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
	    },
	}
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function load_antiFlood(msg, key, bot_id)
	has_enabled = "فعال{✅}"
    has_disabled = "غیر فعال{❎}"
	if db:get("bot:"..bot_id..":anti-flood:"..key) then
        antiflood_status = "آنتی فلود: "..has_disabled
    else
        antiflood_status = "آنتی فلود: "..has_enabled
    end
	-------------------------------------
    if db:get("bot:"..bot_id..":locks:spam:"..key) then
        antispam_status = "آنتی اسپم: "..has_disabled
    else
        antispam_status = "آنتی اسپم: "..has_enabled
    end
	-------------------------------------
    floodMax_status = (db:get('bot:'..bot_id..':flood:max:'..key) or "5").." پیام"
	floodTime_status = (db:get('bot:'..bot_id..':flood:time:'..key) or "3").." ثانیه"
    spamMax_status = (db:get('bot:'..bot_id..':set_char:'..key) or "4096").." حرف"
	-------------------------------------
	text = '`تنظیمات ضد اسپم گروه : `*'..key.."*\n_در حال حاضر کاربران میتوانند در هر_ `"..floodTime_status.."` _ثانیه_ `"..floodMax_status.."` _پیام ارسال کنند و حداکثر حرف های مجاز در جمله و کلمه ها_ `"..spamMax_status.."` _حرف میباشد._\n\n_[برای تغییر تنظیمات روی دکمه ی مورد نظر کلیک کنید...]_"
	keyboard = antiFlood_panel(key, msg.from.id, bot_id, antiflood_status, antispam_status, floodMax_status, floodTime_status, spamMax_status)
	  api.editMessageText(false, msg.message_id, text, keyboard, true, true)
end
-----------------------------------------------------------------------------------------------
local function load_warns(msg, key, bot_id)
	has_enabled = "میوت کردن کاربر🔇"
    has_disabled = "بن کردن کاربر⛔️"
	if db:get("bot:" .. bot_id .. ":chat_id:" .. key .. ":warn_status") then
        warn_status = "واکنش به آخرین وارن: "..has_disabled
    else
        warn_status = "واکنش به آخرین وارن: "..has_enabled
    end
	-------------------------------------
	warn_num = (db:get("bot:" .. bot_id .. ":chat_id:" .. key .. ":maxwarn") or "3") .. " اخطار"
	-------------------------------------
	text = "*شما با استفاه از این قسمت میتوانید حداکثر مقدار اخطار ها و واکنش به آخرین اخطار به کاربران را تنظیم کنید⚙️*\n\n`💡برای اطلاعات بیشتر روی دکمه های زیر کلیک کنید.`"
	keyboard = warns_panel(key, msg.from.id, bot_id, warn_status, warn_num)
	  api.editMessageText(false, msg.message_id, text, keyboard, true, true)
end
-----------------------------------------------------------------------------------------------
local function load_fadd(msg, key, bot_id)
	has_enabled = "فعال✅"
    has_disabled = "غیر فعال❌"
	if db:get("bot:" .. bot_id .. ":chat_id:" .. key .. ":fadd_status") then
        fadd_status = "سخت گیری به ادد کردن کاربر: "..has_enabled
    else
        fadd_status = "سخت گیری به ادد کردن کاربر: "..has_disabled
    end
	-------------------------------------
	fadd_num = (db:get("bot:" .. bot_id .. ":chat_id:" .. key .. ":maxinv") or "2") .. " کاربر"
	-------------------------------------
	text = "*شما با استفاده از این بخش میتوانید کاربر های گروهتون رو محدود کنید⚙️*\n\n_📝در صورت فعال بودن این بخش کاربران ابتدا باید به تعدادی که شما مشخص کرده اید کاربر به گروه اضافه کنند تا دسترسی چت کردن به آنها داده شود( در غیر این صورت پیام آنها بصورت خودکار توسط ربات حذف میگردد )_\n\n`💡این بخش برای افرایش تعداد کاربران گروه موثر است`"
	keyboard = fAdd_panel(key, msg.from.id, bot_id, fadd_status, fadd_num)
	  api.editMessageText(false, msg.message_id, text, keyboard, true, true)
end
-----------------------------------------------------------------------------------------------
local function load_autoDelete(msg, key, bot_id)
	has_enabled = "فعال{✅}"
    has_disabled = "غیر فعال{❎}"
	if db:get("bot:"..bot_id..":autodelete:"..key) then
        autodelete_status = "حذف خودکار: "..has_enabled
    else
        autodelete_status = "حذف خودکار: "..has_disabled
    end
	-------------------------------------
	autodelete_time = (db:get('bot:'..bot_id..':autodelete:time:'..key) or "35").." ثانیه"
	-------------------------------------
	text = '`تنظیمات حذف خودکار پیام های ربات در گروه : `*'..key.."*\n_در حال حاضر پیام های ربات بعد از _ `"..autodelete_time.."` _حذف میگردد_"
	keyboard = autodelete_panel(key, msg.from.id, bot_id, autodelete_status, autodelete_time)
	  api.editMessageText(false, msg.message_id, text, keyboard, true, true)
end
-----------------------------------------------------------------------------------------------
local function settings_panel(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("تنظیمات گروه⛔️"), callback_data = ('bp:setting:settings:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("تنظیمات ضد اسپم⚠️"), callback_data = ('bp:setting:antispam:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("تنظیمات اخطار(WARN) ها🔴"), callback_data = ('bp:setting:warns:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("اضافه کردن کاربر بصورت اجباری📉"), callback_data = ('bp:setting:fadd:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("کلمات فیلتر شده🔕"), callback_data = ('bp:setting:filterlist:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function link_Ypanel(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
    		{text = ("پاک کردن لینک❌"), callback_data = ('bp:dellink:step_one:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function link_Npanel(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("ذخیره کردن لینک گروه در ربات🔄"), callback_data = ('bp:setlink:step_one:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function wait_link(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("انصراف❌"), callback_data = ('bp:setlink:cancel:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function rules_Ypanel(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
    		{text = ("حذف کردن قوانین❌"), callback_data = ('bp:delrules:step_one:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function rules_Npanel(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("ذخیره کردن قوانین گروه در ربات📋"), callback_data = ('bp:setrules:step_one:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function wait_rules(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("انصراف❌"), callback_data = ('bp:setrules:cancel:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function welcome_Ypanel(key, user, bot_id, welcome_status)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = (welcome_status), callback_data = ('bp:chnage:welcome:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("حذف کردن خوشامدگویی❌"), callback_data = ('bp:delwelcome:step_one:'..key..':'..user..':'..bot_id)},
	    },
		{
		    {text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
	    },

    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function welcome_Npanel(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("ذخیره کردن پیام خوشامد گویی در ربات📝"), callback_data = ('bp:setwelcome:step_one:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function wait_welcome(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("انصراف❌"), callback_data = ('bp:setwelcome:cancel:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function mods_panel(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("خالی کردن لیست مدیران👤"), callback_data = ('bp:mods:mgr:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function wlist_panel(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("خالی کردن لیست سفید گروه👤"), callback_data = ('bp:wlist:mgr:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function mutes_panel(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("خالی کردن لیست🔕"), callback_data = ('bp:mutes:mgr:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function bans_panel(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("خالی کردن لیست⛔️"), callback_data = ('bp:bans:mgr:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function filters_panel(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("خالی کردن لیست📋"), callback_data = ('bp:filters:mgr:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:settings:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function b_home(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local function b_settings(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
		{
    		{text = ("برگشت⬅️"), callback_data = ('bp:settings:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end
-----------------------------------------------------------------------------------------------
function is_sudo(msg, chat_id)
    local var = false
    for k,v in pairs(config.sudo_users) do
        if msg.from.id == v then
            var = true
        end
    end
  return var
end
-----------------------------------------------------------------------------------------------
function is_admin(msg, chat_id, bot_id)
    local var = false
	local hashs =  'bot:'..bot_id..':global:admins'
    local admin = db:sismember(hashs, msg.from.id)
	 if admin then
	    var = true
	 end
    if is_sudo(msg) then
       var = true
    end
    return var
end
-----------------------------------------------------------------------------------------------
function is_owner(msg, chat_id, bot_id)
    local var = false
    local hash =  'bot:'..bot_id..':owners:'..chat_id
    local owner = db:sismember(hash, msg.from.id)
	 if owner then
	    var = true
	 end
	 if is_sudo(msg, chat_id) or is_admin(msg, chat_id, bot_id) then
	    var = true
	 end
    return var
end
-----------------------------------------------------------------------------------------------
function is_mod(msg, chat_id, bot_id)
    local var = false
    local mod = db:sismember('bot:'..bot_id..':mods:'..chat_id, msg.from.id)
	 if mod then
	    var = true
	 end
	 if is_sudo(msg, chat_id) or is_admin(msg, chat_id, bot_id) or is_owner(msg, chat_id, bot_id) then
	    var = true
	 end
    return var
end
-----------------------------------------------------------------------------------------------
local action = function(msg, blocks)
	 -----------------------------------------------------------------------------
    if msg.incb then
	-----------------------------------------------------------------------------
	   if blocks[1] == "clb" then
	        if tonumber(blocks[3]) ~= msg.from.id then
	            api.answerCallbackQuery(msg.cb_id, "خطایی رخ داده است⚠️\nشما نمیتوانید از پنل دیگران استفاده کنید...\n\n💡در صورتی که قصد دارید تمامی پیام هاتون رو پاک کنید دستور زیر رو ارسال کنید:\n/iclean",true)
		        return false
			end
	        if blocks[5] == "y" then
			    api.sendMessage(blocks[4], "`##delall:G="..blocks[2]..":m_id="..msg.message_id..":user_id="..blocks[3].."##`" , true)
			    api.editMessageText(false, msg.message_id, "*تمامی پیام های کاربر* `"..blocks[3].."` *به درخواست خود شخص حذف گردید✅*\n_⚠️توجه داشته باشید که تا 1 ساعت آینده نمیتوانید از این دستور استفاده کنید_", false, true, true)
			elseif blocks[5] == "n" then
			    api.editMessageText(false, msg.message_id, "*عملیات حذف تمامی پیام های کاربر* `"..blocks[3].."` *با موفقیت لغو شد✅*\n_⚠️توجه داشته باشید که تا 1 ساعت آینده نمیتوانید از این دستور استفاده کنید_", false, true, true)
			end
			return false
	   end
	if is_mod(msg, blocks[2], blocks[4]) then
	 if tonumber(blocks[3]) ~= msg.from.id then
	    api.answerCallbackQuery(msg.cb_id, "این پنل برای شما ارسال نشده!\nهر فرد قادر به کنترل کردن پنل خود میباشد...\nبرای دریافت پنل دستور زیر رو ارسال کنید : \n\n/panel",true)
		return false
	 else
	 -----------------------------------------------------------------------------
	 ------------------------------*  ANTIFLOOD  *--------------------------------
	 -----------------------------------------------------------------------------
	 if db:get("bp:antiFreez:"..blocks[2]) then 
	    wait_time = db:ttl("bp:antiFreez:"..blocks[2])
	    api.answerCallbackQuery(msg.cb_id, "کاربر گرامی:\nشما درخواست های زیادی به ربات ارسال کردید!\nلطفا "..wait_time.." ثانیه صبر کنید و دوباره روی دکمه ها کلیک کنید🌹",true)
		return false
	 else
		local SPAM_HASH = "bp:Antiflood:"..blocks[2]
        local SPAM_NUM = tonumber(db:get(SPAM_HASH) or 0)
          if SPAM_NUM > 10 then
			db:setex("bp:antiFreez:"..blocks[2], 25, true)
          end
		db:setex(SPAM_HASH, 20, SPAM_NUM + 1)
	 end
	 -----------------------------------------------------------------------------
	 -----------------------------------------------------------------------------
	  if blocks[1] == "bp:gpmanHELP" then
	      api.answerCallbackQuery(msg.cb_id, "شما با استفاده از این قسمت میتونید گروهتون رو مدیریت کنید.\nبرای مدیریت هر بخش روی دکمه ی مورد نظرتون کلیک کنید...",true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:modmanHELP" then
	      api.answerCallbackQuery(msg.cb_id, "شما با استفاده از این قسمت میتونید کاربران با مقام های مختلف رو در گروهتون رو مدیریت کنید.\nبرای مدیریت هر بخش روی دکمه ی مورد نظرتون کلیک کنید...",true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:antiflood:help" then
	      api.answerCallbackQuery(msg.cb_id, "🤔شما با استفاده از این قسمت میتونید تعداد پیام هایی که در زمان مشخص شده در گروه ارسال شده رو محدود کنید تا وقتی کاربری به قصد تخریب گروه چندین پیام پشت سر هم ارسال کرد ربات اون فرد رو از گروه حذف کنه.",true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:antifloodtime:help" then
	      api.answerCallbackQuery(msg.cb_id, "🤔شما با استفاده از این قسمت میتونید زمان چک کردن فلود رو تنظیم کنید\nبرای مثال در صورتی که این قسمت روی3 ثانیه تنظیم شده باشد در صورتی که کاربری بیش از پیام های تنظیم شده پیام دهد از گروه اخراج میشود",true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:antispam:help" then
	      api.answerCallbackQuery(msg.cb_id, "🤔شما با استفاده از این قسمت میتونید تعداد حروف مجاز در جمله رو تنظیم کنید.\nبرای مثال کلمه ی سلام 4 حرف دارد...\nاگر این مقدار روی 1000 تنظیم شده باشد پیام های بیشتر از 1000 حرف توسط ربات حذف میگردد.", true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setting:settings" then
	     loadSettings_One(msg, blocks[2], blocks[4])
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:gosettings:2" then
	     loadSettings_Two(msg, blocks[2], blocks[4])
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:filters:mgr" then
	    db:del('bot:'..blocks[4]..':filters:'..blocks[2])
	    api.answerCallbackQuery(msg.cb_id, "لیست کلمات فیلتر شده با موفقیت خالی شد.", true)
	    api.editMessageText(false, msg.message_id, "کلمه ایی در این گروه فیلتر نشده است...", b_settings(blocks[2], blocks[3], blocks[4]), true, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:mutes:mgr" then
	     api.sendMessage(blocks[4], "`##cmutes:G="..blocks[2]..":m_id="..msg.message_id..":user_id="..blocks[3].."##`" , true)
	     api.answerCallbackQuery(msg.cb_id, "لیست افراد میوت شده با موفقیت خالی شد.", true)
	     api.editMessageText(false, msg.message_id, "هیچ کاربری در این گروه میوت نشده...", b_home(blocks[2], blocks[3], blocks[4]), false, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:bans:mgr" then
		 api.sendMessage(blocks[4], "`##cbans:G="..blocks[2]..":m_id="..msg.message_id..":user_id="..blocks[3].."##`" , true)
	     api.answerCallbackQuery(msg.cb_id, "لیست افراد بن شده با موفقیت خالی شد.", true)
	     api.editMessageText(false, msg.message_id, "هیچ کاربری در این گروه بن نشده...", b_home(blocks[2], blocks[3], blocks[4]), false, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:wlist:mgr" then
	     db:del("bot:"..blocks[4]..":whitelist:"..blocks[2])
	     api.answerCallbackQuery(msg.cb_id, "لیست سفید گروه با موفقیت خالی شد.", true)
	     api.editMessageText(false, msg.message_id, "لیست سفید گروه خالی است...", b_home(blocks[2], blocks[3], blocks[4]), false, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:mods:mgr" then
	     db:del('bot:'..blocks[4]..':mods:'..blocks[2])
	     api.answerCallbackQuery(msg.cb_id, "لیست مدیران با موفقیت خالی شد.", true)
	    local owners = db:smembers("bot:"..blocks[4]..":owners:"..blocks[2])
	    local text = "" 
		if #owners ~= 0 then
	    text = "لیست اونر های گروه:\n"
	     for k,v in pairs(owners) do
	       local user_info = db:hgetall('user:'..v)
		   if user_info and user_info.username then
		      local username = user_info.username
		      text = text..""..k.." - `[@"..username.."] -> ("..v..")`\n"
		    else
		   	  text = text..""..k.." - `["..v.."]`\n"
		    end
	     end
		 text = text.."➖➖➖➖➖➖➖➖➖\n"
		end
		keyboard = mods_panel(blocks[2], blocks[3],blocks[4])
	    if #owners == 0 then
	      text = "_این گروه هیچ مدیری ندارد!_"
		  keyboard = b_home(blocks[2], blocks[3],blocks[4])
	    end
	      api.editMessageText(false, msg.message_id, string.sub(text, 1, 4096), keyboard, true, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:back" then
	  	local ex = db:ttl("bot:"..blocks[4]..":charge:"..blocks[2])
	    local expire_time
          if ex == -1 or ex == "-1" then
              expire_time = "*نوع پنل* : `نامحدود`"
	      elseif ex == -2 or ex == "-2" then
	          expire_time = "*نوع پنل* : `به پایان رسیده⚠️`"
          else
            local d = getTime(ex)
            expire_time = "*نوع پنل* : `محدود (تا "..d.." دیگر ربات در گروه فعال میماند)`"
          end
	      text = '*به پنل مدیریتی گروه خوش آمدید.🌹*\n_برای مدیریت گروه میتونید از دکمه های زیر استفاده کنید..._\n[برای اطلاعات بیشتر با کلیک کردن روی این متن در کانال ما عضو شوید!](https://telegram.me/'..config.channel..')\n\n*آیدی گروه *: `'..blocks[2]..'`\n'..expire_time
	      keyboard = load_home(blocks[2], blocks[3],blocks[4])
	        api.editMessageText(false, msg.message_id, text, keyboard, true, true)
  	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:settings" then
		  text = "تنظیمات گروه به 3 بخش جدا تقسیم شده...\nلطفا گزینه ی مورد نظر رو انتخاب کنید:"
		  keyboard = settings_panel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:locksp" then
	    if blocks[6] == "flood" then 
		  if db:get("bot:"..blocks[4]..":anti-flood:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":anti-flood:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "سیستم آنتی فلود فعال شد🔐\n\n💡از این بعد ربات به پیام های پشت سر هم (به اصطلاح رگباری) واکنش نشان میدهد و کاربر اسپمر را از گروه حذف میکند.",true)
          else
             db:set("bot:"..blocks[4]..":anti-flood:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "سیستم آنتی فلود غیر فعال شد🔓\n\n💡از این بعد ربات به پیام های پشت سر هم (به اصطلاح رگباری) توجهی نمیکند.",true)
          end
		elseif blocks[6] == "spam" then 
		  if db:get("bot:"..blocks[4]..":locks:spam:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:spam:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "سیستم آنتی اسپم فعال شد🔐\n\n💡از این بعد ربات به پیام های طولانی (اسپم) واکنش نشان میدهد و پیام های طولانی رو با توجه به مقدار تنظیم شده توسط شما در تعداد حروف مجاز در جمله پاک میکند.",true)
          else
             db:set("bot:"..blocks[4]..":locks:spam:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "سیستم آنتی اسپم غیر فعال شد🔓\n\n💡از این بعد ربات به پیام های طولانی (اسپم) توجهی نمیکند.",true)
          end
		end
		load_antiFlood(msg, blocks[2],blocks[4])
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:locksps" then
	    if blocks[6] == "autodelete" then 
		  if db:get("bot:"..blocks[4]..":autodelete:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":autodelete:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "حذف خودکار پیام های ربات غیر فعال شد⚠️",true)
          else
             db:set("bot:"..blocks[4]..":autodelete:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "حذف خودکار پیام های ربات فعال شد✅",true)
          end
		end
		load_autoDelete(msg, blocks[2],blocks[4])
	  end
	   -----------------------------------------------------------------------------
	  if blocks[1] == "bp:lockspd" then
	    if blocks[6] == "warns" then 
		  if db:get("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":warn_status") then
             db:del("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":warn_status")
          else
             db:set("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":warn_status", true)
          end
		end
		load_warns(msg, blocks[2],blocks[4])
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:lockspds" then
	    if blocks[6] == "fadd" then 
		  if db:get("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":fadd_status") then
             db:del("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":fadd_status")
          else
             db:set("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":fadd_status", true)
          end
		end
		load_fadd(msg, blocks[2],blocks[4])
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:lock" then
	    if blocks[6] == "link" then 
		  if db:get("bot:"..blocks[4]..":locks:link:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:link:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال لینک آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:link:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال لینک قفل شد🔐")
          end
		elseif blocks[6] == "webpage" then 
		  if db:get("bot:"..blocks[4]..":locks:webpage:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:webpage:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال لینک سایت آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:webpage:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال لینک سایت قفل شد🔐")
          end
		elseif blocks[6] == "tag" then 
		  if db:get("bot:"..blocks[4]..":locks:tag:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:tag:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال تگ{@} آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:tag:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال تگ{@} قفل شد🔐")
          end
		elseif blocks[6] == "hashtag" then 
		  if db:get("bot:"..blocks[4]..":locks:hashtag:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:hashtag:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال هشتگ{#} آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:hashtag:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال هشتگ{#} قفل شد🔐")
          end
		elseif blocks[6] == "english" then 
		  if db:get("bot:"..blocks[4]..":locks:english:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:english:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "کلمات انگلیسی آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:english:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "کلمات انگلیسی قفل شد🔐")
          end
		elseif blocks[6] == "persian" then 
		  if db:get("bot:"..blocks[4]..":locks:arabic:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:arabic:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "کلمات فارسی آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:arabic:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "کلمات فارسی قفل شد🔐")
          end
		elseif blocks[6] == "edit" then 
		  if db:get("bot:"..blocks[4]..":locks:edit:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:edit:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ادیت کردن پیام آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:edit:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ادیت کردن پیام قفل شد🔐")
          end
		elseif blocks[6] == "forward" then 
		  if db:get("bot:"..blocks[4]..":locks:forward:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:forward:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "فوروارد پیام آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:forward:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "فوروارد پیام قفل شد🔐")
          end
		elseif blocks[6] == "pin" then 
		  if db:get("bot:"..blocks[4]..":locks:pin:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:pin:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "پین کردن پیام آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:pin:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "پین کردن پیام قفل شد🔐")
          end
		elseif blocks[6] == "contact" then 
		  if db:get("bot:"..blocks[4]..":locks:contact:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:contact:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال شماره(کانتکت) آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:contact:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال شماره(کانتکت) قفل شد🔐")
          end
		elseif blocks[6] == "join" then 
		  if db:get("bot:"..blocks[4]..":locks:members:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:members:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ورود عضو جدید به گروه آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:members:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ورود عضو جدید به گروه قفل شد🔐")
          end
		elseif blocks[6] == "tgservice" then 
		  if db:get("bot:"..blocks[4]..":locks:tgservice:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:tgservice:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "پیام ورود و خروج آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:tgservice:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "پیام ورود و خروج قفل شد🔐")
          end
		elseif blocks[6] == "bots" then 
		  if db:get("bot:"..blocks[4]..":locks:bot:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:bot:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "اضافه کردن ربات به گروه آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:bot:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "اضافه کردن ربات به گروه قفل شد🔐")
          end
		elseif blocks[6] == "all" then 
		  if db:get("bot:"..blocks[4]..":locks:all:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:all:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال پیام در گروه آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:all:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال پیام در گروه قفل شد🔐")
          end
		elseif blocks[6] == "text" then 
		  if db:get("bot:"..blocks[4]..":locks:text:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:text:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال پیام متنی در گروه آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:text:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال پیام متنی در گروه قفل شد🔐")
          end
		elseif blocks[6] == "sticker" then 
		  if db:get("bot:"..blocks[4]..":locks:sticker:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:sticker:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال استیکر آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:sticker:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال استیکر قفل شد🔐")
          end
		elseif blocks[6] == "photo" then 
		  if db:get("bot:"..blocks[4]..":locks:photo:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:photo:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال عکس آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:photo:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال عکس قفل شد🔐")
          end
		elseif blocks[6] == "game" then 
		  if db:get("bot:"..blocks[4]..":locks:game:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:game:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال بازی آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:game:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال بازی قفل شد🔐")
          end
		elseif blocks[6] == "inline" then 
		  if db:get("bot:"..blocks[4]..":locks:inline:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:inline:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال دکمه شیشه ایی آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:inline:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال دکمه شیشه ایی قفل شد🔐")
          end
		elseif blocks[6] == "video" then 
		  if db:get("bot:"..blocks[4]..":locks:video:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:video:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال فیلم آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:video:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال فیلم قفل شد🔐")
          end
		elseif blocks[6] == "gif" then 
		  if db:get("bot:"..blocks[4]..":locks:gif:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:gif:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال گیف آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:gif:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال گیف قفل شد🔐")
          end
		elseif blocks[6] == "music" then 
		  if db:get("bot:"..blocks[4]..":locks:music:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:music:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال آهنگ آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:music:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال آهنگ قفل شد🔐")
          end
		elseif blocks[6] == "location" then 
		  if db:get("bot:"..blocks[4]..":locks:location:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:location:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال لوکیشن آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:location:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال لوکیشن قفل شد🔐")
          end
		elseif blocks[6] == "document" then 
		  if db:get("bot:"..blocks[4]..":locks:document:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:document:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال فایل آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:document:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال فایل قفل شد🔐")
          end
		elseif blocks[6] == "voice" then 
		  if db:get("bot:"..blocks[4]..":locks:voice:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:voice:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال وویس آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:voice:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال وویس قفل شد🔐")
          end
		elseif blocks[6] == "vm" then 
		  if db:get("bot:"..blocks[4]..":locks:vm:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:vm:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "ارسال پیام تصویری آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:vm:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "ارسال پیام تصویری قفل شد🔐")
          end
		elseif blocks[6] == "kickme" then 
		  if db:get("bot:"..blocks[4]..":locks:kickme:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:kickme:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "دستور kickme/ آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:kickme:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "دستور kickme/ قفل شد🔐")
          end
		elseif blocks[6] == "cmds" then 
		  if db:get("bot:"..blocks[4]..":locks:cmd:"..blocks[2]) then
             db:del("bot:"..blocks[4]..":locks:cmd:"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "دستورات عادی ربات برای کاربران آزاد شد🔓")
          else
             db:set("bot:"..blocks[4]..":locks:cmd:"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "دستورات عادی ربات برای کاربران قفل شد🔐")
          end
		end
		if blocks[5] == "1" then
		   loadSettings_One(msg, blocks[2], blocks[4])
		elseif blocks[5] == "2" then
		   loadSettings_Two(msg, blocks[2], blocks[4])
		end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setting:antispam" then
		  load_antiFlood(msg, blocks[2],blocks[4])
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setting:warns" then
		  load_warns(msg, blocks[2],blocks[4])
	  end
	   -----------------------------------------------------------------------------
	  if blocks[1] == "bp:warns:down" then
	    local WarnsNum = (db:get("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":maxwarn") or 3)
		if tonumber(WarnsNum) > 2 then
		local new_WarnsNum = tonumber(WarnsNum) - 1
		  db:set("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":maxwarn", new_WarnsNum)
	      load_warns(msg, blocks[2],blocks[4])
		else
	      api.answerCallbackQuery(msg.cb_id, "کاربر گرامی:\nحداقل مقدار مجاز برای این قسمت 2 اخطار میباشد⚠️",true)
		end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:warns:up" then
	    local WarnsNum = (db:get("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":maxwarn") or 3)
		if tonumber(WarnsNum) < 20 then
		local new_WarnsNum = tonumber(WarnsNum) + 1
		  db:set("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":maxwarn", new_WarnsNum)
	      load_warns(msg, blocks[2],blocks[4])
		else
	      api.answerCallbackQuery(msg.cb_id, "کاربر گرامی:\nحداکثر مقدار مجاز برای این قسمت 20 اخطار میباشد⚠️",true)
		end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setting:fadd" then
		  load_fadd(msg, blocks[2],blocks[4])
	  end
	   -----------------------------------------------------------------------------
	  if blocks[1] == "bp:fadd:down" then
	    local faddNum = (db:get("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":maxinv") or 2)
		if tonumber(faddNum) > 2 then
		local new_faddNum = tonumber(faddNum) - 1
		  db:set("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":maxinv", new_faddNum)
	      load_fadd(msg, blocks[2],blocks[4])
		else
	      api.answerCallbackQuery(msg.cb_id, "کاربر گرامی:\nحداقل مقدار مجاز برای این قسمت 2 نفر میباشد⚠️",true)
		end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:fadd:up" then
	    local faddNum = (db:get("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":maxinv") or 2)
		if tonumber(faddNum) < 20 then
		local new_faddNum = tonumber(faddNum) + 1
		  db:set("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":maxinv", new_faddNum)
	      load_fadd(msg, blocks[2],blocks[4])
		else
	      api.answerCallbackQuery(msg.cb_id, "کاربر گرامی:\nحداکثر مقدار مجاز برای این قسمت 20 نفر میباشد⚠️️",true)
		end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:warns:clean" then
		local AllWarns = db:keys("bot:" .. blocks[4] .. ":chat_id:" .. blocks[2] .. ":user-warns:*")
	    for k,v in pairs(AllWarns) do
		    db:del(v)
		end
	    api.answerCallbackQuery(msg.cb_id, "تمامی اخطار های دریافت شده توسط کاربران این گروه با موفقیت حذف شد✅",true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:antiflood:down" then
	    local floodMax = db:get('bot:'..blocks[4]..':flood:max:'..blocks[2]) or 5
		if tonumber(floodMax) > 2 then
		local new_floodMax = tonumber(floodMax) - 1
		  db:set('bot:'..blocks[4]..':flood:max:'..blocks[2], new_floodMax)
	      load_antiFlood(msg, blocks[2],blocks[4])
		else
	      api.answerCallbackQuery(msg.cb_id, "حداقل میزان قابل تنظیم برای آنتی فلود 2 میباشد⚠️",true)
		end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:antiflood:up" then
	    local floodMax = db:get('bot:'..blocks[4]..':flood:max:'..blocks[2]) or 5
		if tonumber(floodMax) < 10 then
		local new_floodMax = tonumber(floodMax) + 1
		  db:set('bot:'..blocks[4]..':flood:max:'..blocks[2], new_floodMax)
	      load_antiFlood(msg, blocks[2],blocks[4])
		else
	      api.answerCallbackQuery(msg.cb_id, "حداکثر میزان قابل تنظیم برای آنتی فلود 10 میباشد⚠️",true)
		end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:antifloodtime:down" then
	    local floodTime = db:get('bot:'..blocks[4]..':flood:time:'..blocks[2]) or 3
		if tonumber(floodTime) > 1 then
		local new_floodTime = tonumber(floodTime) - 1
		  db:set('bot:'..blocks[4]..':flood:time:'..blocks[2], new_floodTime)
	      load_antiFlood(msg, blocks[2],blocks[4])
		else
	      api.answerCallbackQuery(msg.cb_id, "حداقل میزان قابل تنظیم برای زمان آنتی فلود 1 میباشد⚠️",true)
		end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:antifloodtime:up" then
	    local floodTime = db:get('bot:'..blocks[4]..':flood:time:'..blocks[2]) or 3
		if tonumber(floodTime) < 5 then
		local new_floodTime = tonumber(floodTime) + 1
		  db:set('bot:'..blocks[4]..':flood:time:'..blocks[2], new_floodTime)
	      load_antiFlood(msg, blocks[2],blocks[4])
		else
	      api.answerCallbackQuery(msg.cb_id, "حداکثر میزان قابل تنظیم برای زمان آنتی فلود 5 میباشد⚠️",true)
		end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:antispam:down" then
	    local maxChar = db:get('bot:'..blocks[4]..':set_char:'..blocks[2]) or 4000
		if tonumber(maxChar) > 1000 then
		local new_maxChar = tonumber(maxChar) - 1000
		  db:set('bot:'..blocks[4]..':set_char:'..blocks[2], new_maxChar)
	      load_antiFlood(msg, blocks[2],blocks[4])
		else
	      api.answerCallbackQuery(msg.cb_id, "حداقل میزان برای محدود کردن پیام ها 1000 میباشد⚠️\nدر صورتی که قصد غیر فعال کردن این قابلیت رو دارید روی دکمه ی آنتی اسپم کلیک کنید تا غیر فعال شود.",true)
		end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:antispam:up" then
	    local maxChar = db:get('bot:'..blocks[4]..':set_char:'..blocks[2]) or 4000
		if tonumber(maxChar) < 5000 then
		local new_maxChar = tonumber(maxChar) + 1000
		  db:set('bot:'..blocks[4]..':set_char:'..blocks[2], new_maxChar)
	      load_antiFlood(msg, blocks[2],blocks[4])
		else
	      api.answerCallbackQuery(msg.cb_id, "حداکثر میزان برای محدود کردن پیام ها 5000 میباشد⚠️\nدر صورتی که قصد غیر فعال کردن این قابلیت رو دارید روی دکمه ی آنتی اسپم کلیک کنید تا غیر فعال شود.",true)
		end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:autodel" then
		  load_autoDelete(msg, blocks[2],blocks[4])
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:autodelete:down" then
	    local deletetime = (db:get('bot:'..blocks[4]..':autodelete:time:'..blocks[2]) or 35)
		if tonumber(deletetime) > 14 then
		local new_deleteTime = tonumber(deletetime) - 10
		  db:set('bot:'..blocks[4]..':autodelete:time:'..blocks[2], new_deleteTime)
	      load_autoDelete(msg, blocks[2],blocks[4])
		else
	      api.answerCallbackQuery(msg.cb_id, "حداقل میزان قابل تنظیم برای حذف خودکار پیام ها 5 ثانیه میباشد⚠️",true)
		end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:autodelete:up" then
	    local deletetime = (db:get('bot:'..blocks[4]..':autodelete:time:'..blocks[2]) or 35)
		if tonumber(deletetime) < 300 then
		local new_deleteTime = tonumber(deletetime) + 10
		  db:set('bot:'..blocks[4]..':autodelete:time:'..blocks[2], new_deleteTime)
	      load_autoDelete(msg, blocks[2],blocks[4])
		else
	      api.answerCallbackQuery(msg.cb_id, "حداکثر میزان قابل تنظیم برای حذف خودکار پیام ها 305 ثانیه میباشد⚠️",true)
		end
	  end
	   -----------------------------------------------------------------------------
	  if blocks[1] == "bp:sup" then
		  text = "   ⁧"
		  keyboard = sup_panel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:cpanel" then
		  text = "_پنل مدیریتی ربات با موفقیت بسته شد✅_"
	      api.editMessageText(false, msg.message_id, text, false, true, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setlink:cancel" then
	      api.answerCallbackQuery(msg.cb_id, "حالت انتظار برای لینک گروه با موفقیت غیر فعال شد.",true)
	      db:del('bot:'..blocks[4]..':w8link:'..blocks[2]..':'..msg.from.id)
		  local link = db:get('bot:'..blocks[4]..':link:'..blocks[2])
		  if link then
		    text = "لینک گروه : \n"..link
		    keyboard = link_Ypanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard)
	      else
		    text = "_لینک این گروه در ربات ذخیره نشده است!_\n`برای ذخیره کردن لینک گروه از دکمه های زیر استفاده کنید.`[⁧](https://telegram.me/"..config.channel..")"
		    keyboard = link_Npanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
		  end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setlink:cancelnonotif" then
	      db:del('bot:'..blocks[4]..':w8link:'..blocks[2]..':'..msg.from.id)
		  local link = db:get('bot:'..blocks[4]..':link:'..blocks[2])
		  if link then
		    text = "لینک گروه : \n"..link
		    keyboard = link_Ypanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard)
	      else
		    text = "_لینک این گروه در ربات ذخیره نشده است!_\n`برای ذخیره کردن لینک گروه از دکمه های زیر استفاده کنید.`[⁧](https://telegram.me/"..config.channel..")"
		    keyboard = link_Npanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
		  end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setlink:step_one" then
	    db:set('bot:'..blocks[4]..':w8link:'..blocks[2]..':'..msg.from.id, msg.message_id)
		  text = "_حالا لینک گروهتون رو بفرستید تا براتون توی ربات ذخیرش کنم🌹_[⁧](https://telegram.me/"..config.channel..")"
		  keyboard = wait_link(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:dellink:step_one" then
	    db:del('bot:'..blocks[4]..':link:'..blocks[2])
		  text = "_لینک این گروه در ربات ذخیره نشده است!_\n`برای ذخیره کردن لینک گروه از دکمه های زیر استفاده کنید.`[⁧](https://telegram.me/"..config.channel..")"
		  keyboard = link_Npanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:link" then
	    local link = db:get('bot:'..blocks[4]..':link:'..blocks[2])
		  if link then
		    text = "لینک گروه : \n"..link
		    keyboard = link_Ypanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard)
	      else
		    text = "_لینک این گروه در ربات ذخیره نشده است!_\n`برای ذخیره کردن لینک گروه از دکمه های زیر استفاده کنید.`[⁧](https://telegram.me/"..config.channel..")"
		    keyboard = link_Npanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
		  end
	   end
	   -----------------------------------------------------------------------------
	   -----------------------------------------------------------------------------
	   -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setrules:cancel" then
	      api.answerCallbackQuery(msg.cb_id, "حالت انتظار برای قوانین گروه با موفقیت غیر فعال شد.",true)
	      db:del('bot:'..blocks[4]..':w8rules:'..blocks[2]..':'..msg.from.id)
	      local rules = db:get('bot:'..blocks[4]..':rules:'..blocks[2])
		  if rules then
		    text = "قوانین گروه:\n__________________\n`"..rules:gsub("`","").."`"
		    keyboard = rules_Ypanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true)
	      else
		    text = "_قوانینی برای این گروه در ربات ذخیره نشده است!_\n`برای ذخیره کردن قوانین گروه از دکمه های زیر استفاده کنید.`[⁧](https://telegram.me/"..config.channel..")"
		    keyboard = rules_Npanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
		  end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setrules:cancelnonotif" then
	      db:del('bot:'..blocks[4]..':w8rules:'..blocks[2]..':'..msg.from.id)
	      local rules = db:get('bot:'..blocks[4]..':rules:'..blocks[2])
		  if rules then
		    text = "قوانین گروه:\n__________________\n`"..rules:gsub("`","").."`"
		    keyboard = rules_Ypanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true)
	      else
		    text = "_قوانینی برای این گروه در ربات ذخیره نشده است!_\n`برای ذخیره کردن قوانین گروه از دکمه های زیر استفاده کنید.`[⁧](https://telegram.me/"..config.channel..")"
		    keyboard = rules_Npanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
		  end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setrules:step_one" then
	    db:set('bot:'..blocks[4]..':w8rules:'..blocks[2]..':'..msg.from.id, msg.message_id)
		  text = "_حالا قوانین گروهتون رو بفرستید تا براتون توی ربات ذخیرش کنم🌹_[⁧](https://telegram.me/"..config.channel..")"
		  keyboard = wait_rules(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:delrules:step_one" then
	    db:del('bot:'..blocks[4]..':rules:'..blocks[2])
		  text = "_قوانین این گروه در ربات ذخیره نشده است!_\n`برای ذخیره کردن قوانین گروه از دکمه های زیر استفاده کنید.`[⁧](https://telegram.me/"..config.channel..")"
		  keyboard = rules_Npanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:rules" then
	    local rules = db:get('bot:'..blocks[4]..':rules:'..blocks[2])
		  if rules then
		    text = "قوانین گروه:\n__________________\n`"..rules:gsub("`","").."`"
		    keyboard = rules_Ypanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true)
	      else
		    text = "_قوانینی برای این گروه در ربات ذخیره نشده است!_\n`برای ذخیره کردن قوانین گروه از دکمه های زیر استفاده کنید.`[⁧](https://telegram.me/"..config.channel..")"
		    keyboard = rules_Npanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
		  end
	   end
	   -----------------------------------------------------------------------------
	   -----------------------------------------------------------------------------
	   -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setwelcome:cancel" then
	      api.answerCallbackQuery(msg.cb_id, "حالت انتظار برای متن خوشامد گویی گروه با موفقیت غیر فعال شد.",true)
	      db:del('bot:'..blocks[4]..':w8welcome:'..blocks[2]..':'..msg.from.id)
		  db:del("bot:"..blocks[4]..":welcome"..blocks[2])
	    local welcome = db:get('bot:'..blocks[4]..':welcome:'..blocks[2])
		  if welcome then
		    text = "_متن خوشامد گویی گروه:_\n*__________________*\n`"..welcome:gsub("`","").."`"
		    local welcome_status
			if db:get("bot:"..blocks[4]..":welcome"..blocks[2]) then
			   welcome_status = "پیام خوشامد گویی : فعال✅"
			else
			   welcome_status = "پیام خوشامد گویی : غیر فعال❎"
			end
		    keyboard = welcome_Ypanel(blocks[2], blocks[3],blocks[4], welcome_status)
	      api.editMessageText(false, msg.message_id, text, keyboard, true)
	      else
		    text = "*متن خوشامد گویی برای این گروه تنظیم نشده!*\n`برای ذخیره کردن متن خوشامد گویی از دکمه های زیر استفاده کنید:`\n_توجه داشته باشید که در متن خوشامد گویی از متغییر های زیر هم استفاده کنید:_\n\n`{username} \nبرای نمایش یوزرنیم فرد وارد شده به گروه\n\n{firstname} \nبرای نمایش نام فرد وارد شده به گروه\n\n{lastname} \nبرای نمایش نام خانوادگی فرد وارد شده به گروه\n\n{rules} \nبرای نمایش قوانین گروه`"
		    keyboard = welcome_Npanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
		  end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setwelcome:cancelnonotif" then
	      db:del('bot:'..blocks[4]..':w8welcome:'..blocks[2]..':'..msg.from.id)
	    local welcome = db:get('bot'..blocks[4]..':welcome:'..blocks[2])
		  if welcome then
		    text = "_متن خوشامد گویی گروه:_\n*__________________*\n`"..welcome:gsub("`","").."`"
		    local welcome_status
			if db:get("bot:"..blocks[4]..":welcome"..blocks[2]) then
			   welcome_status = "پیام خوشامد گویی : فعال✅"
			else
			   welcome_status = "پیام خوشامد گویی : غیر فعال❎"
			end
		    keyboard = welcome_Ypanel(blocks[2], blocks[3],blocks[4], welcome_status)
	      api.editMessageText(false, msg.message_id, text, keyboard, true)
	      else
		    text = "*متن خوشامد گویی برای این گروه تنظیم نشده!*\n`برای ذخیره کردن متن خوشامد گویی از دکمه های زیر استفاده کنید:`\n_توجه داشته باشید که در متن خوشامد گویی از متغییر های زیر هم استفاده کنید:_\n\n`{username} \nبرای نمایش یوزرنیم فرد وارد شده به گروه\n\n{firstname} \nبرای نمایش نام فرد وارد شده به گروه\n\n{lastname} \nبرای نمایش نام خانوادگی فرد وارد شده به گروه\n\n{rules} \nبرای نمایش قوانین گروه`"
		    keyboard = welcome_Npanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
		  end
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setwelcome:step_one" then
	    db:set('bot:'..blocks[4]..':w8welcome:'..blocks[2]..':'..msg.from.id, msg.message_id)
		  text = "_حالا متن خوشامد گویی گروهتون رو بفرستید تا براتون توی ربات ذخیرش کنم🌹_[⁧](https://telegram.me/"..config.channel..")"
		  keyboard = wait_welcome(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:delwelcome:step_one" then
	    db:del('bot'..blocks[4]..':welcome:'..blocks[2])
		db:del('bot:'..blocks[4]..':welcome'..blocks[2])
		  text = "*متن خوشامد گویی برای این گروه تنظیم نشده!*\n`برای ذخیره کردن متن خوشامد گویی از دکمه های زیر استفاده کنید:`\n_توجه داشته باشید که در متن خوشامد گویی از متغییر های زیر هم استفاده کنید:_\n\n`{username} \nبرای نمایش یوزرنیم فرد وارد شده به گروه\n\n{firstname} \nبرای نمایش نام فرد وارد شده به گروه\n\n{lastname} \nبرای نمایش نام خانوادگی فرد وارد شده به گروه\n\n{rules} \nبرای نمایش قوانین گروه`"
		  keyboard = welcome_Npanel(blocks[2], blocks[3],blocks[4])
	    api.editMessageText(false, msg.message_id, text, keyboard, true, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:chnage:welcome" then
	      if db:get("bot:"..blocks[4]..":welcome"..blocks[2]) then
             db:del("bot:"..blocks[4]..":welcome"..blocks[2])
	         api.answerCallbackQuery(msg.cb_id, "یپام خوشامد گویی گروه غیر فعال شد❌")
          else
             db:set("bot:"..blocks[4]..":welcome"..blocks[2], true)
	         api.answerCallbackQuery(msg.cb_id, "یپام خوشامد گویی گروه فعال شد✅")
          end
		  local welcome = db:get('bot:'..blocks[4]..':welcome:'..blocks[2])
		  local text
		  if welcome then
		    text = "_متن خوشامد گویی گروه:_\n*__________________*\n`"..welcome:gsub("`","").."`"
		  else
		    text = "*متن خوشامد گویی برای این گروه تنظیم نشده!*\n`برای ذخیره کردن متن خوشامد گویی از دکمه های زیر استفاده کنید:`\n_توجه داشته باشید که در متن خوشامد گویی از متغییر های زیر هم استفاده کنید:_\n\n`{username} \nبرای نمایش یوزرنیم فرد وارد شده به گروه\n\n{firstname} \nبرای نمایش نام فرد وارد شده به گروه\n\n{lastname} \nبرای نمایش نام خانوادگی فرد وارد شده به گروه\n\n{rules} \nبرای نمایش قوانین گروه`"
		  end
		  local welcome_status
			if db:get("bot:"..blocks[4]..":welcome"..blocks[2]) then
			   welcome_status = "پیام خوشامد گویی : فعال✅"
			else
			   welcome_status = "پیام خوشامد گویی : غیر فعال❎"
			end
		    keyboard = welcome_Ypanel(blocks[2], blocks[3],blocks[4], welcome_status)
	    api.editMessageText(false, msg.message_id, text, keyboard, true, true)
	  end
	  -----------------------------------------------------------------------------
	  if blocks[1] == "bp:wlcsettings" then
	    local welcome = db:get('bot:'..blocks[4]..':welcome:'..blocks[2])
		  if welcome then
		    text = "_متن خوشامد گویی گروه:_\n*__________________*\n`"..welcome:gsub("`","").."`"
			local welcome_status
			if db:get("bot:"..blocks[4]..":welcome"..blocks[2]) then
			   welcome_status = "پیام خوشامد گویی : فعال✅"
			else
			   welcome_status = "پیام خوشامد گویی : غیر فعال❎"
			end
		    keyboard = welcome_Ypanel(blocks[2], blocks[3],blocks[4], welcome_status)
	      api.editMessageText(false, msg.message_id, text, keyboard, true)
	      else
		    text = "*متن خوشامد گویی برای این گروه تنظیم نشده!*\n`برای ذخیره کردن متن خوشامد گویی از دکمه های زیر استفاده کنید:`\n_توجه داشته باشید که در متن خوشامد گویی از متغییر های زیر هم استفاده کنید:_\n\n`{username} \nبرای نمایش یوزرنیم فرد وارد شده به گروه\n\n{firstname} \nبرای نمایش نام فرد وارد شده به گروه\n\n{lastname} \nبرای نمایش نام خانوادگی فرد وارد شده به گروه\n\n{rules} \nبرای نمایش قوانین گروه`"
		    keyboard = welcome_Npanel(blocks[2], blocks[3],blocks[4])
	      api.editMessageText(false, msg.message_id, text, keyboard, true, true)
		  end
	   end
	   -----------------------------------------------------------------------------
	  if blocks[1] == "bp:modman:admin" then
	    local mod_hash = "bot:"..blocks[4]..":mods:"..blocks[2]
	    local mods = db:smembers(mod_hash)
		local owner_hash = "bot:"..blocks[4]..":owners:"..blocks[2]
	    local owners = db:smembers(owner_hash)
	    local text = "" 
		if #owners ~= 0 then
	    text = "لیست اونر های گروه:\n"
	     for k,v in pairs(owners) do
	       local user_info = db:hgetall('user:'..v)
		   if user_info and user_info.username then
		      local username = user_info.username
		      text = text..""..k.." - `[@"..username.."] -> ("..v..")`\n"
		    else
		   	  text = text..""..k.." - `["..v.."]`\n"
		    end
	     end
		 text = text.."____________________\n"
		end
		if #mods ~= 0 then
		text = text.."لیست مدیران گروه:\n"
		for k,v in pairs(mods) do
	       local user_info = db:hgetall('user:'..v)
		   if user_info and user_info.username then
		      local username = user_info.username
		      text = text..""..k.." - `[@"..username.."] -> ("..v..")`\n"
		    else
		   	  text = text..""..k.." - `["..v.."]`\n"
		    end
	     end
		end
		keyboard = mods_panel(blocks[2], blocks[3],blocks[4])
	    if #mods == 0 and #owners == 0 then
	      text = "_این گروه هیچ مدیری ندارد!_"
		  keyboard = b_home(blocks[2], blocks[3],blocks[4])
	    end
	      api.editMessageText(false, msg.message_id, string.sub(text, 1, 4096), keyboard, true, true)
	   end
	   -----------------------------------------------------------------------------
	  if blocks[1] == "bp:modman:wlist" then
	    local whitelist_hash = "bot:"..blocks[4]..":whitelist:"..blocks[2]
	    local whitelist = db:smembers(whitelist_hash)
	    local text 
		if #whitelist ~= 0 then
		text = "لیست سفید گروه:\n"
		for k,v in pairs(whitelist) do
	        local user_info = db:hgetall('user:'..v)
		    if user_info and user_info.username then
		        local username = user_info.username
		        text = text..""..k.." - `[@"..username.."] -> ("..v..")`\n"
		    else
		     	text = text..""..k.." - `["..v.."]`\n"
		    end
	    end
		    keyboard = wlist_panel(blocks[2], blocks[3],blocks[4])
		else
	        text = "_هیچ کاربری در این گروه در لیست سفید نیست!_"
		    keyboard = b_home(blocks[2], blocks[3],blocks[4])
	    end
	        api.editMessageText(false, msg.message_id, string.sub(text, 1, 4096), keyboard, true, true)
	  end
	    -----------------------------------------------------------------------------
	  if blocks[1] == "bp:modman:mute" then
	    local hash = db:smembers("bot:"..blocks[4]..":muted:"..blocks[2])
		local thash = db:keys("bot:"..blocks[4]..":tmuted:"..blocks[2]..":*")
		if #hash == 0 and #thash == 0 then
			api.editMessageText(false, msg.message_id, "هیچ کاربری در این گروه میوت نشده...", b_home(blocks[2], blocks[3],blocks[4]), false, true)
			return false
	    end
	    local text = "لیست کاربران میوت شده:\n\n"
	    for k,v in pairs(hash) do
	        local user_info = db:hgetall('user:'..v)
		    if user_info and user_info.username then
		      local username = user_info.username
		      text = text..""..k.." - `[@"..username.."] -> ("..v..")`\n"
		    else
		   	  text = text..""..k.." - `["..v.."]`\n"
		    end
	    end
		if #hash ~= 0 then 
		    if #thash ~= 0 then
			    text = text .. "➖➖➖➖➖➖➖➖➖\nلیست افراد میوت شده:(بصورت زمانی)\n\n"
			end
		else
		    if #thash ~= 0 then
			    text = "لیست افراد میوت شده:(بصورت زمانی)\n\n"
			end
		end
		for k,v in pairs(thash) do
		    limitTime = db:ttl(v) or 0
		    limitTime = getTime(limitTime)
		    v = v:match("bot:"..blocks[4]..":tmuted:%"..blocks[2]..":(.*)") or 0
	        local user_info = db:hgetall('user:'..v)
		    if user_info and user_info.username then
		      local username = user_info.username
		      text = text..""..k.." - `[@"..username.." -> ("..v..")] ("..limitTime..")`\n"
		    else
		   	  text = text..""..k.." - `["..v.."] -> ("..limitTime..")`\n"
		    end
	    end
		 keyboard = mutes_panel(blocks[2], blocks[3],blocks[4])
	     api.editMessageText(false, msg.message_id, string.sub(text, 1, 4096), keyboard, true, true)
	 end
	   -----------------------------------------------------------------------------
	  if blocks[1] == "bp:modman:ban" then
	    local hash = db:smembers("bot:"..blocks[4]..":banned:"..blocks[2])
		local thash = db:keys("bot:"..blocks[4]..":tbanned:"..blocks[2]..":*")
		if #hash == 0 and #thash == 0 then
			api.editMessageText(false, msg.message_id, "هیچ کاربری در این گروه بن نشده...", b_home(blocks[2], blocks[3],blocks[4]), false, true)
			return false
	    end
	    local text = "لیست کاربران بن شده:\n\n"
	    for k,v in pairs(hash) do
	        local user_info = db:hgetall('user:'..v)
		    if user_info and user_info.username then
		      local username = user_info.username
		      text = text..""..k.." - `[@"..username.."] -> ("..v..")`\n"
		    else
		   	  text = text..""..k.." - `["..v.."]`\n"
		    end
	    end
		if #hash ~= 0 then 
		    if #thash ~= 0 then
			    text = text .. "➖➖➖➖➖➖➖➖➖\nلیست افراد بن شده:(بصورت زمانی)\n\n"
			end
		else
		    if #thash ~= 0 then
			    text = "لیست افراد بن شده:(بصورت زمانی)\n\n"
			end
		end
		for k,v in pairs(thash) do
		    limitTime = db:ttl(v) or 0
		    limitTime = getTime(limitTime)
		    v = v:match("bot:"..blocks[4]..":tbanned:%"..blocks[2]..":(.*)") or 0
	        local user_info = db:hgetall('user:'..v)
		    if user_info and user_info.username then
		      local username = user_info.username
		      text = text..""..k.." - `[@"..username.." -> ("..v..")] ("..limitTime..")`\n"
		    else
		   	  text = text..""..k.." - `["..v.."] -> ("..limitTime..")`\n"
		    end
	    end
		 keyboard = bans_panel(blocks[2], blocks[3],blocks[4])
	     api.editMessageText(false, msg.message_id, string.sub(text, 1, 4096), keyboard, true, true)
	 end
	    -----------------------------------------------------------------------------
	  if blocks[1] == "bp:setting:filterlist" then
	    local hash = "bot:"..blocks[4]..":filters:"..blocks[2]
	    local list = db:hkeys(hash)
	    local text = "لیست کلمات فیلتر شده:\n\n"
		local k = 0
	     for i=1, #list do
		    k = k + 1
		   	text = text.."*"..k.."* - `["..list[i].."]`\n"
	     end
		 keyboard = filters_panel(blocks[2], blocks[3],blocks[4])
	     if #list == 0 then
	        text = "کلمه ایی در این گروه فیلتر نشده است..."
		    keyboard = b_settings(blocks[2], blocks[3],blocks[4])
	     end
	      api.editMessageText(false, msg.message_id, string.sub(text, 1, 4096), keyboard, true, true)
	   end
	    -----------------------------------------------------------------------------
	   if blocks[1] == "bp:modman:bots" then
	       api.sendMessage(blocks[4], "`##getbots:G="..blocks[2]..":m_id="..msg.message_id..":user_id="..blocks[3].."##`" , true)
	   end
	   -----------------------------------------------------------------------------
	  end
	  else
	    api.answerCallbackQuery(msg.cb_id, "شما مدیر این گروه نیستید و دسترسی به کنترل کردن این گروه رو ندارید!\nدر صورتی که قصد خرید این ربات رو برای گروهتون دارید به آیدی زیر پیام دهید:\n\n [ @"..config.Support.bot.." ]",true)
	  end
	end
    -----------------------------------------------------------------------------
end

return {
	admin_not_needed = true,
	triggers = {
		'^###incb:(bp:gpmanHELP):(.*):(.*):(.*)$',
		'^###incb:(bp:settings):(.*):(.*):(.*)$',
		'^###incb:(bp:link):(.*):(.*):(.*)$',
		'^###incb:(bp:rules):(.*):(.*):(.*)$',
		'^###incb:(bp:modmanHELP):(.*):(.*):(.*)$',
		'^###incb:(bp:modman:admin):(.*):(.*):(.*)$',
		'^###incb:(bp:modman:mute):(.*):(.*):(.*)$',
		'^###incb:(bp:modman:ban):(.*):(.*):(.*)$',
		'^###incb:(bp:modman:wlist):(.*):(.*):(.*)$',
		'^###incb:(bp:sup):(.*):(.*):(.*)$',
		'^###incb:(bp:cpanel):(.*):(.*):(.*)$',
		'^###incb:(bp:back):(.*):(.*):(.*)$',
		'^###incb:(bp:autodel):(.*):(.*):(.*)$',
		'^###incb:(bp:dellink:step_one):(.*):(.*):(.*)$',
		'^###incb:(bp:setlink:step_one):(.*):(.*):(.*)$',
		'^###incb:(bp:setlink:cancel):(.*):(.*):(.*)$',
		'^###incb:(bp:setlink:cancelnonotif):(.*):(.*):(.*)$',
		'^###incb:(bp:delrules:step_one):(.*):(.*):(.*)$',
		'^###incb:(bp:setrules:step_one):(.*):(.*):(.*)$',
		'^###incb:(bp:setrules:cancel):(.*):(.*):(.*)$',
		'^###incb:(bp:setrules:cancelnonotif):(.*):(.*):(.*)$',
		'^###incb:(bp:setting:settings):(.*):(.*):(.*)$',
		'^###incb:(bp:gosettings:2):(.*):(.*):(.*)$',
		'^###incb:(bp:lock):(.*):(.*):(.*):([12]):(.*)$',
		'^###incb:(bp:locksp):(.*):(.*):(.*):(.*):(.*)$',
		'^###incb:(bp:locksps):(.*):(.*):(.*):(.*):(.*)$',
		'^###incb:(bp:lockspd):(.*):(.*):(.*):(.*):(.*)$',
		'^###incb:(bp:lockspds):(.*):(.*):(.*):(.*):(.*)$',
		'^###incb:(bp:setting:antispam):(.*):(.*):(.*)$',
		'^###incb:(bp:setting:warns):(.*):(.*):(.*)$',
		'^###incb:(bp:setting:fadd):(.*):(.*):(.*)$',
		'^###incb:(bp:antiflood:down):(.*):(.*):(.*)$',
		'^###incb:(bp:autodelete:down):(.*):(.*):(.*)$',
		'^###incb:(bp:warns:down):(.*):(.*):(.*)$',
		'^###incb:(bp:fadd:down):(.*):(.*):(.*)$',
		'^###incb:(bp:antiflood:up):(.*):(.*):(.*)$',
		'^###incb:(bp:autodelete:up):(.*):(.*):(.*)$',
		'^###incb:(bp:warns:up):(.*):(.*):(.*)$',
		'^###incb:(bp:fadd:up):(.*):(.*):(.*)$',
		'^###incb:(bp:warns:clean):(.*):(.*):(.*)$',
		'^###incb:(bp:antifloodtime:down):(.*):(.*):(.*)$',
		'^###incb:(bp:antifloodtime:up):(.*):(.*):(.*)$',
		'^###incb:(bp:antispam:up):(.*):(.*):(.*)$',
		'^###incb:(bp:antispam:down):(.*):(.*):(.*)$',
		'^###incb:(bp:antiflood:help):(.*):(.*):(.*)$',
		'^###incb:(bp:antifloodtime:help):(.*):(.*):(.*)$',
		'^###incb:(bp:antispam:help):(.*):(.*):(.*)$',
		'^###incb:(bp:setting:filterlist):(.*):(.*):(.*)$',
		'^###incb:(bp:wlcsettings):(.*):(.*):(.*)$',
		'^###incb:(bp:delwelcome:step_one):(.*):(.*):(.*)$',
		'^###incb:(bp:setwelcome:step_one):(.*):(.*):(.*)$',
		'^###incb:(bp:setwelcome:cancel):(.*):(.*):(.*)$',
		'^###incb:(bp:setwelcome:cancelnonotif):(.*):(.*):(.*)$',
		'^###incb:(bp:chnage:welcome):(.*):(.*):(.*)$',
		'^###incb:(bp:modman:bots):(.*):(.*):(.*)$',
		'^###incb:(clb):(.*):(.*):(.*):([yn])$',
		'^###incb:(bp:filters:mgr):(.*):(.*):(.*)$',
		'^###incb:(bp:mutes:mgr):(.*):(.*):(.*)$',
		'^###incb:(bp:bans:mgr):(.*):(.*):(.*)$',
		'^###incb:(bp:mods:mgr):(.*):(.*):(.*)$',
		'^###incb:(bp:wlist:mgr):(.*):(.*):(.*)$',
    },
	
	action = action,
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