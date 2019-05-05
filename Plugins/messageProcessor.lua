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
local function check_filter_words(msg, value)
    local hash = 'bot:'..msg_.bot_id..':filters:'..msg.chat_id
    if hash then
        local names = redis:hkeys(hash)
        local text = ''
        for i=1, #names do
	        if string.match(value:lower(), names[i]:lower()) and not is_mod(msg)then
	            delete_msg(msg.chat_id, {[0] = msg.id})
				break
            end
        end
    end
end
-----------------------------------------------------------------------------------------------
local function check_global_filter_words(msg, value)
    local hash = 'bot:'..msg_.bot_id..':global:filters'
    if hash then
        local names = redis:hkeys(hash)
        local text = ''
        for i=1, #names do
	        if string.match(value:lower(), names[i]:lower()) and not is_mod(msg)then
	            delete_msg(msg.chat_id, {[0] = msg.id})
            end
        end
    end
end
------------------------------------------------------------
local function check_member_inv(msg)
	local function process_newUsers(arg, data)
	    if data then
		    if not is_mod(msg) then
		        if data.type._ == "userTypeBot" then
			        if redis:get("bot:"..msg_.bot_id..":locks:bot:"..msg.chat_id) then
			            chat_kick(msg.chat_id, tonumber(data.id))
			    	    if not redis:get('bot:'..msg_.bot_id..':last:BKick:'..msg.chat_id..':'..msg.sender_user_id) then
				            redis:setex('bot:'..msg_.bot_id..':last:BKick:'..msg.chat_id..':'..msg.sender_user_id, 60, true)
				            chat_kick(msg.chat_id, tonumber(msg.sender_user_id))
						    local function lockbots_kicked(extra,result,success)
    					    	if result.username then
						    	    sendMsg(msg.chat_id, 0, '*کاربر* `{'..result.username..'@}|{'..msg.sender_user_id..'}` \n_به دلیل اضافه کردن ربات به گروه کیک شد!_', "md")
							    else
							    	sendMsg(msg.chat_id, 0, '*کاربر* `{@'..(result.first_name or result.last_name)..'}|{'..msg.sender_user_id..'}` \n_به دلیل اضافه کردن ربات به گروه کیک شد!_', "md")
							    end
     					    end
						    if not is_sleep(msg) then
					            getUser(msg.sender_user_id, lockbots_kicked)
						    end
				        end
				    end
			    end
				if redis:get("bot:"..msg_.bot_id..":locks:members:"..msg.chat_id) then
				    chat_kick(msg.chat_id, tonumber(data.id))
					if not redis:get('bot:'..msg_.bot_id..':lockMember:alart:'..msg.chat_id) then
	        			local function addFalse_alart(arg, result)
		       			    if not is_sleep(msg) then
    	         			    if result.username then 
				      			    sendMsg(msg.chat_id, msg.id, '*کاربر* `{'..result.username..'@}|{'..msg.sender_user_id..'}`:\n_به دلیل قفل بودن اعضا کاربری که ادد کردید از گروه حذف شد!_\n`لطفا از تکرار این کار خودداری کنید.`', "md")
		         			    else
				  			        sendMsg(msg.chat_id, msg.id, '*کاربر* `{'..(result.first_name or result.last_name)..'}|{'..msg.sender_user_id..'}`:\n_به دلیل قفل بودن اعضا کاربری که ادد کردید از گروه حذف شد!_\n`لطفا از تکرار این کار خودداری کنید.`', "md")
		          			    end
	          		   		end
		    			end
		            	getUser(msg.sender_user_id, addFalse_alart)
		            	redis:setex('bot:'..msg_.bot_id..':lockMember:alart:'..msg.chat_id, 60, true)
		            end
				end
		    end
			if tonumber(data.id) == msg_.bot_id then
			    if not is_admin(msg) then
				    chat_leave(msg.chat_id, msg_.bot_id)
				else
				    if not redis:get("bot:"..msg_.bot_id..":charge:"..msg.chat_id) and not redis:get("bot:"..msg_.bot_id..":charge:alarted:"..msg.chat_id) then
	           	    	redis:setex("bot:"..msg_.bot_id..":charge:"..msg.chat_id, 300, true)
	           	    	redis:set("bot:"..msg_.bot_id..":charge:alarted:"..msg.chat_id, true)
						redis:sadd("bot:"..msg_.bot_id..":groups:", msg.chat_id)
						openChat(msg.chat_id)
						enable_channel(msg.chat_id)
					    sendMsg(msg.chat_id, msg.id, "ربات در گروه فعال شد!\nشما ٥ دقيقه وقت داريد كد فعال سازى گروه را وارد كنيد در غير اين صورت ربات گروه رو ترك ميكنه...\nدر صورتی که کد فعال سازی در اختیار ندارید برای تمدید کردن ربات برای گروه به @".._config.Support.bot.." پیام دهید.\n@".._config.channel, "html")
	 	    	    end
				end
			end
	    end
	end
	redis:incrbyfloat("b:"..msg_.bot_id..":"..msg.chat_id..":"..msg.sender_user_id, (#msg.content.member_user_ids + 1))
	for k,v in pairs(msg.content.member_user_ids) do
	    getUser(v, process_newUsers, msg)
	end
    if redis:get("bot:"..msg_.bot_id..":welcome"..msg.chat_id) then
	    local function sendWelcome(arg, data)
            if redis:get('bot:'..msg_.bot_id..':welcome:'..msg.chat_id) then
                text = redis:get('bot:'..msg_.bot_id..':welcome:'..msg.chat_id)
            else
                text = 'Hi {firstname} 😃'
            end
            local text = text:gsub('{rules}',(redis:get('bot:'..msg_.bot_id..':rules:'..msg.chat_id) or ''))
            local text = text:gsub('{firstname}',(data.first_name or ''))
            local text = text:gsub('{lastname}',(data.last_name or ''))
            local text = text:gsub('{username}',(data.username or data.first_name or ''))
		    sendMsg(msg.chat_id, msg.id, text:sub(0, 4000), "html")
		end
		getUser(msg.service_user, sendWelcome)
    end
end
--------------------------------------------------------------
function check_member_leave(msg)
end
--------------------------------------------------------------
local function is_pvBlocked(user_id)
    local v = redis:sismember('bot:'..msg_.bot_id..':blocklist:', user_id)
    return v or false
end
--------------------------------------------------------------
local pre_process = function(msg)
redis:incr('bot:'..msg_.bot_id..':user:msgs'..msg.chat_id..':'..msg.sender_user_id)
redis:incr('bot:'..msg_.bot_id..':bot_msgs')
if msg.chat_type == "pv" then
    if not redis:sismember('bot:'..msg_.bot_id..':bot_users:', msg.sender_user_id) then
	    redis:sadd('bot'..msg_.bot_id..':bot_users:', msg.sender_user_id)
	end
    if not redis:get('bot:'..msg_.bot_id..':pvflod:'..msg.sender_user_id) then
        local aaa = 'bot:'..msg_.bot_id..':pvspam:'..msg.sender_user_id
        local mg = tonumber(redis:get(aaa) or 0)
        if mg > 5 then
		    local v = is_pvBlocked(msg.sender_user_id)
            if v then
		    	return
		    else
				sendMsg(msg.chat_id, msg.id, 'شما به دلیل ارسال اسپم به ربات از ربات بلاک و گلوبال بن میشوید...\nگزارش این اتفاق با موفقیت برای ادمین ارسال شد\nبزودی به این مشکل رسیدگی میکنیم!\n\n'.._config.channel, "html")
				blockUser(msg.sender_user_id)
				redis:sadd('bot:'..msg_.bot_id..':blocklist:', msg.sender_user_id)
		    end
        end
        redis:setex(aaa, 4, mg+1)
    end
elseif msg.chat_type == "group" or msg.chat_type == "supergroup" then
    msg.msg_chacks = (msg.text or msg.caption or msg.edit_new_text)
    if not redis:get("bot:"..msg_.bot_id..":charge:"..msg.chat_id) and not redis:get("bot:"..msg_.bot_id..":charge:alarted:"..msg.chat_id) and msg.text and not msg.text:match("^[#!/]add") then
	    redis:setex("bot:"..msg_.bot_id..":charge:"..msg.chat_id, 300, true)
		enable_channel(msg.chat_id)
	    redis:set("bot:"..msg_.bot_id..":charge:alarted:"..msg.chat_id, true)
		redis:sadd("bot:"..msg_.bot_id..":groups:", msg.chat_id)
		openChat(msg.chat_id)
		sendMsg(msg.chat_id, msg.id, "ربات در گروه فعال شد!\nشما ٥ دقيقه وقت داريد كد فعال سازى گروه را وارد كنيد در غير اين صورت ربات گروه رو ترك ميكنه...\nدر صورتی که کد فعال سازی در اختیار ندارید برای تمدید کردن ربات برای گروه به @".._config.Support.bot.." پیام دهید.\n@".._config.channel, "html")
	end
    if not redis:get("bot:"..msg_.bot_id..":charge:"..msg.chat_id) and redis:get("bot:"..msg_.bot_id..":charge:alarted:"..msg.chat_id) then
	    local group_link = redis:get('bot:'..msg_.bot_id..':link:'..msg.chat_id) or "ثبت نشده"
        if not is_channel_disabled(msg.chat_id) then
	  	    function expire_alarm(arg, data)
		        local hash = "bot:"..msg_.bot_id..":owners:"..msg.chat_id
	 	        local list = redis:smembers(hash)
	 	        local ownerlistText = "لیست اونر ها:\n\n"
	 	        for k,v in pairs(list) do
	   	            local user_info = redis:hgetall('user:'..v)
			        if user_info and user_info.username then
			            local username = user_info.username
			            ownerlistText = ownerlistText..k.." - `@"..username.." ["..v.."]`\n"
			        else
			    	    ownerlistText = ownerlistText..k.." - `"..v.."`\n"
		 	        end
	 	        end
	  	        if #list == 0 then
	  	            ownerlistText = "این گروه اونری ندارد!"
	  	        end
                --send(124757123, 0, 1, "شارژ این گروه به اتمام رسید\nName :\n `"..data.title_:gsub("`","").."`\n*_________________________*\nLink :\n`"..group_link.."`\n*_________________________*\n"..ownerlistText.."\n*_________________________*\nID\n"..msg.chat_id.."\n*_________________________*\nدر صورتی که میخواهید ربات این گروه را ترک کند از دستور زیر استفاده کنید\n\n/leave"..msg.chat_id.."\nبرای جوین دادن توی این گروه میتونی از دستور زیر استفاده کنی:\n/join"..msg.chat_id.."\n*_________________*\nدر صورتی که میخواهید گروه رو دوباره شارژ کنید میتوانید از کد های زیر استفاده کنید...\n\nبرای شارژ 1 ماهه:\n/plan1"..msg.chat_id.."\n\nبرای شارژ 3 ماهه:\n/plan2"..msg.chat_id.."\n\nبرای شارژ نامحدود:\n/plan3"..msg.chat_id, 1, 'md')
            end
            disable_channel(msg.chat_id)
	        --getChat(msg.chat_id, expire_alarm)
			sendMsg(msg.chat_id, msg.id, "شارژ این گروه به اتمام رسید و ربات در گروه غیر فعال شد...\nبرای تمدید کردن ربات به @".._config.Support.user.." پیام دهید.\nدر صورت ریپورت بودن میتوانید با ربات زیر با ما در ارتباط باشید:\n @".._config.Support.bot, "html")
			sendMsg(msg.chat_id, msg.id, "ربات به دلایلی گروه را ترک میکند\nبرای اطلاعات بیشتر میتوانید با @".._config.Support.user.." در ارتباط باشید.\nدر صورت ریپورت بودن میتوانید با ربات زیر به ما پیام دهید\n@".._config.Support.bot.."\n\nChannel> ".._config.channel, "html")
		    redis:del("bot:"..msg_.bot_id..":charge:alarted:"..msg.chat_id)
			redis:srem("bot:"..msg_.bot_id..":groups:", msg.chat_id)
		    chat_leave(msg.chat_id, msg_.bot_id)
        end
    end
    function check_user(a, result, b)
        if result.username then
            redis:hset('user:'..result.id, 'username', result.username)
        end
    end
	   ---------------------------------------------------------
    getUser(msg.sender_user_id, check_user)
	    if msg.service then
	    if redis:get("bot:"..msg_.bot_id..":locks:tgservice:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
	    if msg.service_type == 'link' then
	  ---------------------------------------------------------
     	    function check_member_link(extra,result,success)
                if redis:get("bot:"..msg_.bot_id..":locks:members:"..msg.chat_id) then
     	            chat_kick(msg.chat_id, result.id)
		            if not is_sleep(msg) then
    	                if result.username then
						    sendMsg(msg.chat_id, msg.id, '*کاربر* `{'..result.username..'@}|{'..msg.sender_user_id..'}` _با لینک در گروه عضو شد و به دلیل قفل بودن اعضا توسط ربات کیک شد!_', "md")
		                else
						    sendMsg(msg.chat_id, msg.id, '*کاربر* `{'..(result.first_name or result.last_name)..'}|{'..msg.sender_user_id..'}` _با لینک در گروه عضو شد و به دلیل قفل بودن اعضا توسط ربات کیک شد!_', "md")
		                end
	                end
		          return false
                end
--------------------------------------------------------------
                if redis:get("bot:"..msg_.bot_id..":welcome"..msg.chat_id) then
 	                if redis:get('bot:'..msg_.bot_id..':welcome:'..msg.chat_id) then
   	                    text = redis:get('bot:'..msg_.bot_id..':welcome:'..msg.chat_id)
  	                else
  	                    text = 'Hi {firstname} 😃'
 	                end
 	                local text = text:gsub('{rules}',(redis:get('bot:'..msg_.bot_id..':rules:'..msg.chat_id) or ''))
 	                local text = text:gsub('{firstname}',(result.first_name or ''))
  	                local text = text:gsub('{lastname}',(result.last_name or ''))
  	                local text = text:gsub('{username}',(result.username or ''))
						sendMsg(msg.chat_id, msg.id, text, "html")
                end
	        end
            getUser(msg.sender_user_id,check_member_link)
	    elseif msg.service_type == 'invite' then
	        check_member_inv(msg)
	    elseif msg.service_type == 'leave' then
	        check_member_leave(msg)
	    end
    end
		if redis:get('bot:'..msg_.bot_id..':w8link:'..msg.chat_id..':'..msg.sender_user_id) and not msg.edited then
	    edit_id = redis:get('bot:'..msg_.bot_id..':w8link:'..msg.chat_id..':'..msg.sender_user_id)
	    if is_mod(msg) then
	        if msg.msg_chacks:match("(https://telegram.me/joinchat/%S+)") then
                glink = msg.msg_chacks:match("(https://telegram.me/joinchat/%S+)")
	        elseif msg.msg_chacks:match("(https://t.me/joinchat/%S+)") then
                glink = msg.msg_chacks:match("(https://t.me/joinchat/%S+)")
	        else
                glink = false
	        end
	        if glink then
	            local function link_Ypanel(key, user)
                    local keyboard = {}
                    keyboard.inline_keyboard = {
	                    {
    	  	                {text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..msg_.bot_id)},
    	  	                {text = ("پاک کردن لینک❌"), callback_data = ('bp:dellink:step_one:'..key..':'..user..':'..msg_.bot_id)},
	                    },
                    }
                  return keyboard
                end
                delete_msg(msg.chat_id, {[0] = msg.id})
		        redis:set('bot:'..msg_.bot_id..':link:'..msg.chat_id, glink)
	            redis:del('bot:'..msg_.bot_id..':w8link:'..msg.chat_id..':'..msg.sender_user_id)
		        link = redis:get('bot:'..msg_.bot_id..':link:'..msg.chat_id)
		        text = "لینک گروه با موفقیت ذخیره شد.\n_____________________\n\nلینک گروه : \n"..link
		        keyboard = link_Ypanel(msg.chat_id, msg.sender_user_id)
                helper_edit(false, edit_id, text, keyboard)
	        else
	            local function link_Epanel(key, user)
                local keyboard = {}
                    keyboard.inline_keyboard = {
	                    {
    	  	                {text = ("برگشت⬅️"), callback_data = ('bp:setlink:cancelnonotif:'..key..':'..user..':'..msg_.bot_id)},
    	              	    {text = ("تلاش مجدد🔄"), callback_data = ('bp:setlink:step_one:'..key..':'..user..':'..msg_.bot_id)},
	                    },
                    }
                  return keyboard
                end
	            redis:del('bot:'..msg_.bot_id..':w8link:'..msg.chat_id..':'..msg.sender_user_id)
		        text = "*کاربر گرامی:*\n_من در پیامی که ارسال کردید نتونستم لینکی رو پیدا کنم_!\n`در صورتی که قصد دارید لینک گروهتون رو ثبت کنید از دکمه ی تلاش مجدد استفاده کنید و لینک رو دوباره ارسال کنید...`"
		        keyboard = link_Epanel(msg.chat_id, msg.sender_user_id)
                helper_edit(false, edit_id, text, keyboard, true, true)
	        end
	    end
	end
	-------------------------------------------------------------------------------
	if redis:get('bot:'..msg_.bot_id..':w8rules:'..msg.chat_id..':'..msg.sender_user_id) and not msg.edited then
	    edit_id = redis:get('bot:'..msg_.bot_id..':w8rules:'..msg.chat_id..':'..msg.sender_user_id)
	    if is_mod(msg) then
	        local function rules_Ypanel(key, user)
                local keyboard = {}
                keyboard.inline_keyboard = {
	                {
    	          	    {text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..msg_.bot_id)},
    	          	    {text = ("حذف قوانین❌"), callback_data = ('bp:delrules:step_one:'..key..':'..user..':'..msg_.bot_id)},
	                },
                }
              return keyboard
            end
            delete_msg(msg.chat_id, {[0] = msg.id})
		    redis:set('bot:'..msg_.bot_id..':rules:'..msg.chat_id, msg.msg_chacks)
	        redis:del('bot:'..msg_.bot_id..':w8rules:'..msg.chat_id..':'..msg.sender_user_id)
		    rules = redis:get('bot:'..msg_.bot_id..':rules:'..msg.chat_id)
		    text = "قوانین گروه ذخیره شد:\n__________________\n`"..rules:gsub("`","").."`"
		    keyboard = rules_Ypanel(msg.chat_id, msg.sender_user_id)
            helper_edit(false, edit_id, text, keyboard, true)
	    end
	end
	-------------------------------------------------------------------------------
	if redis:get('bot:'..msg_.bot_id..':w8welcome:'..msg.chat_id..':'..msg.sender_user_id) and not msg.edited then
	    edit_id = redis:get('bot:'..msg_.bot_id..':w8welcome:'..msg.chat_id..':'..msg.sender_user_id)
	    if is_mod(msg) then
	        local function welcome_Ypanel(key, user)
	            local welcome_status
		        if redis:get("bot:"..msg_.bot_id..":welcome"..msg.chat_id) then
			            welcome_status = "پیام خوشامد گویی : فعال✅"
		        else
		         	welcome_status = "پیام خوشامد گویی : غیر فعال❎"
		        end
                local keyboard = {}
                keyboard.inline_keyboard = {
	                {
    		            {text = (welcome_status), callback_data = ('bp:chnage:welcome:'..key..':'..user..':'..msg_.bot_id)},
	                },
		            {
    	            	{text = ("حذف کردن خوشامدگویی❌"), callback_data = ('bp:delwelcome:step_one:'..key..':'..user..':'..msg_.bot_id)},
	                },
		            {
		                {text = ("برگشت⬅️"), callback_data = ('bp:back:'..key..':'..user..':'..msg_.bot_id)},
	                },
                }
              return keyboard
            end
            delete_msg(msg.chat_id, {[0] = msg.id})
		    redis:set('bot:'..msg_.bot_id..':welcome:'..msg.chat_id, msg.msg_chacks)
	        redis:del('bot:'..msg_.bot_id..':w8welcome:'..msg.chat_id..':'..msg.sender_user_id)
		    welcome = redis:get('bot:'..msg_.bot_id..':welcome:'..msg.chat_id)
		    text = "_متن خوشامد گویی گروه ذخیره شد:_\n*__________________*\n`"..welcome:gsub("`","").."`"
		    keyboard = welcome_Ypanel(msg.chat_id, msg.sender_user_id)
            helper_edit(false, edit_id, text, keyboard, true)
	    end
	end
	if not is_whitelisted(msg) then
	if redis:get("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":fadd_status") and not msg.service then
		Added_users = (redis:get("b:"..msg_.bot_id..":"..msg.chat_id..":"..msg.sender_user_id) or 0)
		MaxINV = (redis:get("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":maxinv") or 2)
		if tonumber(Added_users) < tonumber(MaxINV) then
	    	delete_msg(msg.chat_id, {[0] = msg.id})
			if not redis:get("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":lastinv_warn:" .. msg.sender_user_id) then
		    	redis:setex("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":lastinv_warn:" .. msg.sender_user_id, 600, true)
		    	local function invWarn(extra,result,success)
    	      	    if result.username then
				    	sendMsg(msg.chat_id, msg.id, "*کاربر* `{"..result.username.."@}|{"..msg.sender_user_id.."}`:\n\n_شما ابتدا باید_ `" .. MaxINV .. "` _کاربر به این گروه اضافه کنید تا قادر به ادامه چت کردن باشید⚠️\n💡شما تا کنون_ `" .. Added_users .. "` _کاربر به این گروه ادد کرده اید._", "md")
		        	else
				    	sendMsg(msg.chat_id, msg.id, "*کاربر* `{"..(result.first_name or result.last_name).."}|{"..msg.sender_user_id.."}`:\n\n_شما ابتدا باید_ `" .. MaxINV .. "` _کاربر به این گروه اضافه کنید تا قادر به ادامه چت کردن باشید⚠️\n💡شما تا کنون_ `" .. Added_users .. "` _کاربر به این گروه ادد کرده اید._", "md")
		        	end
           		end
		      	getUser(msg.sender_user_id, invWarn)
			end
	    return false
		end
	end
	if is_mod(msg) then
	    if msg.pinned then
		    redis:set('bot:'..msg_.bot_id..':pinnedmsg:id:'..msg.chat_id, msg.content.message_id)
	    end
	end
    if not is_mod(msg) then
	    if redis:get("bot:"..msg_.bot_id..":locks:all:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
      ---------------------------------------------------------
	    if is_banned(msg.chat_id, tonumber(msg.sender_user_id)) then
	        chat_kick(msg.chat_id, msg.sender_user_id)
		    delete_msg(msg.chat_id, {[0] = msg.id})
	    end
	  ---- -----------------------------------------------------
	    if is_muted(msg.chat_id, tonumber(msg.sender_user_id)) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
    --------------------------* AnfiFlood *--------------------------
	if not msg.service or not msg.edited then --- yetor beshe age masalan to 1 saat 10 bar spam khord bzne bege halate fori e // pm am bede  tedad esham tanzim she
		local hash = 'bot:'..msg_.bot_id..':flood:max:'..msg.chat_id
        if not redis:get(hash) then
            floodMax = 5
        else
            floodMax = tonumber(redis:get(hash))
        end
	
        local hash = 'bot:'..msg_.bot_id..':flood:time:'..msg.chat_id
        if not redis:get(hash) then
            floodTime = 3
        else
            floodTime = tonumber(redis:get(hash))
        end
        local hashse = 'bot:'..msg_.bot_id..':anti-flood:'..msg.chat_id
        if not redis:get(hashse) then
            local hash = 'bot:'..msg_.bot_id..':flood:'..msg.sender_user_id..':'..msg.chat_id..':msg-num'
            local msgs = tonumber(redis:get(hash) or 0)
            if msgs > (floodMax) then
                if redis:get('bot:'..msg_.bot_id..':flood:warn:'..msg.sender_user_id) then
       				del_all_msgs(msg.chat_id, msg.sender_user_id)
				else
				    until_date = 7200
				    redis:setex("bot:"..msg_.bot_id..":tmuted:"..msg.chat_id..":"..msg.sender_user_id, until_date, true)
				    until_date = until_date + os.time()
					restrictUser(msg.chat_id, tonumber(msg.sender_user_id), until_date)
					del_all_msgs(msg.chat_id, msg.sender_user_id)
					redis:setex('bot:'..msg_.bot_id..':flood:warn:'..msg.sender_user_id, 30, true)
			   		function antiflood_kicked(extra,result,success)
    					if result.username then
						    sendMsg(msg.chat_id, msg.id, '*کاربر* `{'..result.username..'@}|{'..msg.sender_user_id..'}` \n_به دلیل اسپمینگ(ارسال پیام رگباری) به مدت 2 ساعت در گروه میوت شد_', "md")
						else
							sendMsg(msg.chat_id, msg.id, '*کاربر* `{@'..(result.first_name or result.last_name)..'}|{'..msg.sender_user_id..'}` \n_به دلیل اسپمینگ(ارسال پیام رگباری) به مدت 2 ساعت در گروه میوت شد_', "md")
						end
     				end
					getUser(msg.sender_user_id, antiflood_kicked)
				end
            end
            redis:setex(hash, floodTime, msgs+1)
        end
	end
	-----------------------------------------------------------------
    if msg.fwd then
	    if redis:get("bot:"..msg_.bot_id..":locks:forward:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
	end
	if msg.text and not msg.service then
	    if not redis:get('bot:'..msg_.bot_id..':locks:spam:'..msg.chat_id) then
	        if not redis:get('bot:'..msg_.bot_id..':set_char:'..msg.chat_id) then
                numb = 4096
            else
                numb = tonumber(redis:get('bot:'..msg_.bot_id..':set_char:'..msg.chat_id))
	        end
	        if string.len(msg.text) > numb then
                delete_msg(msg.chat_id, {[0] = msg.id})
	            if not redis:get('bot:'..msg_.bot_id..':checkspam:'..msg.sender_user_id) then 
	                function char_warning(extra,result,success)
    	                if result.username then
						     sendMsg(msg.chat_id, msg.id, '*کاربر* `{'..result.username..'@}|{'..msg.sender_user_id..'}`:\n_تعداد حروف مجاز در جمله ی این گروه توسط مدیران روی_ *'..numb..'* _ حرف تنظیم شده !_\n`لطفا پیامی با بیشتر از '..numb..' ارسال نکنید🌹`', "md")
		                else
						    sendMsg(msg.chat_id, msg.id, '*کاربر* `{'..(result.first_name or result.last_name)..'}|{'..msg.sender_user_id..'}`:\n_تعداد حروف مجاز در جمله ی این گروه توسط مدیران روی_ *'..numb..'* _ حرف تنظیم شده !_\n`لطفا پیامی با بیشتر از '..numb..' ارسال نکنید🌹`', "md")
		                end
                    end
					if not is_sleep(msg) then
		                getUser(msg.sender_user_id, char_warning)
					end
		            redis:setex('bot:'..msg_.bot_id..':checkspam:'..msg.sender_user_id, tonumber(60), true)
	            end
	        end
	    end
	    if redis:get("bot:"..msg_.bot_id..":locks:text:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
	elseif msg.photo then
	    if redis:get("bot:"..msg_.bot_id..":locks:photo:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
	elseif msg.game then
	    if redis:get("bot:"..msg_.bot_id..":locks:game:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
	elseif msg.inline then
	    if redis:get("bot:"..msg_.bot_id..":locks:inline:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
    elseif msg.pinned then
        if redis:get('bot:'..msg_.bot_id..':locks:pin:'..msg.chat_id) then
		    local function pin_warning(extra,result,success)
    		    if result.username then
					sendMsg(msg.chat_id, msg.id, '*کاربر* `{'..result.username..'@}|{'..msg.sender_user_id..'}`:\n_پبن کردن پیام توسط مدیران ربات در گروه محدود شده است!_\n`در صورتی که قصد پین کردن پیام دارید باید با اونر ربات در گروه مشورت کنید.`', "md")
		        else
					sendMsg(msg.chat_id, msg.id, '*کاربر* `{'..(result.first_name or result.last_name)..'}|{'..msg.sender_user_id..'}`:\n_پبن کردن پیام توسط مدیران ربات در گروه محدود شده است!_\n`در صورتی که قصد پین کردن پیام دارید باید با اونر ربات در گروه مشورت کنید.`', "md")
		        end
            end
            unpinMessage(msg.basic_id)
            local pin_id = redis:get('bot:'..msg_.bot_id..':pinnedmsg:id:'..msg.chat_id)
		    if pin_id then
				pinMessage(msg.basic_id, pin_id)
		    end
			if not is_sleep(msg) and not redis:get('bot:'..msg_.bot_id..':pin_warning:'..msg.chat_id) then
			    redis:setex('bot:'..msg_.bot_id..':pin_warning:'..msg.chat_id, 60, true)
		        getUser(msg.sender_user_id, pin_warning)
			end
        end
    elseif msg.document then
	    if redis:get("bot:"..msg_.bot_id..":locks:document:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
	elseif msg.sticker then
	    if redis:get("bot:"..msg_.bot_id..":locks:sticker:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
    elseif msg.music then
	    if redis:get("bot:"..msg_.bot_id..":locks:music:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
    elseif msg.voice then
	    if redis:get("bot:"..msg_.bot_id..":locks:voice:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
    elseif msg.vm then
	    if redis:get("bot:"..msg_.bot_id..":locks:vm:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
    elseif msg.video then
	    if redis:get("bot:"..msg_.bot_id..":locks:video:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
	elseif msg.gif then
	    if redis:get("bot:"..msg_.bot_id..":locks:gif:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
	elseif msg.location then
	    if redis:get("bot:"..msg_.bot_id..":locks:location:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
	elseif msg.contact then
	    if redis:get("bot:"..msg_.bot_id..":locks:contact:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
        end
	end
	if msg.edited then
	    if redis:get("bot:"..msg_.bot_id..":locks:edit:"..msg.chat_id) then
            delete_msg(msg.chat_id, {[0] = msg.id})
	    end
	end
	if msg.msg_chacks then
	    check_filter_words(msg, msg.msg_chacks)
	    check_global_filter_words(msg, msg.msg_chacks)
	    if msg.msg_chacks:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.msg_chacks:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.msg_chacks:match("[Tt].[Mm][Ee]/") or msg.msg_chacks:match("[Tt][Ee][Ii][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") then
	        if redis:get("bot:"..msg_.bot_id..":locks:link:"..msg.chat_id) then
	            delete_msg(msg.chat_id, {[0] = msg.id})
		    end
	    end
	    if msg.msg_chacks:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.msg_chacks:match("[Hh][Tt][Tt][Pp]://") or msg.msg_chacks:match(".[Ii][Rr]") or msg.msg_chacks:match(".[Cc][Oo][Mm]") or msg.msg_chacks:match(".[Oo][Rr][Gg]") or msg.msg_chacks:match(".[Ii][Nn][Ff][Oo]") or msg.msg_chacks:match("[Ww][Ww][Ww].") or msg.msg_chacks:match(".[Tt][Kk]") or msg.msg_chacks:match(".[Mm][Ee]") then
	        if redis:get("bot:"..msg_.bot_id..":locks:webpage:"..msg.chat_id) then
	            delete_msg(msg.chat_id, {[0] = msg.id})
		    end
	    end
		if msg.msg_chacks:match("@") or msg.mention then
	        if redis:get("bot:"..msg_.bot_id..":locks:tag:"..msg.chat_id) then
	            delete_msg(msg.chat_id, {[0] = msg.id})
		    end
	    end
		if msg.msg_chacks:match("#") then
	        if redis:get("bot:"..msg_.bot_id..":locks:hashtag:"..msg.chat_id) then
	            delete_msg(msg.chat_id, {[0] = msg.id})
		    end
	    end
		if msg.msg_chacks:match("[\216-\219][\128-\191]") then
	        if redis:get("bot:"..msg_.bot_id..":locks:arabic:"..msg.chat_id) then
	            delete_msg(msg.chat_id, {[0] = msg.id})
		    end
	    end
		if msg.msg_chacks:match("[a-zA-Z]") then
	        if redis:get("bot:"..msg_.bot_id..":locks:english:"..msg.chat_id) then
	            delete_msg(msg.chat_id, {[0] = msg.id})
		    end
	    end 
    end
   end
   end
  end
  return msg
end

return {
    Commands = {},
	Procces = {
	    sensitivity = false,
		singCommands = false
	},
    pre_process = pre_process
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