-- luacheck: globals vim
local connections = require("acid.connections")
local ops = require("acid.ops")
local core = require("acid.core")

local pwd_to_key = function(pwd)
  if not utils.ends_with(pwd, "/") then
    return pwd .. "/"
  end
  return pwd
end

local sessions = {}

sessions.store = {}


sessions.register_session = function(connection_ix, session)
  if sessions.store[connection_ix] == nil then
    sessions.store[connection_ix] = {
      list = {},
      selected = nil
    }
  end
  table.insert(sessions.store[connection_ix].list, session)
  sessions.store[connection_ix].selected = session
end

sessions.filter = function(data, connection_ix)
  connection_ix = connection_ix or connections.peek()
  local session = sessions.store[connection_ix]
  if session ~= nil then
    data.session = session.selected
  end

  return data
end

sessions.new_session = function(connection_ix)
  connection_ix = connection_ix or connections.peek()
  local handler = function(data)
    sessions.register_session(connection_ix, data['new-session'])
  end

  local conn = connections.store[connection_ix]
  local clone = ops.clone{}
  core.send(conn, clone.payload(), handler)
end


return sessions
