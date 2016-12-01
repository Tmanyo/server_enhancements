-- Shows a message in chat when a player kills another player.
minetest.register_on_punchplayer(function(player, hitter, tool_capabilities, damage)
     local player_hit = player:get_player_name()
     local criminal = hitter:get_player_name()
     local murder_weapon = hitter:get_wielded_item():to_string()
     minetest.after(.1, function()
          local health = player:get_hp()
          if health == 0 then
               minetest.chat_send_all(criminal .. " killed " .. player_hit .. " with " .. murder_weapon .. ".")
          end
     end)
end)

-- Shows a connecting message when someone is connecting.
minetest.register_on_prejoinplayer(function(name, ip)
     minetest.chat_send_all(name .." is connecting!")
end)

-- Server Reboot.
minetest.register_chatcommand("reboot", {
     description = "Warn players and reboot server",
     func = function(name, param)
          if minetest.check_player_privs(name, {server=true}) == true then
               minetest.chat_send_all("[Server] Rebooting in 1 minute!")
               minetest.after(60, function()
                    minetest.request_shutdown()
               end)
               minetest.after(10, function()
                    minetest.chat_send_all("[Server] Rebooting in 50 seconds!")
               end)
               minetest.after(20, function()
                    minetest.chat_send_all("[Server] Rebooting in 40 seconds!")
               end)
               minetest.after(30, function()
                    minetest.chat_send_all("[Server] Rebooting in 30 seconds!")
               end)
               minetest.after(40, function()
                    minetest.chat_send_all("[Server] Rebooting in 20 seconds!")
               end)
               minetest.after(50, function()
                    minetest.chat_send_all("[Server] Rebooting in 10 seconds!")
               end)
          end
     end
})

-- Manipulate other players.
minetest.register_chatcommand("manipulate", {
     params = "<name> <text>",
     description = "Say something as someone else if you have the server priv.",
     func = function(name, params)
          if minetest.check_player_privs(name, {server=true}) == true then
               local s = params
               local manipulated_name = s:match("%w+")
               local manipulated_text = s:match(" %w+")
               if minetest.check_player_privs(name, {server=true}) == true then
                    minetest.chat_send_all("<" .. manipulated_name .. "> " .. manipulated_text)
               end
          end
     end
})
