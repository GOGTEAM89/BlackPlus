do local _ = {
  Cmd = "^[!/#]",
  Support = {
    bot = "CoockFoodBot",
    group_link = "https://t.me/joinchat/EsTsPVD6lPmv11OBOwA9hw",
    id = -1001358599417,
    user = "Amirm_MEtadon"
  },
  channel = "TaradTeam",
  db = 5,
  disabled_channels = {},
  expired_groups = {},
  helper = {
    plugins = {
      "inline.lua",
      "BP-MGR.lua",
      "pv.lua"
    },
    token = "635657724:AAErWM2WyA59wAWJWXrRBDQUnVHfhN1Ovps"
  },
  log = {
    admin = 314895421,
    chat = 314895421
  },
  plugins = {
    "Plugins",
    "messageProcessor",
    "moderationCommands",
    "Administration",
    "helperCallbacks",
    "basicCommands"
  },
  print = false,
  sudo_users = {
    314895421,
    123456789
  }
}
return _
end