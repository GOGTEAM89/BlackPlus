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
---------------------------------------------------------------------------------------------------------------
-------------------------------------------------* FUNCTIONS *-------------------------------------------------
---------------------------------------------------------------------------------------------------------------
	local function ban_by_reply(extra, result, success)
	    local hash = "bot:"..msg_.bot_id..":banned:"..msg.chat_id
    	if have_rank(tonumber(result.sender_user_id), msg.chat_id) then
		  	sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید مدیران گروه را بن کنید⛔️_", "md")
		else
		    if not is_banned(msg.chat_id, tonumber(result.sender_user_id)) then
			    if extra and extra.k then
				    Time = tonumber(extra.v)
				    if extra.k == "m" or extra.k == "دقیقه" then
			  	        if Time >= 61 then
					        return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 61 باشد..._"
					    elseif Time < 1 then
					        return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
					    end
				        until_date = Time * 60
						restrict_text = Time .. " دقیقه"
				    elseif extra.k == "h" or extra.k == "ساعت" then
			    	    if Time >= 25 then
				  	        return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 25 باشد..._"
					    elseif Time < 1 then
				    	    return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
					    end
					    until_date = Time * 3600
						restrict_text = Time .. " ساعت"
				    elseif extra.k == "d" or extra.k == "روز" then
			    	    if Time >= 31 then
				    	    return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 31 باشد..._"
					    elseif Time < 1 then
					        return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
					    end
					    until_date = Time * day
						restrict_text = Time .. " روز"
				    end
					redis:setex("bot:"..msg_.bot_id..":tbanned:"..msg.chat_id..":"..result.sender_user_id, until_date, true)
				    until_date = until_date + os.time()
		    	    chat_kick(msg.chat_id, tonumber(result.sender_user_id), nil, until_date)
				    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت به مدت *"..restrict_text.."* بن شد✅", "md")
				else
		            redis:sadd(hash, tonumber(result.sender_user_id))
		    	    chat_kick(msg.chat_id, tonumber(result.sender_user_id))
				    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت بن شد✅", "md")
				end
		    else
				sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` از قبل بن شده است⚠️", "md")
		    end
		end
	end
    ---------------------------------------------------------
	local function ban_by_username(extra, result, success)
  		if result.id then
    	    local hash = "bot:"..msg_.bot_id..":banned:"..msg.chat_id
    	    if have_rank(tonumber(result.id), msg.chat_id) then
				sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید مدیران گروه را بن کنید⛔️_", "md")
		    else
		        if not is_banned(msg.chat_id, tonumber(result.id)) then
			        if extra and extra.k then
			    	    Time = tonumber(extra.v)
				        if extra.k == "m" or extra.k == "دقیقه" then
			  	            if Time >= 61 then
				    	        return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 61 باشد..._"
				    	    elseif Time < 1 then
				    	        return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
				    	    end
				            until_date = Time * 60
							restrict_text = Time .. " دقیقه"
				        elseif extra.k == "h" or extra.k == "ساعت" then
			    	        if Time >= 25 then
				  	            return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 25 باشد..._"
					        elseif Time < 1 then
				    	        return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
					        end
					        until_date = Time * 3600
							restrict_text = Time .. " ساعت"
				        elseif extra.k == "d" or extra.k == "روز" then
			    	        if Time >= 31 then
				    	        return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 31 باشد..._"
					        elseif Time < 1 then
					            return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
					        end
					        until_date = Time * day
							restrict_text = Time .. " روز"
				        end
						redis:setex("bot:"..msg_.bot_id..":tbanned:"..msg.chat_id..":"..result.id, until_date, true)
				        until_date = until_date + os.time()
		    	        chat_kick(msg.chat_id, tonumber(result.id), nil, until_date)
						sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت به مدت *"..restrict_text.."* بن شد✅", "md")
				    else
	 	                redis:sadd(hash, tonumber(result.id))
			            chat_kick(msg.chat_id, tonumber(result.id))
				        sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت بن شد✅", "md")
					end
	 	        else
				    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` از قبل بن شده است⚠️", "md")
	 	        end
		    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function ban_by_id(extra, user_id)
    	local hash = "bot:"..msg_.bot_id..":banned:"..msg.chat_id
    	if have_rank(tonumber(user_id), msg.chat_id) then
	 	 	sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید مدیران گروه را بن کنید⛔️_", "md")
		else
	  	    if not is_banned(msg.chat_id, tonumber(user_id)) then
			    if extra and extra.k then
			    	Time = tonumber(extra.v)
				    if extra.k == "m" or extra.k == "دقیقه" then
			  	        if Time >= 61 then
					        return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 61 باشد..._"
					    elseif Time < 1 then
				 	        return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
					    end
				        until_date = Time * 60
						restrict_text = Time .. " دقیقه"
				    elseif extra.k == "h" or extra.k == "ساعت" then
			            if Time >= 25 then
				            return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 25 باشد..._"
				        elseif Time < 1 then
				 	        return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
				        end
				        until_date = Time * 3600
						restrict_text = Time .. " ساعت"
				    elseif extra.k == "d" or extra.k == "روز" then
			            if Time >= 31 then
			    	        return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 31 باشد..._"
				        elseif Time < 1 then
				            return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
				        end
				        until_date = Time * day
						restrict_text = Time .. " روز"
				    end
					redis:setex("bot:"..msg_.bot_id..":tbanned:"..msg.chat_id..":"..user_id, until_date, true)
				    until_date = until_date + os.time()
		    	    chat_kick(msg.chat_id, tonumber(user_id), nil, until_date)
				    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت به مدت *"..restrict_text.."* بن شد✅", "md")
				else
	  	            redis:sadd(hash, tonumber(user_id))
		    	    chat_kick(msg.chat_id, tonumber(user_id))
					sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت بن شد✅", "md")
				end
	  	    else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` از قبل بن شده است⚠️", "md")
		    end
		end
	end
	---------------------------------------------------------
	local function mute_by_reply(extra, result, success)
	    local hash = "bot:"..msg_.bot_id..":muted:"..msg.chat_id
    	if have_rank(tonumber(result.sender_user_id), msg.chat_id) then
		  	sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید مدیران گروه را میوت کنید⛔️️_", "md")
		else
		    if not is_muted(msg.chat_id, tonumber(result.sender_user_id)) then
			    if extra and extra.k then
			        Time = tonumber(extra.v)
				    if extra.k == "m" or extra.k == "دقیقه" then
			  	        if Time >= 61 then
					        return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 61 باشد..._"
					    elseif Time < 1 then
					        return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
					    end
				        until_date = Time * 60
						restrict_text = Time .. " دقیقه"
				    elseif extra.k == "h" or extra.k == "ساعت" then
			            if Time >= 25 then
				            return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 25 باشد..._"
				        elseif Time < 1 then
					        return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
				        end
				        until_date = Time * 3600
						restrict_text = Time .. " ساعت"
				    elseif extra.k == "d" or extra.k == "روز" then
			            if Time >= 31 then
					        return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 31 باشد..._"
				        elseif Time < 1 then
				            return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
				        end
				        until_date = Time * day
						restrict_text = Time .. " روز"
				    end
					redis:setex("bot:"..msg_.bot_id..":tmuted:"..msg.chat_id..":"..result.sender_user_id, until_date, true)
				    until_date = until_date + os.time()
					restrictUser(msg.chat_id, tonumber(result.sender_user_id), until_date)
					sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت به مدت *"..restrict_text.."* میوت شد✅", "md")
				else
	 	            redis:sadd(hash, tonumber(result.sender_user_id))
			        restrictUser(msg.chat_id, tonumber(result.sender_user_id))
				    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت میوت شد✅", "md")
				end
	 	    else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` از قبل میوت شده است⚠️", "md")
	 	    end
		end
	end
    ---------------------------------------------------------
	local function mute_by_username(extra, result, success)
  		if result.id then
    	    local hash = "bot:"..msg_.bot_id..":muted:"..msg.chat_id
    	    if have_rank(tonumber(result.id), msg.chat_id) then
				sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید مدیران گروه را میوت کنید⛔️️_", "md")
		    else
		        if not is_muted(msg.chat_id, tonumber(result.id)) then
			        if extra and extra.k then
			            Time = tonumber(extra.v)
				        if extra.k == "m" or extra.k == "دقیقه" then
			  	            if Time >= 61 then
					            return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 61 باشد..._"
					        elseif Time < 1 then
					            return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
					        end
				            until_date = Time * 60
					    	restrict_text = Time .. " دقیقه"
				        elseif extra.k == "h" or extra.k == "ساعت" then
			                if Time >= 25 then
				                return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 25 باشد..._"
				            elseif Time < 1 then
					            return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
				            end
				            until_date = Time * 3600
					    	restrict_text = Time .. " ساعت"
				        elseif extra.k == "d" or extra.k == "روز" then
			                if Time >= 31 then
					            return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 31 باشد..._"
				            elseif Time < 1 then
				                return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
				            end
				            until_date = Time * day
					    	restrict_text = Time .. " روز"
				        end
				    	redis:setex("bot:"..msg_.bot_id..":tmuted:"..msg.chat_id..":"..result.id, until_date, true)
				        until_date = until_date + os.time()
				    	restrictUser(msg.chat_id, tonumber(result.id), until_date)
				    	sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت به مدت *"..restrict_text.."* میوت شد✅", "md")
			    	else
	 	                redis:sadd(hash, tonumber(result.id))
			            restrictUser(msg.chat_id, tonumber(result.id))
				        sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت میوت شد✅", "md")
			    	end
	 	        else
			        sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` از قبل میوت شده است⚠️", "md")
	 	        end
		    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function mute_by_id(extra, user_id)
    	local hash = "bot:"..msg_.bot_id..":muted:"..msg.chat_id
    	if have_rank(tonumber(user_id), msg.chat_id) then
	 	 	sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید مدیران گروه را میوت کنید⛔️️_", "md")
		else
	  	    if not is_muted(msg.chat_id, tonumber(user_id)) then
			    if extra and extra.k then
			        Time = tonumber(extra.v)
				    if extra.k == "m" or extra.k == "دقیقه" then
			  	        if Time >= 61 then
				            return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 61 باشد..._"
				        elseif Time < 1 then
				            return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
				        end
				        until_date = Time * 60
				    	restrict_text = Time .. " دقیقه"
				    elseif extra.k == "h" or extra.k == "ساعت" then
			            if Time >= 25 then
				            return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 25 باشد..._"
				        elseif Time < 1 then
				            return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
				        end
			            until_date = Time * 3600
				    	restrict_text = Time .. " ساعت"
			        elseif extra.k == "d" or extra.k == "روز" then
			            if Time >= 31 then
				            return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 31 باشد..._"
				        elseif Time < 1 then
				            return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
				        end
				        until_date = Time * day
				    	restrict_text = Time .. " روز"
				    end
					redis:setex("bot:"..msg_.bot_id..":tmuted:"..msg.chat_id..":"..user_id, until_date, true)
				    until_date = until_date + os.time()
					restrictUser(msg.chat_id, tonumber(user_id), until_date)
					sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت به مدت *"..restrict_text.."* میوت شد✅", "md")
			    else
	 	            redis:sadd(hash, tonumber(user_id))
			        restrictUser(msg.chat_id, tonumber(user_id))
				    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت میوت شد✅", "md")
			    end
	 	    else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` از قبل میوت شده است⚠️", "md")
	 	    end
		end
	end
	---------------------------------------------------------
	local function unban_by_reply(extra, result, success)
	    local hash = "bot:"..msg_.bot_id..":banned:"..msg.chat_id
		if is_banned(msg.chat_id, tonumber(result.sender_user_id)) then
		    redis:srem(hash, tonumber(result.sender_user_id))
			redis:del("bot:"..msg_.bot_id..":tbanned:"..msg.chat_id..":"..tonumber(result.sender_user_id))
		end
		restrictUser(msg.chat_id, result.sender_user_id, 0, nil, {1,1,1,1,1,1})
		sendMsg(msg.chat_id, msg.id, "_کاربر_ `("..result.sender_user_id..")` _از لیست افراد بن شده و بلاک لیست گروه حذف شد ✅_", "md")
	end
    ---------------------------------------------------------
	local function unban_by_username(extra, result, success)
  		if result.id then
    	local hash = "bot:"..msg_.bot_id..":banned:"..msg.chat_id
		    if is_banned(msg.chat_id, tonumber(result.id)) then
	 	        redis:srem(hash, tonumber(result.id))			 
                redis:del("bot:"..msg_.bot_id..":tbanned:"..msg.chat_id..":"..tonumber(result.id))				
	 	    end
			restrictUser(msg.chat_id, result.id, 0, nil, {1,1,1,1,1,1})
			sendMsg(msg.chat_id, msg.id, "_کاربر_ `("..result.id..")` _از لیست افراد بن شده و بلاک لیست گروه حذف شد ✅_", "md")
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function unban_by_id(user_id)
    	local hash = "bot:"..msg_.bot_id..":banned:"..msg.chat_id
	  	if is_banned(msg.chat_id, tonumber(user_id)) then
		    redis:del("bot:"..msg_.bot_id..":tbanned:"..msg.chat_id..":"..tonumber(user_id))	
	  	    redis:srem(hash, tonumber(user_id))
        end
		restrictUser(msg.chat_id, user_id, 0, nil, {1,1,1,1,1,1})
		sendMsg(msg.chat_id, msg.id, "_کاربر_ `("..user_id..")` _از لیست افراد بن شده و بلاک لیست گروه حذف شد ✅_", "md")
	end
	---------------------------------------------------------
	local function unmute_by_reply(extra, result, success)
	    local hash = "bot:"..msg_.bot_id..":muted:"..msg.chat_id
		if is_muted(msg.chat_id, tonumber(result.sender_user_id)) then
		    redis:srem(hash, tonumber(result.sender_user_id))
			redis:del("bot:"..msg_.bot_id..":tmuted:"..msg.chat_id..":"..tonumber(result.sender_user_id))
		end
		restrictUser(msg.chat_id, result.sender_user_id, 0, nil, {1,1,1,1,1,1})
		sendMsg(msg.chat_id, msg.id, "_کاربر_ `("..result.sender_user_id..")` _از لیست افراد میوت شده و محدود شده در گروه حذف شد ✅_", "md")
	end
    ---------------------------------------------------------
	local function unmute_by_username(extra, result, success)
  		if result.id then
    	local hash = "bot:"..msg_.bot_id..":muted:"..msg.chat_id
		    if is_muted(msg.chat_id, tonumber(result.id)) then
	 	        redis:srem(hash, tonumber(result.id))			 
                redis:del("bot:"..msg_.bot_id..":tmuted:"..msg.chat_id..":"..tonumber(result.id))				
	 	    end
			restrictUser(msg.chat_id, result.id, 0, nil, {1,1,1,1,1,1})
			sendMsg(msg.chat_id, msg.id, "_کاربر_ `("..result.id..")` _از لیست افراد میوت شده و محدود شده در گروه حذف شد ✅_", "md")
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function unmute_by_id(user_id)
    	local hash = "bot:"..msg_.bot_id..":muted:"..msg.chat_id
	  	if is_muted(msg.chat_id, tonumber(user_id)) then
		    redis:del("bot:"..msg_.bot_id..":tmuted:"..msg.chat_id..":"..tonumber(user_id))	
	  	    redis:srem(hash, tonumber(user_id))
        end
		restrictUser(msg.chat_id, user_id, 0, nil, {1,1,1,1,1,1})
		sendMsg(msg.chat_id, msg.id, "_کاربر_ `("..user_id..")` _از لیست افراد میوت شده و محدود شده در گروه حذف شد ✅_", "md")
	end
	---------------------------------------------------------
	local function kick_by_reply(extra, result, success)
    	if have_rank(tonumber(result.sender_user_id), msg.chat_id) then
		  	sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید مدیران گروه را کیک کنید⛔️_", "md")
		else
		    chat_kick(msg.chat_id, tonumber(result.sender_user_id), true)
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت کیک شد✅", "md")
		end
	end
    ---------------------------------------------------------
	local function kick_by_username(extra, result, success)
  		if result.id then
    	    if have_rank(tonumber(result.id), msg.chat_id) then
				sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید مدیران گروه را کیک کنید⛔️_", "md")
		    else
			    chat_kick(msg.chat_id, tonumber(result.id), true)
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت کیک شد✅", "md")
		    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function kick_by_id(user_id)
    	if have_rank(tonumber(user_id), msg.chat_id) then
	 	 	sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید مدیران گروه را کیک کنید⛔️_", "md")
		else
		    chat_kick(msg.chat_id, tonumber(user_id), true)
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت کیک شد✅", "md")
		end
	end
	---------------------------------------------------------
	local function warn_by_reply(extra, result, success)
    	if have_rank(tonumber(result.sender_user_id), msg.chat_id) then
		  	sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید به مدیران گروه اخطار دهید⛔️_", "md")
		else
		    redis:incr("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":user-warns:" .. result.sender_user_id)
		    maxWarns = (redis:get("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":maxwarn") or 3)
			WARNS = (redis:get("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":user-warns:" .. result.sender_user_id) or 0)
			if tonumber(WARNS) >= tonumber(maxWarns) then
			    if redis:get("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":warn_status") then
				    chat_kick(msg.chat_id, tonumber(result.sender_user_id))
				    redis:sadd("bot:"..msg_.bot_id..":banned:"..msg.chat_id, tonumber(result.sender_user_id))
                    redis:del("bot:" ..msg_.bot_id.. ":chat_id:" .. msg.chat_id .. ":user-warns:" .. result.sender_user_id)
				    sendMsg(msg.chat_id, msg.id, "*کاربر* `" .. result.sender_user_id .. "` *به دلیل دریافت اخطار با توجه به تنظیمات گروه، از گروه بن شد⛔️*", "md")
				else
				    restrictUser(msg.chat_id, tonumber(result.sender_user_id))
                    redis:sadd("bot:"..msg_.bot_id..":muted:"..msg.chat_id, tonumber(result.sender_user_id))
                    redis:del("bot:" ..msg_.bot_id.. ":chat_id:" .. msg.chat_id .. ":user-warns:" .. result.sender_user_id)
					sendMsg(msg.chat_id, msg.id, "*کاربر* `" .. result.sender_user_id .. "` *به دلیل دریافت اخطار با توجه به تنظیمات گروه، از گروه میوت شد🔇*", "md")
				end
				return false
			else
			    sendMsg(msg.chat_id, msg.id, "*کاربر* " .. result.sender_user_id .. "\n_شما_ `[" .. WARNS .. "]` _اخطار از طرف مدیران گروه دریافت کرده اید و در صورتی که_ `[" .. (maxWarns - WARNS) .. "]` _اخطار دیگر دریافت کنید محدودیت هایی بصورت خودکار برای شما تنظیم میشود⚠️_\n`لطفا قوانین گروه را رعایت کنید...`", "md")
			end
		end
	end
    ---------------------------------------------------------
	local function warn_by_username(extra, result, success)
  		if result.id then
    	    if have_rank(tonumber(result.id), msg.chat_id) then
				sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید به مدیران گروه اخطار دهید⛔️_", "md")
		    else
			vardump(result)
			    redis:incr("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":user-warns:" .. result.id)
		        maxWarns = (redis:get("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":maxwarn") or 3)
			    WARNS = (redis:get("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":user-warns:" .. result.id) or 0)
			    if tonumber(WARNS) >= tonumber(maxWarns) then
			        if redis:get("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":warn_status") then
			    	    chat_kick(msg.chat_id, tonumber(result.id))
			    	    redis:sadd("bot:"..msg_.bot_id..":banned:"..msg.chat_id, tonumber(result.id))
                        redis:del("bot:" ..msg_.bot_id.. ":chat_id:" .. msg.chat_id .. ":user-warns:" .. result.id)
				        sendMsg(msg.chat_id, msg.id, "*کاربر* `" .. result.id .. "` *به دلیل دریافت اخطار با توجه به تنظیمات گروه، از گروه بن شد⛔️*", "md")
				    else
				        restrictUser(msg.chat_id, tonumber(result.id))
                        redis:sadd("bot:"..msg_.bot_id..":muted:"..msg.chat_id, tonumber(result.id))
                        redis:del("bot:" ..msg_.bot_id.. ":chat_id:" .. msg.chat_id .. ":user-warns:" .. result.id)
				    	sendMsg(msg.chat_id, msg.id, "*کاربر* `" .. result.id .. "` *به دلیل دریافت اخطار با توجه به تنظیمات گروه، از گروه میوت شد🔇*", "md")
				    end
				    return false
		    	else
			        sendMsg(msg.chat_id, msg.id, "*کاربر* `" .. result.id .. "`\n_شما_ `[" .. WARNS .. "]` _اخطار از طرف مدیران گروه دریافت کرده اید و در صورتی که_ `[" .. (maxWarns - WARNS) .. "]` _اخطار دیگر دریافت کنید محدودیت هایی بصورت خودکار برای شما تنظیم میشود⚠️_\n`لطفا قوانین گروه را رعایت کنید...`", "md")
			    end
		    end
   	 	else 
		     sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function warn_by_id(user_id)
    	if have_rank(tonumber(user_id), msg.chat_id) then
	 	 	sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید به مدیران گروه اخطار دهید⛔️_", "md")
		else
		    redis:incr("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":user-warns:" .. user_id)
		    maxWarns = (redis:get("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":maxwarn") or 3)
			WARNS = (redis:get("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":user-warns:" .. user_id) or 0)
			if tonumber(WARNS) >= tonumber(maxWarns) then
			    if redis:get("bot:" .. msg_.bot_id .. ":chat_id:" .. msg.chat_id .. ":warn_status") then
				    chat_kick(msg.chat_id, tonumber(user_id))
				    redis:sadd("bot:"..msg_.bot_id..":banned:"..msg.chat_id, tonumber(user_id))
                    redis:del("bot:" ..msg_.bot_id.. ":chat_id:" .. msg.chat_id .. ":user-warns:" .. user_id)
			        sendMsg(msg.chat_id, msg.id, "*کاربر* `" .. user_id .. "` *به دلیل دریافت اخطار با توجه به تنظیمات گروه، از گروه بن شد⛔️*", "md")
			    else
			        restrictUser(msg.chat_id, tonumber(user_id))
                    redis:sadd("bot:"..msg_.bot_id..":muted:"..msg.chat_id, tonumber(user_id))
                    redis:del("bot:" ..msg_.bot_id.. ":chat_id:" .. msg.chat_id .. ":user-warns:" .. user_id)
			    	sendMsg(msg.chat_id, msg.id, "*کاربر* `" .. user_id .. "` *به دلیل دریافت اخطار با توجه به تنظیمات گروه، از گروه میوت شد🔇*", "md")
			    end
			    return false
		    else
			    sendMsg(msg.chat_id, msg.id, "*کاربر* " .. user_id .. "\n_شما_ `[" .. WARNS .. "]` _اخطار از طرف مدیران گروه دریافت کرده اید و در صورتی که_ `[" .. (maxWarns - WARNS) .. "]` _اخطار دیگر دریافت کنید محدودیت هایی بصورت خودکار برای شما تنظیم میشود⚠️_\n`لطفا قوانین گروه را رعایت کنید...`", "md")
			end
		end
	end
	---------------------------------------------------------
	local function delall_by_reply(extra, result, success)
    	if have_rank(tonumber(result.sender_user_id), msg.chat_id) then
		  	sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید تمامی پیام های یکی از مدیران گروه را حذف کنید⛔️_", "md")
		else
		    del_all_msgs(msg.chat_id, result.sender_user_id)
			sendMsg(msg.chat_id, msg.id, "تمامی پیام های کاربر `("..result.sender_user_id..")` با موفقیت حذف شد✅", "md")
		end
	end
    ---------------------------------------------------------
	local function delall_by_username(extra, result, success)
  		if result.id then
    	    if have_rank(tonumber(result.id), msg.chat_id) then
				sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید تمامی پیام های یکی از مدیران گروه را حذف کنید⛔️_", "md")
		    else
			    del_all_msgs(msg.chat_id, result.id)
				sendMsg(msg.chat_id, msg.id, "تمامی پیام های کاربر `("..result.id..")` با موفقیت حذف شد✅", "md")
		    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function delall_by_id(user_id)
    	if have_rank(tonumber(user_id), msg.chat_id) then
	 	 	sendMsg(msg.chat_id, msg.id, "_شما نمیتوانید تمامی پیام های یکی از مدیران گروه را حذف کنید⛔️_", "md")
		else
		    del_all_msgs(msg.chat_id, user_id)
			sendMsg(msg.chat_id, msg.id, "تمامی پیام های کاربر `("..user_id..")` با موفقیت حذف شد✅", "md")
		end
	end
	---------------------------------------------------------
	local function promote_by_reply(extra, result, success)
	    local hash = "bot:"..msg_.bot_id..":mods:"..msg.chat_id
		if not redis:sismember(hash, tonumber(result.sender_user_id)) then
		    redis:sadd(hash, tonumber(result.sender_user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت به لیست مدیر های گروه افزوده شد✅", "md")
	    else
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` از قبل در لیست مدیر های گروه است⚠️", "md")
		end
	end
    ---------------------------------------------------------
	local function promote_by_username(extra, result, success)
  		if result.id then
    	    local hash = "bot:"..msg_.bot_id..":mods:"..msg.chat_id
		    if not redis:sismember(hash, tonumber(result.id)) then
	 	        redis:sadd(hash, tonumber(result.id))
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت به لیست مدیر های گروه افزوده شد✅", "md")
	        else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` از قبل در لیست مدیر های گروه است⚠️", "md")
	 	    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function promote_by_id(user_id)
    	local hash = "bot:"..msg_.bot_id..":mods:"..msg.chat_id
	  	if not redis:sismember(hash, tonumber(user_id)) then
	  	    redis:sadd(hash, tonumber(user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت به لیست مدیر های گروه افزوده شد✅", "md")
	  	else
		    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` از قبل در لیست مدیر های گروه است⚠️", "md")
		end
	end
	---------------------------------------------------------
	local function demote_by_reply(extra, result, success)
	    local hash = "bot:"..msg_.bot_id..":mods:"..msg.chat_id
		if redis:sismember(hash, tonumber(result.sender_user_id)) then
		    redis:srem(hash, tonumber(result.sender_user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت از لیست مدیر های گروه حذف شد✅", "md")
	    else
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` در لیست مدیر های گروه یافت نشد⚠️", "md")
		end
	end
    ---------------------------------------------------------
	local function demote_by_username(extra, result, success)
  		if result.id then
    	    local hash = "bot:"..msg_.bot_id..":mods:"..msg.chat_id
		    if redis:sismember(hash, tonumber(result.id)) then
	 	        redis:srem(hash, tonumber(result.id))
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت از لیست مدیر های گروه حذف شد✅", "md")
	        else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` در لیست مدیر های گروه یافت نشد⚠️", "md")
	 	    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function demote_by_id(user_id)
    	local hash = "bot:"..msg_.bot_id..":mods:"..msg.chat_id
	  	if redis:sismember(hash, tonumber(user_id)) then
	  	    redis:srem(hash, tonumber(user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت از لیست مدیر های گروه حذف شد✅", "md")
	  	else
		    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` در لیست مدیر های گروه یافت نشد⚠️", "md")
		end
	end
	---------------------------------------------------------
	local function whitelist_by_reply(extra, result, success)
	    local hash = "bot:"..msg_.bot_id..":whitelist:"..msg.chat_id
		if not redis:sismember(hash, tonumber(result.sender_user_id)) then
		    redis:sadd(hash, tonumber(result.sender_user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت به لیست سفید گروه افزوده شد و سخت گیری های ربات برای کاربر حذف گردید✅", "md")
	    else
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` از قبل در لیست سفید گروه است⚠️", "md")
		end
	end
    ---------------------------------------------------------
	local function whitelist_by_username(extra, result, success)
  		if result.id then
    	    local hash = "bot:"..msg_.bot_id..":whitelist:"..msg.chat_id
		    if not redis:sismember(hash, tonumber(result.id)) then
	 	        redis:sadd(hash, tonumber(result.id))
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت به لیست سفید گروه افزوده شد و سخت گیری های ربات برای کاربر حذف گردید✅", "md")
	        else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` از قبل در لیست سفید گروه است⚠️", "md")
	 	    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function whitelist_by_id(user_id)
    	local hash = "bot:"..msg_.bot_id..":whitelist:"..msg.chat_id
	  	if not redis:sismember(hash, tonumber(user_id)) then
	  	    redis:sadd(hash, tonumber(user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت به لیست سفید گروه افزوده شد و سخت گیری های ربات برای کاربر حذف گردید✅", "md")
	  	else
		    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` از قبل در لیست سفید گروه است⚠️", "md")
		end
	end
	---------------------------------------------------------
	local function unwhitelist_by_reply(extra, result, success)
	    local hash = "bot:"..msg_.bot_id..":whitelist:"..msg.chat_id
		if redis:sismember(hash, tonumber(result.sender_user_id)) then
		    redis:srem(hash, tonumber(result.sender_user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` با موفقیت از لیست سفید گروه حذف شد✅", "md")
	    else
			sendMsg(msg.chat_id, msg.id, "کاربر `("..result.sender_user_id..")` در لیست سفید گروه یافت نشد⚠️", "md")
		end
	end
    ---------------------------------------------------------
	local function unwhitelist_by_username(extra, result, success)
  		if result.id then
    	    local hash = "bot:"..msg_.bot_id..":whitelist:"..msg.chat_id
		    if redis:sismember(hash, tonumber(result.id)) then
	 	        redis:srem(hash, tonumber(result.id))
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` با موفقیت از لیست سفید گروه حذف شد✅", "md")
	        else
			    sendMsg(msg.chat_id, msg.id, "کاربر `("..result.id..")` در لیست سفید گروه یافت نشد⚠️", "md")
	 	    end
   	 	else 
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function unwhitelist_by_id(user_id)
    	local hash = "bot:"..msg_.bot_id..":whitelist:"..msg.chat_id
	  	if redis:sismember(hash, tonumber(user_id)) then
	  	    redis:srem(hash, tonumber(user_id))
			sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` با موفقیت از لیست سفید گروه حذف شد✅", "md")
	  	else
		    sendMsg(msg.chat_id, msg.id, "کاربر `("..user_id..")` در لیست سفید گروه یافت نشد⚠️", "md")
		end
	end
---------------------------------------------------------------------------------------------------------------
-------------------------------------------------* COMMANDS *--------------------------------------------------
---------------------------------------------------------------------------------------------------------------
    if msg.chat_type == "pv" then
	    return false
	end
	if is_mod(msg) then
	    if not is_JoinedCH(msg.sender_user_id) then
  	  	    function inCallbacka(extra, result, success)
    	        if result.results and result.results[0] then
				    sendInlineQuery(msg.chat_id, msg.id, result.inline_query_id, result.results[0].id)
       	    	else
           		    sendMsg(msg.chat_id, msg.id, '*خطایی در ارتباط با ربات دستیار رخ داده است⚠️*\n_لطفا کمی صبر کنید و دوباره تلاش کنید_','md')
          	 	end
        	end
		    getInlineResult(msg_.helper_id, msg.chat_id, "BPJoinCH:"..msg.chat_id.."/"..msg.sender_user_id.."/"..msg_.bot_id, inCallbacka)
  	  	    return false
  	    end
        if matches[1] == 'ping' or matches[1] == 'ربات' then
			function sendPing(extra, result, success)
    		    if result.results and result.results[0] then
				    sendInlineQuery(msg.chat_id, msg.id, result.inline_query_id, result.results[0].id)
       			else
        		    sendMsg(msg.chat_id, msg.id, '*خطایی در ارتباط با ربات دستیار رخ داده است⚠️*\n_لطفا کمی صبر کنید و دوباره تلاش کنید_','md')
      		 	end
       		end
			getInlineResult(msg_.helper_id, msg.chat_id, "BPPing:"..msg.chat_id.."/"..msg.sender_user_id.."/"..msg_.bot_id, sendPing)
	---------------------------------------------------------
        elseif matches[1] == 'panel' or matches[1] == 'پنل' then
			function inCallback(extra, result, success)
    	        if result.results and result.results[0] then
				    sendInlineQuery(msg.chat_id, msg.id, result.inline_query_id, result.results[0].id)
       	    	else
           		    sendMsg(msg.chat_id, msg.id, '*خطایی در ارتباط با ربات دستیار رخ داده است⚠️*\n_لطفا کمی صبر کنید و دوباره تلاش کنید_','md')
          	 	end
        	end
		    getInlineResult(msg_.helper_id, msg.chat_id, "BPPanel:"..msg.chat_id.."/"..msg.sender_user_id.."/"..msg_.bot_id, inCallback)
	---------------------------------------------------------
        elseif matches[1] == 'ban' or matches[1] == 'بن' then
		    botMessages(nil, msg)
		    if not matches[2] and msg.reply then
	            getMessage(msg.chat_id, msg.reply, ban_by_reply)
	        elseif matches[2] and is_number(matches[2]) then
			    ban_by_id(nil, matches[2])
	        elseif matches[2] and not is_number(matches[2]) then
		    	resolve_username(matches[2], ban_by_username)
	        end
	---------------------------------------------------------
		elseif matches[1] == 'tban' or matches[1] == 'بن زمانی' then
		    botMessages(nil, msg)
		    if not matches[4] and msg.reply then
	            getMessage(msg.chat_id, msg.reply, ban_by_reply, {k = matches[3], v = matches[2]})
	        elseif matches[2] and is_number(matches[2]) then
		        ban_by_id({k = matches[4], v = matches[3]}, matches[2])
	        elseif matches[2] and not is_number(matches[2]) then
		    	resolve_username(matches[2], ban_by_username, {k = matches[4], v = matches[3]})
	        end
	---------------------------------------------------------
        elseif matches[1] == 'unban' or matches[1] == 'آیین' then
		    botMessages(nil, msg)
		    if not matches[2] and msg.reply then
	            getMessage(msg.chat_id, msg.reply, unban_by_reply)
	        elseif matches[2] and is_number(matches[2]) then
			    unban_by_id(matches[2])
	        elseif matches[2] and not is_number(matches[2]) then
		    	resolve_username(matches[2], unban_by_username)
	        end
	---------------------------------------------------------
        elseif matches[1] == 'kick' or matches[1] == 'اخراج' then
		    botMessages(nil, msg)
		    if not matches[2] and msg.reply then
	            getMessage(msg.chat_id, msg.reply, kick_by_reply)
	        elseif matches[2] and is_number(matches[2]) then
			    kick_by_id(matches[2])
	        elseif matches[2] and not is_number(matches[2]) then
		    	resolve_username(matches[2], kick_by_username)
	        end
	---------------------------------------------------------
        elseif matches[1] == 'warn' or matches[1] == 'اخطار' then
		    botMessages(nil, msg)
		    if not matches[2] and msg.reply then
	            getMessage(msg.chat_id, msg.reply, warn_by_reply)
	        elseif matches[2] and is_number(matches[2]) then
			    warn_by_id(matches[2])
	        elseif matches[2] and not is_number(matches[2]) then
		    	resolve_username(matches[2], warn_by_username)
	        end
	---------------------------------------------------------
        elseif matches[1] == 'mute' or matches[1] == 'سکوت' then
		    botMessages(nil, msg)
		    if not matches[2] and msg.reply then
	            getMessage(msg.chat_id, msg.reply, mute_by_reply)
	        elseif matches[2] and is_number(matches[2]) then
			    mute_by_id(nil, matches[2])
	        elseif matches[2] and not is_number(matches[2]) then
		    	resolve_username(matches[2], mute_by_username)
	        end
	---------------------------------------------------------
		elseif matches[1] == 'tmute' or matches[1] == 'سکوت زمانی' then
		    botMessages(nil, msg)
		    if not matches[4] and msg.reply then
	            getMessage(msg.chat_id, msg.reply, mute_by_reply, {k = matches[3], v = matches[2]})
	        elseif matches[2] and is_number(matches[2]) then
		        mute_by_id({k = matches[4], v = matches[3]}, matches[2])
	        elseif matches[2] and not is_number(matches[2]) then
		    	resolve_username(matches[2], mute_by_username, {k = matches[4], v = matches[3]})
	        end
	---------------------------------------------------------
        elseif matches[1] == 'unmute' or matches[1] == 'آنین' then
		    botMessages(nil, msg)
		    if not matches[2] and msg.reply then
	            getMessage(msg.chat_id, msg.reply, unmute_by_reply)
	        elseif matches[2] and is_number(matches[2]) then
			    unmute_by_id(matches[2])
	        elseif matches[2] and not is_number(matches[2]) then
		    	resolve_username(matches[2], unmute_by_username)
	        end
	---------------------------------------------------------
        elseif matches[1] == 'promote' and is_owner(msg) or matches[1] == 'تنظیم مدیر' and is_owner(msg) then
		    botMessages(nil, msg)
		    if not matches[2] and msg.reply then
	            getMessage(msg.chat_id, msg.reply, promote_by_reply)
	        elseif matches[2] and is_number(matches[2]) then
			    promote_by_id(matches[2])
	        elseif matches[2] and not is_number(matches[2]) then
		    	resolve_username(matches[2], promote_by_username)
	        end
	---------------------------------------------------------
        elseif matches[1] == 'demote' and is_owner(msg) or matches[1] == 'حذف مدیر' and is_owner(msg) then
		    botMessages(nil, msg)
		    if not matches[2] and msg.reply then
	            getMessage(msg.chat_id, msg.reply, demote_by_reply)
	        elseif matches[2] and is_number(matches[2]) then
			    demote_by_id(matches[2])
	        elseif matches[2] and not is_number(matches[2]) then
		    	resolve_username(matches[2], demote_by_username)
	        end
	---------------------------------------------------------
        elseif matches[1] == 'whitelist' or matches[1] == 'مجاز' then
		    botMessages(nil, msg)
		    if not matches[2] and msg.reply then
	            getMessage(msg.chat_id, msg.reply, whitelist_by_reply)
	        elseif matches[2] and is_number(matches[2]) then
			    whitelist_by_id(matches[2])
	        elseif matches[2] and not is_number(matches[2]) then
		    	resolve_username(matches[2], whitelist_by_username)
	        end
	---------------------------------------------------------
        elseif matches[1] == 'unwhitelist' or matches[1] == 'حذف مجاز' then
		    botMessages(nil, msg)
		    if not matches[2] and msg.reply then
	            getMessage(msg.chat_id, msg.reply, unwhitelist_by_reply)
	        elseif matches[2] and is_number(matches[2]) then
			    unwhitelist_by_id(matches[2])
	        elseif matches[2] and not is_number(matches[2]) then
		    	resolve_username(matches[2], unwhitelist_by_username)
	        end
	---------------------------------------------------------
        elseif matches[1] == 'delall' or matches[1] == 'پاک سازی' then
		    botMessages(nil, msg)
		    if not matches[2] and msg.reply then
	            getMessage(msg.chat_id, msg.reply, delall_by_reply)
	        elseif matches[2] and is_number(matches[2]) then
			    delall_by_id(matches[2])
	        elseif matches[2] and not is_number(matches[2]) then
		    	resolve_username(matches[2], delall_by_username)
	        end
	---------------------------------------------------------
        elseif matches[1] == 'pin' or matches[1] == 'پین' then
		    botMessages(nil, msg)
		    if msg.reply then
				pinMessage(msg.basic_id, msg.reply)
				redis:set('bot:'..msg_.bot_id..':pinnedmsg:id:'..msg.chat_id, msg.reply)
				return "*پیام مورد نظر با موفقیت پین شد✅*"
			else
			    return "*لطفا ابتدا پیامی را ریپلی کنید⚠️*"
			end
	---------------------------------------------------------
        elseif matches[1] == 'unpin' or matches[1] == 'آنپین' then
		    botMessages(nil, msg)
			unpinMessage(msg.basic_id)
			return "*پیام پین شده با موفقیت آنپین شد✅*"
	---------------------------------------------------------
        elseif matches[1] == 'repin' or matches[1] == 'ریپین' then 
		    botMessages(nil, msg)
			local pin_id = redis:get('bot:'..msg_.bot_id..':pinnedmsg:id:'..msg.chat_id)
			if pin_id then
				pinMessage(msg.basic_id, pin_id)
       	 	    return "*آخرین پیام پین شده در گروه مجدادا پین شد✅*"
			else
        	 	return "*خطایی رخ داده⚠️*\n_من قادر به پیدا کردن آخرین پیام پین شده نیستم!_"
			end
	---------------------------------------------------------
        elseif matches[1] == 'del' or matches[1] == 'حذف' then
		    botMessages(nil, msg)
			if redis:get("bot:"..msg_.bot_id..":last:delmsg:"..msg.chat_id) then
			    mTime = redis:ttl("bot:"..msg_.bot_id..":last:delmsg:"..msg.chat_id) or 0
				sendMsg(msg.chat_id, msg.id, "*لطفا* `"..mTime.."` *ثانیه صبر کنید و دوباره تلاش کنید...*", "md")
			    return false
			end
			if matches[2] then
			    local function cleanMessages(extra, result, success)
	                for k,message in pairs(result.messages) do
	                    delete_msg(msg.chat_id,{[0] = message.id})
	                end
					 redis:setex("bot:"..msg_.bot_id..":last:delmsg:"..msg.chat_id, 5, true) 
				end
				if tonumber(matches[2]) >= 10000 then
				    return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 10000 باشد_"
				elseif tonumber(matches[2]) <= 1 then
				    return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 1 باشد_"
				else
			        getChatHistory(msg.chat_id, msg.id, tonumber(matches[2]), cleanMessages)
					delCB(nil, msg)
					sendMsg(msg.chat_id, msg.id, "`"..matches[2].."` *پیام اخیر گروه با موفقیت حذف شد✅*", "md", 1, delCB)
				end
			else
			    delete_msg(msg.chat_id, {[0] = msg.id})
				delete_msg(msg.chat_id, {[0] = msg.reply})
			end
	---------------------------------------------------------
        elseif matches[1] == 'lock' or matches[1] == 'قفل' then
		    local until_date
		    local time_text
			botMessages(nil, msg)
			if matches[3] and matches[4] then
			    local Time = tonumber(matches[3])
			    if matches[4] == "m" or matches[4] == "دقیقه" then
			  	    if Time >= 61 then
					    return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 61 باشد..._"
					elseif Time < 1 then
					    return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
					end
				    until_date = Time * 60
					time_text = Time .. " دقیقه"
				elseif matches[4] == "h" or matches[4] == "ساعت" then
			        if Time >= 25 then
				        return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 25 باشد..._"
				    elseif Time < 1 then
					    return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
				   end
				    until_date = Time * 3600
					time_text = Time .. " ساعت"
				elseif matches[4] == "d" or matches[4] == "روز" then
			        if Time >= 31 then
					    return "*خطایی رخ داده است⚠️*\n_این مقدار باید کمتر از 31 باشد..._"
				    elseif Time < 1 then
				        return "*خطایی رخ داده است⚠️*\n_این مقدار باید بیشتر از 0 باشد..._"
				    end
				    until_date = Time * 86400
					time_text = Time .. " روز"
				end
			end
			if matches[2] == 'all' or matches[2] == 'همه' then
				if redis:get("bot:"..msg_.bot_id..":locks:all:"..msg.chat_id) then
					return "*قفل چت از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:all:"..msg.chat_id, until_date, true)
					    return "*قفل همه ی پیام ها فعال شد و کاربران تا* `" .. time_text .. "` *دیگر قادر به صحبت کردن نیستند🔕*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:all:"..msg.chat_id, true)
					    return "*قفل همه ی پیام ها فعال شد و کاربران دیگر قادر به صحبت کردن نیستند🔕*"
					end
				end
			elseif matches[2] == 'link' or matches[2] == 'لینک' then
				if redis:get("bot:"..msg_.bot_id..":locks:link:"..msg.chat_id) then
					return "*قفل 'لینک های تلگرامی' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:link:"..msg.chat_id, until_date, true)
					    return "*قفل 'لینک های تلگرامی' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:link:"..msg.chat_id, true)
					    return "*قفل 'لینک های تلگرامی' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'webpage' or matches[2] == 'سایت' then
				if redis:get("bot:"..msg_.bot_id..":locks:webpage:"..msg.chat_id) then
					return "*قفل 'تمامی لینک ها و هایپر لینک ها' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:webpage:"..msg.chat_id, until_date, true)
					    return "*قفل 'تمامی لینک ها و هایپر لینک ها' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:webpage:"..msg.chat_id, true)
					    return "*قفل 'تمامی لینک ها و هایپر لینک ها' با موفقیت 'فعال' شد✅*"
					end
				end
			elseif matches[2] == 'tag' or matches[2] == 'تگ' then
				if redis:get("bot:"..msg_.bot_id..":locks:tag:"..msg.chat_id) then
					return "*قفل 'تگ(@)' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:tag:"..msg.chat_id, until_date, true)
					    return "*قفل 'تگ(@)' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:tag:"..msg.chat_id, true)
					    return "*قفل 'تگ(@)' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'hashtag' or matches[2] == 'هشتگ' then
				if redis:get("bot:"..msg_.bot_id..":locks:hashtag:"..msg.chat_id) then
					return "*قفل 'هشتگ(#)' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:hashtag:"..msg.chat_id, until_date, true)
					    return "*قفل 'هشتگ(#)' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:hashtag:"..msg.chat_id, true)
					    return "*قفل 'هشتگ(#)' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'english' or matches[2] == 'انگلیسی' then
				if redis:get("bot:"..msg_.bot_id..":locks:english:"..msg.chat_id) then
					return "*قفل 'چت با زبان انگلیسی' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:english:"..msg.chat_id, until_date, true)
					    return "*قفل 'چت با زبان انگلیسی' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:english:"..msg.chat_id, true)
					    return "*قفل 'چت با زبان انگلیسی' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'persian' or matches[2] == 'فارسی' then
				if redis:get("bot:"..msg_.bot_id..":locks:arabic:"..msg.chat_id) then
					return "*قفل 'چت با زبان فارسی' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:arabic:"..msg.chat_id, until_date, true)
					    return "*قفل 'چت با زبان فارسی' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:arabic:"..msg.chat_id, true)
					    return "*قفل 'چت با زبان فارسی' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'forward' or matches[2] == 'فوروارد' then
				if redis:get("bot:"..msg_.bot_id..":locks:forward:"..msg.chat_id) then
					return "*قفل 'فوروارد' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:forward:"..msg.chat_id, until_date, true)
					    return "*قفل 'فوروارد' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:forward:"..msg.chat_id, true)
					    return "*قفل 'فوروارد' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'edit' or matches[2] == 'ویرایش' then
				if redis:get("bot:"..msg_.bot_id..":locks:edit:"..msg.chat_id) then
					return "*قفل 'ویرایش' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:edit:"..msg.chat_id, until_date, true)
					    return "*قفل 'ویرایش' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:edit:"..msg.chat_id, true)
					    return "*قفل 'ویرایش' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'pin' or matches[2] == 'پین' then
				if redis:get("bot:"..msg_.bot_id..":locks:pin:"..msg.chat_id) then
					return "*قفل 'پین کردن پیام' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:pin:"..msg.chat_id, until_date, true)
					    return "*قفل 'پین کردن پیام' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:pin:"..msg.chat_id, true)
					    return "*قفل 'پین کردن پیام' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'contact' or matches[2] == 'کانتکت' then
				if redis:get("bot:"..msg_.bot_id..":locks:contact:"..msg.chat_id) then
					return "*قفل 'کانتکت(شماره تماس)' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:contact:"..msg.chat_id, until_date, true)
					    return "*قفل 'کانتکت(شماره تماس)' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:contact:"..msg.chat_id, true)
					    return "*قفل 'کانتکت(شماره تماس)' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'contact' or matches[2] == 'کانتکت' then
				if redis:get("bot:"..msg_.bot_id..":locks:contact:"..msg.chat_id) then
					return "*قفل 'کانتکت(شماره تماس)' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:contact:"..msg.chat_id, until_date, true)
					    return "*قفل 'کانتکت(شماره تماس)' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:contact:"..msg.chat_id, true)
					    return "*قفل 'کانتکت(شماره تماس)' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'member' or matches[2] == 'اعضا' then
				if redis:get("bot:"..msg_.bot_id..":locks:members:"..msg.chat_id) then
					return "*قفل 'اعضا(جلوگیری از ورود عضو جدید)' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:members:"..msg.chat_id, until_date, true)
					    return "*قفل 'اعضا(جلوگیری از ورود عضو جدید)' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:members:"..msg.chat_id, true)
					    return "*قفل 'اعضا(جلوگیری از ورود عضو جدید)' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'bots' or matches[2] == 'ربات' then
				if redis:get("bot:"..msg_.bot_id..":locks:bot:"..msg.chat_id) then
					return "*قفل 'ربات' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:bot:"..msg.chat_id, until_date, true)
					    return "*قفل 'ربات' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:bot:"..msg.chat_id, true)
					    return "*قفل 'ربات' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'tgservice' or matches[2] == 'پیام ورود و خروج' then
				if redis:get("bot:"..msg_.bot_id..":locks:tgservice:"..msg.chat_id) then
					return "*قفل 'پیام ورود خروج اعضا' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:tgservice:"..msg.chat_id, until_date, true)
					    return "*قفل 'پیام ورود خروج اعضا' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:tgservice:"..msg.chat_id, true)
					    return "*قفل 'پیام ورود خروج اعضا' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'text' or matches[2] == 'متن' then
				if redis:get("bot:"..msg_.bot_id..":locks:text:"..msg.chat_id) then
					return "*قفل 'ارسال پیام متنی' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:text:"..msg.chat_id, until_date, true)
					    return "*قفل 'ارسال پیام متنی' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:text:"..msg.chat_id, true)
					    return "*قفل 'ارسال پیام متنی' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'sticker' or matches[2] == 'استیکر' then
				if redis:get("bot:"..msg_.bot_id..":locks:sticker:"..msg.chat_id) then
					return "*قفل 'ارسال استیکر' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:sticker:"..msg.chat_id, until_date, true)
					    return "*قفل 'ارسال استیکر' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:sticker:"..msg.chat_id, true)
					    return "*قفل 'ارسال استیکر' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'videomsg' or matches[2] == 'پیام تصویری' then
				if redis:get("bot:"..msg_.bot_id..":locks:vm:"..msg.chat_id) then
					return "*قفل 'ارسال پیام تصویری' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:vm:"..msg.chat_id, until_date, true)
					    return "*قفل 'ارسال پیام تصویری' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:vm:"..msg.chat_id, true)
					    return "*قفل 'ارسال پیام تصویری' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'photo' or matches[2] == 'عکس' then
				if redis:get("bot:"..msg_.bot_id..":locks:photo:"..msg.chat_id) then
					return "*قفل 'ارسال عکس' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:photo:"..msg.chat_id, until_date, true)
					    return "*قفل 'ارسال عکس' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:photo:"..msg.chat_id, true)
					    return "*قفل 'ارسال عکس' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'game' or matches[2] == 'بازی' then
				if redis:get("bot:"..msg_.bot_id..":locks:game:"..msg.chat_id) then
					return "*قفل 'ارسال بازی' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:game:"..msg.chat_id, until_date, true)
					    return "*قفل 'ارسال بازی' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:game:"..msg.chat_id, true)
					    return "*قفل 'ارسال بازی' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'inline' or matches[2] == 'اینلاین' then
				if redis:get("bot:"..msg_.bot_id..":locks:inline:"..msg.chat_id) then
					return "*قفل 'دکمه شیشه ای' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:inline:"..msg.chat_id, until_date, true)
					    return "*قفل 'دکمه شیشه ای' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:inline:"..msg.chat_id, true)
					    return "*قفل 'دکمه شیشه ای' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'video' or matches[2] == 'فیلم' then
				if redis:get("bot:"..msg_.bot_id..":locks:video:"..msg.chat_id) then
					return "*قفل 'ارسال فیلم' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:video:"..msg.chat_id, until_date, true)
					    return "*قفل 'ارسال فیلم' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:video:"..msg.chat_id, true)
					    return "*قفل 'ارسال فیلم' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'gif' or matches[2] == 'گیف' then
				if redis:get("bot:"..msg_.bot_id..":locks:gif:"..msg.chat_id) then
					return "*قفل 'ارسال گیف' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:gif:"..msg.chat_id, until_date, true)
					    return "*قفل 'ارسال گیف' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:gif:"..msg.chat_id, true)
					    return "*قفل 'ارسال گیف' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'music' or matches[2] == 'آهنگ' then
				if redis:get("bot:"..msg_.bot_id..":locks:music:"..msg.chat_id) then
					return "*قفل 'ارسال آهنگ' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:music:"..msg.chat_id, until_date, true)
					    return "*قفل 'ارسال آهنگ' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:music:"..msg.chat_id, true)
					    return "*قفل 'ارسال آهنگ' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'location' or matches[2] == 'موقعیت مکانی' then
				if redis:get("bot:"..msg_.bot_id..":locks:location:"..msg.chat_id) then
					return "*قفل 'ارسال موقعیت مکانی' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:location:"..msg.chat_id, until_date, true)
					    return "*قفل 'ارسال موقعیت مکانی' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:location:"..msg.chat_id, true)
					    return "*قفل 'ارسال موقعیت مکانی' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'file' or matches[2] == 'فایل' then
				if redis:get("bot:"..msg_.bot_id..":locks:document:"..msg.chat_id) then
					return "*قفل 'ارسال فایل' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:document:"..msg.chat_id, until_date, true)
					    return "*قفل 'ارسال فایل' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:document:"..msg.chat_id, true)
					    return "*قفل 'ارسال فایل' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'voice' or matches[2] == 'وویس' then
				if redis:get("bot:"..msg_.bot_id..":locks:voice:"..msg.chat_id) then
					return "*قفل 'ارسال وویس' از قبل فعال است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:voice:"..msg.chat_id, until_date, true)
					    return "*قفل 'ارسال وویس' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:voice:"..msg.chat_id, true)
					    return "*قفل 'ارسال وویس' با موفقیت فعال شد✅*"
					end
				end
			elseif matches[2] == 'cmds' or matches[2] == 'دستورات' then
				if redis:get("bot:"..msg_.bot_id..":locks:cmd:"..msg.chat_id) then
					return "*دستورات ربات از قبل قفل است⚠️*"
				else
					if until_date then
					    redis:setex("bot:"..msg_.bot_id..":locks:cmd:"..msg.chat_id, until_date, true)
					    return "*قفل 'دستورات معمولی ربات برای کاربران عادی' با موفقیت فعال شد و بعد از* `" .. time_text .. "` *بصورت خودکار غیرفعال میگردد✅*"
					else
					    redis:set("bot:"..msg_.bot_id..":locks:cmd:"..msg.chat_id, true)
					    return "*دستورات معمولی ربات برای کاربران عادی قفل شد✅*"
					end
				end
			end
	---------------------------------------------------------
        elseif matches[1] == 'unlock' or matches[1] == 'آزاد کردن' or matches[1] == 'باز کردن' then
			botMessages(nil, msg)
			if matches[2] == 'all' or matches[2] == 'همه' then
				if not redis:get("bot:"..msg_.bot_id..":locks:all:"..msg.chat_id) then
					return "*قفل چت از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:all:"..msg.chat_id)
					return "*قفل همه ی پیام ها غیر فعال شد و کاربران  قادر به صحبت کردن هستند🔈*"
				end
			elseif matches[2] == 'link' or matches[2] == 'لینک' then
				if not redis:get("bot:"..msg_.bot_id..":locks:link:"..msg.chat_id) then
					return "*قفل 'لینک های تلگرامی' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:link:"..msg.chat_id)
					return "*قفل 'لینک های تلگرامی' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'webpage' or matches[2] == 'سایت' then
				if not redis:get("bot:"..msg_.bot_id..":locks:webpage:"..msg.chat_id) then
					return "*قفل 'تمامی لینک ها و هایپر لینک ها' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:webpage:"..msg.chat_id)
					return "*قفل 'تمامی لینک ها و هایپر لینک ها' با موفقیت ' غیر فعال' شد✅*"
				end
			elseif matches[2] == 'tag' or matches[2] == 'تگ' then
				if not redis:get("bot:"..msg_.bot_id..":locks:tag:"..msg.chat_id) then
					return "*قفل 'تگ(@)' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:tag:"..msg.chat_id)
					return "*قفل 'تگ(@)' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'hashtag' or matches[2] == 'هشتگ' then
				if not redis:get("bot:"..msg_.bot_id..":locks:hashtag:"..msg.chat_id) then
					return "*قفل 'هشتگ(#)' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:hashtag:"..msg.chat_id)
					return "*قفل 'هشتگ(#)' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'english' or matches[2] == 'انگلیسی' then
				if not redis:get("bot:"..msg_.bot_id..":locks:english:"..msg.chat_id) then
					return "*قفل 'چت با زبان انگلیسی' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:english:"..msg.chat_id)
					return "*قفل 'چت با زبان انگلیسی' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'persian' or matches[2] == 'فارسی' then
				if not redis:get("bot:"..msg_.bot_id..":locks:arabic:"..msg.chat_id) then
					return "*قفل 'چت با زبان فارسی' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:arabic:"..msg.chat_id)
				    return "*قفل 'چت با زبان فارسی' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'forward' or matches[2] == 'فوروارد' then
				if not redis:get("bot:"..msg_.bot_id..":locks:forward:"..msg.chat_id) then
					return "*قفل 'فوروارد' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:forward:"..msg.chat_id)
					return "*قفل 'فوروارد' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'edit' or matches[2] == 'ویرایش' then
				if not redis:get("bot:"..msg_.bot_id..":locks:edit:"..msg.chat_id) then
					return "*قفل 'ویرایش' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:edit:"..msg.chat_id)
					return "*قفل 'ویرایش' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'pin' or matches[2] == 'پین' then
				if not redis:get("bot:"..msg_.bot_id..":locks:pin:"..msg.chat_id) then
					return "*قفل 'پین کردن پیام' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:pin:"..msg.chat_id)
					return "*قفل 'پین کردن پیام' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'contact' or matches[2] == 'کانتکت' then
				if not redis:get("bot:"..msg_.bot_id..":locks:contact:"..msg.chat_id) then
					return "*قفل 'کانتکت(شماره تماس)' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:contact:"..msg.chat_id)
					return "*قفل 'کانتکت(شماره تماس)' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'contact' or matches[2] == 'کانتکت' then
				if not redis:get("bot:"..msg_.bot_id..":locks:contact:"..msg.chat_id) then
					return "*قفل 'کانتکت(شماره تماس)' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:contact:"..msg.chat_id)
					return "*قفل 'کانتکت(شماره تماس)' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'member' or matches[2] == 'اعضا' then
				if not redis:get("bot:"..msg_.bot_id..":locks:members:"..msg.chat_id) then
					return "*قفل 'اعضا(جلوگیری از ورود عضو جدید)' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:members:"..msg.chat_id)
					return "*قفل 'اعضا(جلوگیری از ورود عضو جدید)' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'bots' or matches[2] == 'ربات' then
				if not redis:get("bot:"..msg_.bot_id..":locks:bot:"..msg.chat_id) then
					return "*قفل 'ربات' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:bot:"..msg.chat_id)
					return "*قفل 'ربات' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'tgservice' or matches[2] == 'پیام ورود و خروج' then
				if not redis:get("bot:"..msg_.bot_id..":locks:tgservice:"..msg.chat_id) then
					return "*قفل 'پیام ورود خروج اعضا' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:tgservice:"..msg.chat_id)
					return "*قفل 'پیام ورود خروج اعضا' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'text' or matches[2] == 'متن' then
				if not redis:get("bot:"..msg_.bot_id..":locks:text:"..msg.chat_id) then
					return "*قفل 'ارسال پیام متنی' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:text:"..msg.chat_id)
					return "*قفل 'ارسال پیام متنی' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'sticker' or matches[2] == 'استیکر' then
				if not redis:get("bot:"..msg_.bot_id..":locks:sticker:"..msg.chat_id) then
					return "*قفل 'ارسال استیکر' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:sticker:"..msg.chat_id)
					return "*قفل 'ارسال استیکر' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'videomsg' or matches[2] == 'پیام تصویری' then
				if not redis:get("bot:"..msg_.bot_id..":locks:vm:"..msg.chat_id) then
					return "*قفل 'ارسال پیام تصویری' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:vm:"..msg.chat_id)
					return "*قفل 'ارسال پیام تصویری' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'photo' or matches[2] == 'عکس' then
				if not redis:get("bot:"..msg_.bot_id..":locks:photo:"..msg.chat_id) then
					return "*قفل 'ارسال عکس' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:photo:"..msg.chat_id)
					return "*قفل 'ارسال عکس' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'game' or matches[2] == 'بازی' then
				if not redis:get("bot:"..msg_.bot_id..":locks:game:"..msg.chat_id) then
					return "*قفل 'ارسال بازی' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:game:"..msg.chat_id)
					return "*قفل 'ارسال بازی' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'inline' or matches[2] == 'اینلاین' then
				if not redis:get("bot:"..msg_.bot_id..":locks:inline:"..msg.chat_id) then
					return "*قفل 'دکمه شیشه ای' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:inline:"..msg.chat_id)
					return "*قفل 'دکمه شیشه ای' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'video' or matches[2] == 'فیلم' then
				if not redis:get("bot:"..msg_.bot_id..":locks:video:"..msg.chat_id) then
					return "*قفل 'ارسال فیلم' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:video:"..msg.chat_id)
					return "*قفل 'ارسال فیلم' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'gif' or matches[2] == 'گیف' then
				if not redis:get("bot:"..msg_.bot_id..":locks:gif:"..msg.chat_id) then
					return "*قفل 'ارسال گیف' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:gif:"..msg.chat_id)
					return "*قفل 'ارسال گیف' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'music' or matches[2] == 'آهنگ' then
				if not redis:get("bot:"..msg_.bot_id..":locks:music:"..msg.chat_id) then
					return "*قفل 'ارسال آهنگ' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:music:"..msg.chat_id)
					return "*قفل 'ارسال آهنگ' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'location' or matches[2] == 'موقعیت مکانی' then
				if not redis:get("bot:"..msg_.bot_id..":locks:location:"..msg.chat_id) then
					return "*قفل 'ارسال موقعیت مکانی' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:location:"..msg.chat_id)
					return "*قفل 'ارسال موقعیت مکانی' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'file' or matches[2] == 'فایل' then
				if not redis:get("bot:"..msg_.bot_id..":locks:document:"..msg.chat_id) then
					return "*قفل 'ارسال فایل' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:document:"..msg.chat_id)
					return "*قفل 'ارسال فایل' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'voice' or matches[2] == 'وویس' then
				if not redis:get("bot:"..msg_.bot_id..":locks:voice:"..msg.chat_id) then
					return "*قفل 'ارسال وویس' از قبل غیر فعال است⚠️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:voice:"..msg.chat_id)
					return "*قفل 'ارسال وویس' با موفقیت غیر فعال شد✅*"
				end
			elseif matches[2] == 'cmds' or matches[2] == 'دستورات' then
				if not redis:get("bot:"..msg_.bot_id..":locks:cmd:"..msg.chat_id) then
					return "*دستورات ربات از قبل آزاد است⚠️️*"
				else
					redis:del("bot:"..msg_.bot_id..":locks:cmd:"..msg.chat_id)
					return "*دستورات معمولی ربات برای کاربران عادی آزاد شد✅*"
				end
			end
	---------------------------------------------------------
        elseif matches[1] == 'filter' or matches[1] == 'فیلتر' then
		    botMessages(nil, msg)
            redis:hset('bot:'..msg_.bot_id..':filters:'..msg.chat_id, string.sub(matches[2], 1, 50), 'newword')
	        return "*کلمه جدید با موفقیت فیلتر شد✅*\n\n`"..matches[2]:gsub("`","").."`"
	---------------------------------------------------------
        elseif matches[1] == 'rw' or matches[1] == 'remword' or matches[1] == 'حذف فیلتر' then	
		    botMessages(nil, msg)
            redis:hdel('bot:'..msg_.bot_id..':filters:'..msg.chat_id, matches[2])
            return "*کلمه* `{"..matches[2]:gsub("`","").."}` *با موفقیت از لیست کلمات فیلتر شده حذف شد*✅"
	---------------------------------------------------------
        elseif matches[1] == 'share' or matches[1] == 'شماره ربات' then
			sendContact(msg.chat_id, msg.id, msg_.bot_id, msg_.bot_number, msg_.bot_name)
	---------------------------------------------------------
        elseif matches[1] == 'charge stats' or matches[1] == 'شارژ گروه' then
		    botMessages(nil, msg)
			local ex = redis:ttl("bot:"..msg_.bot_id..":charge:"..msg.chat_id)
			local expire_time
    		if ex == -1 or ex == "-1" then
     			expire_time = "*نوع پنل* : `نامحدود`"
			elseif ex == -2 or ex == "-2" then
	 			expire_time = "*نوع پنل* : `به پایان رسیده⚠️`"
   			else
  		    	local d = getTime(ex)
    			expire_time = "*نوع پنل* : `محدود (تا "..d.." دیگر ربات در گروه فعال میماند)`"
    		end
			return expire_time
	---------------------------------------------------------
		end
    ---------------------------------------------------------
    end
end

return {
    Commands = {
        _config.Cmd..'(ping)$',
        '^(ربات)$',
		_config.Cmd..'(panel)$',
        '^(پنل)$',
		_config.Cmd..'(lock) (.*) (%d+)([dhm])$',
		_config.Cmd..'(lock) (.*)$',
		'^(قفل) (.*) (%d+) (روز)$',
		'^(قفل) (.*) (%d+) (ساعت)$',
		'^(قفل) (.*) (%d+) (دقیقه)$',
		'^(قفل) (.*)$',
		_config.Cmd..'(unlock) (.*)$',
		'^(آزاد کردن) (.*)$',
		'^(باز کردن) (.*)$',
		_config.Cmd..'(ban) (.*)$',
		_config.Cmd..'(ban)$',
        _config.Cmd..'(tban) (%d+)([dhm])$',
        _config.Cmd..'(tban) (.*) (%d+)([dhm])$',
		'^(بن زمانی) (.*) (%d+) (روز)$',
		'^(بن زمانی) (.*) (%d+) (ساعت)$',
		'^(بن زمانی) (.*) (%d+) (دقیقه)$',
		'^(بن زمانی) (%d+) (روز)$',
		'^(بن زمانی) (%d+) (ساعت)$',
		'^(بن زمانی) (%d+) (دقیقه)$',
		'^(بن) (.*)$',
        '^(بن)$',
		_config.Cmd..'(unban) (.*)$',
        _config.Cmd..'(unban)$',
		'^(آنین) (.*)$',
        '^(آنین)$',
		_config.Cmd..'(promote) (.*)$',
        _config.Cmd..'(promote)$',
		'^(تنظیم مدیر) (.*)$',
        '^(تنظیم مدیر)$',
		_config.Cmd..'(demote) (.*)$',
        _config.Cmd..'(demote)$',
		'^(حذف مدیر) (.*)$',
        '^(حذف مدیر)$',
		_config.Cmd..'(whitelist) (.*)$',
        _config.Cmd..'(whitelist)$',
		'^(مجاز) (.*)$',
        '^(مجاز)$',
		_config.Cmd..'(unwhitelist) (.*)$',
        _config.Cmd..'(unwhitelist)$',
		'^(حذف مجاز) (.*)$',
        '^(حذف مجاز)$',
		_config.Cmd..'(kick) (.*)$',
        _config.Cmd..'(kick)$',
		'^(اخراج) (.*)$',
        '^(اخراج)$',
		_config.Cmd..'(warn) (.*)$',
        _config.Cmd..'(warn)$',
		'^(اخطار) (.*)$',
        '^(اخطار)$',
        _config.Cmd..'(mute) (.*)$',
        _config.Cmd..'(mute)$',
		_config.Cmd..'(tmute) (%d+)([dhm])$',
        _config.Cmd..'(tmute) (.*) (%d+)([dhm])$',
		'^(سکوت زمانی) (.*) (%d+) (روز)$',
		'^(سکوت زمانی) (.*) (%d+) (ساعت)$',
		'^(سکوت زمانی) (.*) (%d+) (دقیقه)$',
		'^(سکوت زمانی) (%d+) (روز)$',
		'^(سکوت زمانی) (%d+) (ساعت)$',
		'^(سکوت زمانی) (%d+) (دقیقه)$',
		'^(سکوت) (.*)$',
        '^(سکوت)$',
		_config.Cmd..'(unmute) (.*)$',
        _config.Cmd..'(unmute)$',
		'^(آنمیوت) (.*)$',
        '^(آنمیوت)$',
		_config.Cmd..'(delall) (.*)$',
        _config.Cmd..'(delall)$',
		'^(پاک سازی) (.*)$',
        '^(پاک سازی)$',
        _config.Cmd..'(share)$',
        '^(شماره ربات)$',
		_config.Cmd..'(pin)$',
        '^(پین)$',
		_config.Cmd..'(unpin)$',
        '^(آنپین)$',
		_config.Cmd..'(repin)$',
        '^(ریپین)$',
        _config.Cmd..'(del) (%d+)$', 
		_config.Cmd..'(del)$',
		'^(حذف) (%d+)$', 
		'^(حذف)$',
		_config.Cmd..'(charge stats)$', 
		'^(شارژ گروه)$',
		_config.Cmd..'(filter) (.*)$', 
		'^(فیلتر) (.*)$',
		_config.Cmd..'(rw) (.*)$', 
		_config.Cmd..'(remword) (.*)$', 
		'^(حذف فیلتر) (.*)$',		
    },
	Procces = {
	    sensitivity = true,
		singCommands = true,
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