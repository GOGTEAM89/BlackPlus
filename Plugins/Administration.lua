--[[
     **************************
     *  BlackPlus Plugins...  *
     *                        *
     *     By @SubProcess     *
     *                        *
     *  Channel > @SubCreator *
     **************************
	 
]]
local Plugin = function(msg, matches)
    local function CCall(extra, result, success) 
		if result.can_be_called then
		    callUser(extra.user_id)
			sendMsg(msg.chat_id, msg.id, "📞در حال تماس با کاربر مورد نظر ...", "md")
		else
			sendMsg(msg.chat_id, msg.id, "کاربر مورد نظر تنظیمات تماس خود را شخصی سازی کرده است و قادر به تماس با آن نیستم", "md")
		end
	end
	---------------------------------------------------------
	local function setowner_by_reply(extra, result, success)
	    local hash = "bot:"..msg_.bot_id..":owners:"..msg.chat_id
		if not redis:sismember(hash, tonumber(result.sender_user_id)) then
		    redis:sadd(hash, tonumber(result.sender_user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت به لیست اونر های گروه افزوده شد✅", "md")
	    else
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` از قبل در لیست اونر های گروه است⚠️", "md")
		end
	end
    ---------------------------------------------------------
	local function setowner_by_username(extra, result, success)
  		if result.id then
    	    local hash = "bot:"..msg_.bot_id..":owners:"..msg.chat_id
		    if not redis:sismember(hash, tonumber(result.id)) then
	 	        redis:sadd(hash, tonumber(result.id))
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت به لیست اونر های گروه افزوده شد✅", "md")
	        else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` از قبل در لیست اونر های گروه است⚠️", "md")
	 	    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function setowner_by_id(user_id)
    	local hash = "bot:"..msg_.bot_id..":owners:"..msg.chat_id
	  	if not redis:sismember(hash, tonumber(user_id)) then
	  	    redis:sadd(hash, tonumber(user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت به لیست اونر های گروه افزوده شد✅", "md")
	  	else
		    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` از قبل در لیست اونر های گروه است⚠️", "md")
		end
	end
	---------------------------------------------------------
	local function deowner_by_reply(extra, result, success)
	    local hash = "bot:"..msg_.bot_id..":owners:"..msg.chat_id
		if redis:sismember(hash, tonumber(result.sender_user_id)) then
		    redis:srem(hash, tonumber(result.sender_user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت از لیست اونر های گروه حذف شد✅", "md")
	    else
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` در لیست اونر های گروه یافت نشد⚠️", "md")
		end
	end
    ---------------------------------------------------------
	local function deowner_by_username(extra, result, success)
  		if result.id then
    	    local hash = "bot:"..msg_.bot_id..":owners:"..msg.chat_id
		    if redis:sismember(hash, tonumber(result.id)) then
	 	        redis:srem(hash, tonumber(result.id))
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت از لیست اونر های گروه حذف شد✅", "md")
	        else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` در لیست اونر های گروه یافت نشد⚠️", "md")
	 	    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function deowner_by_id(user_id)
    	local hash = "bot:"..msg_.bot_id..":owners:"..msg.chat_id
	  	if redis:sismember(hash, tonumber(user_id)) then
	  	    redis:srem(hash, tonumber(user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت از لیست اونر های گروه حذف شد✅", "md")
	  	else
		    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` در لیست اونر های گروه یافت نشد⚠️", "md")
		end
	end
	---------------------------------------------------------
	local function addadmin_by_reply(extra, result, success)
	    local hash = 'bot:'..msg_.bot_id..':global:admins'
		if not redis:sismember(hash, tonumber(result.sender_user_id)) then
		    redis:sadd(hash, tonumber(result.sender_user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت به لیست ادمین های ربات افزوده شد✅", "md")
	    else
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` از قبل در لیست ادمین های ربات است⚠️", "md")
		end
	end
    ---------------------------------------------------------
	local function addadmin_by_username(extra, result, success)
  		if result.id then
    	    local hash = 'bot:'..msg_.bot_id..':global:admins'
		    if not redis:sismember(hash, tonumber(result.id)) then
	 	        redis:sadd(hash, tonumber(result.id))
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت به لیست ادمین های ربات افزوده شد✅", "md")
	        else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` از قبل در لیست ادمین های ربات است⚠️", "md")
	 	    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function addadmin_by_id(user_id)
    	local hash = 'bot:'..msg_.bot_id..':global:admins'
	  	if not redis:sismember(hash, tonumber(user_id)) then
	  	    redis:sadd(hash, tonumber(user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت به لیست ادمین های ربات افزوده شد✅", "md")
	  	else
		    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` از قبل در لیست ادمین های ربات است⚠️", "md")
		end
	end
	---------------------------------------------------------
	local function deadmin_by_reply(extra, result, success)
	    local hash = 'bot:'..msg_.bot_id..':global:admins'
		if redis:sismember(hash, tonumber(result.sender_user_id)) then
		    redis:srem(hash, tonumber(result.sender_user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت از لیست ادمین های ربات حذف شد✅", "md")
	    else
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` در لیست ادمین های ربات یافت نشد⚠️", "md")
		end
	end
    ---------------------------------------------------------
	local function deadmin_by_username(extra, result, success)
  		if result.id then
    	    local hash = 'bot:'..msg_.bot_id..':global:admins'
		    if redis:sismember(hash, tonumber(result.id)) then
	 	        redis:srem(hash, tonumber(result.id))
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت از لیست ادمین های ربات حذف شد✅", "md")
	        else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` در لیست ادمین های ربات یافت نشد⚠️", "md")
	 	    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function deadmin_by_id(user_id)
    	local hash = 'bot:'..msg_.bot_id..':global:admins'
	  	if redis:sismember(hash, tonumber(user_id)) then
	  	    redis:srem(hash, tonumber(user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت از لیست ادمین های ربات حذف شد✅", "md")
	  	else
		    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` در لیست ادمین های ربات یافت نشد⚠️", "md")
		end
	end
	---------------------------------------------------------
	local function gban_by_reply(extra, result, success)
	    local hash = 'bot:'..msg_.bot_id..':global:banned'
		if not redis:sismember(hash, tonumber(result.sender_user_id)) then
		    redis:sadd(hash, tonumber(result.sender_user_id))
			chat_kick(msg.chat_id, tonumber(result.sender_user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت از تمامی قسمت های ربات بن شد✅", "md")
	    else
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` از قبل در لیست افراد بن شده از ربات است⚠️", "md")
		end
	end
    ---------------------------------------------------------
	local function gban_by_username(extra, result, success)
  		if result.id then
    	    local hash = 'bot:'..msg_.bot_id..':global:banned'
		    if not redis:sismember(hash, tonumber(result.id)) then
	 	        redis:sadd(hash, tonumber(result.id))
				chat_kick(msg.chat_id, tonumber(result.id))
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت از تمامی قسمت های ربات بن شد✅", "md")
	        else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` از قبل در لیست افراد بن شده از ربات است⚠️", "md")
	 	    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function gban_by_id(user_id)
    	local hash = 'bot:'..msg_.bot_id..':global:banned'
	  	if not redis:sismember(hash, tonumber(user_id)) then
	  	    redis:sadd(hash, tonumber(user_id))
			chat_kick(msg.chat_id, tonumber(user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت از تمامی قسمت های ربات بن شد✅", "md")
	  	else
		    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` از قبل در لیست افراد بن شده از ربات است⚠️", "md")
		end
	end
	---------------------------------------------------------
	local function gunban_by_reply(extra, result, success)
	    local hash = 'bot:'..msg_.bot_id..':global:banned'
		if redis:sismember(hash, tonumber(result.sender_user_id)) then
		    redis:srem(hash, tonumber(result.sender_user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` از لیست افراد گلوبال بن شده حذف شد✅", "md")
	    else
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` از ربات بن نشده است⚠️", "md")
		end
	end
    ---------------------------------------------------------
	local function gunban_by_username(extra, result, success)
  		if result.id then
    	    local hash = 'bot:'..msg_.bot_id..':global:banned'
		    if redis:sismember(hash, tonumber(result.id)) then
	 	        redis:srem(hash, tonumber(result.id))
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` از لیست افراد گلوبال بن شده حذف شد✅", "md")
	        else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` از ربات بن نشده است⚠️", "md")
	 	    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function gunban_by_id(user_id)
    	local hash = 'bot:'..msg_.bot_id..':global:banned'
	  	if redis:sismember(hash, tonumber(user_id)) then
	  	    redis:srem(hash, tonumber(user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` از لیست افراد گلوبال بن شده حذف شد✅", "md")
	  	else
		    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` از ربات بن نشده است⚠️", "md")
		end
	end
	---------------------------------------------------------
	local function gmute_by_reply(extra, result, success)
	    local hash = 'bot:'..msg_.bot_id..':global:muted'
		if not redis:sismember(hash, tonumber(result.sender_user_id)) then
		    redis:sadd(hash, tonumber(result.sender_user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت در تمامی گروه های ربات میوت شد✅", "md")
	    else
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` از قبل در لیست افراد میوت شده از تمامی گروه های ربات است⚠️", "md")
		end
	end
    ---------------------------------------------------------
	local function gmute_by_username(extra, result, success)
  		if result.id then
    	    local hash = 'bot:'..msg_.bot_id..':global:muted'
		    if not redis:sismember(hash, tonumber(result.id)) then
	 	        redis:sadd(hash, tonumber(result.id))
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")`  با موفقیت در تمامی گروه های ربات میوت شد✅", "md")
	        else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` از قبل در لیست افراد میوت شده از تمامی گروه های ربات است⚠️", "md")
	 	    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function gmute_by_id(user_id)
    	local hash = 'bot:'..msg_.bot_id..':global:muted'
	  	if not redis:sismember(hash, tonumber(user_id)) then
	  	    redis:sadd(hash, tonumber(user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")`  با موفقیت در تمامی گروه های ربات میوت شد✅", "md")
	  	else
		    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` از قبل در لیست افراد میوت شده از تمامی گروه های ربات است⚠️", "md")
		end
	end
	---------------------------------------------------------
	local function gunmute_by_reply(extra, result, success)
	    local hash = 'bot:'..msg_.bot_id..':global:muted'
		if redis:sismember(hash, tonumber(result.sender_user_id)) then
		    redis:srem(hash, tonumber(result.sender_user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` از لیست افراد گلوبال میوت شده حذف شد✅", "md")
	    else
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` در تمامی گروه های ربات میوت نشده است⚠️", "md")
		end
	end
    ---------------------------------------------------------
	local function gunmute_by_username(extra, result, success)
  		if result.id then
    	    local hash = 'bot:'..msg_.bot_id..':global:muted'
		    if redis:sismember(hash, tonumber(result.id)) then
	 	        redis:srem(hash, tonumber(result.id))
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` از لیست افراد گلوبال میوت شده حذف شد✅", "md")
	        else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` در تمامی گروه های ربات میوت نشده است⚠️", "md")
	 	    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function gunmute_by_id(user_id)
    	local hash = 'bot:'..msg_.bot_id..':global:muted'
	  	if redis:sismember(hash, tonumber(user_id)) then
	  	    redis:srem(hash, tonumber(user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` از لیست افراد گلوبال میوت شده حذف شد✅", "md")
	  	else
		    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` در تمامی گروه های ربات میوت نشده است⚠️", "md")
		end
	end
	---------------------------------------------------------
	local function block_by_reply(extra, result, success)
	    local hash = 'bot:'..msg_.bot_id..':blocklist:'
		if not redis:sismember(hash, tonumber(result.sender_user_id)) then
		    redis:sadd(hash, tonumber(result.sender_user_id))
			blockUser(tonumber(result.sender_user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` بلاک شد✅", "md")
	    else
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` از قبل بلاک شده است⚠️", "md")
		end
	end
    ---------------------------------------------------------
	local function block_by_username(extra, result, success)
  		if result.id then
    	    local hash = 'bot:'..msg_.bot_id..':blocklist:'
		    if not redis:sismember(hash, tonumber(result.id)) then
	 	        redis:sadd(hash, tonumber(result.id))
				blockUser(tonumber(result.id))
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` بلاک شد✅", "md")
	        else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` از قبل بلاک شده است⚠️", "md")
	 	    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function block_by_id(user_id)
    	local hash = 'bot:'..msg_.bot_id..':blocklist:'
	  	if not redis:sismember(hash, tonumber(user_id)) then
	  	    redis:sadd(hash, tonumber(user_id))
			blockUser(tonumber(user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` بلاک شد✅", "md")
	  	else
		    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` از قبل بلاک شده است⚠️", "md")
		end
	end
	---------------------------------------------------------
	local function unblock_by_reply(extra, result, success)
	    local hash = 'bot:'..msg_.bot_id..':blocklist:'
		redis:srem(hash, tonumber(result.sender_user_id))
		unblockUser(tonumber(result.sender_user_id))
		sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` آنبلاک شد✅", "md")
	end
    ---------------------------------------------------------
	local function unblock_by_username(extra, result, success)
  		if result.id then
    	    local hash = 'bot:'..msg_.bot_id..':blocklist:'
	 	    redis:srem(hash, tonumber(result.id))
			unblockUser(tonumber(result.id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` آنبلاک شد✅", "md")
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function unblock_by_id(user_id)
    	local hash = 'bot:'..msg_.bot_id..':blocklist:'
	  	redis:srem(hash, tonumber(user_id))
		unblockUser(tonumber(user_id))
		sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` آنبلاک شد✅", "md")
	end
	---------------------------------------------------------
	local function call_by_reply(extra, result, success)
	    getUserFull(result.sender_user_id, CCall, {user_id = result.sender_user_id})
	end
    ---------------------------------------------------------
	local function call_by_username(extra, result, success)
  		if result.id then
    	    getUserFull(result.id, CCall, {user_id = result.id})
   	 	else
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function call_by_id(user_id)
    	getUserFull(user_id, CCall, {user_id = user_id})
	end
    ---------------------------------------------------------
	if not is_admin(msg) then
	    return false
	end
	---------------------------------------------------------
    if matches[1] == 'call' then
		if not matches[2] and msg.reply then
	        getMessage(msg.chat_id, msg.reply, call_by_reply)
	    elseif matches[2] and is_number(matches[2]) then
		    call_by_id(matches[2])
	    elseif matches[2] and not is_number(matches[2]) then
	    	resolve_username(matches[2], call_by_username)
	    else
		    getUserFull(msg.sender_user_id, CCall, {user_id = msg.sender_user_id})
		end
    ---------------------------------------------------------
	elseif matches[1] == 'setowner' or matches[1] == 'تنظیم مالک' then
	    botMessages(nil, msg)
	    if not matches[2] and msg.reply then
            getMessage(msg.chat_id, msg.reply, setowner_by_reply)
	    elseif matches[2] and is_number(matches[2]) then
		    setowner_by_id(matches[2])
	    elseif matches[2] and not is_number(matches[2]) then
	    	resolve_username(matches[2], setowner_by_username)
	    end
	---------------------------------------------------------
	elseif matches[1] == 'remowner' or matches[1] == 'حذف مالک' then
	    botMessages(nil, msg)
	    if not matches[2] and msg.reply then
            getMessage(msg.chat_id, msg.reply, deowner_by_reply)
	    elseif matches[2] and is_number(matches[2]) then
		    deowner_by_id(matches[2])
	    elseif matches[2] and not is_number(matches[2]) then
	    	resolve_username(matches[2], deowner_by_username)
	    end
	---------------------------------------------------------
	elseif matches[1] == 'addadmin' and is_sudo(msg) or matches[1] == 'تنظیم ادمین' and is_sudo(msg) then
	    botMessages(nil, msg)
	    if not matches[2] and msg.reply then
            getMessage(msg.chat_id, msg.reply, addadmin_by_reply)
	    elseif matches[2] and is_number(matches[2]) then
		    addadmin_by_id(matches[2])
	    elseif matches[2] and not is_number(matches[2]) then
	    	resolve_username(matches[2], addadmin_by_username)
	    end
	---------------------------------------------------------
	elseif matches[1] == 'remadmin' and is_sudo(msg) or matches[1] == 'حذف ادمین' and is_sudo(msg) then
	    botMessages(nil, msg)
	    if not matches[2] and msg.reply then
            getMessage(msg.chat_id, msg.reply, deadmin_by_reply)
	    elseif matches[2] and is_number(matches[2]) then
		    deadmin_by_id(matches[2])
	    elseif matches[2] and not is_number(matches[2]) then
	    	resolve_username(matches[2], deadmin_by_username)
	    end
	---------------------------------------------------------
	elseif matches[1] == 'gban' or matches[1] == 'مسدود کلی' then
	    botMessages(nil, msg)
	    if not matches[2] and msg.reply then
            getMessage(msg.chat_id, msg.reply, gban_by_reply)
	    elseif matches[2] and is_number(matches[2]) then
		    gban_by_id(matches[2])
	    elseif matches[2] and not is_number(matches[2]) then
	    	resolve_username(matches[2], gban_by_username)
	    end
	---------------------------------------------------------
	elseif matches[1] == 'gunban' or matches[1] == 'رفع مسدود کلی' then
	    botMessages(nil, msg)
	    if not matches[2] and msg.reply then
            getMessage(msg.chat_id, msg.reply, gunban_by_reply)
	    elseif matches[2] and is_number(matches[2]) then
		    gunban_by_id(matches[2])
	    elseif matches[2] and not is_number(matches[2]) then
	    	resolve_username(matches[2], gunban_by_username)
	    end
	---------------------------------------------------------
	elseif matches[1] == 'gmute' or matches[1] == 'سکوت کلی' then
	    botMessages(nil, msg)
	    if not matches[2] and msg.reply then
            getMessage(msg.chat_id, msg.reply, gmute_by_reply)
	    elseif matches[2] and is_number(matches[2]) then
		    gmute_by_id(matches[2])
	    elseif matches[2] and not is_number(matches[2]) then
	    	resolve_username(matches[2], gmute_by_username)
	    end
	---------------------------------------------------------
	elseif matches[1] == 'gunmute' or matches[1] == 'رفع سکوت کلی' then
	    botMessages(nil, msg)
	    if not matches[2] and msg.reply then
            getMessage(msg.chat_id, msg.reply, gunmute_by_reply)
	    elseif matches[2] and is_number(matches[2]) then
		    gunmute_by_id(matches[2])
	    elseif matches[2] and not is_number(matches[2]) then
	    	resolve_username(matches[2], gunmute_by_username)
	    end
	---------------------------------------------------------
	elseif matches[1] == 'block' or matches[1] == 'تنظیم ادمین' then
	    botMessages(nil, msg)
	    if not matches[2] and msg.reply then
            getMessage(msg.chat_id, msg.reply, block_by_reply)
	    elseif matches[2] and is_number(matches[2]) then
		    block_by_id(matches[2])
	    elseif matches[2] and not is_number(matches[2]) then
	    	resolve_username(matches[2], block_by_username)
	    end
	---------------------------------------------------------
	elseif matches[1] == 'unblock' or matches[1] == 'حذف ادمین' then
	    botMessages(nil, msg)
	    if not matches[2] and msg.reply then
            getMessage(msg.chat_id, msg.reply, unblock_by_reply)
	    elseif matches[2] and is_number(matches[2]) then
		    unblock_by_id(matches[2])
	    elseif matches[2] and not is_number(matches[2]) then
	    	resolve_username(matches[2], unblock_by_username)
	    end
	---------------------------------------------------------
	elseif matches[1] == 'charge' or matches[1] == 'شارژ' then
	    botMessages(nil, msg)
		if msg.chat_type ~= "pv" then
		    Time = tonumber(matches[2])
			if matches[3] == "m" then
			    Tdate = Time * 60
				_text = Time .. " دقیقه"
			elseif matches[3] == "h" then
			    Tdate = Time * 3600
				_text = Time .. " ساعت"
			elseif matches[3] == "d" then
			    Tdate = Time * 86400
				_text = Time .. " روز"
			end
			redis:setex("bot:"..msg_.bot_id..":charge:"..msg.chat_id, Tdate, true)
	        redis:sadd("bot:"..msg_.bot_id..":groups:", msg.chat_id)
			openChat(msg.chat_id)
			enable_channel(msg.chat_id)
			return "*گروه با موفقیت به مدت* `".._text.."` *شارژ شد✅*"
		else
		    return "*این دستور فقط در گروه قابل استفاده میباشد⚠️*"
		end
	---------------------------------------------------------
	elseif matches[1] == 'leave' or matches[1] == 'خروج ربات' then
	    if msg.chat_type ~= "pv" then
	        chat_leave(msg.chat_id, msg_.bot_id)
	    else
		    return "*این دستور فقط در گروه قابل استفاده میباشد⚠️*"
		end
	---------------------------------------------------------
	elseif matches[1] == 'add' or matches[1] == 'ادد' then
	    if msg.chat_type ~= "pv" then
	        redis:set("bot:"..msg_.bot_id..":charge:"..msg.chat_id, true)
	        redis:sadd("bot:"..msg_.bot_id..":groups:", msg.chat_id)
			openChat(msg.chat_id)
			enable_channel(msg.chat_id)
			return "*گروه با موفقیت بصورت نامحدود فعال شد✅*"
	    else
		    return "*این دستور فقط در گروه قابل استفاده میباشد⚠️*"
		end
	---------------------------------------------------------
	elseif matches[1] == 'rem' or matches[1] == 'حذف گروه' then
	    if msg.chat_type ~= "pv" then
		    redis:del("bot:"..msg_.bot_id..":charge:"..msg.chat_id)
	        redis:srem("bot:"..msg_.bot_id..":groups:", msg.chat_id)
			redis:del("bot:"..msg_.bot_id..":charge:alarted:"..msg.chat_id)
			enable_channel(msg.chat_id)
	        chat_leave(msg.chat_id, msg_.bot_id)
			return "*گروه با موفقیت از لیست گروه های ربات حذف شد✅*"
	    else
		    return "*این دستور فقط در گروه قابل استفاده میباشد⚠️*"
		end
    ---------------------------------------------------------
	end
end

return {
    Commands = {
        _config.Cmd..'(setowner) (.*)$',
        _config.Cmd..'(setowner)$',
		'^(تنظیم مالک) (.*)$',
        '^(تنظیم مالک)$',
		_config.Cmd..'(remowner) (.*)$',
        _config.Cmd..'(remowner)$',
		'^(حذف مالک) (.*)$',
        '^(حذف مالک)$',
		_config.Cmd..'(addadmin) (.*)$',
        _config.Cmd..'(addadmin)$',
		'^(تنظیم ادمین) (.*)$',
        '^(تنظیم ادمین)$',
		_config.Cmd..'(remadmin) (.*)$',
        _config.Cmd..'(remadmin)$',
		'^(حذف ادمین) (.*)$',
        '^(حذف ادمین)$',
		_config.Cmd..'(block) (.*)$',
        _config.Cmd..'(block)$',
		'^(بلاک) (.*)$',
        '^(بلاک)$',
		_config.Cmd..'(unblock) (.*)$',
        _config.Cmd..'(unblock)$',
		'^(آنبلاک) (.*)$',
        '^(آنبلاک)$',
		_config.Cmd..'(gban) (.*)$',
        _config.Cmd..'(gban)$',
		'^(مسدود کلی) (.*)$',
        '^(مسدود کلی)$',
		_config.Cmd..'(gunban) (.*)$',
        _config.Cmd..'(gunban)$',
		'^(رفع مسدود کلی) (.*)$',
        '^(رفع مسدود کلی)$',
		_config.Cmd..'(gmute) (.*)$',
        _config.Cmd..'(gmute)$',
		'^(سکوت کلی) (.*)$',
        '^(سکوت کلی)$',
		_config.Cmd..'(call) (.*)$',
        _config.Cmd..'(call)$',
		'^(تماس) (.*)$',
        '^(تماس)$',
		_config.Cmd..'(gunmute) (.*)$',
        _config.Cmd..'(gunmute)$',
		'^(رفع سکوت کلی) (.*)$',
        '^(رفع سکوت کلی)$',
		_config.Cmd..'(charge) (.*)([mhd])$',
		'^(شارژ) (.*)([mhd])$',
        _config.Cmd..'(leave)$',
        '^(خروج ربات)$',
		_config.Cmd..'(add) (.*)$',
        '^(ادد) (.*)$',
		_config.Cmd..'(rem)$',
        '^(حذف گروه)$',
    },
	Procces = {
	    sensitivity = true,
		singCommands = false,
		editedCommands = true
	},
	parse_mode = "md", -- ["md","html","normal"]
    Plugin = Plugin
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