-module(servers_supervisor).

-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link()->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([])->
	Server1 = {server1,{function_server, start_link, [server1]},permanent, 400, worker, [function_server]},
	Server2 = {server2,{function_server, start_link, [server2]},permanent, 400, worker, [function_server]},
	Server3 = {server3,{function_server, start_link, [server3]},permanent, 400, worker, [function_server]},
	{ok,{{one_for_one,1,1}, [Server1, Server2, Server3]}}.
