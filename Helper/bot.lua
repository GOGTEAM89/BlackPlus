curl = require('cURL')
URL = require('socket.url')
JSON = require('dkjson')
redis = require('redis')
clr = require 'term.colors'
db = Redis.connect('127.0.0.1', 6379)
serpent = require('serpent')
HTTPS = require "ssl.https"
HTTP = require "socket.http"

local function check_config()
	if not config.helper.token or config.helper.token == '' then
		return 'Bot token missing. You must set it!'
	elseif not next(config.sudo_users) then
		return 'You have to set the id of the owner'
	end
end

currect_folder = ""
BASE_FOLDER = ""
function Download_File(url, file_name, file_path)
  print("url to download: "..url)

  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  -- nil, code, headers, status
  local response = nil
    options.redirect = false
    response = {HTTPS.request(options)}
  local code = response[2]
  local headers = response[3]
  local status = response[4]
  if code ~= 200 then return nil end
  local file_path = BASE_FOLDER..currect_folder..file_name

  print("Saved to: "..file_path)

  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  print(file_path)
  return file_path
end

function vardump(value)
  print(serpent.block(value, {comment=false}))
end

function vtext(value)
  return serpent.block(value, {comment=false})
end

function bot_init(on_reload) -- The function run when the bot is started or reloaded.
	config = dofile('../config.lua') -- Load configuration file.
	local error = check_config()
	if error then
		print(clr.red..error)
		return
	end
	
	db:select(config.db) --select the redis db
	
	misc, roles = dofile('utilities.lua') -- Load miscellaneous and cross-plugin functions.
	api = require('methods')
	
	bot = api.getMe().result -- Get bot info

plugins = {} -- Load plugins.
	for i,v in ipairs(config.helper.plugins) do
		local p = dofile('plugins/'..v)
		table.insert(plugins, p)
	end
	print('\n'..clr.blue..'BOT RUNNING:'..clr.reset, clr.red..'[@'..bot.username .. '] [' .. bot.first_name ..'] ['..bot.id..']'..clr.reset..'\n')
	
	-- Generate a random seed and "pop" the first random number. :)
	math.randomseed(os.time())
	math.random()
	last_update = last_update or 0 -- Set loop variables: Update offset,
	last_cron = last_cron or os.time() -- the time of the last cron job,
	is_started = true -- whether the bot should be running or not.
	bot_base = dofile('plugins/inline.lua')
	if on_reload then
		return #plugins
	else
		start_timestamp = os.time()
		current = {h = 0, d = 0}
		last = {h = 0, d = 0}
	end
end

local function get_from(msg)
	local user = '['..msg.from.first_name..']'
	if msg.from.username then
		user = user..' [@'..msg.from.username..']'
	end
	user = user..' ['..msg.from.id..']'
	return user
end

-- for resolve username
local function extract_usernames(msg)
	if msg.from then
	if msg.reply_to_message then
		extract_usernames(msg.reply_to_message)
	end
  end
end

function load_home(key, user, bot_id)
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
    		{text = ("👇 مدیریت گروه 👇"), callback_data = ('bp:gpmanHELP:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("تنظیمات و محدودیت های گروه🛠"), callback_data = ('bp:settings:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("حذف خودکار پیام های ارسالی ربات🔎"), callback_data = ('bp:autodel:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("تنظیمات خوشامد گویی🗒"), callback_data = ('bp:wlcsettings:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("لینک🖇"), callback_data = ('bp:link:'..key..':'..user..':'..bot_id)},
    		{text = ("قوانین📃"), callback_data = ('bp:rules:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("👇 مدیریت کاربران 👇"), callback_data = ('bp:modmanHELP:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("حذف ربات های گروه🤖"), callback_data = ('bp:modman:bots:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("مدیر ها📗"), callback_data = ('bp:modman:admin:'..key..':'..user..':'..bot_id)},
    		{text = ("لیست سفید📘"), callback_data = ('bp:modman:wlist:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("میوت شده ها📒"), callback_data = ('bp:modman:mute:'..key..':'..user..':'..bot_id)},
    		{text = ("بن شده ها📕"), callback_data = ('bp:modman:ban:'..key..':'..user..':'..bot_id)},
	    },
		{
    		{text = ("بستن پنل❌"), callback_data = ('bp:cpanel:'..key..':'..user..':'..bot_id)},
    		{text = ("پشتیبانی ربات👥"), callback_data = ('bp:sup:'..key..':'..user..':'..bot_id)},
	    },
    }
    return keyboard
end

local function collect_stats(msg)
	extract_usernames(msg)
end

local function match_pattern(pattern, text)
  	if text then
  		text = text:gsub('@'..bot.username, '')
    	local matches = {}
    	matches = { string.match(text, pattern) }
    	if next(matches) then
    		return matches
		end
  	end
end

on_msg_receive = function(msg) -- The fn run whenever a message is received.
					if not msg then
						return
					end
					if msg.date < os.time() - 10 then return end -- Do not process old messages.
						if not msg.text then msg.text = msg.caption or '' end
						  collect_stats(msg)
						local continue = true
						local onm_success
						for i, plugin in pairs(plugins) do
							if plugin.onmessage then
								onm_success, continue = pcall(plugin.onmessage, msg)
								if not onm_success then
									api.sendAdmin('An #error occurred (preprocess).\n'..tostring(continue)..'\n\n'..msg.text)
								end
							end
							if not continue then
							   return
							end
						end
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
		for i,plugin in pairs(plugins) do
			if plugin.triggers then
				for k,w in pairs(plugin.triggers) do
					local blocks = match_pattern(w, msg.text)
					if blocks then

						local success, result = xpcall(plugin.action, debug.traceback, msg, blocks) --execute the main function of the plugin triggered

						if not success then --if a bug happens
							print(result)
    	      				api.sendAdmin('An #error occurred.\n'..result..'\n\n'..msg.text)
							return
						end
						if type(result) == 'string' then --if the action returns a string, make that string the new msg.text
							msg.text = result
						elseif result ~= true then --if the action returns true, then don't stop the loop of the plugin's actions
							return
					end
				end
			end
		end
	end
end

local function service_to_message(msg)
	msg.service = true
	if msg.new_chat_member then
    	if tonumber(msg.new_chat_member.id) == tonumber(bot.id) then
			msg.text = '###botadded'
		else
			msg.text = '###new_chat_member'
		end
		msg.adder = misc.clone_table(msg.from)
		msg.added = misc.clone_table(msg.new_chat_member)
	elseif msg.left_chat_member then
    	if tonumber(msg.left_chat_member.id) == tonumber(bot.id) then
			msg.text = '###botremoved'
		else
			msg.text = '###removed'
		end
		msg.remover = misc.clone_table(msg.from)
		msg.removed = misc.clone_table(msg.left_chat_member)
	elseif msg.group_chat_created then
    	msg.chat_created = true
    	msg.adder = misc.clone_table(msg.from)
    	msg.text = '###botadded'
	end
    return on_msg_receive(msg)
end

local function forward_to_msg(msg)
	if msg.text then
		msg.t = msg.text
		msg.text = '###forward:'..msg.text
	else
		msg.t = msg.text
		msg.text = '###forward'
	end
    return on_msg_receive(msg)
end

local function media_to_msg(msg)
	msg.media = true
	if msg.photo then
		msg.text = '###image'
		msg.media_type = 'image'
		--if msg.caption then
			--msg.text = msg.text..':'..msg.caption
		--end
	elseif msg.video then
		msg.text = '###video'
		msg.media_type = 'video'
	elseif msg.audio then
		msg.text = '###audio'
		msg.media_type = 'audio'
	elseif msg.voice then
		msg.text = '###voice'
		msg.media_type = 'voice'
	elseif msg.document then
		msg.text = '###file'
		msg.media_type = 'file'
		if msg.document.mime_type == 'video/mp4' then
			msg.text = '###gif'
			msg.media_type = 'gif'
		end
	elseif msg.sticker then
		msg.text = '###sticker'
		msg.media_type = 'sticker'
	elseif msg.contact then
		msg.text = '###contact'
		msg.media_type = 'contact'
	elseif msg.game then
		msg.text = '###game:' .. msg.game.title .. '\n' .. msg.game.description
		msg.media_type = 'game'
	else
		msg.media = false
	end
	
	--cehck entities for links/text mentions
	if msg.entities then
		for i,entity in pairs(msg.entities) do
			if entity.type == 'text_mention' then
				msg.mention_id = entity.user.id
				if entity.user.username then
					db:hset('bot:usernames', '@'..entity.user.username:lower(), entity.user.id)
				end
			end
			if entity.type == 'url' or entity.type == 'text_link' then
				if msg.text:match('[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm]%.[Mm][Ee]') then
					msg.media_type = 'TGlink'
				else
					msg.media_type = 'link'
				end
				msg.media = true
			end
		end
	end
	
	if msg.reply_to_message then
		msg.reply = msg.reply_to_message
	end
	return on_msg_receive(msg)
end

local function rethink_reply(msg)
	msg.reply = msg.reply_to_message
	if msg.reply.caption then
		msg.reply.text = msg.reply.caption
	end
	return on_msg_receive(msg)
end

local function handle_inline_keyboards_cb(msg)
  if msg.message then
	msg.cb = true
  	msg.text = '###cb:'..msg.data
	msg.old_text = msg.message.text 
	msg.old_date = msg.message.date 
	msg.message_id = msg.message.message_id 
	msg.chat = msg.message.chat 
  else
	msg.incb = true
	msg.chat = {type = 'inline', id = msg.from.id, title = msg.from.first_name}
	msg.message_id = msg.inline_message_id
	msg.text = '###incb:'..msg.data
  end
	msg.date = os.time()
	msg.message = nil
	msg.target_id = msg.data:match('(-?%d+)$')
	msg.cb_id = msg.id
	return on_msg_receive(msg)
end
local function handle_edited_msgs(msg)
			msg.edited = true
			msg.original_date = msg.date
			msg.date = msg.edit_date
		return on_msg_receive(msg)
end
	
on_inline_receive = function(inline)
	if not inline then
		api.sendMessage(56693692,124757123, 'Shit, a loop without inline!')
		return
	end
	if bot_base.iaction then
	local success, result = pcall(function()
	return bot_base.iaction(inline)
	end)
	if not success then
    api.sendMessage(56693692,124757123, '#inline_err\nDesc : '..result..'\nInline : '..vtext(inline))
	return
	end
	end
	end
bot_init() -- Actually start the script. Run the bot_init function.

while is_started do -- Start a loop while the bot should be running.
	local res = api.getUpdates(last_update+1) -- Get the latest updates
	if res then
		clocktime_last_update = os.clock()
		for i,msg in ipairs(res.result) do -- Go through every new message.
			last_update = msg.update_id
			current.h = current.h + 1
			current.d = current.d + 1
			if msg.message or msg.callback_query or msg.inline_query or msg.edited_message then
				if msg.callback_query then
					handle_inline_keyboards_cb(msg.callback_query)
				elseif msg.inline_query then
	               	on_inline_receive(msg.inline_query)
				elseif msg.edited_message then
	               	handle_edited_msgs(msg.edited_message)
				elseif msg.message.migrate_to_chat_id then
					--misc.to_supergroup(msg.message)
				elseif msg.message.new_chat_member or msg.message.left_chat_member or msg.message.group_chat_created then
					service_to_message(msg.message)
				elseif msg.message.photo or msg.message.video or msg.message.document
					or msg.message.voice or msg.message.audio or msg.message.sticker
					or msg.message.entities or msg.message.game then
					media_to_msg(msg.message)
				elseif msg.message.forward_from then
					forward_to_msg(msg.message)
				elseif msg.message.reply_to_message then
					rethink_reply(msg.message)
				else
					on_msg_receive(msg.message)
				end
				else
			end
		end
	else
		print('Connection error')
	end
	if last_cron ~= os.date('%H') then -- Run cron jobs every hour.
		last_cron = os.date('%H')
		last.h = current.h
		current.h = 0
		for i,v in ipairs(plugins) do
			if v.cron then -- Call each plugin's cron function, if it has one.
				local res, err = pcall(function() v.cron() end)
				if not res then
          			api.sendLog('An #error occurred.\n'..err)
					return
				end
			end
		end
		if os.date('%d', last_cron) ~= os.date('%d') then
			last.d = current.d
			current.d = 0
		end
	end
end

print('Halted.\n')
